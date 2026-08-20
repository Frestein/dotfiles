-- ============================================================================
-- General settings
-- ============================================================================
swayimg.mode = "viewer"
swayimg.set_window_size(1280, 720)
swayimg.overlay = false
swayimg.decoration = false
swayimg.dnd_button = "Shift-MouseRight"

-- Signal handlers (SIGUSR1/SIGUSR2)
swayimg.viewer.on_signal("USR1", function()
	swayimg.viewer.reload()
end)
swayimg.viewer.on_signal("USR2", function()
	swayimg.viewer.open("next")
end)

-- ============================================================================
-- Image list
-- ============================================================================
swayimg.imagelist.order = "alpha"
swayimg.imagelist.reverse = false
swayimg.imagelist.recursive = false
swayimg.imagelist.adjacent = true
swayimg.imagelist.fsmon = true

-- ============================================================================
-- Font & text layer (global)
-- ============================================================================
swayimg.text.font = "monospace"
swayimg.text.size = 12
swayimg.text.color = 0xffebdbb2
swayimg.text.shadow = 0xd0000000
swayimg.text.background = 0x00000000
swayimg.text.padding = 10
swayimg.text.timeout = 5
swayimg.text.status_timeout = 3
swayimg.text.visible = false

-- ============================================================================
-- Viewer mode
-- ============================================================================
-- Background & transparency
swayimg.viewer.set_window_background(0xff282828)
swayimg.viewer.set_image_chessboard(10, 0xffaaaaaa, 0xff555555)

-- Scale, position, antialiasing
local antialiasing_enabled = true

-- Force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
	local mode = swayimg.mode
	if mode == "viewer" then
		swayimg.viewer.set_fix_scale("optimal")
	elseif mode == "slideshow" then
		swayimg.slideshow.set_fix_scale("optimal")
	end
end)
swayimg.viewer.default_position = "center"
swayimg.antialiasing = antialiasing_enabled
swayimg.viewer.loop = true
swayimg.viewer.history = 50
swayimg.viewer.preload = 25

-- Text overlay
swayimg.viewer.set_text("topleft", {
	"{name}",
	"{format}",
	"{sizehr}",
	"{frame.width}x{frame.height}",
	"{meta.*}",
})
swayimg.viewer.set_text("topright", {
	"{list.index}/{list.total}",
})
swayimg.viewer.set_text("bottomleft", {
	"{scale}%",
	"{frame.index}/{frame.total}",
})

-- ============================================================================
-- Slideshow mode
-- ============================================================================
swayimg.slideshow.timeout = 5
swayimg.slideshow.set_window_background(0xff282828)
swayimg.slideshow.set_image_chessboard(10, 0xffaaaaaa, 0xff555555)
swayimg.slideshow.default_scale = "optimal"
swayimg.slideshow.default_position = "center"
swayimg.slideshow.loop = true
swayimg.slideshow.autocenter = true
swayimg.slideshow.preload = 25
swayimg.slideshow.history = 50

-- Text overlay
swayimg.slideshow.set_text("bottomright", {
	"{dir}",
	"Status: {status}",
})

-- ============================================================================
-- Gallery mode
-- ============================================================================
swayimg.gallery.thumb_size = 200
swayimg.gallery.selected_scale = 1.15
swayimg.gallery.aspect = "fill"
swayimg.gallery.padding_size = 5
swayimg.gallery.selected_color = 0xff3c3836
swayimg.gallery.unselected_color = 0xff32302f
swayimg.gallery.border_color = 0xff928374
swayimg.gallery.border_size = 4
swayimg.gallery.window_color = 0xff282828
swayimg.gallery.cache = 100
swayimg.gallery.preload = true
swayimg.gallery.pstore = false

-- Text overlay
swayimg.gallery.set_text("bottomright", {
	"{name}",
	"Status: {status}",
})

-- ============================================================================
-- Key bindings – helper functions
-- ============================================================================
local viewer = swayimg.viewer

local function step_left(dx)
	local pos = viewer.get_position()
	viewer.position = { x = pos.x + dx, y = pos.y }
end
local function step_right(dx)
	local pos = viewer.get_position()
	viewer.position = { x = pos.x - dx, y = pos.y }
end
local function step_up(dy)
	local pos = viewer.get_position()
	viewer.position = { x = pos.x, y = pos.y + dy }
end
local function step_down(dy)
	local pos = viewer.get_position()
	viewer.position = { x = pos.x, y = pos.y - dy }
end
local function zoom(amount)
	local scale = viewer.scale
	viewer.scale = scale + amount
end

-- ============================================================================
-- Viewer mode key bindings
-- ============================================================================

-- Navigation
viewer.on_key("Home", function()
	viewer.open("first")
end)
viewer.on_key("End", function()
	viewer.open("last")
end)
viewer.on_key("g", function()
	viewer.open("first")
end)
viewer.on_key("Shift+g", function()
	viewer.open("last")
end)
viewer.on_key("Prior", function()
	viewer.open("prev")
end)
viewer.on_key("Next", function()
	viewer.open("next")
end)
viewer.on_key("h", function()
	viewer.open("prev")
end)
viewer.on_key("j", function()
	viewer.open("next")
end)
viewer.on_key("k", function()
	viewer.open("prev")
end)
viewer.on_key("l", function()
	viewer.open("next")
end)
viewer.on_key("Shift+Space", function()
	viewer.open("prev")
end)
viewer.on_key("Space", function()
	viewer.open("next")
end)
viewer.on_key("Shift+r", function()
	viewer.open("random")
end)
viewer.on_key("Shift+d", function()
	viewer.open("prev_dir")
end)
viewer.on_key("d", function()
	viewer.open("next_dir")
end)
viewer.on_key("Shift+o", function()
	viewer.frame = viewer.frame - 1
end)
viewer.on_key("o", function()
	viewer.frame = viewer.frame + 1
end)

-- Special actions
viewer.on_key("s", function()
	swayimg.mode = "slideshow"
end)
viewer.on_key("n", function()
	viewer.animation = false
end)
viewer.on_key("f", function()
	swayimg.fullscreen = not swayimg.fullscreen
end)
viewer.on_key("Return", function()
	swayimg.mode = "gallery"
end)

-- Movement & zoom
viewer.on_key("Left", function()
	step_left(10)
end)
viewer.on_key("Right", function()
	step_right(10)
end)
viewer.on_key("Up", function()
	step_up(10)
end)
viewer.on_key("Down", function()
	step_down(10)
end)
viewer.on_key("Equal", function()
	zoom(0.1)
end)
viewer.on_key("Plus", function()
	zoom(0.1)
end)
viewer.on_key("Minus", function()
	zoom(-0.1)
end)
viewer.on_key("w", function()
	viewer.set_fix_scale("width")
end)
viewer.on_key("Shift+w", function()
	viewer.set_fix_scale("height")
end)
viewer.on_key("z", function()
	viewer.set_fix_scale("fit")
end)
viewer.on_key("Shift+z", function()
	viewer.set_fix_scale("fill")
end)
viewer.on_key("0", function()
	viewer.set_fix_scale("real")
end)
viewer.on_key("BackSpace", function()
	viewer.set_fix_scale("optimal")
end)
viewer.on_key("Alt+z", function()
	viewer.set_fix_scale("keep")
end)
viewer.on_key("Alt+s", function()
	viewer.set_fix_scale("optimal")
end)
viewer.on_key("Alt+p", function()
	viewer.set_fix_position("center")
end)

-- Transformations
viewer.on_key("bracketleft", function()
	viewer.rotate(90)
end)
viewer.on_key("bracketright", function()
	viewer.rotate(270)
end)
viewer.on_key("m", function()
	viewer.flip_vertical()
end)
viewer.on_key("Shift+m", function()
	viewer.flip_horizontal()
end)

-- Misc
viewer.on_key("a", function()
	antialiasing_enabled = not antialiasing_enabled
	swayimg.antialiasing = antialiasing_enabled
end)
viewer.on_key("r", function()
	viewer.reload()
end)
viewer.on_key("Delete", function()
	local img = viewer.get_image()
	if img then
		os.execute('trash-put "' .. img.path .. '"')
		viewer.open("next")
	end
end)
viewer.on_key("Shift+Delete", function()
	local img = viewer.get_image()
	if img then
		os.execute('rm -f "' .. img.path .. '"')
		viewer.open("next")
	end
end)
viewer.on_key("q", function()
	swayimg.exit()
end)

-- Mouse bindings
viewer.on_mouse("ScrollLeft", function()
	step_right(5)
end)
viewer.on_mouse("ScrollRight", function()
	step_left(5)
end)
viewer.on_mouse("ScrollUp", function()
	viewer.open("prev")
end)
viewer.on_mouse("ScrollDown", function()
	viewer.open("next")
end)
viewer.on_mouse("Ctrl+ScrollUp", function()
	zoom(0.1)
end)
viewer.on_mouse("Ctrl+ScrollDown", function()
	zoom(-0.1)
end)
viewer.on_mouse("Shift+ScrollUp", function()
	step_up(5)
end)
viewer.on_mouse("Shift+ScrollDown", function()
	step_down(5)
end)
viewer.on_mouse("Shift+ScrollLeft", function()
	step_left(5)
end)
viewer.on_mouse("Shift+ScrollRight", function()
	step_right(5)
end)
viewer.on_mouse("Alt+ScrollUp", function()
	viewer.prev_frame()
end)
viewer.on_mouse("Alt+ScrollDown", function()
	viewer.next_frame()
end)
viewer.on_mouse("MouseLeft", function()
	viewer.drag_button = "MouseLeft"
end)
viewer.on_mouse("MouseSide", function()
	viewer.open("prev")
end)
viewer.on_mouse("MouseExtra", function()
	viewer.open("next")
end)
viewer.on_mouse("MouseRight", function()
	swayimg.mode = "gallery"
end)

-- ============================================================================
-- Slideshow mode key bindings
-- ============================================================================
local slideshow = swayimg.slideshow

slideshow.on_key("Home", function()
	slideshow.open("first")
end)
slideshow.on_key("End", function()
	slideshow.open("last")
end)
slideshow.on_key("g", function()
	slideshow.open("first")
end)
slideshow.on_key("Shift+g", function()
	slideshow.open("last")
end)
slideshow.on_key("Prior", function()
	slideshow.open("prev")
end)
slideshow.on_key("Next", function()
	slideshow.open("next")
end)
slideshow.on_key("Left", function()
	slideshow.open("prev")
end)
slideshow.on_key("Right", function()
	slideshow.open("next")
end)
slideshow.on_key("Up", function()
	slideshow.open("prev")
end)
slideshow.on_key("Down", function()
	slideshow.open("next")
end)
slideshow.on_key("h", function()
	slideshow.open("prev")
end)
slideshow.on_key("j", function()
	slideshow.open("next")
end)
slideshow.on_key("k", function()
	slideshow.open("prev")
end)
slideshow.on_key("l", function()
	slideshow.open("next")
end)
slideshow.on_key("Shift+r", function()
	slideshow.open("random")
end)
slideshow.on_key("Shift+d", function()
	slideshow.open("prev_dir")
end)
slideshow.on_key("d", function()
	slideshow.open("next_dir")
end)
slideshow.on_key("Space", function()
	swayimg.slideshow.timeout = 0 -- pause (timeout 0 stops timer)
end)
slideshow.on_key("f", function()
	swayimg.fullscreen = not swayimg.fullscreen
end)
slideshow.on_key("Delete", function()
	local img = swayimg.slideshow.get_image()
	if img then
		os.execute('trash-put "' .. img.path .. '"')
		slideshow.open("next")
	end
end)
slideshow.on_key("Shift+Delete", function()
	local img = swayimg.slideshow.get_image()
	if img then
		os.execute('rm -f "' .. img.path .. '"')
		slideshow.open("next")
	end
end)
slideshow.on_key("Return", function()
	swayimg.mode = "viewer"
end)
slideshow.on_key("q", function()
	swayimg.exit()
end)
slideshow.on_mouse("MouseRight", function()
	swayimg.mode = "gallery"
end)

-- ============================================================================
-- Gallery mode key bindings
-- ============================================================================
local gallery = swayimg.gallery

gallery.on_key("Home", function()
	gallery.select("first")
end)
gallery.on_key("End", function()
	gallery.select("last")
end)
gallery.on_key("g", function()
	gallery.select("first")
end)
gallery.on_key("Shift+g", function()
	gallery.select("last")
end)
gallery.on_key("Left", function()
	gallery.select("left")
end)
gallery.on_key("Right", function()
	gallery.select("right")
end)
gallery.on_key("Up", function()
	gallery.select("up")
end)
gallery.on_key("Down", function()
	gallery.select("down")
end)
gallery.on_key("h", function()
	gallery.select("left")
end)
gallery.on_key("j", function()
	gallery.select("down")
end)
gallery.on_key("k", function()
	gallery.select("up")
end)
gallery.on_key("l", function()
	gallery.select("right")
end)
gallery.on_key("Prior", function()
	gallery.select("pgup")
end)
gallery.on_key("Next", function()
	gallery.select("pgdown")
end)
gallery.on_key("s", function()
	swayimg.mode = "slideshow"
end)
gallery.on_key("f", function()
	swayimg.fullscreen = not swayimg.fullscreen
end)
gallery.on_key("Return", function()
	swayimg.mode = "viewer"
end)
gallery.on_key("a", function()
	antialiasing_enabled = not antialiasing_enabled
	swayimg.antialiasing = antialiasing_enabled
end)
gallery.on_key("r", function()
	gallery.reload()
end)
gallery.on_key("Equal", function()
	gallery.thumb_size = gallery.thumb_size + 20
end)
gallery.on_key("Plus", function()
	gallery.thumb_size = gallery.thumb_size + 20
end)
gallery.on_key("Minus", function()
	gallery.thumb_size = gallery.thumb_size - 20
end)
gallery.on_key("Delete", function()
	local img = gallery.get_image()
	if img then
		os.execute('trash-put "' .. img.path .. '"')
		gallery.select("next")
	end
end)
gallery.on_key("Shift+Delete", function()
	local img = gallery.get_image()
	if img then
		os.execute('rm -f "' .. img.path .. '"')
		gallery.select("next")
	end
end)
gallery.on_key("q", function()
	swayimg.exit()
end)

-- Mouse bindings for gallery
gallery.on_mouse("ScrollLeft", function()
	gallery.select("left")
end)
gallery.on_mouse("ScrollRight", function()
	gallery.select("right")
end)
gallery.on_mouse("ScrollUp", function()
	gallery.select("up")
end)
gallery.on_mouse("ScrollDown", function()
	gallery.select("down")
end)
gallery.on_mouse("Ctrl+ScrollUp", function()
	gallery.thumb_size = gallery.thumb_size + 20
end)
gallery.on_mouse("Ctrl+ScrollDown", function()
	gallery.thumb_size = gallery.thumb_size - 20
end)
