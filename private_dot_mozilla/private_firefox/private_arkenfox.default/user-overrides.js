// 0102: resume previous session
user_pref("browser.startup.page", 3);

// 0401: disable SB (Safe Browsing)
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);

// 0402: disable SB checks for downloads (both local lookups + remote)
user_pref("browser.safebrowsing.downloads.enabled", false);

// 0403: disable SB checks for downloads (remote)
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

// 0404: disable SB checks for unwanted software
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);

// 0710: disable DoH
user_pref("network.trr.mode", 5);

// 0803: enable live search suggestions
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.searches", true);

// 0810: enable search and form history
user_pref("browser.formfill.enable", true);

// 1003: enable storing extra session data everywhere
user_pref("browser.sessionstore.privacy_level", 0);

// 1211: disable OCSP
user_pref("security.OCSP.enabled", 0);

// 2812: disable clearOnShutdown items
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false);
user_pref("privacy.clearOnShutdown_v2.downloads", false);
user_pref("privacy.clearOnShutdown_v2.formdata", false);

// 2815: set "Cookies" and "Site Data" to don't clear on shutdown
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);

// 2821: disable "Clear Data" items
user_pref("privacy.clearSiteData.browsingHistoryAndDownloads", false);
user_pref("privacy.clearSiteData.formdata", false);

// 2831: disable "Clear History" items
user_pref("privacy.clearHistory.browsingHistoryAndDownloads", false);
user_pref("privacy.clearHistory.formdata", false);

// 5003: disable saving passwords
user_pref("signon.rememberSignons", false);
