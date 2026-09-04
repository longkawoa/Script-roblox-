--[[
================================================================
                 LONG UI LIBRARY V13.0
                 POSITION + CONFIRMATION FIX
================================================================

UPDATE
----------------------------------------------------------------
✓ Source: bynhatlong-v12-Library.lua
✓ Hide / Show Menu
✓ Không thu menu thành 58px
✓ Restore đúng kích thước 507x384
✓ Restore không lấy vị trí của GUI thu nhỏ
✓ Center khi restore nếu cần
✓ Original Position
✓ Saved Position
✓ Position tự clamp theo màn hình
✓ Tự xử lý đổi kích thước / xoay màn hình
✓ PC + Mobile
✓ Drag
✓ Close confirmation OPAQUE
✓ Confirmation không bị Transparency của Menu ảnh hưởng
✓ ESC đóng confirmation
✓ Click Không đóng confirmation
✓ Không Floating Button
✓ Animation Speed = 100
✓ Menu Width = 507
✓ Menu Height = 384
✓ Transparency = 57
✓ Position API
✓ Visibility API
✓ Animation API
✓ Center API
✓ Restore API
✓ Hide / Show API
================================================================
]]

--==============================================================
-- SOURCE
--==============================================================

local SOURCE_URL =
    "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/bynhatlong-v12-Library.lua"

--==============================================================
-- SERVICES
--==============================================================

local Players =
    game:GetService("Players")

local StarterGui =
    game:GetService("StarterGui")

local UserInputService =
    game:GetService("UserInputService")

local LocalPlayer =
    Players.LocalPlayer

--==============================================================
-- SAFE HTTP
--==============================================================

local function HttpGet(url)

    local Success, Result =
        pcall(function()

            return game:HttpGet(url)

        end)

    if not Success then

        error(
            "[LONG V13] HttpGet failed:\n"
            .. tostring(Result)
        )

    end

    if type(Result) ~= "string" then

        error(
            "[LONG V13] Invalid source."
        )

    end

    if #Result < 1000 then

        error(
            "[LONG V13] Source too small."
        )

    end

    return Result

end

--==============================================================
-- REPLACE ONCE
--==============================================================

local function ReplaceOnce(
    Source,
    Old,
    New
)

    local StartPos, EndPos =
        string.find(
            Source,
            Old,
            1,
            true
        )

    if not StartPos then

        return Source, false

    end

    return
        string.sub(
            Source,
            1,
            StartPos - 1
        )
        .. New
        .. string.sub(
            Source,
            EndPos + 1
        ),
        true

end

--==============================================================
-- LOAD V12
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
--
-- QUAN TRỌNG:
-- Confirmation KHÔNG sử dụng Transparency của Menu.
--==============================================================

local ConfirmationCode = [[

    --==========================================================
    -- LONG V13 CLOSE CONFIRMATION
    --==========================================================

    local CloseConfirmation = nil
    local CloseOverlay = nil
    local CloseBusy = false

    --==========================================================
    -- REMOVE
    --==========================================================

    local function RemoveCloseConfirmation()

        if CloseOverlay then

            pcall(function()

                CloseOverlay:Destroy()

            end)

            CloseOverlay = nil

        end

        if CloseConfirmation then

            pcall(function()

                CloseConfirmation:Destroy()

            end)

            CloseConfirmation = nil

        end

    end

    --==========================================================
    -- NOTIFICATION
    --==========================================================

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

    --==========================================================
    -- DESTROY
    --==========================================================

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

    --==========================================================
    -- CREATE CONFIRMATION
    --==========================================================

    local function CreateCloseConfirmation()

        if CloseBusy then

            return

        end

        if CloseConfirmation
            and CloseConfirmation.Parent
        then

            return

        end

        --======================================================
        -- FULL SCREEN OVERLAY
        --======================================================

        CloseOverlay =
            Instance.new("TextButton")

        CloseOverlay.Name =
            "LONG_CloseOverlay"

        CloseOverlay.AnchorPoint =
            Vector2.new(
                0,
                0
            )

        CloseOverlay.Position =
            UDim2.fromScale(
                0,
                0
            )

        CloseOverlay.Size =
            UDim2.fromScale(
                1,
                1
            )

        CloseOverlay.BackgroundColor3 =
            Color3.new(
                0,
                0,
                0
            )

        CloseOverlay.BackgroundTransparency =
            0.45

        CloseOverlay.BorderSizePixel =
            0

        CloseOverlay.Text =
            ""

        CloseOverlay.AutoButtonColor =
            false

        CloseOverlay.ZIndex =
            999

        CloseOverlay.Parent =
            ScreenGui

        CloseOverlay.MouseButton1Click:Connect(
            function()

                RemoveCloseConfirmation()

            end
        )

        --======================================================
        -- CONFIRMATION FRAME
        --
        -- KHÔNG DÙNG Library.Theme.Transparency
        --======================================================

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
                330,
                175
            )

        CloseConfirmation.BackgroundColor3 =
            Library.Theme.Secondary

        --======================================================
        -- FIX QUAN TRỌNG
        -- Confirmation LUÔN OPAQUE
        --======================================================

        CloseConfirmation.BackgroundTransparency =
            0

        CloseConfirmation.BorderSizePixel =
            0

        CloseConfirmation.ZIndex =
            1000

        CloseConfirmation.Parent =
            ScreenGui

        --======================================================
        -- CORNER
        --======================================================

        local Corner =
            Instance.new("UICorner")

        Corner.CornerRadius =
            UDim.new(
                0,
                12
            )

        Corner.Parent =
            CloseConfirmation

        --======================================================
        -- STROKE
        --======================================================

        local Stroke =
            Instance.new("UIStroke")

        Stroke.Color =
            Library.Theme.Border

        Stroke.Thickness =
            1

        Stroke.Transparency =
            0

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
                18,
                14
            )

        Title.Size =
            UDim2.new(
                1,
                -36,
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
                18,
                48
            )

        Message.Size =
            UDim2.new(
                1,
                -36,
                0,
                48
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
            UDim2.fromOffset(
                18,
                125
            )

        NoButton.Size =
            UDim2.new(
                0.5,
                -27,
                0,
                36
            )

        NoButton.BackgroundColor3 =
            Library.Theme.Tertiary

        -- KHÔNG TRONG
        NoButton.BackgroundTransparency =
            0

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
                -18,
                0,
                125
            )

        YesButton.Size =
            UDim2.new(
                0.5,
                -27,
                0,
                36
            )

        YesButton.BackgroundColor3 =
            Library.Theme.Danger

        -- KHÔNG TRONG
        YesButton.BackgroundTransparency =
            0

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

        --======================================================
        -- ESC KEY
        --======================================================

        local EscapeConnection

        EscapeConnection =
            UserInputService.InputBegan:Connect(
                function(
                    Input,
                    GameProcessed
                )

                    if GameProcessed then

                        return

                    end

                    if not CloseConfirmation
                        or not CloseConfirmation.Parent
                    then

                        if EscapeConnection then

                            EscapeConnection:Disconnect()

                        end

                        return

                    end

                    if Input.KeyCode ==
                        Enum.KeyCode.Escape
                    then

                        RemoveCloseConfirmation()

                        if EscapeConnection then

                            EscapeConnection:Disconnect()

                        end

                    end

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

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            ConfirmationCode
            .. "\n"
            .. Marker
        )

    if Patched then

        Source =
            NewSource

    end

end

--==============================================================
-- CLOSE BUTTON
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
-- REMOVE FLOATING BUTTON TOGGLE
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
    -- External toggle can use WindowObject:ToggleInstant().]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- POSITION SYSTEM
--==============================================================

local PositionCode = [[

    --==========================================================
    -- LONG V13 POSITION SYSTEM
    --==========================================================

    local SavedCenterX = nil
    local SavedCenterY = nil

    local OriginalCenterX = nil
    local OriginalCenterY = nil

    local PositionInitialized = false
    local ApplyingSavedPosition = false

    --==========================================================
    -- VIEWPORT
    --==========================================================

    local function GetViewport()

        local Camera =
            workspace.CurrentCamera

        if not Camera then

            return nil

        end

        return Camera.ViewportSize

    end

    --==========================================================
    -- READ CENTER
    --==========================================================

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

        local X =
            AbsolutePosition.X
            + AbsoluteSize.X / 2

        local Y =
            AbsolutePosition.Y
            + AbsoluteSize.Y / 2

        return X, Y

    end

    --==========================================================
    -- SAVE CURRENT
    --==========================================================

    local function SaveCurrentCenter()

        if ApplyingSavedPosition then

            return

        end

        local X, Y =
            ReadCurrentCenter()

        if X and Y then

            SavedCenterX =
                X

            SavedCenterY =
                Y

            if not PositionInitialized then

                OriginalCenterX =
                    X

                OriginalCenterY =
                    Y

            end

            PositionInitialized =
                true

        end

    end

    --==========================================================
    -- GET FULL MENU SIZE
    --==========================================================

    local function GetFullMenuSize()

        local Width =
            tonumber(
                Library.Settings.MenuWidth
            )
            or 507

        local Height =
            tonumber(
                Library.Settings.MenuHeight
            )
            or 384

        return Width, Height

    end

    --==========================================================
    -- APPLY CENTER
    --==========================================================

    local function ApplyCenter(
        X,
        Y
    )

        if not Main
            or not Main.Parent
        then

            return

        end

        local Viewport =
            GetViewport()

        if not Viewport then

            return

        end

        local Width,
            Height =
            GetFullMenuSize()

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

            X =
                Viewport.X / 2

        else

            X =
                math.clamp(
                    X,
                    MinX,
                    MaxX
                )

        end

        if MaxY < MinY then

            Y =
                Viewport.Y / 2

        else

            Y =
                math.clamp(
                    Y,
                    MinY,
                    MaxY
                )

        end

        SavedCenterX =
            X

        SavedCenterY =
            Y

        ApplyingSavedPosition =
            true

        Main.AnchorPoint =
            Vector2.new(
                0.5,
                0.5
            )

        Main.Position =
            UDim2.fromOffset(
                X,
                Y
            )

        ApplyingSavedPosition =
            false

    end

    --==========================================================
    -- APPLY SAVED POSITION
    --==========================================================

    local function ApplySavedCenter()

        if not SavedCenterX
            or not SavedCenterY
        then

            SaveCurrentCenter()

        end

        if not SavedCenterX
            or not SavedCenterY
        then

            return

        end

        ApplyCenter(
            SavedCenterX,
            SavedCenterY
        )

    end

    --==========================================================
    -- CENTER SCREEN
    --==========================================================

    local function CenterScreen()

        local Viewport =
            GetViewport()

        if not Viewport then

            return false

        end

        ApplyCenter(
            Viewport.X / 2,
            Viewport.Y / 2
        )

        return true

    end

    --==========================================================
    -- RESTORE ORIGINAL
    --==========================================================

    local function RestoreOriginalCenter()

        if OriginalCenterX
            and OriginalCenterY
        then

            ApplyCenter(
                OriginalCenterX,
                OriginalCenterY
            )

            return true

        end

        return CenterScreen()

    end

    --==========================================================
    -- TRACK DRAG
    --==========================================================

    Main:GetPropertyChangedSignal(
        "Position"
    ):Connect(
        function()

            if ApplyingSavedPosition then

                return

            end

            task.defer(
                function()

                    if Main
                        and Main.Parent
                        and not ApplyingSavedPosition
                    then

                        SaveCurrentCenter()

                    end

                end
            )

        end
    )

    --==========================================================
    -- VIEWPORT CHANGED
    --==========================================================

    local LastViewportX = nil
    local LastViewportY = nil

    task.spawn(
        function()

            while Main
                and Main.Parent
            do

                task.wait(0.25)

                local Viewport =
                    GetViewport()

                if Viewport then

                    if LastViewportX
                        and LastViewportY
                    then

                        if Viewport.X ~= LastViewportX
                            or Viewport.Y ~= LastViewportY
                        then

                            if Main.Visible then

                                ApplySavedCenter()

                            end

                        end

                    end

                    LastViewportX =
                        Viewport.X

                    LastViewportY =
                        Viewport.Y

                end

            end

        end
    )

    --==========================================================
    -- POSITION API
    --==========================================================

    function WindowObject:SavePosition()

        SaveCurrentCenter()

        return {

            X =
                SavedCenterX,

            Y =
                SavedCenterY

        }

    end

    function WindowObject:GetPosition()

        SaveCurrentCenter()

        return {

            X =
                SavedCenterX,

            Y =
                SavedCenterY

        }

    end

    function WindowObject:GetOriginalPosition()

        return {

            X =
                OriginalCenterX,

            Y =
                OriginalCenterY

        }

    end

    function WindowObject:SetPosition(
        X,
        Y
    )

        X =
            tonumber(X)

        Y =
            tonumber(Y)

        if not X
            or not Y
        then

            return false

        end

        SavedCenterX =
            X

        SavedCenterY =
            Y

        PositionInitialized =
            true

        ApplySavedCenter()

        return true

    end

    function WindowObject:Center()

        return CenterScreen()

    end

    function WindowObject:ResetPosition()

        return RestoreOriginalCenter()

    end

    function WindowObject:ClampPosition()

        ApplySavedCenter()

        return true

    end

    --==========================================================
    -- INITIAL
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
-- INSERT POSITION
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- NOTIFICATION\n"
        .. "    --=========================================================="

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            PositionCode
            .. "\n"
            .. Marker
        )

    if Patched then

        Source =
            NewSource

    end

end

--==============================================================
-- HIDE / SHOW
--
-- SHOW:
-- 1. Kích thước menu được giữ full 507x384.
-- 2. Không dùng vị trí của GUI thu nhỏ.
-- 3. Restore lại vị trí gốc/saved.
-- 4. Nếu vị trí cũ không hợp lệ -> tự clamp.
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

            if Main.Visible then

                --================================================
                -- HIDE
                --================================================

                SaveCurrentCenter()

                Main.Visible =
                    false

                Minimize.Text =
                    "Mở"

            else

                --================================================
                -- SHOW
                --================================================

                Main.Size =
                    UDim2.fromOffset(
                        Library.Settings.MenuWidth,
                        Library.Settings.MenuHeight
                    )

                Sidebar.Visible =
                    true

                Content.Visible =
                    true

                Main.Visible =
                    true

                Minimize.Text =
                    "Ẩn"

                --================================================
                -- ĐỢI ABSOLUTE SIZE CẬP NHẬT
                --================================================

                task.defer(
                    function()

                        task.wait()

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

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Old,
            New
        )

    if Patched then

        Source =
            NewSource

    end

end

--==============================================================
-- VISIBILITY API
--==============================================================

local VisibilityAPI = [[

    --==========================================================
    -- LONG V13 VISIBILITY API
    --==========================================================

    function WindowObject:HideInstant()

        if not Main
            or not Main.Parent
        then

            return false

        end

        SaveCurrentCenter()

        Main.Visible =
            false

        if Minimize then

            Minimize.Text =
                "Mở"

        end

        if FloatingButton then

            FloatingButton.Visible =
                false

        end

        return true

    end

    function WindowObject:ShowInstant()

        if not Main
            or not Main.Parent
        then

            return false

        end

        --======================================================
        -- LUÔN FULL SIZE
        --======================================================

        Main.Size =
            UDim2.fromOffset(
                Library.Settings.MenuWidth,
                Library.Settings.MenuHeight
            )

        Sidebar.Visible =
            true

        Content.Visible =
            true

        Main.Visible =
            true

        if Minimize then

            Minimize.Text =
                "Ẩn"

        end

        if FloatingButton then

            FloatingButton.Visible =
                false

        end

        --======================================================
        -- APPLY POSITION SAU KHI SIZE CẬP NHẬT
        --======================================================

        task.defer(
            function()

                task.wait()

                if Main
                    and Main.Parent
                then

                    ApplySavedCenter()

                end

            end
        )

        return true

    end

    function WindowObject:ToggleInstant()

        if not Main
            or not Main.Parent
        then

            return false

        end

        if Main.Visible then

            return self:HideInstant()

        else

            return self:ShowInstant()

        end

    end

    function WindowObject:IsVisible()

        if not Main
            or not Main.Parent
        then

            return false

        end

        return Main.Visible == true

    end

    function WindowObject:IsHidden()

        return not self:IsVisible()

    end

    function WindowObject:SetVisibility(
        Value,
        Instant
    )

        Value =
            Value == true

        if Instant == false then

            if Value then

                return self:Show()

            else

                return self:Hide()

            end

        end

        if Value then

            return self:ShowInstant()

        else

            return self:HideInstant()

        end

    end

    function WindowObject:HideMenu()

        return self:HideInstant()

    end

    function WindowObject:ShowMenu()

        return self:ShowInstant()

    end

    function WindowObject:ToggleMenu()

        return self:ToggleInstant()

    end

    function WindowObject:Restore()

        return self:ShowInstant()

    end

]]

--==============================================================
-- INSERT VISIBILITY API
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- WINDOW API\n"
        .. "    --=========================================================="

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            VisibilityAPI
            .. "\n"
            .. Marker
        )

    if Patched then

        Source =
            NewSource

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

        Main.Size =
            UDim2.fromOffset(
                Library.Settings.MenuWidth,
                Library.Settings.MenuHeight
            )

        Sidebar.Visible =
            true

        Content.Visible =
            true

        Main.Visible =
            true

        if Minimize then

            Minimize.Text =
                "Ẩn"

        end

        FloatingButton.Visible =
            false

        task.defer(
            function()

                task.wait()

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

        if Minimize then

            Minimize.Text =
                "Mở"

        end

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
-- ANIMATION API
--==============================================================

local AnimationAPI = [[

    --==========================================================
    -- LONG V13 ANIMATION API
    --==========================================================

    function WindowObject:SetAnimationSpeed(
        Value
    )

        Value =
            tonumber(Value)

        if not Value then

            return false

        end

        Value =
            math.clamp(
                Value,
                0,
                100
            )

        Library.Settings.AnimationSpeed =
            Value / 100

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

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            AnimationAPI
            .. "\n"
            .. Marker
        )

    if Patched then

        Source =
            NewSource

    end

end

--==============================================================
-- ANIMATION SLIDER = 100
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
-- EXTRA API
--==============================================================

local ExtraAPI = [[

    --==========================================================
    -- LONG V13 EXTRA API
    --==========================================================

    function WindowObject:IsMinimized()

        return false

    end

    function WindowObject:CenterMenu()

        return self:Center()

    end

    function WindowObject:ResetMenuPosition()

        return self:ResetPosition()

    end

    function WindowObject:SaveMenuPosition()

        return self:SavePosition()

    end

    function WindowObject:GetMenuPosition()

        return self:GetPosition()

    end

]]

--==============================================================
-- INSERT EXTRA API
--==============================================================

do

    local Marker =
        "    --==========================================================\n"
        .. "    -- WINDOW API\n"
        .. "    --=========================================================="

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            ExtraAPI
            .. "\n"
            .. Marker
        )

    if Patched then

        Source =
            NewSource

    end

end

--==============================================================
-- FINAL SETTINGS
--==============================================================

local FinalCode = [[

--==============================================================
-- LONG V13 FINAL SETTINGS
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

--==============================================================
-- THEME TRANSPARENCY
--==============================================================

if Library.Theme then

    Library.Theme.Transparency =
        0.57

end

--==============================================================
-- FORCE FLOATING BUTTON OFF
--==============================================================

for _, Window in ipairs(
    Library.Windows
) do

    pcall(function()

        if Window.FloatingButton then

            Window.FloatingButton.Visible =
                false

        end

    end)

end

]]

--==============================================================
-- INSERT FINAL SETTINGS
--==============================================================

do

    local Marker =
        "\nreturn Library"

    local NewSource, Patched =
        ReplaceOnce(
            Source,
            Marker,
            "\n"
            .. FinalCode
            .. Marker
        )

    if Patched then

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
        "[LONG V13] Compile error:\n"
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
        "[LONG V13] Runtime error:\n"
        .. tostring(Result)
    )

end

local Library =
    Result

if type(Library) ~= "table" then

    error(
        "[LONG V13] Library did not return table."
    )

end

--==============================================================
-- FINAL LIBRARY API
--==============================================================

pcall(function()

    function Library:SetAnimationSpeed(
        Value
    )

        Value =
            tonumber(Value)

        if not Value then

            return false

        end

        Value =
            math.clamp(
                Value,
                0,
                100
            )

        self.Settings.AnimationSpeed =
            Value / 100

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
