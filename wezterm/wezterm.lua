local wezterm = require("wezterm")
local config = {}

-- カラースキームは全体のANSIカラーや標準配色のベースになる。
config.color_scheme = "UltraViolent"

-- HackGenを優先して使う。Nerd Font系の記号や日本語表示が崩れにくい。
config.font = wezterm.font_with_fallback({ { family = "HackGen", weight = "Bold" } })

-- 行間。少し広げると日本語やPowerline記号が詰まりにくい。
config.line_height = 1.1

config.font_size = 15

-- ウィンドウ背景の縦グラデーション。
config.window_background_gradient = {
	orientation = "Vertical",
	interpolation = "Linear",
	blend = "Rgb",
	colors = { "#021b22", "#011318", "#050509" },
}

-- タブバーの色。背景色、アクティブタブ、非アクティブタブ、ホバー時を個別に指定する。
config.colors = {
	tab_bar = {
		background = "#011318",
		active_tab = {
			bg_color = "#021b22",
			fg_color = "#d6f3f5",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#050509",
			fg_color = "#7f9ca3",
		},
		inactive_tab_hover = {
			bg_color = "#032b34",
			fg_color = "#d6f3f5",
		},
		new_tab = {
			bg_color = "#050509",
			fg_color = "#7f9ca3",
		},
		new_tab_hover = {
			bg_color = "#021b22",
			fg_color = "#d6f3f5",
		},
	},
}

-- macOSのタイトルバー周辺の色。
config.window_frame = {
	active_titlebar_bg = "#021b22",
	inactive_titlebar_bg = "#021b22",
	active_titlebar_fg = "#d6f3f5",
	inactive_titlebar_fg = "#7f9ca3",
}

-- WezTerm内蔵ボタンを使いつつ、ウィンドウリサイズは有効にする。
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- macOSのタイトルバー色を背景色に合わせるための環境変数。
config.set_environment_variables = {
	MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR = "1",
}

-- config.colors = {
--   cursor_fg = '#000000',
--   cursor_bg = '#c0c0c0',
--   -- base setting
--   foreground = '#00ff00',
--   background = '#000000',
-- }

-- config.colors = {
--     cursor_bg = '#0fcc0f'
-- }

-- 右側ステータスバーを更新するイベント。
-- 現在ディレクトリ、ホスト名、時刻、バッテリーをPowerline風に表示する。
wezterm.on("update-right-status", function(window, pane)
	local overrides = window:get_config_overrides()
	if overrides and overrides.window_background_gradient then
		overrides.window_background_gradient = nil
		window:set_config_overrides(overrides)
	end

	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		local cwd = ""
		local hostname = ""
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- Remove the domain name portion of the hostname
			local dot = hostname:find("[.]")
			if dot then
				hostname = hostname:sub(1, dot - 1)
			end
			-- and extract the cwd from the uri
			cwd = cwd_uri:sub(slash)

			table.insert(cells, cwd)
			table.insert(cells, hostname)
		end
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	-- The powerline < symbol
	local LEFT_ARROW = utf8.char(0xe0b3)
	-- The filled in variant of the < symbol
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Color palette for the backgrounds of each cell
	local colors = { "#3c1361", "#52307c", "#663a82", "#7c5295", "#b491c8" }

	-- Foreground color for the text across the fade
	local text_fg = "#c0c0c0"

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, {
			Foreground = {
				Color = text_fg,
			},
		})
		table.insert(elements, {
			Background = {
				Color = colors[cell_no],
			},
		})
		table.insert(elements, {
			Text = " " .. text .. " ",
		})
		if not is_last then
			table.insert(elements, {
				Foreground = {
					Color = colors[cell_no + 1],
				},
			})
			table.insert(elements, {
				Text = SOLID_LEFT_ARROW,
			})
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

-- システムベル音を有効化（Claude Codeのタスク完了通知用）
config.audible_bell = "SystemBeep"

-- キーバインド。
-- Ctrl+\ / Ctrl+- でペイン分割、Ctrl+h/j/k/l でペイン移動、Shift+Enterで改行を送信する。
config.keys = {
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\n"),
	},
}

return config
