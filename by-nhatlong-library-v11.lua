--[[
================================================================
                 LONG UI LIBRARY V10.1
                 POSITION FIXED BUILD
================================================================

FIX
----------------------------------------------------------------
✓ Fix Mini UI bị nhảy vị trí khi thu nhỏ
✓ Mini UI giữ nguyên vị trí người dùng đã kéo
✓ Restore giữ nguyên vị trí
✓ Không tự đưa Mini UI về giữa
✓ Không tự reset vị trí khi resize
✓ PC + Mobile
✓ Drag mini UI
✓ Clamp vị trí
✓ Close confirmation giữ nguyên
✓ Không update / không thêm toggle menu
✓ Animation Speed = 100
✓ Menu Width  = 507
✓ Menu Height = 384
✓ Transparency = 57
✓ Không Floating Button tự động
✓ Position API
✓ Animation API
✓ Theme
✓ Accent
✓ RGB
✓ Language
✓ Search
✓ Notification
✓ Slider
✓ Dropdown
✓ Multi Dropdown
✓ Textbox
✓ Keybind
✓ Reset

================================================================
SOURCE
by-nhatlong-v9
================================================================
]]

--==============================================================
-- SOURCE
--==============================================================

local SOURCE_URL =
    "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/by-nhatlong-v9"

--==============================================================
-- SERVICES
--==============================================================

local Players =
    game:GetService("Players")

local StarterGui =
    game:GetService("StarterGui")

local UserInputService =
    game:GetService("UserInputService")

local TweenService =
    game:GetService("TweenService")

local LocalPlayer =
    Players.LocalPlayer

--==============================================================
-- SAFE HTTP
--==============================================================

local function HttpGet(url)

    local success, result =
        pcall(function()

            return game:HttpGet(url)

        end)

    if not success then

        error(
            "[LONG V10.1] HttpGet failed:\n"
            .. tostring(result)
        )

    end

    if type(result) ~= "string" then

        error(
            "[LONG V10.1] Invalid source."
        )

    end

    if #result < 1000 then

        error(
            "[LONG V10.1] Source too small."
        )

    end

    return result

end

--==============================================================
-- REPLACE
--==============================================================

local function ReplaceOnce(
    source,
    old,
    new
)

    local startPos, endPos =
        string.find(
            source,
            old,
            1,
            true
        )

    if not startPos then

        return source, false

    end

    return
        string.sub(
            source,
            1,
            startPos - 1
        )
        .. new
        .. string.sub(
            source,
            endPos + 1
        ),
        true

end

--==============================================================
-- LOAD ORIGINAL
--==============================================================

local Source =
    HttpGet(SOURCE_URL)

--==============================================================
-- DEFAULT SETTINGS
--==============================================================

Source =
    Source:gsub(
        "AnimationSpeed = 0%.18,",
        "AnimationSpeed = 1.0,"
    )

Source =
    Source:gsub(
        "FloatingButton = true,",
        "FloatingButton = false,"
    )

--==============================================================
-- CLOSE CONFIRMATION
--==============================================================

local ConfirmationCode = [[

    --==========================================================
    -- LONG CLOSE CONFIRMATION
    --==========================================================

    local CloseConfirmation = nil
    local CloseBusy = false

    local function RemoveCloseConfirmation()

        if CloseConfirmation then

            pcall(function()

                CloseConfirmation:Destroy()

            end)

            CloseConfirmation = nil

        end

    end

    local function NotifyDestroyed()

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

    end

    local function DestroyWindowConfirmed()

        if CloseBusy then
            return
        end

        CloseBusy = true

        RemoveCloseConfirmation()

        NotifyDestroyed()

        task.delay(
            0.05,
            function()

                pcall(function()

                    if ScreenGui then

                        ScreenGui:Destroy()

                    end

                end)

            end
        )

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
            Vector2.new(
                0.5,
                0.5
            )

        CloseConfirmation.Position =
            UDim2.fromScale(
                0.5,
                0.5
            )

        CloseConfirmation.Size =
            UDim2.fromOffset(
                310,
                160
            )

        CloseConfirmation.BackgroundColor3 =
            Library.Theme.Secondary

        CloseConfirmation.BackgroundTransparency =
            Library.Theme.Transparency

        CloseConfirmation.BorderSizePixel =
            0

        CloseConfirmation.ZIndex =
            1000

        CloseConfirmation.Parent =
            ScreenGui

        local Corner =
            Instance.new("UICorner")

        Corner.CornerRadius =
            UDim.new(
                0,
                12
            )

        Corner.Parent =
            CloseConfirmation

        local Stroke =
            Instance.new("UIStroke")

        Stroke.Color =
            Library.Theme.Border

        Stroke.Thickness =
            1

        Stroke.Parent =
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
                16,
                13
            )

        Title.Size =
            UDim2.new(
                1,
                -32,
                0,
                28
            )

        Title.BackgroundTransparency =
            1

        Title.Text =
            "Xác nhận đóng Menu"

        Title.Font =
            Enum.Font.GothamBold

        Title.TextSize =
            15

        Title.TextColor3 =
            Library.Theme.Text

        Title.TextXAlignment =
            Enum.TextXAlignment.Left

        Title.ZIndex =
            1001

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
                16,
                47
            )

        Message.Size =
            UDim2.new(
                1,
                -32,
                0,
                44
            )

        Message.BackgroundTransparency =
            1

        Message.Text =
            "Bạn có chắc muốn đóng và destroy Menu GUI?"

        Message.Font =
            Enum.Font.Gotham

        Message.TextSize =
            12

        Message.TextWrapped =
            true

        Message.TextColor3 =
            Library.Theme.SubText

        Message.TextXAlignment =
            Enum.TextXAlignment.Left

        Message.ZIndex =
            1001

        Message.Parent =
            CloseConfirmation

        --======================================================
        -- NO BUTTON
        --======================================================

        local NoButton =
            Instance.new("TextButton")

        NoButton.Name =
            "No"

        NoButton.Position =
            UDim2.new(
                0,
                16,
                1,
                -50
            )

        NoButton.Size =
            UDim2.new(
                0.5,
                -21,
                0,
                35
            )

        NoButton.BackgroundColor3 =
            Library.Theme.Tertiary

        NoButton.BackgroundTransparency =
            Library.Theme.Transparency

        NoButton.BorderSizePixel =
            0

        NoButton.Text =
            "Không"

        NoButton.Font =
            Enum.Font.GothamBold

        NoButton.TextSize =
            12

        NoButton.TextColor3 =
            Library.Theme.Text

        NoButton.AutoButtonColor =
            false

        NoButton.ZIndex =
            1001

        NoButton.Parent =
            CloseConfirmation

        local NoCorner =
            Instance.new("UICorner")

        NoCorner.CornerRadius =
            UDim.new(
                0,
                8
            )

        NoCorner.Parent =
            NoButton

        --======================================================
        -- YES BUTTON
        --======================================================

        local YesButton =
            Instance.new("TextButton")

        YesButton.Name =
            "Yes"

        YesButton.AnchorPoint =
            Vector2.new(
                1,
                0
            )

        YesButton.Position =
            UDim2.new(
                1,
                -16,
                1,
                -50
            )

        YesButton.Size =
            UDim2.new(
                0.5,
                -21,
                0,
                35
            )

        YesButton.BackgroundColor3 =
            Library.Theme.Danger

        YesButton.BackgroundTransparency =
            Library.Theme.Transparency

        YesButton.BorderSizePixel =
            0

        YesButton.Text =
            "Đóng"

        YesButton.Font =
            Enum.Font.GothamBold

        YesButton.TextSize =
            12

        YesButton.TextColor3 =
            Color3.new(
                1,
                1,
                1
            )

        YesButton.AutoButtonColor =
            false

        YesButton.ZIndex =
            1001

        YesButton.Parent =
            CloseConfirmation

        local YesCorner =
            Instance.new("UICorner")

        YesCorner.CornerRadius =
            UDim.new(
                0,
                8
            )

        YesCorner.Parent =
            YesButton

        --======================================================
        -- HOVER
        --======================================================

        NoButton.MouseEnter:Connect(
            function()

                pcall(function()

                    NoButton.BackgroundColor3 =
                        Library.Theme.Accent

                end)

            end
        )

        NoButton.MouseLeave:Connect(
            function()

                pcall(function()

                    NoButton.BackgroundColor3 =
                        Library.Theme.Tertiary

                end)

            end
        )

        YesButton.MouseEnter:Connect(
            function()

                pcall(function()

                    YesButton.BackgroundColor3 =
                        Library.Theme.Danger:Lerp(
                            Color3.new(
                                1,
                                1,
                                1
                            ),
                            0.12
                        )

                end)

            end
        )

        YesButton.MouseLeave:Connect(
            function()

                pcall(function()

                    YesButton.BackgroundColor3 =
                        Library.Theme.Danger

                end)

            end
        )

        --======================================================
        -- BUTTONS
        --======================================================

        NoButton.MouseButton1Click:Connect(
            function()

                RemoveCloseConfirmation()

            end
        )

        YesButton.MouseButton1Click:Connect(
            function()

                DestroyWindowConfirmed()

            end
        )

        NoButton.TouchTap:Connect(
            function()

                RemoveCloseConfirmation()

            end
        )

        YesButton.TouchTap:Connect(
            function()

                DestroyWindowConfirmed()

            end
        )

    end

]]

--==============================================================
-- INSERT CONFIRMATION
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- MINIMIZE STATE\n"
        .. "    --=========================================================="

    local NewSource, patched =
        ReplaceOnce(
            Source,
            Marker,
            ConfirmationCode
            .. "\n"
            .. Marker
        )

    if patched then

        Source =
            NewSource

    end

end

--==============================================================
-- CLOSE
--==============================================================

do

    local Old =
        [[    Close.MouseButton1Click:Connect(
        function()

            Main.Visible = false

            if Library.Settings.FloatingButton then
                FloatingButton.Visible = true
            end
        end
    )]]

    local New =
        [[    Close.MouseButton1Click:Connect(
        function()

            CreateCloseConfirmation()

        end
    )]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- FLOATING BUTTON OFF
--==============================================================

do

    local Old =
        [[    FloatingButton.MouseButton1Click:Connect(
        function()

            Main.Visible = true

            FloatingButton.Visible = false
        end
    )]]

    local New =
        [[    FloatingButton.MouseButton1Click:Connect(
        function()

            FloatingButton.Visible = false

        end
    )]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- FORCE FLOATING BUTTON HIDDEN
--==============================================================

do

    local Old =
        [[        FloatingButton.Visible =
            Library.Settings.FloatingButton
            and not Main.Visible]]

    local New =
        [[        FloatingButton.Visible = false]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- REMOVE FLOATING BUTTON SETTING
--==============================================================

do

    local Old =
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

    local New =
        [[    -- Floating Button disabled.
    -- User creates their own menu toggle.]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- FIXED POSITION SYSTEM
--==============================================================

local PositionCode = [[

    --==========================================================
    -- LONG V10.1 FIXED POSITION SYSTEM
    --==========================================================

    local SavedCenterX = nil
    local SavedCenterY = nil

    local PositionInitialized = false

    local function GetViewport()

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return nil
        end

        return Camera.ViewportSize

    end

    local function ReadCurrentCenter()

        if not Main
            or not Main.Parent
        then
            return nil, nil
        end

        local AbsolutePosition =
            Main.AbsolutePosition

        local AbsoluteSize =
            Main.AbsoluteSize

        local CenterX =
            AbsolutePosition.X
            + AbsoluteSize.X / 2

        local CenterY =
            AbsolutePosition.Y
            + AbsoluteSize.Y / 2

        return
            CenterX,
            CenterY

    end

    local function SaveCurrentCenter()

        local X, Y =
            ReadCurrentCenter()

        if X and Y then

            SavedCenterX =
                X

            SavedCenterY =
                Y

            PositionInitialized =
                true

        end

    end

    local function ApplySavedCenter()

        if not Main
            or not Main.Parent
        then
            return
        end

        if not SavedCenterX
            or not SavedCenterY
        then
            SaveCurrentCenter()
            return
        end

        local Viewport =
            GetViewport()

        if not Viewport then
            return
        end

        local Width =
            Main.AbsoluteSize.X

        local Height =
            Main.AbsoluteSize.Y

        if Width <= 0
            or Height <= 0
        then
            return
        end

        local HalfWidth =
            Width / 2

        local HalfHeight =
            Height / 2

        local Margin =
            8

        local MinX =
            HalfWidth + Margin

        local MaxX =
            Viewport.X
            - HalfWidth
            - Margin

        local MinY =
            HalfHeight + Margin

        local MaxY =
            Viewport.Y
            - HalfHeight
            - Margin

        if MaxX < MinX then

            SavedCenterX =
                Viewport.X / 2

        else

            SavedCenterX =
                math.clamp(
                    SavedCenterX,
                    MinX,
                    MaxX
                )

        end

        if MaxY < MinY then

            SavedCenterY =
                Viewport.Y / 2

        else

            SavedCenterY =
                math.clamp(
                    SavedCenterY,
                    MinY,
                    MaxY
                )

        end

        Main.Position =
            UDim2.fromOffset(
                SavedCenterX,
                SavedCenterY
            )

    end

    local function ClampSavedCenter()

        if not Main
            or not Main.Parent
        then
            return
        end

        if not SavedCenterX
            or not SavedCenterY
        then
            SaveCurrentCenter()
        end

        ApplySavedCenter()

    end

    function WindowObject:SavePosition()

        SaveCurrentCenter()

        return {
            X = SavedCenterX,
            Y = SavedCenterY
        }

    end

    function WindowObject:GetPosition()

        SaveCurrentCenter()

        return {
            X = SavedCenterX,
            Y = SavedCenterY
        }

    end

    function WindowObject:SetPosition(
        x,
        y
    )

        x =
            tonumber(x)

        y =
            tonumber(y)

        if not x
            or not y
        then

            return false

        end

        SavedCenterX =
            x

        SavedCenterY =
            y

        PositionInitialized =
            true

        ClampSavedCenter()

        return true

    end

    function WindowObject:ResetPosition()

        local Viewport =
            GetViewport()

        if not Viewport then
            return false
        end

        SavedCenterX =
            Viewport.X / 2

        SavedCenterY =
            Viewport.Y / 2

        PositionInitialized =
            true

        ApplySavedCenter()

        return true

    end

    function WindowObject:ClampPosition()

        ClampSavedCenter()

        return true

    end

    --==========================================================
    -- INITIAL POSITION
    --==========================================================

    task.defer(
        function()

            if not PositionInitialized then

                SaveCurrentCenter()

            end

        end
    )

]]

--==============================================================
-- INSERT POSITION SYSTEM
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- NOTIFICATION\n"
        .. "    --=========================================================="

    local NewSource, patched =
        ReplaceOnce(
            Source,
            Marker,
            PositionCode
            .. "\n"
            .. Marker
        )

    if patched then

        Source =
            NewSource

    end

end

--==============================================================
-- FIX MINIMIZE
--
-- QUAN TRỌNG:
-- Không lưu Main.Position.
-- Lưu CENTER của GUI trước khi đổi Size.
--
-- Vì AnchorPoint = 0.5,0.5 nên center sẽ không đổi
-- dù Size chuyển từ 384 -> 58.
--==============================================================

do

    local Old =
        [[    Minimize.MouseButton1Click:Connect(
        function()

            minimized =
                not minimized

            if minimized then

                Tween(
                    Main,
                    {
                        Size =
                            UDim2.fromOffset(
                                Library.Settings.MenuWidth,
                                58
                            )
                    }
                )

                Minimize.Text =
                    "+"

                Sidebar.Visible =
                    false

                Content.Visible =
                    false

            else

                Tween(
                    Main,
                    {
                        Size =
                            UDim2.fromOffset(
                                Library.Settings.MenuWidth,
                                Library.Settings.MenuHeight
                            )
                    }
                )

                Minimize.Text =
                    "—"

                Sidebar.Visible =
                    true

                Content.Visible =
                    true

            end

        end
    )]]

    local New =
        [[    Minimize.MouseButton1Click:Connect(
        function()

            minimized =
                not minimized

            --==================================================
            -- SAVE CENTER BEFORE RESIZE
            --==================================================

            SaveCurrentCenter()

            if minimized then

                --================================================
                -- MINIMIZE
                --================================================

                Tween(
                    Main,
                    {
                        Size =
                            UDim2.fromOffset(
                                Library.Settings.MenuWidth,
                                58
                            )
                    }
                )

                Minimize.Text =
                    "+"

                Sidebar.Visible =
                    false

                Content.Visible =
                    false

                --================================================
                -- RESTORE EXACT SAME CENTER
                --================================================

                task.defer(
                    function()

                        if Main
                            and Main.Parent
                        then

                            ApplySavedCenter()

                        end

                    end
                )

            else

                --================================================
                -- RESTORE
                --================================================

                Tween(
                    Main,
                    {
                        Size =
                            UDim2.fromOffset(
                                Library.Settings.MenuWidth,
                                Library.Settings.MenuHeight
                            )
                    }
                )

                Minimize.Text =
                    "—"

                Sidebar.Visible =
                    true

                Content.Visible =
                    true

                --================================================
                -- KEEP SAME CENTER
                --================================================

                task.defer(
                    function()

                        if Main
                            and Main.Parent
                        then

                            ApplySavedCenter()

                        end

                    end
                )

            end

        end
    )]]

    local NewSource, patched =
        ReplaceOnce(
            Source,
            Old,
            New
        )

    if patched then

        Source =
            NewSource

    else

        warn(
            "[LONG V10.1] Minimize block not found."
        )

    end

end

--==============================================================
-- SHOW
--==============================================================

do

    local Old =
        [[    function WindowObject:Show()

        Main.Visible =
            true

        FloatingButton.Visible =
            false

    end]]

    local New =
        [[    function WindowObject:Show()

        if not Main
            or not Main.Parent
        then
            return
        end

        Main.Visible =
            true

        FloatingButton.Visible =
            false

        task.defer(
            function()

                if Main
                    and Main.Parent
                then

                    ApplySavedCenter()

                end

            end
        )

    end]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- HIDE
--==============================================================

do

    local Old =
        [[    function WindowObject:Hide()

        Main.Visible =
            false

        if Library.Settings.FloatingButton then

            FloatingButton.Visible =
                true

        end

    end]]

    local New =
        [[    function WindowObject:Hide()

        if not Main
            or not Main.Parent
        then
            return
        end

        SaveCurrentCenter()

        Main.Visible =
            false

        FloatingButton.Visible =
            false

    end]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- TOGGLE
--
-- KHÔNG UPDATE LOGIC TOGGLE.
-- Chỉ giữ API cũ.
--==============================================================

-- Không patch thêm toggle menu.

--==============================================================
-- ANIMATION API
--==============================================================

local AnimationAPI = [[

    --==========================================================
    -- V10.1 ANIMATION API
    --==========================================================

    function WindowObject:SetAnimationSpeed(
        value
    )

        value =
            tonumber(value)

        if not value then
            return false
        end

        value =
            math.clamp(
                value,
                0,
                100
            )

        Library.Settings.AnimationSpeed =
            value / 100

        return true

    end

    function WindowObject:GetAnimationSpeed()

        return math.floor(
            Library.Settings.AnimationSpeed
            * 100
            + 0.5
        )

    end

]]

--==============================================================
-- INSERT ANIMATION API
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- WINDOW API\n"
        .. "    --=========================================================="

    local NewSource, patched =
        ReplaceOnce(
            Source,
            Marker,
            AnimationAPI
            .. "\n"
            .. Marker
        )

    if patched then

        Source =
            NewSource

    end

end

--==============================================================
-- FORCE ANIMATION SLIDER
--==============================================================

do

    local Old =
        [[        math.floor(
            Library.Settings.AnimationSpeed
            * 100
        ),]]

    local New =
        [[        100,]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- ANIMATION CALLBACK
--==============================================================

do

    local Old =
        [[        function(value)

            Library.Settings.AnimationSpeed =
                value / 100

        end]]

    local New =
        [[        function(value)

            Library.Settings.AnimationSpeed =
                math.clamp(
                    tonumber(value) or 100,
                    0,
                    100
                ) / 100

        end]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- FINAL SETTINGS
--==============================================================

local FinalCode = [[

--==============================================================
-- LONG V10.1 FINAL SETTINGS
--==============================================================

Library.Settings.MenuWidth =
    507

Library.Settings.MenuHeight =
    384

Library.Settings.Transparency =
    57

Library.Settings.AnimationSpeed =
    1.0

Library.Settings.FloatingButton =
    false

if Library.Theme then

    Library.Theme.Transparency =
        0.57

end

--==============================================================
-- FORCE FLOATING BUTTON OFF
--==============================================================

for _, window in ipairs(
    Library.Windows
) do

    pcall(function()

        if window.FloatingButton then

            window.FloatingButton.Visible =
                false

        end

    end)

end

]]

--==============================================================
-- INSERT FINAL
--==============================================================

do

    local Marker =
        "\nreturn Library"

    local NewSource, patched =
        ReplaceOnce(
            Source,
            Marker,
            "\n"
            .. FinalCode
            .. Marker
        )

    if patched then

        Source =
            NewSource

    end

end

--==============================================================
-- COMPILE
--==============================================================

local Chunk,
    ErrorMessage =
    loadstring(Source)

if not Chunk then

    error(
        "[LONG V10.1] Compile error:\n"
        .. tostring(ErrorMessage)
    )

end

--==============================================================
-- EXECUTE
--==============================================================

local Success,
    Result =
    pcall(function()

        return Chunk()

    end)

if not Success then

    error(
        "[LONG V10.1] Runtime error:\n"
        .. tostring(Result)
    )

end

local Library =
    Result

if type(Library) ~= "table" then

    error(
        "[LONG V10.1] Library did not return table."
    )

end

--==============================================================
-- FINAL API
--==============================================================

pcall(function()

    function Library:SetAnimationSpeed(
        value
    )

        value =
            tonumber(value)

        if not value then
            return false
        end

        value =
            math.clamp(
                value,
                0,
                100
            )

        self.Settings.AnimationSpeed =
            value / 100

        return true

    end

    function Library:GetAnimationSpeed()

        return math.floor(
            self.Settings.AnimationSpeed
            * 100
            + 0.5
        )

    end

end)

--==============================================================
-- FINAL VALUES
--==============================================================

pcall(function()

    Library.Settings.MenuWidth =
        507

    Library.Settings.MenuHeight =
        384

    Library.Settings.Transparency =
        57

    Library.Settings.AnimationSpeed =
        1.0

    Library.Settings.FloatingButton =
        false

end)

--==============================================================
-- RETURN
--==============================================================

return Library
