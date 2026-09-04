--[[
================================================================
                    LONG UI LIBRARY V10
                     FULL UPDATED BUILD
================================================================

UPDATE V10
----------------------------------------------------------------
✓ Menu Width        = 507
✓ Menu Height       = 384
✓ Transparency      = 57
✓ Animation Speed   = 100
✓ No automatic Floating Button
✓ User creates own toggle button
✓ Close confirmation
✓ Close -> Destroy
✓ Cancel -> Keep GUI
✓ Minimize UI
✓ Minimized UI remains draggable
✓ Minimized position preserved
✓ Window position save / restore
✓ Position clamp
✓ Animation speed API
✓ Show / Hide / Toggle / Destroy
✓ PC + Mobile / Touch
✓ Theme
✓ Accent
✓ RGB
✓ Language
✓ Notifications
✓ Search
✓ Slider
✓ Dropdown
✓ Multi Dropdown
✓ Textbox
✓ Keybind
✓ Reset
✓ Safe callbacks
✓ Safe destroy

SOURCE:
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
            "[LONG V10] HttpGet failed:\n"
            .. tostring(result)
        )

    end

    if type(result) ~= "string" then

        error(
            "[LONG V10] Invalid source."
        )

    end

    if #result < 1000 then

        error(
            "[LONG V10] Source too small."
        )

    end

    return result

end

--==============================================================
-- SAFE FIND / REPLACE
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
-- LOAD ORIGINAL LIBRARY
--==============================================================

local Source =
    HttpGet(SOURCE_URL)

--==============================================================
-- FORCE DEFAULT SETTINGS
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

Source =
    Source:gsub(
        "MenuWidth = 507,",
        "MenuWidth = 507,"
    )

Source =
    Source:gsub(
        "MenuHeight = 384,",
        "MenuHeight = 384,"
    )

Source =
    Source:gsub(
        "Transparency = 57,",
        "Transparency = 57,"
    )

--==============================================================
-- CLOSE CONFIRMATION
--==============================================================

local ConfirmationCode = [[

    --==========================================================
    -- V10 CLOSE CONFIRMATION
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
        -- NO
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
        -- YES
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
        -- BUTTON EVENTS
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

    else

        warn(
            "[LONG V10] Close confirmation marker not found."
        )

    end

end

--==============================================================
-- REPLACE CLOSE EVENT
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
            "[LONG V10] Close event not found."
        )

    end

end

--==============================================================
-- REMOVE FLOATING BUTTON CLICK
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

            -- Automatic Floating Button disabled.

            FloatingButton.Visible = false

        end
    )]]

    local NewSource =
        ReplaceOnce(
            Source,
            Old,
            New
        )

    Source =
        NewSource

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
        [[    -- Floating Button disabled in V10.
    -- The user creates their own toggle button.]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- MINIMIZE POSITION SYSTEM
--==============================================================

local PositionCode = [[

    --==========================================================
    -- V10 WINDOW POSITION SYSTEM
    --==========================================================

    local SavedWindowPosition =
        Main.Position

    local DefaultWindowPosition =
        UDim2.fromScale(
            0.5,
            0.5
        )

    local function ClampWindowPosition()

        if not Main
            or not Main.Parent
        then
            return
        end

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return
        end

        local Viewport =
            Camera.ViewportSize

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

        local Current =
            Main.AbsolutePosition

        local CenterX =
            Current.X + HalfWidth

        local CenterY =
            Current.Y + HalfHeight

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
            MinX = Viewport.X / 2
            MaxX = MinX
        end

        if MaxY < MinY then
            MinY = Viewport.Y / 2
            MaxY = MinY
        end

        CenterX =
            math.clamp(
                CenterX,
                MinX,
                MaxX
            )

        CenterY =
            math.clamp(
                CenterY,
                MinY,
                MaxY
            )

        Main.Position =
            UDim2.fromOffset(
                CenterX,
                CenterY
            )

        SavedWindowPosition =
            Main.Position

    end

    function WindowObject:SavePosition()

        if Main
            and Main.Parent
        then

            SavedWindowPosition =
                Main.Position

        end

        return SavedWindowPosition

    end

    function WindowObject:GetPosition()

        if Main
            and Main.Parent
        then

            return Main.Position

        end

        return SavedWindowPosition

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

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return false
        end

        local Viewport =
            Camera.ViewportSize

        local Width =
            Main.AbsoluteSize.X

        local Height =
            Main.AbsoluteSize.Y

        local HalfWidth =
            Width / 2

        local HalfHeight =
            Height / 2

        x =
            math.clamp(
                x,
                HalfWidth + 8,
                Viewport.X
                    - HalfWidth
                    - 8
            )

        y =
            math.clamp(
                y,
                HalfHeight + 8,
                Viewport.Y
                    - HalfHeight
                    - 8
            )

        Main.Position =
            UDim2.fromOffset(
                x,
                y
            )

        SavedWindowPosition =
            Main.Position

        return true

    end

    function WindowObject:ResetPosition()

        Main.Position =
            DefaultWindowPosition

        SavedWindowPosition =
            Main.Position

        return true

    end

    function WindowObject:ClampPosition()

        ClampWindowPosition()

        return true

    end

]]

--==============================================================
-- INSERT POSITION API
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

    else

        warn(
            "[LONG V10] Position marker not found."
        )

    end

end

--==============================================================
-- REPLACE MINIMIZE EVENT
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

                Minimize.Text = "+"
                Sidebar.Visible = false
                Content.Visible = false

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

                Minimize.Text = "—"
                Sidebar.Visible = true
                Content.Visible = true

            end
        end
    )]]

    local New =
        [[    Minimize.MouseButton1Click:Connect(
        function()

            minimized =
                not minimized

            if minimized then

                SavedWindowPosition =
                    Main.Position

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

                task.defer(
                    function()

                        if Main
                            and Main.Parent
                        then

                            Main.Position =
                                SavedWindowPosition

                            ClampWindowPosition()

                        end

                    end
                )

            else

                SavedWindowPosition =
                    Main.Position

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

                task.defer(
                    function()

                        if Main
                            and Main.Parent
                        then

                            Main.Position =
                                SavedWindowPosition

                            ClampWindowPosition()

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
            "[LONG V10] Minimize event not found."
        )

    end

end

--==============================================================
-- REPLACE SHOW
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

        if SavedWindowPosition then

            Main.Position =
                SavedWindowPosition

        end

        task.defer(
            function()

                if Main
                    and Main.Parent
                then

                    ClampWindowPosition()

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
-- REPLACE HIDE
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

        SavedWindowPosition =
            Main.Position

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
-- REPLACE TOGGLE
--==============================================================

do

    local Old =
        [[    function WindowObject:Toggle()

        if Main.Visible then

            self:Hide()

        else

            self:Show()

        end

    end]]

    local New =
        [[    function WindowObject:Toggle()

        if not Main
            or not Main.Parent
        then
            return
        end

        if Main.Visible then

            self:Hide()

        else

            self:Show()

        end

    end]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- ANIMATION API
--==============================================================

local AnimationAPI = [[

    --==========================================================
    -- V10 ANIMATION API
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

    else

        warn(
            "[LONG V10] Window API marker not found."
        )

    end

end

--==============================================================
-- FORCE ANIMATION SLIDER = 100
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
-- FORCE ANIMATION CALLBACK
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
-- FINAL FLOATING BUTTON LOCK
--==============================================================

local FinalCode = [[

--==============================================================
-- V10 FINAL SETTINGS
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
-- WINDOW FINALIZATION
--==============================================================

for _, window in ipairs(
    Library.Windows
) do

    pcall(function()

        if window.FloatingButton then

            window.FloatingButton.Visible =
                false

        end

        if window.Main then

            window.Main.Visible =
                true

        end

        if window.Main
            and window.Main.Parent
        then

            window.Main.Position =
                window.Main.Position

        end

    end)

end

]]

--==============================================================
-- INSERT FINAL CODE
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

    else

        warn(
            "[LONG V10] Return Library marker not found."
        )

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
        "[LONG V10] Compile error:\n"
        .. tostring(ErrorMessage)
    )

end

--==============================================================
-- EXECUTE
--==============================================================

local Library

local Success,
    Result =
    pcall(function()

        return Chunk()

    end)

if not Success then

    error(
        "[LONG V10] Runtime error:\n"
        .. tostring(Result)
    )

end

Library =
    Result

if type(Library) ~= "table" then

    error(
        "[LONG V10] Library did not return a table."
    )

end

--==============================================================
-- FINAL SETTINGS
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

    if Library.Theme then

        Library.Theme.Transparency =
            0.57

    end

end)

--==============================================================
-- EXTRA LIBRARY API
--==============================================================

pcall(function()

    if not Library.SetAnimationSpeed then

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

    end

    if not Library.GetAnimationSpeed then

        function Library:GetAnimationSpeed()

            return math.floor(
                self.Settings.AnimationSpeed
                * 100
                + 0.5
            )

        end

    end

end)

--==============================================================
-- RETURN
--==============================================================

return Library
