local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- copying with keyboard (in short - CTRL+SHIFT+X - enter the mode)
-- https://wezterm.org/copymode.html

----- MISC -----
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

----- WINDOW -----
-- config.initial_rows = 58
-- config.initial_cols = 240
config.initial_rows = 60
config.initial_cols = 120
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
	border_left_width = "0.2cell",
	border_right_width = "0.2cell",
	border_bottom_height = "0.1cell",
	border_top_height = "0.1cell",
	border_left_color = "#1e293b",
	border_right_color = "#1e293b",
	border_bottom_color = "#1e293b",
	border_top_color = "#1e293b",
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 0,
}
-- config.window_background_opacity = 0.84
-- config.macos_window_background_blur = 15

----- FONT -----
config.font_size = 16
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Medium",
		-- DISABLE LIGATURES (triple =, arrow functions)
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	},
})

----- TAB BAR -----
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
-- config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.colors = {
	split = "#495565",
	tab_bar = {
		background = "rgb(0,0,0)",
		-- background = "#1e293b",
	},
}
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end
wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
	local edge_background = "#000000"
	-- local background = "#1e293b"
	local background = "#000000"
	local foreground = "#808080"

	if tab.is_active then
		background = "#000000"
		foreground = "#ffffff"
	elseif hover then
		background = "#1b1b32"
		foreground = "#909090"
	end

	local edge_foreground = background
	local title = tab_title(tab)
	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	local text = { Text = "  " .. title .. "  " }
	if #tabs == 1 then
		text = { Text = "  " }
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		text,
		{ Background = { Color = edge_foreground } },
		{ Foreground = { Color = "#909090" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		-- { Text = " " },
	}
end)
-- format_tab_title - https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
-- nerdfont icons - https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html

----- PANES -----
config.inactive_pane_hsb = {
	-- saturation = 0.4,
	brightness = 0.5,
}

----- KEYBINDINGS -----
local act = wezterm.action
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "d",
		mods = "CMD",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{ key = "UpArrow", mods = "CMD", action = act.ScrollByLine(-5) },
	{ key = "DownArrow", mods = "CMD", action = act.ScrollByLine(5) },
	{
		key = "H",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "K",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "J",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "OPT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "OPT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "k",
		mods = "OPT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "j",
		mods = "OPT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "e",
		mods = "CMD",
		action = act.ResetFontAndWindowSize,
	},
	{
		key = "p",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
}

--- BACKGROUND IMAGE -----
-- config.window_background_image = "/Users/bodya/.config/wezterm/background3.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- 	hue = 1.0,
-- 	saturation = 1.0,
-- }
-- config.background = {
-- 	{
-- 		source = { File = "/Users/bodya/.config/wezterm/background.jpg" },
-- 		vertical_align = "Middle",
-- 		horizontal_align = "Center",
-- 		height = "Contain",
-- 		-- width = "Contain",
-- 		hsb = { brightness = 0.1 },
-- 	},
-- }

return config

-- OLD CONFIG
-- ========================================================================
-- local wezterm = require("wezterm")
-- local config = wezterm.config_builder()
--
-- -- copying with keyboard (in short - CTRL+SHIFT+X - enter the mode)
-- -- https://wezterm.org/copymode.html
--
-- ----- MISC -----
-- -- config.color_scheme = "iTerm2 Default"
-- -- config.color_scheme = "rose-pine"
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 500
--
-- ----- WINDOW -----
-- -- config.initial_rows = 58
-- -- config.initial_cols = 240
-- config.initial_rows = 50
-- config.initial_cols = 100
-- -- config.window_decorations = "RESIZE"
-- -- INTEGRATED_BUTTONS|RESIZE
-- config.window_frame = {
-- 	border_left_width = "0.2cell",
-- 	border_right_width = "0.2cell",
-- 	border_bottom_height = "0.1cell",
-- 	-- border_top_height = "0.2cell",
-- 	border_left_color = "#1e293b",
-- 	border_right_color = "#1e293b",
-- 	border_bottom_color = "#1e293b",
-- 	border_top_color = "#1e293b",
-- }
-- -- config.window_frame = {}
-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 2,
-- 	bottom = 0,
-- }
-- config.window_background_opacity = 0.84
-- config.macos_window_background_blur = 15
--
-- ----- FONT -----
-- config.font_size = 16
-- config.font = wezterm.font_with_fallback({
-- 	{
-- 		family = "JetBrainsMono Nerd Font",
-- 		weight = "Medium",
-- 		-- DISABLE LIGATURES (triple =, arrow functions)
-- 		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
-- 	},
-- })
--
-- ----- TAB BAR -----
-- config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
-- config.show_new_tab_button_in_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.show_tab_index_in_tab_bar = true
-- config.colors = {
-- 	split = "#495565",
-- 	tab_bar = {
-- 		background = "rgba(0,0,0,0)",
-- 		-- background = "#1e293b",
-- 	},
-- }
-- local function tab_title(tab_info)
-- 	local title = tab_info.tab_title
-- 	-- if the tab title is explicitly set, take that
-- 	if title and #title > 0 then
-- 		return title
-- 	end
-- 	-- Otherwise, use the title from the active pane
-- 	-- in that tab
-- 	return tab_info.active_pane.title
-- end
-- wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
-- 	local edge_background = "#000000"
-- 	local background = "#1e293b"
-- 	local foreground = "#808080"
--
-- 	if tab.is_active then
-- 		background = "#000000"
-- 		foreground = "#ffffff"
-- 	elseif hover then
-- 		background = "#1b1b32"
-- 		foreground = "#909090"
-- 	end
--
-- 	local edge_foreground = background
-- 	local title = tab_title(tab)
-- 	-- ensure that the titles fit in the available space,
-- 	-- and that we have room for the edges.
-- 	title = wezterm.truncate_right(title, max_width - 2)
--
-- 	return {
-- 		{ Background = { Color = edge_background } },
-- 		{ Foreground = { Color = edge_foreground } },
-- 		{ Background = { Color = background } },
-- 		{ Foreground = { Color = foreground } },
-- 		{ Text = "  " .. tab.tab_index + 1 .. ":" .. title .. "  " },
-- 		{ Background = { Color = edge_foreground } },
-- 		{ Foreground = { Color = "#909090" } },
-- 		{ Background = { Color = edge_background } },
-- 		{ Foreground = { Color = edge_foreground } },
-- 		-- { Text = " " },
-- 	}
-- end)
-- -- format_tab_title - https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
-- -- nerdfont icons - https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
--
-- ----- PANES -----
-- config.inactive_pane_hsb = {
-- 	-- saturation = 0.4,
-- 	brightness = 0.5,
-- }
--
-- ----- KEYBINDINGS -----
-- local act = wezterm.action
-- config.keys = {
-- 	{
-- 		key = "w",
-- 		mods = "CMD",
-- 		action = act.CloseCurrentPane({ confirm = false }),
-- 	},
-- 	{
-- 		key = "d",
-- 		mods = "CMD",
-- 		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{
-- 		key = "d",
-- 		mods = "CMD|SHIFT",
-- 		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{ key = "UpArrow", mods = "CMD", action = act.ScrollByLine(-5) },
-- 	{ key = "DownArrow", mods = "CMD", action = act.ScrollByLine(5) },
-- 	{
-- 		key = "H",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Left"),
-- 	},
-- 	{
-- 		key = "L",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Right"),
-- 	},
-- 	{
-- 		key = "K",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Up"),
-- 	},
-- 	{
-- 		key = "J",
-- 		mods = "CTRL",
-- 		action = act.ActivatePaneDirection("Down"),
-- 	},
-- 	{
-- 		key = "h",
-- 		mods = "OPT",
-- 		action = act.AdjustPaneSize({ "Left", 5 }),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "OPT",
-- 		action = act.AdjustPaneSize({ "Right", 5 }),
-- 	},
-- 	{
-- 		key = "k",
-- 		mods = "OPT",
-- 		action = act.AdjustPaneSize({ "Up", 5 }),
-- 	},
-- 	{
-- 		key = "j",
-- 		mods = "OPT",
-- 		action = act.AdjustPaneSize({ "Down", 5 }),
-- 	},
-- 	{
-- 		key = "e",
-- 		mods = "CMD",
-- 		action = act.ResetFontAndWindowSize,
-- 	},
-- 	{
-- 		key = "p",
-- 		mods = "CTRL",
-- 		action = wezterm.action.ActivateTabRelative(-1),
-- 	},
-- 	{
-- 		key = "n",
-- 		mods = "CTRL",
-- 		action = wezterm.action.ActivateTabRelative(1),
-- 	},
-- }
--
-- --- BACKGROUND IMAGE -----
-- -- config.window_background_image = "/Users/bodya/.config/wezterm/background3.jpg"
-- -- config.window_background_image_hsb = {
-- -- 	brightness = 0.1,
-- -- 	hue = 1.0,
-- -- 	saturation = 1.0,
-- -- }
-- -- config.background = {
-- -- 	{
-- -- 		source = { File = "/Users/bodya/.config/wezterm/background.jpg" },
-- -- 		vertical_align = "Middle",
-- -- 		horizontal_align = "Center",
-- -- 		height = "Contain",
-- -- 		-- width = "Contain",
-- -- 		hsb = { brightness = 0.1 },
-- -- 	},
-- -- }
--
-- return config
