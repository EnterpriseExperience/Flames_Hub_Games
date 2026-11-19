local g             = getgenv and getgenv() or _G
local Players       = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local UIS           = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local CoreGui       = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local LP            = g.LocalPlayer or Players.LocalPlayer
local PlayerGui     = g.PlayerGui or LP:FindFirstChildOfClass("PlayerGui") or LP:FindFirstChildWhichIsA("PlayerGui")
local parent_gui    = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or CoreGui or PlayerGui
local function rnd()
    local t = {}
    for i = 1, math.random(12,24) do t[i] = string.char(math.random(33,126)) end
    return table.concat(t)
end

local C = {
    win_bg          = Color3.fromRGB(15,  15,  15),
    child_bg        = Color3.fromRGB(0,   0,   0),
    popup_bg        = Color3.fromRGB(20,  20,  20),
    border          = Color3.fromRGB(110, 110, 128),
    border_shadow   = Color3.fromRGB(0,   0,   0),
    frame_bg        = Color3.fromRGB(41,  74,  122),
    frame_bg_hov    = Color3.fromRGB(66,  150, 250),
    frame_bg_act    = Color3.fromRGB(66,  150, 250),
    title_bg        = Color3.fromRGB(10,  10,  10),
    title_bg_act    = Color3.fromRGB(41,  74,  122),
    title_bg_col    = Color3.fromRGB(0,   0,   0),
    scrollbar_bg    = Color3.fromRGB(5,   5,   5),
    scrollbar_grab  = Color3.fromRGB(79,  79,  79),
    scrollbar_hov   = Color3.fromRGB(105, 105, 105),
    scrollbar_act   = Color3.fromRGB(130, 130, 130),
    check_mark      = Color3.fromRGB(66,  150, 250),
    slider_grab     = Color3.fromRGB(61,  133, 224),
    slider_grab_act = Color3.fromRGB(66,  150, 250),
    button          = Color3.fromRGB(66,  150, 250),
    button_hov      = Color3.fromRGB(66,  150, 250),
    button_act      = Color3.fromRGB(15,  135, 250),
    header          = Color3.fromRGB(66,  150, 250),
    header_hov      = Color3.fromRGB(66,  150, 250),
    header_act      = Color3.fromRGB(66,  150, 250),
    separator       = Color3.fromRGB(110, 110, 128),
    separator_hov   = Color3.fromRGB(26,  102, 191),
    separator_act   = Color3.fromRGB(66,  150, 250),
    text            = Color3.fromRGB(255, 255, 255),
    text_dis        = Color3.fromRGB(128, 128, 128),
    plot_lines      = Color3.fromRGB(156, 156, 156),
    success         = Color3.fromRGB(80,  200, 120),
    warning         = Color3.fromRGB(220, 160, 0),
    danger          = Color3.fromRGB(220, 60,  60),
    info            = Color3.fromRGB(66,  150, 250),
}

local FONT          = Enum.Font.Code
local FONT_SZ       = 13
local PAD           = 8
local ITEM_SPC      = 4
local FRAME_PAD     = 4
local EL_H          = 20
local BORDER_W      = 1
local function stroke(p, col, w)
    local s = Instance.new("UIStroke")
    s.Color = col or C.border
    s.Thickness = w or BORDER_W
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

local function padding(p, px, py)
    local u = Instance.new("UIPadding")
    u.PaddingLeft   = UDim.new(0, px or PAD)
    u.PaddingRight  = UDim.new(0, px or PAD)
    u.PaddingTop    = UDim.new(0, py or FRAME_PAD)
    u.PaddingBottom = UDim.new(0, py or FRAME_PAD)
    u.Parent = p
    return u
end

local function list_layout(p, sp)
    local l = Instance.new("UIListLayout")
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, sp or ITEM_SPC)
    l.Parent = p
    return l
end

local function frame(p, sz, bg, name)
    local f = Instance.new("Frame")
    f.Size = sz or UDim2.new(1,0,0,EL_H)
    f.BackgroundColor3 = bg or C.win_bg
    f.BorderSizePixel = 0
    f.Name = name or rnd()
    f.Parent = p
    return f
end

local function label(p, txt, sz, col, xalign)
    local l = Instance.new("TextLabel")
    l.Size = sz or UDim2.new(1,0,1,0)
    l.Position = UDim2.new(0,0,0,0)
    l.BackgroundTransparency = 1
    l.Text = txt or ""
    l.TextColor3 = col or C.text
    l.TextSize = FONT_SZ
    l.Font = FONT
    l.TextXAlignment = xalign or Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.Name = rnd()
    l.Parent = p
    return l
end

local function set(obj, props)
    for k,v in pairs(props) do obj[k] = v end
end

local function hover(btn, base_frame, base_col, hov_col)
    btn.MouseEnter:Connect(function()  set(base_frame,{BackgroundColor3=hov_col}) end)
    btn.MouseLeave:Connect(function()  set(base_frame,{BackgroundColor3=base_col}) end)
end

local Lib = {}
Lib.__index = Lib
local function ensure_sg(self)
    if self._sg and self._sg.Parent then return end
    local sg = Instance.new("ScreenGui")
    sg.Name = rnd()
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 999
    sg.IgnoreGuiInset = true
    local ok = pcall(function() sg.Parent = parent_gui end)
    if not ok then sg.Parent = PlayerGui end
    self._sg = sg
end

Lib.ensure_sg = ensure_sg
setmetatable(Lib, { __call = function(s,...) return s:Window(...) end })
local _inst = setmetatable({}, Lib)
_inst._windows = {}
function Lib:Window(title, width, height)
    if type(self) ~= "table" then
        title, width, height = self, title, width
        self = Lib
    end
    self._windows = self._windows or {}
    ensure_sg(self)

    local W = width  or 400
    local H = height or 500
    local win = { _sections = {} }
    local main = Instance.new("Frame")
    main.Name = rnd()
    main.Size = UDim2.new(0, W, 0, H)
    main.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
    main.BackgroundColor3 = C.win_bg
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = self._sg
    stroke(main, C.border, 1)

    local tbar = frame(main, UDim2.new(1,0,0,19), C.title_bg_act, "TitleBar")
    local collapse_lbl = label(tbar, "▼ ", UDim2.new(0,14,1,0), C.text)
    collapse_lbl.Position = UDim2.new(0,4,0,0)
    collapse_lbl.TextSize = 10

    local title_lbl = label(tbar, (title or "Untitled"), UDim2.new(1,-60,1,0), C.text)
    title_lbl.Position = UDim2.new(0,20,0,0)
    title_lbl.TextSize = FONT_SZ

    local close_f = frame(tbar, UDim2.new(0,17,0,17), C.button, "CloseF")
    close_f.Position = UDim2.new(1,-19,0.5,-8)
    local close_lbl = label(close_f, "×", UDim2.new(1,0,1,0), C.text, Enum.TextXAlignment.Center)
    close_lbl.TextSize = 14
    local close_btn = Instance.new("TextButton")
    close_btn.Size = UDim2.new(1,0,1,0)
    close_btn.BackgroundTransparency = 1
    close_btn.Text = ""
    close_btn.Parent = close_f

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Content"
    scroll.Size = UDim2.new(1,0,1,-19)
    scroll.Position = UDim2.new(0,0,0,19)
    scroll.BackgroundColor3 = C.win_bg
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 12
    scroll.ScrollBarImageColor3 = C.scrollbar_grab
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = main
    padding(scroll, PAD, FRAME_PAD)
    list_layout(scroll, ITEM_SPC)

    local collapsed = false
    local full_h = H
    local collapse_btn = Instance.new("TextButton")
    collapse_btn.Size = UDim2.new(1,-40,1,0)
    collapse_btn.BackgroundTransparency = 1
    collapse_btn.Text = ""
    collapse_btn.Parent = tbar
    collapse_btn.MouseButton1Click:Connect(function()
        collapsed = not collapsed
        collapse_lbl.Text = collapsed and "▶ " or "▼ "
        main.Size = collapsed and UDim2.new(0,W,0,19) or UDim2.new(0,W,0,full_h)
        scroll.Visible = not collapsed
    end)

    close_btn.MouseButton1Click:Connect(function() main:Destroy() end)
    hover(close_btn, close_f, C.button, C.button_act)
    tbar.InputBegan:Connect(function(inp)
        if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then return end
        if UIS:GetFocusedTextBox() then return end
        local drag_start = inp.Position
        local frame_start = main.Position
        local move_conn, end_conn
        move_conn = UIS.InputChanged:Connect(function(i)
            if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
            local d = i.Position - drag_start
            main.Position = UDim2.new(frame_start.X.Scale, frame_start.X.Offset + d.X, frame_start.Y.Scale, frame_start.Y.Offset + d.Y)
        end)
        end_conn = UIS.InputEnded:Connect(function(i)
            if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
            move_conn:Disconnect()
            end_conn:Disconnect()
        end)
    end)
    win._main    = main
    win._content = scroll

    function win:Section(name)
        if type(self) ~= "table" then name = self; self = win end
        local sec = { _elements = {} }
        local sec_frame = Instance.new("Frame")
        sec_frame.Name = rnd()
        sec_frame.Size = UDim2.new(1,0,0,0)
        sec_frame.AutomaticSize = Enum.AutomaticSize.Y
        sec_frame.BackgroundColor3 = C.child_bg
        sec_frame.BackgroundTransparency = 0.6
        sec_frame.BorderSizePixel = 0
        sec_frame.Parent = scroll
        stroke(sec_frame, C.border, 1)

        local inner = Instance.new("Frame")
        inner.Name = "Inner"
        inner.Size = UDim2.new(1,0,0,0)
        inner.AutomaticSize = Enum.AutomaticSize.Y
        inner.BackgroundTransparency = 1
        inner.Parent = sec_frame
        padding(inner, PAD, FRAME_PAD)
        list_layout(inner, ITEM_SPC)

        local sec_collapsed = false
        local items_frame

        if name and name ~= "" then
            local hdr_row = frame(inner, UDim2.new(1,0,0,EL_H), C.header, "HdrRow")
            hdr_row.BackgroundTransparency = 0.7
            hdr_row.LayoutOrder = 0
            padding(hdr_row, FRAME_PAD, 0)

            local hdr_arrow = label(hdr_row, "▼", UDim2.new(0,12,1,0), C.text)
            hdr_arrow.TextSize = 10
            hdr_arrow.Position = UDim2.new(0,2,0,0)

            local hdr_lbl = label(hdr_row, name, UDim2.new(1,-16,1,0), C.text)
            hdr_lbl.Position = UDim2.new(0,16,0,0)
            hdr_lbl.Font = FONT
            hdr_lbl.TextSize = FONT_SZ

            local hdr_btn = Instance.new("TextButton")
            hdr_btn.Size = UDim2.new(1,0,1,0)
            hdr_btn.BackgroundTransparency = 1
            hdr_btn.Text = ""
            hdr_btn.Parent = hdr_row
            hdr_btn.MouseEnter:Connect(function() set(hdr_row,{BackgroundTransparency=0.4}) end)
            hdr_btn.MouseLeave:Connect(function() set(hdr_row,{BackgroundTransparency=0.7}) end)

            items_frame = Instance.new("Frame")
            items_frame.Name = "Items"
            items_frame.Size = UDim2.new(1,0,0,0)
            items_frame.AutomaticSize = Enum.AutomaticSize.Y
            items_frame.BackgroundTransparency = 1
            items_frame.LayoutOrder = 1
            items_frame.Parent = inner
            list_layout(items_frame, ITEM_SPC)

            hdr_btn.MouseButton1Click:Connect(function()
                sec_collapsed = not sec_collapsed
                hdr_arrow.Text = sec_collapsed and "▶" or "▼"
                items_frame.Visible = not sec_collapsed
            end)
        else
            items_frame = inner
        end

        local lo = 0
        local function next_lo() lo = lo + 1; return lo end
        function sec:Separator()
            local s = frame(items_frame, UDim2.new(1,0,0,1), C.separator, rnd())
            s.LayoutOrder = next_lo()
        end

        function sec:Label(text)
            local el = {}
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.win_bg, rnd())
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_lo()
            local lbl = label(row, text or "", UDim2.new(1,0,1,0), C.text)
            function el:Set(t) lbl.Text = t or "" end
            return el
        end

        function sec:Paragraph(title_text, body_text)
            local el = {}
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1,0,0,0)
            row.AutomaticSize = Enum.AutomaticSize.Y
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_lo()
            row.Parent = items_frame
            list_layout(row, 2)

            local t_lbl = label(row, title_text or "", UDim2.new(1,0,0,EL_H), C.text)
            local b_lbl = Instance.new("TextLabel")
            b_lbl.Size = UDim2.new(1,0,0,0)
            b_lbl.AutomaticSize = Enum.AutomaticSize.Y
            b_lbl.BackgroundTransparency = 1
            b_lbl.Text = body_text or ""
            b_lbl.TextColor3 = C.text_dis
            b_lbl.TextSize = FONT_SZ
            b_lbl.Font = FONT
            b_lbl.TextXAlignment = Enum.TextXAlignment.Left
            b_lbl.TextWrapped = true
            b_lbl.Parent = row

            function el:Set(t,b)
                if t then t_lbl.Text = t end
                if b then b_lbl.Text = b end
            end
            return el
        end

        function sec:Toggle(opts)
            local el = {}
            local name_s  = opts.Name     or "Toggle"
            local state   = opts.Default  or false
            local cb      = opts.Callback or function() end
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.win_bg, rnd())
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_lo()

            local box = frame(row, UDim2.new(0,13,0,13), C.frame_bg, rnd())
            box.Position = UDim2.new(0,0,0.5,-6)
            stroke(box, C.border, 1)

            local check = label(box, "✓", UDim2.new(1,0,1,0), C.check_mark, Enum.TextXAlignment.Center)
            check.TextSize = 11
            check.Visible = state

            local name_lbl = label(row, "  " .. name_s, UDim2.new(1,-17,1,0), C.text)
            name_lbl.Position = UDim2.new(0,17,0,0)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,1,0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = row

            btn.MouseEnter:Connect(function() set(box,{BackgroundColor3=C.frame_bg_hov}) end)
            btn.MouseLeave:Connect(function() set(box,{BackgroundColor3=C.frame_bg}) end)

            local function set_state(s)
                state = s
                check.Visible = s
                cb(s)
            end
            btn.MouseButton1Click:Connect(function() set_state(not state) end)

            function el:Set(s) set_state(s) end
            function el:Get() return state end
            return el
        end

        function sec:Button(opts)
            local el = {}
            local name_s = opts.Name     or "Button"
            local cb     = opts.Callback or function() end
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.button, rnd())
            row.BackgroundTransparency = 0.74
            row.LayoutOrder = next_lo()
            stroke(row, C.border, 1)

            local lbl = label(row, name_s, UDim2.new(1,0,1,0), C.text, Enum.TextXAlignment.Center)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,1,0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = row

            btn.MouseEnter:Connect(function() set(row,{BackgroundTransparency=0.2}) end)
            btn.MouseLeave:Connect(function() set(row,{BackgroundTransparency=0.74}) end)
            btn.MouseButton1Down:Connect(function() set(row,{BackgroundColor3=C.button_act, BackgroundTransparency=0}) end)
            btn.MouseButton1Up:Connect(function()   set(row,{BackgroundColor3=C.button,     BackgroundTransparency=0.74}); cb() end)

            function el:SetName(t) lbl.Text = t or "" end
            return el
        end

        function sec:Slider(opts)
            local el = {}
            local name_s  = opts.Name     or "Slider"
            local min_v   = opts.Min      or 0
            local max_v   = opts.Max      or 100
            local val     = math.clamp(opts.Default or min_v, min_v, max_v)
            local suffix  = opts.Suffix   or ""
            local cb      = opts.Callback or function() end
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.frame_bg, rnd())
            row.LayoutOrder = next_lo()
            stroke(row, C.border, 1)
            local fill = frame(row, UDim2.new((val-min_v)/(max_v-min_v),0,1,0), C.slider_grab, rnd())
            fill.Position = UDim2.new(0,0,0,0)
            local overlay = label(row, name_s .. ": " .. tostring(val) .. suffix, UDim2.new(1,0,1,0), C.text, Enum.TextXAlignment.Center)
            overlay.ZIndex = 2
            local sliding = false
            local function update(inp)
                local abs = row.AbsolutePosition
                local w   = row.AbsoluteSize.X
                local rel = math.clamp((inp.Position.X - abs.X) / w, 0, 1)
                val = math.floor(min_v + (max_v - min_v) * rel)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                overlay.Text = name_s .. ": " .. tostring(val) .. suffix
                cb(val)
            end

            row.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = true; update(inp)
                end
            end)
            UIS.InputChanged:Connect(function(inp)
                if not sliding then return end
                if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                    update(inp)
                end
            end)
            UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)

            function el:Set(v)
                val = math.clamp(v, min_v, max_v)
                local rel = (val-min_v)/(max_v-min_v)
                fill.Size = UDim2.new(rel,0,1,0)
                overlay.Text = name_s .. ": " .. tostring(val) .. suffix
            end
            function el:Get() return val end
            return el
        end

        function sec:TextBox(opts)
            local el = {}
            local name_s   = opts.Name        or "Input"
            local ph       = opts.Placeholder or ""
            local default  = opts.Default     or ""
            local numeric  = opts.Numeric     or false
            local cb       = opts.Callback    or function() end
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H*2+2), C.win_bg, rnd())
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_lo()

            local name_lbl = label(row, name_s, UDim2.new(1,0,0,EL_H), C.text)
            name_lbl.Position = UDim2.new(0,0,0,0)

            local input_bg = frame(row, UDim2.new(1,0,0,EL_H), C.frame_bg, rnd())
            input_bg.Position = UDim2.new(0,0,0,EL_H+2)
            stroke(input_bg, C.border, 1)

            local tb = Instance.new("TextBox")
            tb.Size = UDim2.new(1,-FRAME_PAD*2,1,0)
            tb.Position = UDim2.new(0,FRAME_PAD,0,0)
            tb.BackgroundTransparency = 1
            tb.Text = default
            tb.PlaceholderText = ph
            tb.TextColor3 = C.text
            tb.PlaceholderColor3 = C.text_dis
            tb.TextSize = FONT_SZ
            tb.Font = FONT
            tb.TextXAlignment = Enum.TextXAlignment.Left
            tb.ClearTextOnFocus = false
            tb.Parent = input_bg

            tb.Focused:Connect(function()   set(input_bg,{BackgroundColor3=C.frame_bg_hov}) end)
            tb.FocusLost:Connect(function(enter)
                set(input_bg,{BackgroundColor3=C.frame_bg})
                if numeric then
                    local n = tonumber(tb.Text)
                    if not n then tb.Text = default; return end
                    tb.Text = tostring(n)
                end
                cb(tb.Text, enter)
            end)

            function el:Set(t) tb.Text = tostring(t or "") end
            function el:Get() return tb.Text end
            return el
        end

        function sec:Dropdown(opts)
            local el = {}
            local name_s  = opts.Name     or "Combo"
            local items   = opts.Items    or {}
            local sel     = opts.Default  or items[1] or ""
            local cb      = opts.Callback or function() end
            local open    = false
            local wrapper = Instance.new("Frame")
            wrapper.Size = UDim2.new(1,0,0,EL_H)
            wrapper.BackgroundTransparency = 1
            wrapper.ClipsDescendants = false
            wrapper.AutomaticSize = Enum.AutomaticSize.Y
            wrapper.LayoutOrder = next_lo()
            wrapper.Parent = items_frame

            local row = frame(wrapper, UDim2.new(1,0,0,EL_H), C.frame_bg, rnd())
            stroke(row, C.border, 1)

            local name_lbl = label(row, name_s, UDim2.new(0.55,0,1,0), C.text)
            name_lbl.Position = UDim2.new(0,FRAME_PAD,0,0)

            local sel_lbl = label(row, sel .. "  ▼", UDim2.new(0.4,0,1,0), C.text_dis, Enum.TextXAlignment.Right)
            sel_lbl.Position = UDim2.new(0.57,0,0,0)

            local popup = Instance.new("Frame")
            popup.Size = UDim2.new(1,0,0,0)
            popup.Position = UDim2.new(0,0,1,1)
            popup.BackgroundColor3 = C.popup_bg
            popup.BorderSizePixel = 0
            popup.ClipsDescendants = true
            popup.ZIndex = 20
            popup.Parent = row
            stroke(popup, C.border, 1)

            local popup_list = Instance.new("Frame")
            popup_list.Size = UDim2.new(1,0,0,0)
            popup_list.AutomaticSize = Enum.AutomaticSize.Y
            popup_list.BackgroundTransparency = 1
            popup_list.ZIndex = 21
            popup_list.Parent = popup
            padding(popup_list, FRAME_PAD, 2)
            list_layout(popup_list, 2)

            local item_h = EL_H
            local max_vis = 6
            local function populate(list)
                for _,c in ipairs(popup_list:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
                for _,item in ipairs(list) do
                    local ib = Instance.new("TextButton")
                    ib.Size = UDim2.new(1,0,0,item_h)
                    ib.BackgroundColor3 = tostring(item)==sel and C.header or C.popup_bg
                    ib.BackgroundTransparency = tostring(item)==sel and 0.69 or 1
                    ib.Text = tostring(item)
                    ib.TextColor3 = C.text
                    ib.TextSize = FONT_SZ
                    ib.Font = FONT
                    ib.TextXAlignment = Enum.TextXAlignment.Left
                    ib.BorderSizePixel = 0
                    ib.ZIndex = 22
                    ib.Parent = popup_list
                    padding(ib, FRAME_PAD, 0)
                    ib.MouseEnter:Connect(function() set(ib,{BackgroundColor3=C.header, BackgroundTransparency=0.4}) end)
                    ib.MouseLeave:Connect(function() set(ib,{BackgroundColor3= tostring(item)==sel and C.header or C.popup_bg, BackgroundTransparency= tostring(item)==sel and 0.69 or 1}) end)
                    ib.MouseButton1Click:Connect(function()
                        sel = tostring(item)
                        sel_lbl.Text = sel .. "  ▼"
                        populate(list)
                        open = false
                        popup.Size = UDim2.new(1,0,0,0)
                        cb(sel)
                    end)
                end
            end
            populate(items)

            local open_btn = Instance.new("TextButton")
            open_btn.Size = UDim2.new(1,0,1,0)
            open_btn.BackgroundTransparency = 1
            open_btn.Text = ""
            open_btn.ZIndex = 5
            open_btn.Parent = row

            open_btn.MouseButton1Click:Connect(function()
                open = not open
                local th = math.min(#items, max_vis) * (item_h+2) + 4
                popup.Size = UDim2.new(1,0,0, open and th or 0)
                sel_lbl.Text = sel .. (open and "  ▲" or "  ▼")
            end)
            open_btn.MouseEnter:Connect(function() set(row,{BackgroundColor3=C.frame_bg_hov}) end)
            open_btn.MouseLeave:Connect(function() set(row,{BackgroundColor3=C.frame_bg}) end)

            function el:Set(v)
                sel = tostring(v)
                sel_lbl.Text = sel .. "  ▼"
                populate(items)
            end
            function el:SetItems(list) items = list; populate(list) end
            function el:Get() return sel end
            return el
        end

        function sec:ColorPicker(opts)
            local el = {}
            local color  = opts.Default  or Color3.fromRGB(255,0,0)
            local cb     = opts.Callback or function() end
            local open   = false
            local h_v, s_v, v_v = Color3.toHSV(color)
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.frame_bg, rnd())
            row.LayoutOrder = next_lo()
            stroke(row, C.border, 1)

            local swatch = frame(row, UDim2.new(0,13,0,13), color, rnd())
            swatch.Position = UDim2.new(0,FRAME_PAD,0.5,-6)
            stroke(swatch, C.border, 1)

            local hex_lbl = label(row, "#"..color:ToHex():upper().."  ▼", UDim2.new(1,-20,1,0), C.text)
            hex_lbl.Position = UDim2.new(0,20,0,0)

            local picker = Instance.new("Frame")
            picker.Size = UDim2.new(1,0,0,0)
            picker.Position = UDim2.new(0,0,1,1)
            picker.BackgroundColor3 = C.popup_bg
            picker.BorderSizePixel = 0
            picker.ClipsDescendants = true
            picker.ZIndex = 20
            picker.Parent = row
            stroke(picker, C.border, 1)

            local PH = 170
            local sv = Instance.new("ImageLabel")
            sv.Size = UDim2.new(1,-PAD*2,0,120)
            sv.Position = UDim2.new(0,PAD,0,PAD)
            sv.Image = "rbxassetid://6523286724"
            sv.BackgroundColor3 = Color3.fromHSV(h_v,1,1)
            sv.BorderSizePixel = 0
            sv.ZIndex = 21
            sv.Parent = picker
            stroke(sv, C.border, 1)

            local sv_knob = frame(sv, UDim2.new(0,7,0,7), Color3.fromRGB(255,255,255), rnd())
            sv_knob.AnchorPoint = Vector2.new(0.5,0.5)
            sv_knob.Position = UDim2.new(s_v,0,1-v_v,0)
            sv_knob.ZIndex = 22
            stroke(sv_knob, Color3.fromRGB(0,0,0), 1)

            local hbar = Instance.new("ImageLabel")
            hbar.Size = UDim2.new(1,-PAD*2,0,12)
            hbar.Position = UDim2.new(0,PAD,0,130)
            hbar.Image = "rbxassetid://6523291696"
            hbar.BackgroundColor3 = Color3.fromRGB(255,255,255)
            hbar.BorderSizePixel = 0
            hbar.ZIndex = 21
            hbar.Parent = picker
            stroke(hbar, C.border, 1)

            local h_knob = frame(hbar, UDim2.new(0,4,1,0), Color3.fromRGB(255,255,255), rnd())
            h_knob.AnchorPoint = Vector2.new(0.5,0)
            h_knob.Position = UDim2.new(h_v,0,0,0)
            h_knob.ZIndex = 22
            stroke(h_knob, Color3.fromRGB(0,0,0), 1)

            local hex_full = label(picker, "#"..color:ToHex():upper(), UDim2.new(1,-PAD*2,0,16), C.text_dis, Enum.TextXAlignment.Center)
            hex_full.Position = UDim2.new(0,PAD,0,148)
            hex_full.ZIndex = 21
            local function update()
                color = Color3.fromHSV(h_v,s_v,v_v)
                swatch.BackgroundColor3 = color
                sv.BackgroundColor3 = Color3.fromHSV(h_v,1,1)
                sv_knob.Position = UDim2.new(s_v,0,1-v_v,0)
                h_knob.Position  = UDim2.new(h_v,0,0,0)
                local hex = color:ToHex():upper()
                hex_lbl.Text  = "#"..hex.."  ▼"
                hex_full.Text = "#"..hex
                cb(color)
            end

            local sv_drag, h_drag = false, false
            sv.InputBegan:Connect(function(inp)
                if inp.UserInputType~=Enum.UserInputType.MouseButton1 and inp.UserInputType~=Enum.UserInputType.Touch then return end
                sv_drag=true
                s_v=math.clamp((inp.Position.X-sv.AbsolutePosition.X)/sv.AbsoluteSize.X,0,1)
                v_v=1-math.clamp((inp.Position.Y-sv.AbsolutePosition.Y)/sv.AbsoluteSize.Y,0,1)
                update()
            end)
            hbar.InputBegan:Connect(function(inp)
                if inp.UserInputType~=Enum.UserInputType.MouseButton1 and inp.UserInputType~=Enum.UserInputType.Touch then return end
                h_drag=true
                h_v=math.clamp((inp.Position.X-hbar.AbsolutePosition.X)/hbar.AbsoluteSize.X,0,1)
                update()
            end)
            UIS.InputChanged:Connect(function(inp)
                if inp.UserInputType~=Enum.UserInputType.MouseMovement and inp.UserInputType~=Enum.UserInputType.Touch then return end
                if sv_drag then
                    s_v=math.clamp((inp.Position.X-sv.AbsolutePosition.X)/sv.AbsoluteSize.X,0,1)
                    v_v=1-math.clamp((inp.Position.Y-sv.AbsolutePosition.Y)/sv.AbsoluteSize.Y,0,1)
                    update()
                end
                if h_drag then
                    h_v=math.clamp((inp.Position.X-hbar.AbsolutePosition.X)/hbar.AbsoluteSize.X,0,1)
                    update()
                end
            end)
            UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                    sv_drag=false; h_drag=false
                end
            end)

            local open_btn = Instance.new("TextButton")
            open_btn.Size = UDim2.new(1,0,1,0)
            open_btn.BackgroundTransparency = 1
            open_btn.Text = ""
            open_btn.Parent = row
            open_btn.MouseButton1Click:Connect(function()
                open = not open
                picker.Size = UDim2.new(1,0,0, open and PH or 0)
                hex_lbl.Text = "#"..color:ToHex():upper()..(open and "  ▲" or "  ▼")
            end)
            open_btn.MouseEnter:Connect(function() set(row,{BackgroundColor3=C.frame_bg_hov}) end)
            open_btn.MouseLeave:Connect(function() set(row,{BackgroundColor3=C.frame_bg}) end)

            function el:Set(c) color=c; h_v,s_v,v_v=Color3.toHSV(c); update() end
            function el:Get() return color end
            return el
        end

        function sec:Keybind(opts)
            local el = {}
            local bound    = opts.Default  or Enum.KeyCode.F
            local cb       = opts.Callback or function() end
            local listening = false
            local row = frame(items_frame, UDim2.new(1,0,0,EL_H), C.win_bg, rnd())
            row.BackgroundTransparency = 1
            row.LayoutOrder = next_lo()

            local key_f = frame(row, UDim2.new(0,80,0,EL_H-2), C.frame_bg, rnd())
            key_f.Position = UDim2.new(1,-82,0.5,-(EL_H-2)/2)
            stroke(key_f, C.border, 1)

            local key_lbl = label(key_f, "["..bound.Name.."]", UDim2.new(1,0,1,0), C.text, Enum.TextXAlignment.Center)
            local key_btn = Instance.new("TextButton")
            key_btn.Size = UDim2.new(1,0,1,0)
            key_btn.BackgroundTransparency = 1
            key_btn.Text = ""
            key_btn.Parent = key_f

            key_btn.MouseButton1Click:Connect(function()
                listening = true
                key_lbl.Text = "[...]"
                set(key_f,{BackgroundColor3=C.frame_bg_hov})
            end)
            key_btn.MouseEnter:Connect(function() if not listening then set(key_f,{BackgroundColor3=C.frame_bg_hov}) end end)
            key_btn.MouseLeave:Connect(function() if not listening then set(key_f,{BackgroundColor3=C.frame_bg}) end end)

            UIS.InputBegan:Connect(function(inp, gpe)
                if not listening then return end
                if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                listening = false
                bound = inp.KeyCode
                key_lbl.Text = "["..bound.Name.."]"
                set(key_f,{BackgroundColor3=C.frame_bg})
                cb(bound)
            end)

            function el:Set(kc) bound=kc; key_lbl.Text="["..kc.Name.."]" end
            function el:Get() return bound end
            return el
        end

        table.insert(win._sections, sec)
        return sec
    end

    table.insert(self._windows, win)
    return win
end

function Lib:Notify(opts)
    if type(self) ~= "table" then opts = self; self = Lib end
    ensure_sg(self)
    local title_s  = opts.Title    or "Notice"
    local msg_s    = opts.Message  or ""
    local dur      = opts.Duration or 3
    local ntype    = opts.Type     or "Info"
    local accent_map = { Info=C.info, Success=C.success, Warning=C.warning, Error=C.danger }
    local accent = accent_map[ntype] or C.info
    local NW = 300
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0,NW,0,0)
    notif.AutomaticSize = Enum.AutomaticSize.Y
    notif.Position = UDim2.new(1,NW+8,1,-8)
    notif.AnchorPoint = Vector2.new(1,1)
    notif.BackgroundColor3 = C.popup_bg
    notif.BorderSizePixel = 0
    notif.Parent = self._sg
    stroke(notif, C.border, 1)

    local bar = frame(notif, UDim2.new(0,3,1,0), accent, rnd())
    bar.Position = UDim2.new(0,0,0,0)

    local t_lbl = label(notif, "[" .. ntype .. "] " .. title_s, UDim2.new(1,-12,0,EL_H), C.text)
    t_lbl.Position = UDim2.new(0,8,0,2)
    t_lbl.TextColor3 = accent

    local m_lbl = Instance.new("TextLabel")
    m_lbl.Size = UDim2.new(1,-12,0,0)
    m_lbl.AutomaticSize = Enum.AutomaticSize.Y
    m_lbl.Position = UDim2.new(0,8,0,EL_H+2)
    m_lbl.BackgroundTransparency = 1
    m_lbl.Text = msg_s
    m_lbl.TextColor3 = C.text_dis
    m_lbl.TextSize = FONT_SZ
    m_lbl.Font = FONT
    m_lbl.TextXAlignment = Enum.TextXAlignment.Left
    m_lbl.TextWrapped = true
    m_lbl.Parent = notif

    notif.Position = UDim2.new(1,NW+8,1,-8)
    task.defer(function() set(notif,{Position=UDim2.new(1,-8,1,-8)}) end)
    task.delay(dur, function()
        set(notif,{Position=UDim2.new(1,NW+8,1,-8)})
        task.delay(0.05, function() notif:Destroy() end)
    end)
end

return _inst