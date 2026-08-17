# ===========================================================================
# Requirements
# ===========================================================================

# This configuration depends on the following Python packages:
#
#   python-adblock      - Brave's adblock (python-adblock library)
#   python-pyperclip    - Clipboard access (qute-code-hint userscript)
#   python-protobuf     - idk
#   python-tldextract   - TLD extraction (qute-pass userscript)

import os
from pathlib import Path

# ===========================================================================
# Avoiding errors
# ===========================================================================

# ---------------------------------------------------------------------------
# Linter errors
# ---------------------------------------------------------------------------

# Additional info:
# https://github.com/qutebrowser/qutebrowser/blob/main/doc/help/configuring.asciidoc#avoiding-flake8-errors

# pylint: disable=C0111
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103

# pylint: disable=C0111
from qutebrowser.config.config import ConfigContainer  # noqa: E402, F401
from qutebrowser.config.configfiles import ConfigAPI  # noqa: E402, F401

# ---------------------------------------------------------------------------
# Web-sites errors
# ---------------------------------------------------------------------------

# Fix 'TrustedHTML' error
c.content.javascript.log_message.excludes = {
    "userscript:_qute_stylesheet": [
        "*Refused to apply inline style because it violates the following Content Security Policy directive: *"
    ],
    "userscript:_qute_js": ["*TrustedHTML*"],
}

# ===========================================================================
# Content settings
# ===========================================================================

# fmt: off

config.set("content.cookies.accept", "all", "chrome-devtools://*")
config.set("content.cookies.accept", "all", "devtools://*")

config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")
config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}", "https://web.whatsapp.com/")
config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}; rv:133.0) Gecko/20100101 Firefox/133.0", "https://accounts.google.com/*")

config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")

config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

config.set("content.local_content_can_access_remote_urls", True, "file:///home/frestein/.local/share/qutebrowser/userscripts/*")
config.set("content.local_content_can_access_file_urls", False, "file:///home/frestein/.local/share/qutebrowser/userscripts/*")

# fmt: on

# ===========================================================================
# Advertising blocking
# ===========================================================================

c.content.blocking.method = "adblock"
c.content.blocking.hosts.lists = []
c.content.blocking.adblock.lists = [
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt",
    "https://easylist-downloads.adblockplus.org/bitblock.txt",
    "https://easylist-downloads.adblockplus.org/cntblock.txt",
    "https://easylist-downloads.adblockplus.org/ruadlist.txt",
    "https://easylist-msie.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-msie.adblockplus.org/antiadblockfilters.txt",
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_adservers.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_adservers_popup.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_general_block.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_general_block_popup.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_thirdparty.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_thirdparty_popup.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://raw.github.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt",
    "https://raw.githubusercontent.com/LanikSJ/ubo-filters/main/filters/combined-filters.txt",
    "https://raw.githubusercontent.com/easylist/ruadlist/refs/heads/master/advblock.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/annoyances-cookies.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/annoyances-others.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/badlists.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2020.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2021.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2022.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2023.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2024.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2025.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/quick-fixes.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/resource-abuse.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/ubo-link-shorteners.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/ubol-filters.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/",
]

# ===========================================================================
# General settings
# ===========================================================================

config.load_autoconfig(True)

# ---------------------------------------------------------------------------
# UI / Behavior
# ---------------------------------------------------------------------------

config.source("gruvbox.py")

c.tabs.background = True

c.completion.shrink = True
c.completion.cmd_history_max_items = 10000

c.scrolling.smooth = True

c.downloads.position = "bottom"
c.downloads.location.prompt = False

c.hints.radius = 0
c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre",
]

c.fonts.hints = "bold 12px Monospace"

c.window.title_format = "{perc}{current_title}{title_sep}qutebrowser"

c.new_instance_open_target = "tab"

c.content.headers.accept_language = "ru-RU,ru;q=0.9"
c.content.autoplay = False
c.content.fullscreen.overlay_timeout = 0

c.auto_save.session = True

c.session.lazy_restore = True

# ---------------------------------------------------------------------------
# QtWebEgnine
# ---------------------------------------------------------------------------

c.qt.args = [
    "enable-accelerated-video",
    "enable-native-gpu-memory-buffers",
    "enable-oop-rasterization",
    "enable-quic",
    # "enable-unsafe-webgpu",
    # "enable-vulkan",
    "enable-zero-copy",
    "font-cache-shared-handle",
    "ignore-gpu-blocklist",
    "num-raster-threads=4",
    "enable-features=VaapiIgnoreDriverChecks,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,FluentOverlayScrollbar,",
    # TEST: AcceleratedVideoDecodeLinuxZeroCopyGL
]
c.qt.workarounds.disable_accelerated_2d_canvas = "never"

# ---------------------------------------------------------------------------
# Language & defaults
# ---------------------------------------------------------------------------

c.spellcheck.languages = ["en-US", "ru-RU"]

c.tabs.last_close = "close"

c.url.default_page = "https://start.duckduckgo.com/"
c.url.start_pages = "https://start.duckduckgo.com/"

# ---------------------------------------------------------------------------
# File chooser
# ---------------------------------------------------------------------------

# fmt: off

c.fileselect.handler = "external"

yazi_chooser = ["xdg-terminal-exec", "--", "--title", "footclient-center-half-float-yazi", "yazi", "--chooser-file", "{}"]

c.fileselect.single_file.command = yazi_chooser
c.fileselect.multiple_files.command = yazi_chooser
c.fileselect.folder.command = yazi_chooser

# ---------------------------------------------------------------------------
# Editor
# ---------------------------------------------------------------------------

c.editor.command = ["emacsclient", "-nc", "+{line}:{column}", "{file}"]

# c.editor.command = ["xdg-terminal-exec", "nvim", "{file}", "-c", "normal {line}G{column0}l"]

# fmt: on

# ---------------------------------------------------------------------------
# Keyboard langmap (Russian → English)
# ---------------------------------------------------------------------------

config.unbind(".")

en_keys = "qwertyuiop[]asdfghjkl;'zxcvbnm,./" + 'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
ru_keys = "йцукенгшщзхъфывапролджэячсмитьбю." + "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,"

c.bindings.key_mappings.update(dict(zip(ru_keys, en_keys)))

# ---------------------------------------------------------------------------
# Web history exclude
# ---------------------------------------------------------------------------

config_dir = Path(__file__).parent
exclude_file = config_dir / "web_exclude.txt"
web_exclude = []

if exclude_file.exists():
    with open(exclude_file) as f:
        web_exclude = [line.strip() for line in f if line.strip()]

c.completion.web_history.exclude = web_exclude

# ===========================================================================
# Search engines
# ===========================================================================

# ---------------------------------------------------------------------------
# Instance variables
# ---------------------------------------------------------------------------

instance_4get = "4get.joygnu.org"
instance_searxng = "eu.priv.au"
instance_mozhi = "mozhi.pussthecat.org"

# ---------------------------------------------------------------------------
# Search engines
# ---------------------------------------------------------------------------

# fmt: off

c.url.searchengines = {
    # Web
    "DEFAULT": "duckduckgo.com/?q={}",
    "search-ddg": "duckduckgo.com/?q={}",
    "search-g": "google.com/search?q={}",
    "search-ya": "ya.ru/search/?text={}",
    "search-4get": f"{instance_4get}/web?country=ru&nsfw=yes&s={{}}",
    "search-sx": f"{instance_searxng}/?q={{}}",

    # Development & Packages
    "wk-nixos": "wiki.nixos.org/w/index.php?search={}",
    "wk-gentoo": "wiki.gentoo.org/index.php?search={}",
    "wk-arch": "wiki.archlinux.org/index.php?search={}",
    "pkg-melpa": "melpa.org/#/?q={}",
    "pkg-guix": "packages.guix.gnu.org/search/?query={}",
    "pkg-toys": "toys.whereis.social/?search={}",
    "pkg-nix": "search.nixos.org/packages?query={}",
    "pkg-nur": "nur.nix-community.org/?query={}",
    "pkg-gentoo": "packages.gentoo.org/packages/search?q={}",
    "pkg-arch": "archlinux.org/packages/?q={}",
    "pkg-aur": "aur.archlinux.org/packages?&K={}",
    "pkg-linux": "pkgs.org/search/?q={}",
    "grep-sg": "sourcegraph.com/search?q=context:global+{}",
    "grep-gh-code": "github.com/search?q={}&type=code",
    "grep-gh-repo": "github.com/search?q={}&type=repositories",
    "grep-gh-issue": "github.com/search?q={}&type=issues",
    "grep-gh-user": "github.com/search?q={}&type=users",
    "grep-cb-repo": "codeberg.org/explore/repos?only_show_relevant=true&sort=moststars&q={}",
    "grep-cb-user": "codeberg.org/explore/users?q={}",

    # Userscripts
    "userscript-gf": "greasyfork.org/en/scripts?q={}",
    "userscript-sf": "sleazyfork.org/en/scripts?q={}",

    # Torrent
    "torrent-rutracker": "rutracker.org/forum/tracker.php?nm={}",

    # Translation
    "trans-g": "translate.google.com/?text={}",
    "trans-mozhi": f"{instance_mozhi}/?engine=yandex&from=auto&to=ru&text={{}}",

    # Maps
    "map-g": "google.com/maps?q={}",
    "map-osm": "www.openstreetmap.org/search?query={}",

    # Media
    "media-yt": "youtube.com/results?search_query={}",
    "media-kp": "kinopoisk.ru/index.php?kp_query={}",

    # Music
    "music-ytm": "music.youtube.com/search?q={}",
    "music-lfm": "last.fm/search?q={}",

    # References
    "ref-pin": "pinterest.com/search/pins/?q={}",
    "ref-zch": "zerochan.net/{}",
    "ref-coub": "coub.com/search?q={}",

    # Social & Forums
    "social-reddit": "reddit.com/r/{}",

    # Games
    "games-pdb": "protondb.com/search?q={}",

    # Anime & Manga
    "anime-sfw": "anilist.co/search/anime?hide my anime=true&search={}",
    "anime-nsfw": "anilist.co/search/anime?hide my anime=true&adult=true&search={}",
    "manga-sfw": "anilist.co/search/manga?hide my manga=true&search={}",
    "manga-nsfw": "anilist.co/search/manga?hide my manga=true&adult=true&search={}",

    # Shopping
    "shop-ozon": "ozon.ru/search/?text={}",
    "shop-yam": "market.yandex.ru/search?text={}",
}

# fmt: on

# ===========================================================================
# Aliases
# ===========================================================================

gopass = f"spawn -u qute-pass -d '{os.environ.get('DMENU')}' -M gopass"

c.aliases = config.get("aliases", {})
c.aliases.update(
    {
        "kinopoisk-to-cx": 'jseval window.location.href = window.location.href.replace("kinopoisk.ru", "kinopoisk.cx");',
        "git-clone": 'spawn xdg-open "git+{url}"',
        "qr": "spawn -u qr",
        "buku-random": "spawn -u qute-buku random",
        "buku-dmenu": "spawn -u qute-buku dmenu",
        "translate": "spawn -u qute-translate-popup",
        "gopass-login-path": f"{gopass}",
        "gopass-login-secret": f"{gopass} --username-target secret --username-pattern 'login: (.+)'",
        "gopass-username-path": f"{gopass} --username-only ",
        "gopass-username-secret": f"{gopass} --username-target secret --username-pattern 'login: (.+)' --username-only ",
        "gopass-password": f"{gopass} --password-only",
        "gopass-otp": f"{gopass} --otp-only",
    }
)

# ===========================================================================
# Keybindigs
# ===========================================================================

bind = config.bind
unbind = config.unbind

# fmt: off

# ---------------------------------------------------------------------------
# Unbind defaults
# ---------------------------------------------------------------------------

unbind("<Alt-m>")
unbind(";i")
unbind(";I")
unbind("gO")

# ---------------------------------------------------------------------------
# Configuration management
# ---------------------------------------------------------------------------

bind("\\ce", "config-edit")
bind("\\rc", "config-source")
bind("\\ra", "adblock-update")
bind("\\rg", "greasemonkey-reload")

# ---------------------------------------------------------------------------
# Toggle
# ---------------------------------------------------------------------------

bind("tbh", "config-cycle -p -t -u *://{url:host}/* content.blocking.enabled true false ;; reload")
bind("tBh", "config-cycle -p -u *://{url:host}/* content.blocking.enabled true false ;; reload")
bind("tbH", "config-cycle -p -t -u *://*.{url:host}/* content.blocking.enabled true false ;; reload")
bind("tBH", "config-cycle -p -u *://*.{url:host}/* content.blocking.enabled true false ;; reload")
bind("tbu", "config-cycle -p -t -u {url} content.blocking.enabled true false ;; reload")
bind("tBu", "config-cycle -p -u {url} content.blocking.enabled true false ;; reload")
bind("tqt", "config-cycle tabs.show multiple switching")
bind("tqs", "config-cycle statusbar.show always in-mode")

# ---------------------------------------------------------------------------
# External editor
# ---------------------------------------------------------------------------

bind("<Alt-e>", "edit-text")
bind("<Alt-v>", "edit-text")
bind("<Alt-c>", "cmd-edit")
bind("<Alt-u>", "edit-url")
bind("<Alt-e>", "edit-text", mode="insert")
bind("<Alt-v>", "edit-text", mode="insert")

# ---------------------------------------------------------------------------
# Tabs
# ---------------------------------------------------------------------------

bind("gT", "cmd-set-text -s :tab-take")
bind("gG", "cmd-set-text -s :tab-give")
bind("gl", "tab-focus last")
bind("gp", "tab-pin")
bind("gc", "cmd-set-text :open {url:pretty}")
bind("gC", "cmd-set-text :open -t -r {url:pretty}")
bind("<Ctrl-m>", "tab-mute")

# ---------------------------------------------------------------------------
# Media
# ---------------------------------------------------------------------------

bind("\\m", "spawn umpv {url}")
bind(";m", "hint --rapid links spawn umpv {hint-url}")

# ---------------------------------------------------------------------------
# Navigation
# ---------------------------------------------------------------------------

bind("<Shift-Left>", "back")
bind("<Shift-Down>", "tab-prev")
bind("<Shift-Up>", "tab-next")
bind("<Shift-Right>", "forward")
bind("<Shift-h>", "back")
bind("<Shift-j>", "tab-prev")
bind("<Shift-k>", "tab-next")
bind("<Shift-l>", "forward")

# ---------------------------------------------------------------------------
# Command mode
# ---------------------------------------------------------------------------

bind("<Ctrl-n>", "completion-item-focus next", mode="command")
bind("<Ctrl-p>", "completion-item-focus prev", mode="command")
bind("<Ctrl-j>", "completion-item-focus next", mode="command")
bind("<Ctrl-k>", "completion-item-focus prev", mode="command")
bind("<Ctrl-Down>", "command-history-next", mode="command")
bind("<Ctrl-Up>", "command-history-prev", mode="command")

# ---------------------------------------------------------------------------
# Bookmarks
# ---------------------------------------------------------------------------

bind("b", "buku-dmenu")
bind("B", "buku-random")

# ---------------------------------------------------------------------------
# Downloads
# ---------------------------------------------------------------------------

bind("gD", "spawn -u qute-downloads")

# ---------------------------------------------------------------------------
# Images
# ---------------------------------------------------------------------------

bind(";ii", "hint images")
bind(";iy", "hint images yank")
bind(";it", "hint images tab")
bind(";id", "hint images download")
bind(";iT", "hint --rapid images tab")
bind(";iD", "hint --rapid images download")

# ---------------------------------------------------------------------------
# RSS
# ---------------------------------------------------------------------------

bind("gF", "spawn -u openfeeds")

# ---------------------------------------------------------------------------
# Password management
# ---------------------------------------------------------------------------

bind("\\pl", "gopass-login-path")
bind("\\pL", "gopass-login-secret")
bind("\\pu", "gopass-username-path")
bind("\\pU", "gopass-username-secret")
bind("\\pp", "gopass-password")
bind("\\po", "gopass-otp")

# ---------------------------------------------------------------------------
# Tridactyl quickmarks
# ---------------------------------------------------------------------------

qsites = {
    "1": "chat.deepseek.com",
    "2": "perplexity.ai",
    "3": "duck.ai",
    "a": "anilist.co/user/Frestein",
    "s": instance_4get,
    "S": instance_searxng,
    "d": "duckduckgo.com",
    "g": "codeberg.org/Frestein",
    "G": "github.com/Frestein",
    "e": "mail.google.com/mail/u/2/",
    "E": "app.tuta.com",
    "m": "music.youtube.com",
    "M": "last.fm/user/Frestein",
    "k": "kinopoisk.ru/user/frestein/movies/planned-to-watch",
    "t": f"{instance_mozhi}/?engine=yandex&from=auto&to=ru",
    "T": "translate.google.com",
    "c": "coub.com/community/anime",
    "y": "youtube.com",
    "p": "pinterest.com",
    "r": "reddit.com",
}

for k, v in qsites.items():
    bind("go" + k, "open " + v)
    bind("gn" + k, "open -t " + v)

# ---------------------------------------------------------------------------
# Kinopoisk
# ---------------------------------------------------------------------------

bind("\\k", "kinopoisk-to-cx")

# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------

bind("\\gc", "git-clone")

# ---------------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------------

bind("\\qr", "qr")
bind("tt", "translate")
bind("tt", "translate", mode="caret")
bind("cm", "clear-messages")
bind(";c", "hint code userscript qute-code-hint")

# fmt: on
