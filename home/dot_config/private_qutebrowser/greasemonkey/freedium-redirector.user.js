// ==UserScript==
// @name     Freedium Redirector
// @author   Frestein (frestein@tuta.io)
// @version  0.1.0
// @description Redirects Medium->Freedium
// @grant    none
// @match    https://*.medium.com/*
// @run-at   document-start
// ==/UserScript==
window.location.href = `https://freedium.cfd/${window.location.href}`;
