--[[
==============================================================
        LONG UI LIBRARY V9 - UPDATED LOADER
==============================================================

UPDATE:
✓ Giữ nguyên giao diện LONG UI V9
✓ Menu Width  = 507
✓ Menu Height = 384
✓ Transparency = 57%
✓ Không còn Floating Button tự động
✓ Người dùng tự tạo nút Toggle
✓ Bấm X -> Popup xác nhận
✓ "Đóng" -> Destroy GUI
✓ "Không" -> Giữ GUI
✓ Có thông báo "Đã destroy menu GUI"
✓ Window:Show()
✓ Window:Hide()
✓ Window:Toggle()
✓ Window:Destroy()

SOURCE:
by-nhatlong-v9
==============================================================
]]

local SOURCE_URL =
    "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/by-nhatlong-v9"

--==============================================================
-- SERVICES
--==============================================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- SAFE HTTP
--==============================================================

local function HttpGet(url)
    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok or type(result) ~= "string" or #result < 100 then
        error(
            "[LONG] Không thể tải Library.\n"
            .. tostring(result)
        )
    end

    return result
end

--==============================================================
-- PLAIN TEXT REPLACE
--==============================================================

local function ReplaceOnce(source, old, new)
    local startPos, endPos = string.find(
        source,
        old,
        1,
        true
    )

    if not startPos then
        return source, false
    end

    return
        string.sub(source, 1, startPos - 1)
        .. new
        .. string.sub(source, endPos + 1),
        true
end

--==============================================================
-- LOAD ORIGINAL SOURCE
--==============================================================

local Source = HttpGet(SOURCE_URL)

--==============================================================
-- FORCE DEFAULT SETTINGS
--==============================================================

Source = Source:gsub(
    'FloatingButton = true,',
    'FloatingButton = false,'
)

Source = Source:gsub(
    'MenuWidth = 507,',
    'MenuWidth = 507,'
)

Source = Source:gsub(
    'MenuHeight = 384,',
    'MenuHeight = 384,'
)

Source = Source:gsub(
    'Transparency = 57,',
    'Transparency = 57,'
)

--==============================================================
-- CLOSE CONFIRMATION SYSTEM
--==============================================================

local ConfirmationCode = [[

    --==========================================================
    -- LONG CLOSE CONFIRMATION
    --==========================================================

    local CloseConfirmation = nil
    local CloseBusy = false

    local function DestroyWithNotification()

        if CloseBusy then
            return
        end

        CloseBusy = true

        pcall(function()
            StarterGui:SetCore(
                "SendNotification",
                {
                    Title = "LONG",
                    Text = "Đã destroy menu GUI",
                    Duration = 3
                }
            )
        end)

        task.delay(
            0.08,
            function()

                pcall(function()
                    if ScreenGui then
                        ScreenGui:Destroy()
                    end
                end)

            end
        )
    end

    local function RemoveConfirmation()

        if CloseConfirmation then

            pcall(function()
                CloseConfirmation:Destroy()
            end)

            CloseConfirmation = nil
        end

    end

    local function CreateCloseConfirmation()

        if CloseBusy then
            return
        end

        if CloseConfirmation
            and CloseConfirmation.Parent
        then
            return
        end

        CloseConfirmation =
            Instance.new("Frame")

        CloseConfirmation.Name =
            "LONG_CloseConfirmation"

        CloseConfirmation.AnchorPoint =
            Vector2.new(0.5, 0.5)

        CloseConfirmation.Position =
            UDim2.fromScale(0.5, 0.5)

        CloseConfirmation.Size =
            UDim2.fromOffset(
                300,
                155
            )

        CloseConfirmation.BackgroundColor3 =
            Library.Theme.Secondary

        CloseConfirmation.BackgroundTransparency =
            Library.Theme.Transparency

        CloseConfirmation.BorderSizePixel =
            0

        CloseConfirmation.ZIndex =
            100

        CloseConfirmation.Parent =
            ScreenGui

        local confirmCorner =
            Instance.new("UICorner")

        confirmCorner.CornerRadius =
            UDim.new(0, 12)

        confirmCorner.Parent =
            CloseConfirmation

        local confirmStroke =
            Instance.new("UIStroke")

        confirmStroke.Color =
            Library.Theme.Border

        confirmStroke.Thickness =
            1

        confirmStroke.Parent =
            CloseConfirmation

        --======================================================
        -- TITLE
        --======================================================

        local Title =
            Instance.new("TextLabel")

        Title.Name =
            "Title"

        Title.Position =
            UDim2.fromOffset(
                15,
                12
            )

        Title.Size =
            UDim2.new(
                1,
                -30,
                0,
                28
            )

        Title.BackgroundTransparency =
            1

        Title.Text =
            "Xác nhận đóng Menu"

        Title.TextColor3 =
            Library.Theme.Text

        Title.Font =
            Enum.Font.GothamBold

        Title.TextSize =
            15

        Title.TextXAlignment =
            Enum.TextXAlignment.Left

        Title.ZIndex =
            101

        Title.Parent =
            CloseConfirmation

        --======================================================
        -- MESSAGE
        --======================================================

        local Message =
            Instance.new("TextLabel")

        Message.Name =
            "Message"

        Message.Position =
            UDim2.fromOffset(
                15,
                44
            )

        Message.Size =
            UDim2.new(
                1,
                -30,
                0,
                42
            )

        Message.BackgroundTransparency =
            1

        Message.Text =
            "Bạn có muốn destroy Menu GUI không?"

        Message.TextColor3 =
            Library.Theme.SubText

        Message.Font =
            Enum.Font.Gotham

        Message.TextSize =
            12

        Message.TextWrapped =
            true

        Message.TextXAlignment =
            Enum.TextXAlignment.Left

        Message.ZIndex =
            101

        Message.Parent =
            CloseConfirmation

        --======================================================
        -- DON'T BUTTON
        --======================================================

        local NoButton =
            Instance.new("TextButton")

        NoButton.Name =
            "No"

        NoButton.Position =
            UDim2.new(
                0,
                15,
                1,
                -48
            )

        NoButton.Size =
            UDim2.new(
                0.5,
                -20,
                0,
                34
            )

        NoButton.BackgroundColor3 =
            Library.Theme.Tertiary

        NoButton.BackgroundTransparency =
            Library.Theme.Transparency

        NoButton.BorderSizePixel =
            0

        NoButton.Text =
            "Không"

        NoButton.TextColor3 =
            Library.Theme.Text

        NoButton.Font =
            Enum.Font.GothamBold

        NoButton.TextSize =
            12

        NoButton.AutoButtonColor =
            false

        NoButton.ZIndex =
            101

        NoButton.Parent =
            CloseConfirmation

        local noCorner =
            Instance.new("UICorner")

        noCorner.CornerRadius =
            UDim.new(0, 8)

        noCorner.Parent =
            NoButton

        --======================================================
        -- YES BUTTON
        --======================================================

        local YesButton =
            Instance.new("TextButton")

        YesButton.Name =
            "Yes"

        YesButton.AnchorPoint =
            Vector2.new(1, 0)

        YesButton.Position =
            UDim2.new(
                1,
                -15,
                1,
                -48
            )

        YesButton.Size =
            UDim2.new(
                0.5,
                -20,
                0,
                34
            )

        YesButton.BackgroundColor3 =
            Library.Theme.Danger

        YesButton.BackgroundTransparency =
            Library.Theme.Transparency

        YesButton.BorderSizePixel =
            0

        YesButton.Text =
            "Đóng"

        YesButton.TextColor3 =
            Color3.new(
                1,
                1,
                1
            )

        YesButton.Font =
            Enum.Font.GothamBold

        YesButton.TextSize =
            12

        YesButton.AutoButtonColor =
            false

        YesButton.ZIndex =
            101

        YesButton.Parent =
            CloseConfirmation

        local yesCorner =
            Instance.new("UICorner")

        yesCorner.CornerRadius =
            UDim.new(0, 8)

        yesCorner.Parent =
            YesButton

        --======================================================
        -- BUTTON EVENTS
        --======================================================

        NoButton.MouseButton1Click:Connect(
            function()

                RemoveConfirmation()

            end
        )

        YesButton.MouseButton1Click:Connect(
            function()

                DestroyWithNotification()

            end
        )

        --======================================================
        -- MOBILE / TOUCH
        --======================================================

        NoButton.TouchTap:Connect(
            function()

                RemoveConfirmation()

            end
        )

        YesButton.TouchTap:Connect(
            function()

                DestroyWithNotification()

            end
        )

    end

]]

--==============================================================
-- INSERT CONFIRMATION SYSTEM
--==============================================================

do

    local marker =
        "    --==========================================================\n"
        .. "    -- MINIMIZE STATE\n"
        .. "    --=========================================================="

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            marker,
            ConfirmationCode
            .. "\n"
            .. marker
        )

    if not patched then
        warn(
            "[LONG] Không tìm thấy vị trí chèn Close Confirmation."
        )
    end

end

--==============================================================
-- REPLACE CLOSE EVENT
--==============================================================

do

    local oldBlock =
        [[    Close.MouseButton1Click:Connect(
        function()

            Main.Visible =
                false

            if Library.Settings.FloatingButton then
                FloatingButton.Visible = true
            end
        end
    )]]

    local newBlock =
        [[    Close.MouseButton1Click:Connect(
        function()

            CreateCloseConfirmation()

        end
    )]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

    if not patched then

        warn(
            "[LONG] Không tìm thấy Close event."
        )

    end

end

--==============================================================
-- DISABLE FLOATING BUTTON EVENT
--==============================================================

do

    local oldBlock =
        [[    FloatingButton.MouseButton1Click:Connect(
        function()

            Main.Visible = true

            FloatingButton.Visible = false
        end
    )]]

    local newBlock =
        [[    FloatingButton.MouseButton1Click:Connect(
        function()

            -- Floating Button disabled.
            -- Toggle must be created by the player.

            FloatingButton.Visible = false

        end
    )]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- DISABLE FLOATING BUTTON IN REFRESH
--==============================================================

do

    local oldBlock =
        [[        FloatingButton.Visible =
            Library.Settings.FloatingButton
            and not Main.Visible]]

    local newBlock =
        [[        FloatingButton.Visible = false]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- DISABLE FLOATING BUTTON SETTING
--==============================================================

do

    local oldBlock =
        [[    BehaviorSection:CreateToggle(
        Library:GetText(
            "FloatingButton"
        ),
        Library.Settings.FloatingButton,

        function(value)

            Library.Settings.FloatingButton =
                value

            FloatingButton.Visible =
                value
                and not Main.Visible

        end
    )]]

    local newBlock =
        [[    -- Floating Button removed.
    -- Library no longer creates an automatic open button.]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- PATCH SHOW
--==============================================================

do

    local oldBlock =
        [[    function WindowObject:Show()

        Main.Visible =
            true

        FloatingButton.Visible =
            false

    end]]

    local newBlock =
        [[    function WindowObject:Show()

        if not Main or not Main.Parent then
            return
        end

        Main.Visible = true

        if FloatingButton then
            FloatingButton.Visible = false
        end

    end]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- PATCH HIDE
--==============================================================

do

    local oldBlock =
        [[    function WindowObject:Hide()

        Main.Visible =
            false

        if Library.Settings.FloatingButton then

            FloatingButton.Visible =
                true

        end

    end]]

    local newBlock =
        [[    function WindowObject:Hide()

        if not Main or not Main.Parent then
            return
        end

        Main.Visible = false

        if FloatingButton then
            FloatingButton.Visible = false
        end

    end]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- PATCH TOGGLE
--==============================================================

do

    local oldBlock =
        [[    function WindowObject:Toggle()

        if Main.Visible then

            self:Hide()
        else

            self:Show()

        end

    end]]

    local newBlock =
        [[    function WindowObject:Toggle()

        if not Main or not Main.Parent then
            return
        end

        if Main.Visible then
            self:Hide()
        else
            self:Show()
        end

    end]]

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            oldBlock,
            newBlock
        )

end

--==============================================================
-- FORCE FLOATING BUTTON FALSE AFTER CREATE
--==============================================================

local ForceCode = [[

--==============================================================
-- FINAL FLOATING BUTTON LOCK
--==============================================================

Library.Settings.FloatingButton = false

for _, window in ipairs(Library.Windows) do

    if window
        and window.FloatingButton
    then

        pcall(function()
            window.FloatingButton.Visible = false
        end)

    end

end

]]

-- Insert before return Library
do

    local marker =
        "\nreturn Library"

    local patched

    Source, patched =
        ReplaceOnce(
            Source,
            marker,
            ForceCode
            .. marker
        )

    if not patched then
        warn(
            "[LONG] Không tìm thấy return Library."
        )
    end

end

--==============================================================
-- COMPILE
--==============================================================

local Chunk, ErrorMessage =
    loadstring(Source)

if not Chunk then

    error(
        "[LONG] Library patch bị lỗi:\n"
        .. tostring(ErrorMessage)
    )

end

--==============================================================
-- EXECUTE
--==============================================================

local Library =
    Chunk()

if type(Library) ~= "table" then

    error(
        "[LONG] Library không trả về table hợp lệ."
    )

end

--==============================================================
-- FINAL DEFAULTS
--==============================================================

pcall(function()

    Library.Settings.MenuWidth =
        507

    Library.Settings.MenuHeight =
        384

    Library.Settings.Transparency =
        57

    Library.Settings.FloatingButton =
        false

    if Library.Theme then

        Library.Theme.Transparency =
            0.57

    end

end)

--==============================================================
-- RETURN
--==============================================================

return Library
