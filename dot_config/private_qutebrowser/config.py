# Requirements:
# - python-adblock
# - python-pyperclip (qute-code-hint)
# - python-protobuf

import os.path

# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103G

# pylint: disable=C0111
from qutebrowser.config.config import ConfigContainer  # noqa: E402, F401
from qutebrowser.config.configfiles import ConfigAPI  # noqa: E402, F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

# Fix 'TrustedHTML' error
c.content.javascript.log_message.excludes = {
    "userscript:_qute_stylesheet": [
        "*Refused to apply inline style because it violates the following Content Security Policy directive: *"
    ],
    "userscript:_qute_js": ["*TrustedHTML*"],
}

###############################################################################
# Variables and constants
###############################################################################

# Tridactyl quickmarks
qsites = {
    "A": "chat.deepseek.com",
    "G": "github.com",
    "S": "priv.au",
    "a": "duck.ai",
    "g": "codeberg.org",
    "m": "app.tuta.com",
    "r": "www.perplexity.ai",
    "s": "4get.tux.pizza",
    "t": "deepl.com/en/translator#en/ru/",
    "y": "youtube.com",
}

DMENU_CMD = f"fuzzel -d --config={os.path.join(os.path.expanduser('~'), '.config', 'hypr', 'fuzzel', 'fuzzel.ini')}"
QUTE_PASS = f"{os.path.expanduser('~')}/.config/qutebrowser/userscripts/qute-pass"

###############################################################################
# General settings
###############################################################################

config.load_autoconfig(True)

c.editor.command = [
    "xdg-terminal-exec",
    "nvim",
    "{file}",
    "-c",
    "normal {line}G{column0}l",
]
c.spellcheck.languages = ["en-US", "ru-RU"]

c.url.default_page = "https://4get.tux.pizza/"
c.url.start_pages = "https://4get.tux.pizza/"
c.url.searchengines = {
    "DEFAULT": "https://4get.tux.pizza/web?s={}",
    "4get": "https://4get.tux.pizza/web?s={}",
    "alter": "https://openalternative.co/?q={}",
    "anilist": "https://anilist.co/search/anime?search={}",
    "aur": "https://aur.archlinux.org/packages?&K={}",
    "aw": "https://wiki.archlinux.org/index.php?search={}",
    "ddg": "https://duckduckgo.com/?q={}",
    "deepl": "https://www.deepl.com/en/translator#en/ru/{}",
    "gh": "https://github.com/search?q={}",
    "maps": "https://www.google.com/maps?q={}",
    "reddit": "https://www.reddit.com/r/{}/",
    "rutracker": "https://rutracker.org/forum/tracker.php?nm={}",
    "searxng": "https://priv.au/?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "kino": "https://www.kinopoisk.ru/index.php?kp_query={}",
    "zerochan": "https://www.zerochan.net/{}",
    "protondb": "https://www.protondb.com/search?q={}",
}

c.fileselect.handler = "external"
c.fileselect.single_file.command = [
    "footclient",
    "-T",
    "foot-yazi-flt",
    "yazi",
    "--chooser-file",
    "{}",
]
c.fileselect.multiple_files.command = [
    "footclient",
    "-T",
    "foot-yazi-flt",
    "yazi",
    "--chooser-file",
    "{}",
]
c.fileselect.folder.command = [
    "footclient",
    "-T",
    "foot-yazi-flt",
    "yazi",
    "--chooser-file",
    "{}",
]

# Langmap
config.unbind(".")
en_keys = "qwertyuiop[]asdfghjkl;'zxcvbnm,./" + 'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
ru_keys = "йцукенгшщзхъфывапролджэячсмитьбю." + "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,"
c.bindings.key_mappings.update(dict(zip(ru_keys, en_keys)))

###############################################################################
# Content settings
###############################################################################

config.set("content.cookies.accept", "all", "chrome-devtools://*")
config.set("content.cookies.accept", "all", "devtools://*")

config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:133.0) Gecko/20100101 Firefox/133.0",
    "https://accounts.google.com/*",
)

config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")

config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

config.set(
    "content.local_content_can_access_remote_urls",
    True,
    "file:///home/frestein/.local/share/qutebrowser/userscripts/*",
)
config.set(
    "content.local_content_can_access_file_urls",
    False,
    "file:///home/frestein/.local/share/qutebrowser/userscripts/*",
)

################################################################################
# Advertising blocking
################################################################################

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

################################################################################
# UI settings
################################################################################

config.source("gruvbox.py")
c.tabs.background = True
c.scrolling.smooth = True
c.downloads.position = "bottom"

c.hints.radius = 0
c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre",
]

c.fonts.hints = "bold 12px Maple Mono, Monospace"

################################################################################
# Other settings
################################################################################

c.window.title_format = "{perc}{current_title}{title_sep}qutebrowser"
c.new_instance_open_target = "tab"
c.content.autoplay = False
c.content.fullscreen.overlay_timeout = 0
c.downloads.location.prompt = False
c.auto_save.session = True
c.session.lazy_restore = True
c.completion.cmd_history_max_items = 10000

################################################################################
# Aliases
################################################################################

c.aliases = config.get("aliases", {})
c.aliases.update(
    {
        "bk": "spawn -u qute-buku",
        "qr": "spawn -u qr",
        "translate": "spawn -u translate",
    }
)

################################################################################
# Bindings
################################################################################

# Configuration management
config.bind(",cs", "config-source")
config.bind(",ce", "config-edit")
config.bind(",ca", "adblock-update")
config.bind(",b", "config-cycle content.blocking.enabled true false")
config.bind(",cg", "greasemonkey-reload")
config.bind(",p", "config-cycle -p content.plugins ;; reload")

# External editor
config.bind("<Alt-e>", "edit-text")
config.bind("<Alt-v>", "edit-text")
config.bind("<Alt-c>", "cmd-edit")
config.bind("<Alt-u>", "edit-url")
config.bind("<Alt-e>", "edit-text", mode="insert")
config.bind("<Alt-v>", "edit-text", mode="insert")

# Tabs
config.bind("gT", "cmd-set-text -s :tab-take")
config.bind("gD", "cmd-set-text -s :tab-give")

# Media
config.bind(",m", "spawn umpv {url}")
config.bind(";m", "hint --rapid links spawn umpv {hint-url}")

# Navigation
config.bind("<Shift-Left>", "back")
config.bind("<Shift-Down>", "tab-prev")
config.bind("<Shift-Up>", "tab-next")
config.bind("<Shift-Right>", "forward")
config.bind("<Shift-h>", "back")
config.bind("<Shift-j>", "tab-prev")
config.bind("<Shift-k>", "tab-next")
config.bind("<Shift-l>", "forward")

# Quick actions
config.bind(",qr", "qr")
config.bind("tt", "translate")
config.bind("tt", "translate", mode="caret")
config.bind("cm", "clear-messages")
config.bind(";c", "hint code userscript qute-code-hint")

# Bookmarks
config.bind("b", "spawn -u qute-buku dmenu")

# Downloads
config.bind(",d", "spawn -u qute-downloads")

# Images
config.unbind(";i")
config.unbind(";I")
config.bind(";ii", "hint images")
config.bind(";iy", "hint images yank")
config.bind(";it", "hint images tab")
config.bind(";id", "hint images download")
config.bind(";iT", "hint --rapid images tab")
config.bind(";iD", "hint --rapid images download")

# RSS
config.bind("gF", "spawn -u openfeeds")

# Password management (gopass)
config.bind(
    "zl",
    f"spawn -u {QUTE_PASS} -d '{DMENU_CMD}' -M gopass --username-target secret --username-pattern 'login: (.+)'",
)
config.bind(
    "zul",
    f"spawn -u {QUTE_PASS} -d '{DMENU_CMD}' -M gopass --username-only --username-target secret --username-pattern 'login: (.+)'",
)
config.bind("zpl", f"spawn -u {QUTE_PASS} -d '{DMENU_CMD}' -M gopass --password-only")
config.bind("zol", f"spawn -u {QUTE_PASS} -d '{DMENU_CMD}' -M gopass --otp-only")

# Quickmarks
for k, v in qsites.items():
    config.bind("gc" + k, "open " + v)
    config.bind("gn" + k, "open -t " + v)


# Kinopoisk
config.bind(
    "cx",
    'jseval window.location.href = window.location.href.replace("kinopoisk.ru", "kinopoisk.cx");',
)

# Git
config.bind("cg", 'spawn xdg-open "git+{url}"')

config.bind("ct", "config-cycle tabs.show multiple switching")
config.bind("cb", "config-cycle statusbar.show always in-mode")
