// ==UserScript==
// @name         Youtube Sponsorblock
// @version      1.0.0
// @description  Skip sponsor segments automatically
// @author       Frestein (frestein@tuta.io)
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
const delay = 1000;

const tryFetchSkipSegments = (videoID) =>
  fetch(`https://sponsor.ajay.app/api/skipSegments?videoID=${videoID}`)
    .then((r) => r.json())
    .then((rJson) =>
      rJson.filter((a) => a.actionType === "skip").map((a) => a.segment),
    )
    .catch(
      (e) =>
        console.log(
          `Sponsorblock: failed fetching skipSegments for ${videoID}, reason: ${e}`,
        ) || [],
    );

const createVisualMarkers = (segments, videoElement) => {
  const progressBar = document.querySelector(".ytp-progress-bar");
  if (!progressBar) return;

  const oldMarkers = document.querySelectorAll(".sponsorblock-marker");
  oldMarkers.forEach((m) => m.remove());

  const duration = videoElement.duration;
  if (!duration) return;

  segments.forEach(([start, end]) => {
    const marker = document.createElement("div");
    marker.className = "sponsorblock-marker";

    const startPercent = (start / duration) * 100;
    const widthPercent = ((end - start) / duration) * 100;

    Object.assign(marker.style, {
      position: "absolute",
      left: `${startPercent}%`,
      width: `${widthPercent}%`,
      height: "45%",
      backgroundColor: "rgba(0, 128, 0, 0.6)",
      pointerEvents: "none",
      zIndex: 10,
      top: "2px",
    });

    progressBar.appendChild(marker);
  });
};

const skipSegments = async () => {
  const videoID = new URL(document.location).searchParams.get("v");
  if (!videoID) {
    return;
  }
  const key = `segmentsToSkip-${videoID}`;
  window[key] = window[key] || (await tryFetchSkipSegments(videoID));
  for (const v of document.querySelectorAll("video")) {
    if (Number.isNaN(v.duration)) continue;

    createVisualMarkers(window[key], v);

    for (const [start, end] of window[key]) {
      if (v.currentTime >= start && v.currentTime < end) {
        const segmentLength = end - start;
        const positionInSegment = v.currentTime - start;
        const positionPercent = positionInSegment / segmentLength;

        if (positionPercent <= 0.01) {
          console.log(
            `Sponsorblock: skipped video @${v.currentTime} from ${start} to ${end}`,
          );
          v.currentTime = end;
          return;
        } else {
          return;
        }
      }

      const timeToSponsor = (start - v.currentTime) / v.playbackRate;
      if (v.currentTime < start && timeToSponsor < delay / 1000) {
        console.log(
          `Sponsorblock: Almost at sponsor segment, sleep for ${timeToSponsor * 1000}ms`,
        );
        setTimeout(skipSegments, timeToSponsor * 1000);
      }
    }
  }
};

if (!window.skipSegmentsIntervalID) {
  window.skipSegmentsIntervalID = setInterval(skipSegments, delay);
}

const style = document.createElement("style");
style.textContent = `
    .ytp-progress-bar {
        position: relative !important;
    }
`;
document.head.appendChild(style);
