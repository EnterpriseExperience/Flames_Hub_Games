local g = getgenv and getgenv() or _G
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local UserInputService = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local TweenService = g.TweenService or cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local LP = g.LocalPlayer or Players.LocalPlayer
local PlayerGui = g.PlayerGui or LP:FindFirstChildOfClass("PlayerGui")
local function safe_keycode(name, fallback)
    local ok, kc = pcall(function() return Enum.KeyCode[name] end)
    if ok and kc then return kc end
    return Enum.KeyCode[fallback] or Enum.KeyCode.Q
end

local function random_string(len)
	local length = math.random(10,40)
	local array = {}
	for i = 1, length do array[i] = string.char(math.random(32, 126)) end
	return table.concat(array)
end

local parent_gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or CoreGui or PlayerGui
local THEME = {
    bg           = Color3.fromRGB(15, 15, 15),
    title_bar    = Color3.fromRGB(25, 25, 25),
    section_bg   = Color3.fromRGB(20, 20, 20),
    element_bg   = Color3.fromRGB(30, 30, 30),
    element_hover= Color3.fromRGB(40, 40, 40),
    accent       = Color3.fromRGB(0, 122, 255),
    accent_hover = Color3.fromRGB(30, 142, 255),
    text         = Color3.fromRGB(240, 240, 240),
    text_dim     = Color3.fromRGB(160, 160, 160),
    border       = Color3.fromRGB(50, 50, 50),
    toggle_on    = Color3.fromRGB(0, 122, 255),
    toggle_off   = Color3.fromRGB(60, 60, 60),
    slider_track = Color3.fromRGB(50, 50, 50),
    danger       = Color3.fromRGB(220, 50, 50),
    success      = Color3.fromRGB(50, 200, 100),
    warning      = Color3.fromRGB(220, 160, 0),
    info         = Color3.fromRGB(0, 122, 255),
}

local FONT       = Enum.Font.GothamMedium
local FONT_BOLD  = Enum.Font.GothamBold
local FONT_LIGHT = Enum.Font.Gotham
local PAD        = 8
local EL_H       = 32
local CORNER     = 6
local ANIM_T     = 0.12
local function make_corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or CORNER)
    c.Parent = parent
    return c
end

local function make_stroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or THEME.border
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function make_padding(parent, all)
    local p = Instance.new("UIPadding")
    local u = UDim.new(0, all or PAD)
    p.PaddingLeft   = u
    p.PaddingRight  = u
    p.PaddingTop    = u
    p.PaddingBottom = u
    p.Parent = parent
    return p
end

local function make_list(parent, padding)
    local l = Instance.new("UIListLayout")
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, padding or 4)
    l.Parent = parent
    return l
end

local function make_frame(parent, size, pos, color, name)
    local f = Instance.new("Frame")
    f.Size = size or UDim2.new(1, 0, 0, EL_H)
    f.Position = pos or UDim2.new(0, 0, 0, 0)
    f.BackgroundColor3 = color or THEME.element_bg
    f.BorderSizePixel = 0
    f.Name = name or random_string(8)
    f.Parent = parent
    return f
end

local function make_label(parent, text, size, color, font, xalign)
    local l = Instance.new("TextLabel")
    l.Size = size or UDim2.new(1, 0, 1, 0)
    l.Position = UDim2.new(0, 0, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text or ""
    l.TextColor3 = color or THEME.text
    l.TextSize = 13
    l.Font = font or FONT
    l.TextXAlignment = xalign or Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.Name = random_string(8)
    l.Parent = parent
    return l
end

local function make_button_frame(parent, size, color)
    local f = make_frame(parent, size, nil, color or THEME.element_bg)
    make_corner(f)
    return f
end

local function tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function hover_highlight(frame, base, highlight)
    frame.MouseEnter:Connect(function() tween(frame, { BackgroundColor3 = highlight or THEME.element_hover }) end)
    frame.MouseLeave:Connect(function() tween(frame, { BackgroundColor3 = base or THEME.element_bg }) end)
end

local Lib = {}
Lib.__index = Lib
function Lib.new(title, width, height)
    local self = setmetatable({}, Lib)
    self._windows = self._windows or {}
    local gui_name = random_string()
    local sg = Instance.new("ScreenGui")
    sg.Name = gui_name
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 999
    sg.IgnoreGuiInset = true
    local ok = pcall(function() sg.Parent = parent_gui end)
    if not ok then sg.Parent = PlayerGui end
    self._sg = sg
    return self
end

setmetatable(Lib, {
    __call = function(self, ...)
        return self:Window(...)
    end
})

local _inst = setmetatable({}, Lib)
_inst._windows = {}
local function ensure_sg(self)
    if self._sg and self._sg.Parent then return end
    local sg = Instance.new("ScreenGui")
    sg.Name = random_string(16)
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 999
    sg.IgnoreGuiInset = true
    local ok = pcall(function() sg.Parent = parent_gui end)
    if not ok then sg.Parent = PlayerGui end
    self._sg = sg
end

Lib.ensure_sg = ensure_sg

function Lib:Window(title, width, height)
    if type(self) ~= "table" then
        title, width, height = self, title, width
        self = Lib
    end
    self._windows = self._windows or {}
    ensure_sg(self)
    local win = {}
    win._sections = {}
    local w = width or 320
    local h = height or 480
    local main = Instance.new("Frame")
    main.Name = random_string(8)
    main.Size = UDim2.new(0, w, 0, h)
    main.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    main.BackgroundColor3 = THEME.bg
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = self._sg
    make_corner(main, CORNER)
    make_stroke(main, THEME.border, 1)

    local title_bar = Instance.new("Frame")
    title_bar.Name = "TitleBar"
    title_bar.Size = UDim2.new(1, 0, 0, 36)
    title_bar.BackgroundColor3 = THEME.title_bar
    title_bar.BorderSizePixel = 0
    title_bar.Parent = main

    local accent_line = Instance.new("Frame")
    accent_line.Size = UDim2.new(1, 0, 0, 2)
    accent_line.Position = UDim2.new(0, 0, 1, -2)
    accent_line.BackgroundColor3 = THEME.accent
    accent_line.BorderSizePixel = 0
    accent_line.Parent = title_bar

    local title_lbl = make_label(title_bar, title or "Window", UDim2.new(1, -80, 1, 0), THEME.text, FONT_BOLD, Enum.TextXAlignment.Left)
    title_lbl.TextSize = 14
    make_padding(title_lbl, 10)

    local close_btn = Instance.new("TextButton")
    close_btn.Size = UDim2.new(0, 28, 0, 28)
    close_btn.Position = UDim2.new(1, -34, 0.5, -14)
    close_btn.BackgroundColor3 = THEME.danger
    close_btn.Text = "×"
    close_btn.TextColor3 = THEME.text
    close_btn.TextSize = 16
    close_btn.Font = FONT_BOLD
    close_btn.BorderSizePixel = 0
    close_btn.Name = "CloseBtn"
    close_btn.Parent = title_bar
    make_corner(close_btn, 4)

    local min_btn = Instance.new("TextButton")
    min_btn.Size = UDim2.new(0, 28, 0, 28)
    min_btn.Position = UDim2.new(1, -66, 0.5, -14)
    min_btn.BackgroundColor3 = THEME.element_bg
    min_btn.Text = "−"
    min_btn.TextColor3 = THEME.text
    min_btn.TextSize = 16
    min_btn.Font = FONT_BOLD
    min_btn.BorderSizePixel = 0
    min_btn.Name = "MinBtn"
    min_btn.Parent = title_bar
    make_corner(min_btn, 4)

    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, -38)
    content.Position = UDim2.new(0, 0, 0, 38)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = THEME.accent
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = main
    make_padding(content, PAD)
    make_list(content, 6)

    local minimized = false
    local full_h = h

    min_btn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween(main, { Size = UDim2.new(0, w, 0, 36) })
            content.Visible = false
        else
            tween(main, { Size = UDim2.new(0, w, 0, full_h) })
            content.Visible = true
        end
    end)

    close_btn.MouseButton1Click:Connect(function()
        tween(main, { BackgroundTransparency = 1 })
        task.delay(ANIM_T, function() main:Destroy() end)
    end)

    local drag_start, frame_start
    local dragging = false
    title_bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            drag_start = input.Position
            frame_start = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - drag_start
            main.Position = UDim2.new(frame_start.X.Scale, frame_start.X.Offset + delta.X, frame_start.Y.Scale, frame_start.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    win._main    = main
    win._content = content
    function win:Section(name)
        if type(self) ~= "table" then
            name = self
            self = win
        end

        local sec = {}
        sec._elements = {}
        local sec_frame = Instance.new("Frame")
        sec_frame.Name = random_string(8)
        sec_frame.Size = UDim2.new(1, 0, 0, 0)
        sec_frame.AutomaticSize = Enum.AutomaticSize.Y
        sec_frame.BackgroundColor3 = THEME.section_bg
        sec_frame.BorderSizePixel = 0
        sec_frame.Parent = content
        make_corner(sec_frame, CORNER)
        make_stroke(sec_frame, THEME.border, 1)

        local sec_inner = Instance.new("Frame")
        sec_inner.Name = "Inner"
        sec_inner.Size = UDim2.new(1, 0, 0, 0)
        sec_inner.AutomaticSize = Enum.AutomaticSize.Y
        sec_inner.BackgroundTransparency = 1
        sec_inner.Parent = sec_frame
        make_padding(sec_inner, PAD)
        make_list(sec_inner, 4)

        if name and name ~= "" then
            local hdr = Instance.new("Frame")
            hdr.Size = UDim2.new(1, 0, 0, 24)
            hdr.BackgroundTransparency = 1
            hdr.Name = "Header"
            hdr.LayoutOrder = 0
            hdr.Parent = sec_inner

            local hdr_lbl = make_label(hdr, name:upper(), UDim2.new(1, 0, 1, 0), THEME.text_dim, FONT_BOLD)
            hdr_lbl.TextSize = 11

            local hdr_line = Instance.new("Frame")
            hdr_line.Size = UDim2.new(1, 0, 0, 1)
            hdr_line.Position = UDim2.new(0, 0, 1, -1)
            hdr_line.BackgroundColor3 = THEME.border
            hdr_line.BorderSizePixel = 0
            hdr_line.Parent = hdr
        end

        local layout_order = 1
        local function next_order()
            layout_order = layout_order + 1
            return layout_order
        end

        function sec:Separator()
            local sep = Instance.new("Frame")
            sep.Size = UDim2.new(1, 0, 0, 1)
            sep.BackgroundColor3 = THEME.border
            sep.BorderSizePixel = 0
            sep.LayoutOrder = next_order()
            sep.Parent = sec_inner
        end

        function sec:Label(text)
            local el = {}
            local row = make_frame(sec_inner, UDim2.new(1, 0, 0, 24), nil, Color3.fromRGB(0,0,0))
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_order()
            local lbl = make_label(row, text or "", UDim2.new(1, 0, 1, 0), THEME.text_dim, FONT_LIGHT)
            lbl.TextSize = 12
            function el:Set(t) lbl.Text = t or "" end
            return el
        end

        function sec:Paragraph(title_text, body_text)
            local el = {}
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 0)
            row.AutomaticSize = Enum.AutomaticSize.Y
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_order()
            row.Parent = sec_inner
            make_list(row, 2)

            local t_lbl = make_label(row, title_text or "", UDim2.new(1, 0, 0, 18), THEME.text, FONT_BOLD)
            t_lbl.TextSize = 13

            local b_lbl = Instance.new("TextLabel")
            b_lbl.Size = UDim2.new(1, 0, 0, 0)
            b_lbl.AutomaticSize = Enum.AutomaticSize.Y
            b_lbl.BackgroundTransparency = 1
            b_lbl.Text = body_text or ""
            b_lbl.TextColor3 = THEME.text_dim
            b_lbl.TextSize = 12
            b_lbl.Font = FONT_LIGHT
            b_lbl.TextXAlignment = Enum.TextXAlignment.Left
            b_lbl.TextWrapped = true
            b_lbl.Parent = row

            function el:Set(t, b)
                if t then t_lbl.Text = t end
                if b then b_lbl.Text = b end
            end
            return el
        end

        function sec:Toggle(options)
            local el = {}
            local name_str = options.Name or "Toggle"
            local state = options.Default or false
            local cb = options.Callback or function() end

            local row = make_frame(sec_inner, UDim2.new(1, 0, 0, EL_H), nil, THEME.element_bg)
            row.LayoutOrder = next_order()
            make_corner(row)
            hover_highlight(row, THEME.element_bg, THEME.element_hover)

            local lbl = make_label(row, name_str, UDim2.new(1, -56, 1, 0), THEME.text, FONT)
            make_padding(lbl, PAD)

            local track = Instance.new("Frame")
            track.Size = UDim2.new(0, 40, 0, 20)
            track.Position = UDim2.new(1, -48, 0.5, -10)
            track.BackgroundColor3 = state and THEME.toggle_on or THEME.toggle_off
            track.BorderSizePixel = 0
            track.Parent = row
            make_corner(track, 10)

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 14, 0, 14)
            knob.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.BorderSizePixel = 0
            knob.Parent = track
            make_corner(knob, 7)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = row

            local function set_state(s)
                state = s
                tween(track, { BackgroundColor3 = s and THEME.toggle_on or THEME.toggle_off })
                tween(knob, { Position = s and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) })
                cb(s)
            end

            btn.MouseButton1Click:Connect(function() set_state(not state) end)

            function el:Set(s) set_state(s) end
            function el:Get() return state end
            return el
        end

        function sec:Button(options)
            local el = {}
            local name_str = options.Name or "Button"
            local cb = options.Callback or function() end

            local row = make_button_frame(sec_inner, UDim2.new(1, 0, 0, EL_H), THEME.accent)
            row.LayoutOrder = next_order()
            hover_highlight(row, THEME.accent, THEME.accent_hover)

            local lbl = make_label(row, name_str, UDim2.new(1, 0, 1, 0), THEME.text, FONT_BOLD, Enum.TextXAlignment.Center)
            lbl.TextSize = 13

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = row

            btn.MouseButton1Click:Connect(function()
                tween(row, { BackgroundColor3 = THEME.accent_hover })
                task.delay(0.1, function() tween(row, { BackgroundColor3 = THEME.accent }) end)
                cb()
            end)

            function el:SetName(t) lbl.Text = t or "" end
            return el
        end

        function sec:Slider(options)
            local el = {}
            local name_str = options.Name or "Slider"
            local min_v = options.Min or 0
            local max_v = options.Max or 100
            local default = math.clamp(options.Default or min_v, min_v, max_v)
            local cb = options.Callback or function() end
            local suffix = options.Suffix or ""
            local val = default

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, EL_H + 16)
            row.BackgroundColor3 = THEME.element_bg
            row.BorderSizePixel = 0
            row.LayoutOrder = next_order()
            row.Parent = sec_inner
            make_corner(row)

            local top = Instance.new("Frame")
            top.Size = UDim2.new(1, 0, 0, EL_H)
            top.BackgroundTransparency = 1
            top.Parent = row

            local name_lbl = make_label(top, name_str, UDim2.new(1, -60, 1, 0), THEME.text, FONT)
            make_padding(name_lbl, PAD)

            local val_lbl = make_label(top, tostring(default) .. suffix, UDim2.new(0, 54, 1, 0), THEME.text_dim, FONT, Enum.TextXAlignment.Right)
            val_lbl.Position = UDim2.new(1, -58, 0, 0)

            local track_bg = Instance.new("Frame")
            track_bg.Size = UDim2.new(1, -PAD*2, 0, 4)
            track_bg.Position = UDim2.new(0, PAD, 1, -10)
            track_bg.BackgroundColor3 = THEME.slider_track
            track_bg.BorderSizePixel = 0
            track_bg.Parent = row
            make_corner(track_bg, 2)

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((default - min_v) / (max_v - min_v), 0, 1, 0)
            fill.BackgroundColor3 = THEME.accent
            fill.BorderSizePixel = 0
            fill.Parent = track_bg
            make_corner(fill, 2)

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 12, 0, 12)
            knob.AnchorPoint = Vector2.new(0.5, 0.5)
            knob.Position = UDim2.new((default - min_v) / (max_v - min_v), 0, 0.5, 0)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.BorderSizePixel = 0
            knob.Parent = track_bg
            make_corner(knob, 6)

            local sliding = false

            local function update_slider(input)
                local track_abs = track_bg.AbsolutePosition
                local track_w   = track_bg.AbsoluteSize.X
                local rel = math.clamp((input.Position.X - track_abs.X) / track_w, 0, 1)
                val = math.floor(min_v + (max_v - min_v) * rel)
                fill.Size  = UDim2.new(rel, 0, 1, 0)
                knob.Position = UDim2.new(rel, 0, 0.5, 0)
                val_lbl.Text = tostring(val) .. suffix
                cb(val)
            end

            track_bg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    update_slider(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not sliding then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    update_slider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)

            function el:Set(v)
                val = math.clamp(v, min_v, max_v)
                local rel = (val - min_v) / (max_v - min_v)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                knob.Position = UDim2.new(rel, 0, 0.5, 0)
                val_lbl.Text = tostring(val) .. suffix
            end
            function el:Get() return val end
            return el
        end

        function sec:TextBox(options)
            local el = {}
            local name_str = options.Name or "Input"
            local placeholder = options.Placeholder or ""
            local default = options.Default or ""
            local cb = options.Callback or function() end
            local numeric = options.Numeric or false

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, EL_H + 20)
            row.BackgroundColor3 = THEME.element_bg
            row.BorderSizePixel = 0
            row.LayoutOrder = next_order()
            row.Parent = sec_inner
            make_corner(row)

            local name_lbl = make_label(row, name_str, UDim2.new(1, 0, 0, 20), THEME.text, FONT)
            name_lbl.Position = UDim2.new(0, PAD, 0, 4)
            name_lbl.Size = UDim2.new(1, -PAD*2, 0, 20)

            local input_frame = Instance.new("Frame")
            input_frame.Size = UDim2.new(1, -PAD*2, 0, 24)
            input_frame.Position = UDim2.new(0, PAD, 0, 26)
            input_frame.BackgroundColor3 = THEME.bg
            input_frame.BorderSizePixel = 0
            input_frame.Parent = row
            make_corner(input_frame, 4)
            make_stroke(input_frame, THEME.border, 1)

            local tb = Instance.new("TextBox")
            tb.Size = UDim2.new(1, -PAD, 1, 0)
            tb.Position = UDim2.new(0, PAD/2, 0, 0)
            tb.BackgroundTransparency = 1
            tb.Text = default
            tb.PlaceholderText = placeholder
            tb.TextColor3 = THEME.text
            tb.PlaceholderColor3 = THEME.text_dim
            tb.TextSize = 13
            tb.Font = FONT
            tb.TextXAlignment = Enum.TextXAlignment.Left
            tb.ClearTextOnFocus = false
            tb.Parent = input_frame

            tb.FocusLost:Connect(function(enter)
                if numeric then
                    local n = tonumber(tb.Text)
                    if not n then tb.Text = default; return end
                    tb.Text = tostring(n)
                end
                cb(tb.Text, enter)
            end)

            tb.Focused:Connect(function()
                tween(input_frame, { BackgroundColor3 = THEME.element_hover })
                make_stroke(input_frame, THEME.accent, 1)
            end)
            tb.FocusLost:Connect(function()
                tween(input_frame, { BackgroundColor3 = THEME.bg })
                make_stroke(input_frame, THEME.border, 1)
            end)

            function el:Set(t) tb.Text = tostring(t or "") end
            function el:Get() return tb.Text end
            return el
        end

        function sec:Dropdown(options)
            local el = {}
            local name_str = options.Name or "Dropdown"
            local items = options.Items or {}
            local default = options.Default or items[1] or ""
            local cb = options.Callback or function() end
            local selected = default
            local open = false

            local wrapper = Instance.new("Frame")
            wrapper.Size = UDim2.new(1, 0, 0, EL_H)
            wrapper.BackgroundTransparency = 1
            wrapper.ClipsDescendants = false
            wrapper.LayoutOrder = next_order()
            wrapper.Parent = sec_inner
            wrapper.AutomaticSize = Enum.AutomaticSize.Y

            local row = make_frame(wrapper, UDim2.new(1, 0, 0, EL_H), nil, THEME.element_bg)
            make_corner(row)

            local name_lbl = make_label(row, name_str, UDim2.new(0.5, 0, 1, 0), THEME.text, FONT)
            make_padding(name_lbl, PAD)

            local sel_lbl = make_label(row, selected, UDim2.new(0.4, 0, 1, 0), THEME.text_dim, FONT, Enum.TextXAlignment.Right)
            sel_lbl.Position = UDim2.new(0.5, 0, 0, 0)

            local arrow = make_label(row, "▾", UDim2.new(0, 20, 1, 0), THEME.text_dim, FONT_BOLD, Enum.TextXAlignment.Center)
            arrow.Position = UDim2.new(1, -24, 0, 0)

            local dropdown_frame = Instance.new("Frame")
            dropdown_frame.Size = UDim2.new(1, 0, 0, 0)
            dropdown_frame.Position = UDim2.new(0, 0, 1, 2)
            dropdown_frame.BackgroundColor3 = THEME.section_bg
            dropdown_frame.BorderSizePixel = 0
            dropdown_frame.ClipsDescendants = true
            dropdown_frame.ZIndex = 10
            dropdown_frame.Parent = row
            make_corner(dropdown_frame)
            make_stroke(dropdown_frame, THEME.border, 1)

            local dd_list = Instance.new("Frame")
            dd_list.Size = UDim2.new(1, 0, 0, 0)
            dd_list.AutomaticSize = Enum.AutomaticSize.Y
            dd_list.BackgroundTransparency = 1
            dd_list.Parent = dropdown_frame
            make_padding(dd_list, 4)
            make_list(dd_list, 2)

            local item_height = 26
            local max_visible = 5

            local function populate(list)
                for _, c in ipairs(dd_list:GetChildren()) do
                    if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
                end
                for _, item in ipairs(list) do
                    local item_btn = Instance.new("TextButton")
                    item_btn.Size = UDim2.new(1, 0, 0, item_height)
                    item_btn.BackgroundColor3 = THEME.element_bg
                    item_btn.Text = tostring(item)
                    item_btn.TextColor3 = item == selected and THEME.accent or THEME.text
                    item_btn.TextSize = 13
                    item_btn.Font = FONT
                    item_btn.TextXAlignment = Enum.TextXAlignment.Left
                    item_btn.BorderSizePixel = 0
                    item_btn.ZIndex = 11
                    item_btn.Parent = dd_list
                    make_corner(item_btn, 4)
                    make_padding(item_btn, 6)
                    hover_highlight(item_btn, THEME.element_bg, THEME.element_hover)
                    item_btn.MouseButton1Click:Connect(function()
                        selected = tostring(item)
                        sel_lbl.Text = selected
                        populate(list)
                        open = false
                        tween(dropdown_frame, { Size = UDim2.new(1, 0, 0, 0) })
                        arrow.Text = "▾"
                        cb(selected)
                    end)
                end
            end

            populate(items)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.ZIndex = 5
            btn.Parent = row

            btn.MouseButton1Click:Connect(function()
                open = not open
                local target_h = math.min(#items, max_visible) * (item_height + 2) + 8
                tween(dropdown_frame, { Size = UDim2.new(1, 0, 0, open and target_h or 0) })
                arrow.Text = open and "▴" or "▾"
            end)

            function el:Set(v)
                selected = tostring(v)
                sel_lbl.Text = selected
                populate(items)
            end
            function el:SetItems(list)
                items = list
                populate(list)
            end
            function el:Get() return selected end
            return el
        end

        function sec:ColorPicker(options)
            local el = {}
            local name_str = options.Name or "Color"
            local default = options.Default or Color3.fromRGB(255, 0, 0)
            local cb = options.Callback or function() end
            local color = default
            local open = false

            local row = make_frame(sec_inner, UDim2.new(1, 0, 0, EL_H), nil, THEME.element_bg)
            row.LayoutOrder = next_order()
            make_corner(row)
            hover_highlight(row, THEME.element_bg, THEME.element_hover)

            local name_lbl = make_label(row, name_str, UDim2.new(1, -48, 1, 0), THEME.text, FONT)
            make_padding(name_lbl, PAD)

            local preview = Instance.new("Frame")
            preview.Size = UDim2.new(0, 24, 0, 24)
            preview.Position = UDim2.new(1, -32, 0.5, -12)
            preview.BackgroundColor3 = color
            preview.BorderSizePixel = 0
            preview.Parent = row
            make_corner(preview, 4)
            make_stroke(preview, THEME.border, 1)

            local picker_frame = Instance.new("Frame")
            picker_frame.Size = UDim2.new(1, 0, 0, 0)
            picker_frame.Position = UDim2.new(0, 0, 1, 2)
            picker_frame.BackgroundColor3 = THEME.section_bg
            picker_frame.BorderSizePixel = 0
            picker_frame.ClipsDescendants = true
            picker_frame.ZIndex = 10
            picker_frame.Parent = row
            make_corner(picker_frame)
            make_stroke(picker_frame, THEME.border, 1)

            local h_val, s_val, v_val = Color3.toHSV(default)
            local picker_h = 160

            local sv_frame = Instance.new("ImageLabel")
            sv_frame.Size = UDim2.new(1, -PAD*2, 0, 100)
            sv_frame.Position = UDim2.new(0, PAD, 0, PAD)
            sv_frame.Image = "rbxassetid://6523286724"
            sv_frame.BackgroundColor3 = Color3.fromHSV(h_val, 1, 1)
            sv_frame.BorderSizePixel = 0
            sv_frame.ZIndex = 11
            sv_frame.Parent = picker_frame
            make_corner(sv_frame, 4)

            local sv_knob = Instance.new("Frame")
            sv_knob.Size = UDim2.new(0, 10, 0, 10)
            sv_knob.AnchorPoint = Vector2.new(0.5, 0.5)
            sv_knob.Position = UDim2.new(s_val, 0, 1 - v_val, 0)
            sv_knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sv_knob.BorderSizePixel = 0
            sv_knob.ZIndex = 12
            sv_knob.Parent = sv_frame
            make_corner(sv_knob, 5)
            make_stroke(sv_knob, Color3.fromRGB(0,0,0), 1)

            local hue_bar = Instance.new("ImageLabel")
            hue_bar.Size = UDim2.new(1, -PAD*2, 0, 16)
            hue_bar.Position = UDim2.new(0, PAD, 0, 110)
            hue_bar.Image = "rbxassetid://6523291696"
            hue_bar.BackgroundColor3 = Color3.fromRGB(255,255,255)
            hue_bar.BorderSizePixel = 0
            hue_bar.ZIndex = 11
            hue_bar.Parent = picker_frame
            make_corner(hue_bar, 4)

            local hue_knob = Instance.new("Frame")
            hue_knob.Size = UDim2.new(0, 8, 1, 0)
            hue_knob.AnchorPoint = Vector2.new(0.5, 0)
            hue_knob.Position = UDim2.new(h_val, 0, 0, 0)
            hue_knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
            hue_knob.BorderSizePixel = 0
            hue_knob.ZIndex = 12
            hue_knob.Parent = hue_bar
            make_corner(hue_knob, 2)
            make_stroke(hue_knob, Color3.fromRGB(0,0,0), 1)

            local hex_label = make_label(picker_frame, "#" .. color:ToHex():upper(), UDim2.new(1, -PAD*2, 0, 20), THEME.text_dim, FONT_LIGHT, Enum.TextXAlignment.Center)
            hex_label.Position = UDim2.new(0, PAD, 0, 134)
            hex_label.ZIndex = 11

            local function update_color()
                color = Color3.fromHSV(h_val, s_val, v_val)
                preview.BackgroundColor3 = color
                sv_frame.BackgroundColor3 = Color3.fromHSV(h_val, 1, 1)
                sv_knob.Position = UDim2.new(s_val, 0, 1 - v_val, 0)
                hue_knob.Position = UDim2.new(h_val, 0, 0, 0)
                hex_label.Text = "#" .. color:ToHex():upper()
                cb(color)
            end

            local sv_drag, hue_drag = false, false

            sv_frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sv_drag = true
                    local rel_x = math.clamp((input.Position.X - sv_frame.AbsolutePosition.X) / sv_frame.AbsoluteSize.X, 0, 1)
                    local rel_y = math.clamp((input.Position.Y - sv_frame.AbsolutePosition.Y) / sv_frame.AbsoluteSize.Y, 0, 1)
                    s_val = rel_x
                    v_val = 1 - rel_y
                    update_color()
                end
            end)
            hue_bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    hue_drag = true
                    h_val = math.clamp((input.Position.X - hue_bar.AbsolutePosition.X) / hue_bar.AbsoluteSize.X, 0, 1)
                    update_color()
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
                if sv_drag then
                    local rel_x = math.clamp((input.Position.X - sv_frame.AbsolutePosition.X) / sv_frame.AbsoluteSize.X, 0, 1)
                    local rel_y = math.clamp((input.Position.Y - sv_frame.AbsolutePosition.Y) / sv_frame.AbsoluteSize.Y, 0, 1)
                    s_val = rel_x
                    v_val = 1 - rel_y
                    update_color()
                end
                if hue_drag then
                    h_val = math.clamp((input.Position.X - hue_bar.AbsolutePosition.X) / hue_bar.AbsoluteSize.X, 0, 1)
                    update_color()
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sv_drag = false
                    hue_drag = false
                end
            end)

            local open_btn = Instance.new("TextButton")
            open_btn.Size = UDim2.new(1, 0, 1, 0)
            open_btn.BackgroundTransparency = 1
            open_btn.Text = ""
            open_btn.Parent = row

            open_btn.MouseButton1Click:Connect(function()
                open = not open
                tween(picker_frame, { Size = UDim2.new(1, 0, 0, open and picker_h or 0) })
            end)

            function el:Set(c)
                color = c
                h_val, s_val, v_val = Color3.toHSV(c)
                update_color()
            end
            function el:Get() return color end
            return el
        end

        function sec:Keybind(options)
            local el = {}
            local name_str = options.Name or "Keybind"
            local default = options.Default or safe_keycode("Unknown", "Q")
            local cb = options.Callback or function() end
            local bound = default
            local listening = false
            local row = make_frame(sec_inner, UDim2.new(1, 0, 0, EL_H), nil, THEME.element_bg)
            row.LayoutOrder = next_order()
            make_corner(row)
            local name_lbl = make_label(row, name_str, UDim2.new(1, -80, 1, 0), THEME.text, FONT)
            make_padding(name_lbl, PAD)
            local key_btn = Instance.new("TextButton")
            key_btn.Size = UDim2.new(0, 72, 0, 22)
            key_btn.Position = UDim2.new(1, -76, 0.5, -11)
            key_btn.BackgroundColor3 = THEME.bg
            key_btn.Text = bound.Name
            key_btn.TextColor3 = THEME.text_dim
            key_btn.TextSize = 12
            key_btn.Font = FONT
            key_btn.BorderSizePixel = 0
            key_btn.Parent = row
            make_corner(key_btn, 4)
            make_stroke(key_btn, THEME.border, 1)

            key_btn.MouseButton1Click:Connect(function()
                listening = true
                key_btn.Text = "..."
                key_btn.TextColor3 = THEME.accent
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if not listening then return end
                if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                listening = false
                bound = input.KeyCode
                key_btn.Text = bound.Name
                key_btn.TextColor3 = THEME.text_dim
                cb(bound)
            end)

            function el:Set(kc)
                bound = kc
                key_btn.Text = kc.Name
            end
            function el:Get() return bound end
            return el
        end

        table.insert(win._sections, sec)
        return sec
    end

    table.insert(self._windows, win)
    return win
end

function Lib:Notify(options)
    if type(self) ~= "table" then
        options = self
        self = Lib
    end
    ensure_sg(self)
    local title_str = options.Title or "Notification"
    local msg = options.Message or ""
    local duration = options.Duration or 3
    local ntype = options.Type or "Info"
    local color_map = {
        Info    = THEME.info,
        Success = THEME.success,
        Warning = THEME.warning,
        Error   = THEME.danger,
    }
    local accent_color = color_map[ntype] or THEME.info
    local notif_w = 280
    local notif_h = 64
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, notif_w, 0, notif_h)
    notif.Position = UDim2.new(1, notif_w + 10, 1, -80)
    notif.BackgroundColor3 = THEME.section_bg
    notif.BorderSizePixel = 0
    notif.Parent = self._sg
    make_corner(notif, CORNER)
    make_stroke(notif, THEME.border, 1)

    local side = Instance.new("Frame")
    side.Size = UDim2.new(0, 3, 1, 0)
    side.BackgroundColor3 = accent_color
    side.BorderSizePixel = 0
    side.Parent = notif
    make_corner(side, 2)

    local title_lbl = make_label(notif, title_str, UDim2.new(1, -16, 0, 22), THEME.text, FONT_BOLD)
    title_lbl.Position = UDim2.new(0, 12, 0, 6)
    title_lbl.TextSize = 13

    local msg_lbl = make_label(notif, msg, UDim2.new(1, -16, 0, 32), THEME.text_dim, FONT_LIGHT)
    msg_lbl.Position = UDim2.new(0, 12, 0, 26)
    msg_lbl.TextSize = 12
    msg_lbl.TextWrapped = true

    local progress = Instance.new("Frame")
    progress.Size = UDim2.new(1, 0, 0, 2)
    progress.Position = UDim2.new(0, 0, 1, -2)
    progress.BackgroundColor3 = accent_color
    progress.BorderSizePixel = 0
    progress.Parent = notif

    tween(notif, { Position = UDim2.new(1, -(notif_w + 10), 1, -80) }, 0.3)
    tween(progress, { Size = UDim2.new(0, 0, 0, 2) }, duration)
    task.delay(duration, function()
        tween(notif, { Position = UDim2.new(1, notif_w + 10, 1, -80) }, 0.3)
        task.delay(0.35, function() notif:Destroy() end)
    end)
end

return _inst