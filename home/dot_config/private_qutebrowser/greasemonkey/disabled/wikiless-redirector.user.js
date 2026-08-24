// ==UserScript==
// @name     Wikiless Redirector
// @author   Frestein (frestein@tuta.io)
// @version  0.1.0
// @description Redirects Wikipedia->Wikiless
// @grant    none
// @match    https://*.wikipedia.org/*
// @run-at   document-start
// ==/UserScript==

const lang = window.location.hostname.split('.')[0] || 'en';
const newUrl = new URL(window.location.href);
newUrl.hostname = 'wl.vern.cc';
newUrl.searchParams.set('lang', lang);

window.location.replace(newUrl.toString());
