// ==UserScript==
// @name         Advanced Content Blocker
// @namespace    http://tampermonkey.net/
// @version      1.0.0
// @description  Blocks elements based on predefined filter list
// @author       Frestein (frestein@tuta.io)
// @match        *://*/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function () {
  "use strict";

  const filterRules = {
    //  TEST: Need test
    // "rutracker.org": [
    //   "#bn-top-block",
    //   "#bn-top-right",
    //   ".bn-idx",
    //   "td.vMiddle",
    //   "td.tCenter",
    // ],
    // "rutracker.net": [
    //   "#bn-top-block",
    //   "#bn-top-right",
    //   ".bn-idx",
    //   "td.vMiddle",
    //   "td.tCenter",
    // ],
    "hentailib.me": [".mc_b"],
    "kwork.ru": [".js-notification-block"],
    "www.trueachievements.com": [
      ".lb_holder",
      ".ta-ab-overlay",
      "#mpu-1",
      ".nn_player",
    ],
    "www.aznude.com": [".az-ads-banner"],
    "simpcity.su": [
      ".blockitsowereplaceit",
      ".nocopy.prm-wrapper",
      ".notices",
      ".notice",
      ".notice-content",
    ],
    "f95zone.to": [
      ".blockitsowereplaceit",
      ".nocopy.prm-wrapper",
      ".notices",
      ".notice",
      ".notice-content",
      ".samBannerUnit",
    ],
    "rule34.xxx": [
      ".content > span > div",
      "#post-list > span",
      "#status-notices",
      "#post-comments",
      ".image-sublinks",
      ".verticalFlexWithMargins.sidebarRight",
    ],
    "vk.com": [
      ".left_menu_nav_wrap",
      ".FCPanel",
      "#ads_left",
      ".vkuiGroup--padding-m.vkuiGroup--card.vkuiGroup--sizeX-regular.vkuiGroup.ProfileGifts.ProfileGroup",
      "div.vkuiSpacing.vkuiGroup__separator:nth-of-type(2)",
      "#react_rootEcosystemServicesNavigationEntry",
      ".apps_feedRightAppsBlock_single_app--promo",
      ".CatalogSection--header_section",
      ".apps_feedRightAppsBlock_single_mini_app",
      ".apps_feedRightAppsBlock_single_app--",
      ".ProfileFriendsFindBlock__placeholder",
      ".LegalRecommendationsLinkLeftMenuAuthorized",
      ".WideSeparator--legalRecommendationsLink",
    ],
    "www.youtube.com": [".ejoy-ai-adv"],
    "skillbox.ru": [
      ".universal-notice--active",
      ".article-advert-banner__link",
    ],
    "www.fotor.com": ["._1Pece", "._3KDv2"],
    "www.pornhub.com": [
      ".eJOY__extension_ai_adv_root_class",
      "#age-verification-container",
      "#age-verification-wrapper",
      "#customSkinCTA",
      "#customSkin",
      "#abAlert",
      "#countryRedirectMessage",
      "#welcome",
      "#headerUpgradePremiumBtn",
    ],
    "www.atlassian.com": [".eJOY__extension_ai_adv_root_class"],
    "wikipedia.org": ["#siteNotice"],
    "aniu.ru": [".stream"],
    "www.law.ru": [".marquiz-widget_hide-on-mobile", ".headerRow1__background"],
    "chan.sankakucomplex.com": [
      "#add-to-favs",
      "#news-ticker",
      "#popular-preview",
      "#rating",
      "#sp1",
      "#edit",
      "#comments",
      ".action-row",
      ".sub-action-row",
      ".reactions",
      ".status-notice",
      '#subnavbar [href="https://get.sankaku.plus/"]',
      '#subnavbar [href^="https://chan.sankakucomplex.com/"]',
      '[href="/companions"]',
      '[href^="https://www.sankakucomplex.com/books"]',
      '[href="https://www.sankakucomplex.com/games"]',
      '[href^="https://s.zlinkn.com/d.php"]',
      ".ai-carousel.carousel",
      ".companion--draggable_element",
      ".companion-carousel.carousel",
      ".has-mail",
      ".news-carousel.carousel",
      ".pending.status-notice",
      ".premium-carousel.carousel",
      ".topbar-carousel.carousel",
      "div.carousel:nth-of-type(1)",
      "div.status-notice:nth-of-type(3)",
    ],
    "medium.com": [".sz.sy.sx.m"],
    "gelbooru.com": [
      ".headerAd",
      ".footerAd",
      ".footerAd2",
      ".mainBodyPadding > div",
      "#scrollebox",
      "#motd",
    ],
  };

  function shouldActivate() {
    return Object.prototype.hasOwnProperty.call(filterRules, location.hostname);
  }

  function applyBlockingRules() {
    if (!shouldActivate()) return;

    filterRules[location.hostname].forEach((selector) => {
      try {
        document.querySelectorAll(selector).forEach((element) => {
          element.style.display = "none";
        });
      } catch (e) {
        console.debug("Blocking error:", e);
      }
    });
  }

  (function init() {
    if (!shouldActivate()) return;

    applyBlockingRules();

    const observer = new MutationObserver((mutations) => {
      if (!shouldActivate()) {
        observer.disconnect();
        return;
      }
      applyBlockingRules();
    });

    observer.observe(document, {
      childList: true,
      subtree: true,
      attributes: false,
    });

    window.addEventListener("unload", () => observer.disconnect());
  })();
})();
