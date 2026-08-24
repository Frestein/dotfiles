// ==UserScript==
// @name     Breezewiki Redirector
// @author   Frestein (frestein@tuta.io)
// @version  0.1.0
// @description redirects fandom.com->breezewiki.com
// @grant    none
// @match    https://*.fandom.com/*
// @run-at   document-start
// ==/UserScript==

window.location.host = window.location.host.replace(
  "fandom.com",
  "breezewiki.com",
);
