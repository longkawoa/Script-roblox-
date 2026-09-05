--[[
================================================================
                 LONG UI LIBRARY V12.0
                 100 TAB ICON + OPTIONAL GETKEY
================================================================

UPDATE V12.0
----------------------------------------------------------------
✓ Library Menu vẫn là giao diện chính
✓ Không xoá giao diện mặc định
✓ 100 Tab Icons
✓ Auto Icon theo tên Tab
✓ CreateTab("Combat") -> tự icon
✓ CreateTab("Combat", "🔥") -> custom icon
✓ Tab:SetIcon()
✓ Library:GetTabIcon()
✓ Library:SetTabIcon()
✓ Creator Interface Config
✓ CreateWindow Interface Options
✓ Window:SetInterface()
✓ Title / Subtitle API
✓ Theme API
✓ Accent API
✓ Transparency API
✓ Menu Size API
✓ Sidebar API
✓ UI Scale API
✓ Optional GetKey Menu
✓ Static Key
✓ Custom Key Validator
✓ OpenKeyMenu()
✓ CloseKeyMenu()
✓ DestroyKeyMenu()
✓ SetKey()
✓ IsKeyUnlocked()
✓ Hide / Show
✓ Position API
✓ Animation API
✓ Close Confirmation
✓ Floating Button OFF
✓ PC + Mobile
✓ Drag
✓ Search
✓ Notification
✓ Slider
✓ Dropdown
✓ Multi Dropdown
✓ Textbox
✓ Keybind
✓ Reset
✓ Settings Tab luôn được giữ
✓ Menu mặc định 507x384
✓ Transparency 57
✓ Animation 100

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
            "[LONG V12.0] HttpGet failed:\n"
            .. tostring(result)
        )

    end

    if type(result) ~= "string" then

        error(
            "[LONG V12.0] Invalid source."
        )

    end

    if #result < 1000 then

        error(
            "[LONG V12.0] Source too small."
        )

    end

    return result

end

--==============================================================
-- REPLACE ONCE
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
-- LOAD SOURCE
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
    -- LONG V12 CLOSE CONFIRMATION
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
            0

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
-- INSERT CLOSE SYSTEM
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
        [[    -- Floating Button disabled by LONG V12.
    -- Creator may create their own button. ]]

    Source =
        ReplaceOnce(
            Source,
            Old,
            New
        )

end

--==============================================================
-- HIDE / SHOW
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

            SaveCurrentCenter()

            if Main.Visible then

                Main.Visible =
                    false

                Minimize.Text =
                    "Mở"

            else

                Main.Visible =
                    true

                Minimize.Text =
                    "Ẩn"

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
    -- LONG V12 POSITION SYSTEM
    --==========================================================

    local SavedCenterX = nil
    local SavedCenterY = nil

    local PositionInitialized = false

    local ApplyingSavedPosition = false

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

        return
            AbsolutePosition.X
                + AbsoluteSize.X / 2,

            AbsolutePosition.Y
                + AbsoluteSize.Y / 2

    end

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

        ApplyingSavedPosition =
            true

        Main.Position =
            UDim2.fromOffset(
                SavedCenterX,
                SavedCenterY
            )

        ApplyingSavedPosition =
            false

    end

    local function ClampSavedCenter()

        ApplySavedCenter()

    end

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

        if not x or not y then
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

    function WindowObject:Center()

        return self:ResetPosition()

    end

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
-- VISIBILITY API
--==============================================================

local VisibilityAPI = [[

    --==========================================================
    -- LONG V12 VISIBILITY API
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

        task.defer(
            function()

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

        end

        return self:ShowInstant()

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

    function WindowObject:SetVisibility(
        value,
        instant
    )

        value =
            value == true

        if instant == false then

            if value then
                return self:Show()
            end

            return self:Hide()

        end

        if value then

            return self:ShowInstant()

        end

        return self:HideInstant()

    end

]]

--==============================================================
-- INSERT VISIBILITY
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
            VisibilityAPI
            .. "\n"
            .. Marker
        )

    if patched then

        Source =
            NewSource

    end

end

--==============================================================
-- ANIMATION API
--==============================================================

local AnimationAPI = [[

    --==========================================================
    -- LONG V12 ANIMATION API
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
-- FINAL SETTINGS
--==============================================================

local FinalCode = [[

--==============================================================
-- LONG V12 FINAL DEFAULTS
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

]]

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
        "[LONG V12.0] Compile error:\n"
        .. tostring(ErrorMessage)
    )

end

--==============================================================
-- EXECUTE ORIGINAL LIBRARY
--==============================================================

local Success,
    Result =
    pcall(function()

        return Chunk()

    end)

if not Success then

    error(
        "[LONG V12.0] Runtime error:\n"
        .. tostring(Result)
    )

end

local Library =
    Result

if type(Library) ~= "table" then

    error(
        "[LONG V12.0] Library did not return table."
    )

end

--==============================================================
-- 100 TAB ICONS
--==============================================================

Library.TabIcons = {

    -- 1
    Main = "🏠",

    -- 2
    Home = "🏠",

    -- 3
    Player = "👤",

    -- 4
    Players = "👥",

    -- 5
    Combat = "⚔️",

    -- 6
    Visual = "👁️",

    -- 7
    ESP = "👁️",

    -- 8
    Farm = "🌾",

    -- 9
    Farming = "🌾",

    -- 10
    AutoFarm = "🤖",

    -- 11
    Auto = "⚡",

    -- 12
    Misc = "⚙️",

    -- 13
    Settings = "⚙️",

    -- 14
    Setting = "⚙️",

    -- 15
    Config = "🛠️",

    -- 16
    Configuration = "🛠️",

    -- 17
    Teleport = "📍",

    -- 18
    Teleports = "📍",

    -- 19
    World = "🌎",

    -- 20
    Map = "🗺️",

    -- 21
    Server = "🌐",

    -- 22
    Servers = "🌐",

    -- 23
    Info = "ⓘ",

    -- 24
    About = "ⓘ",

    -- 25
    Script = "📜",

    -- 26
    Scripts = "📜",

    -- 27
    Shop = "🛒",

    -- 28
    Store = "🏪",

    -- 29
    Backpack = "🎒",

    -- 30
    Inventory = "🎒",

    -- 31
    Items = "📦",

    -- 32
    Item = "📦",

    -- 33
    Weapon = "🔫",

    -- 34
    Weapons = "🔫",

    -- 35
    Melee = "🗡️",

    -- 36
    Gun = "🔫",

    -- 37
    Guns = "🔫",

    -- 38
    Magic = "✨",

    -- 39
    Skills = "💫",

    -- 40
    Skill = "💫",

    -- 41
    Quest = "📜",

    -- 42
    Quests = "📜",

    -- 43
    Mission = "🎯",

    -- 44
    Missions = "🎯",

    -- 45
    Objective = "🎯",

    -- 46
    Objectives = "🎯",

    -- 47
    Event = "🎉",

    -- 48
    Events = "🎉",

    -- 49
    Character = "🧍",

    -- 50
    Characters = "🧍",

    -- 51
    Pet = "🐾",

    -- 52
    Pets = "🐾",

    -- 53
    Mount = "🐎",

    -- 54
    Mounts = "🐎",

    -- 55
    Vehicle = "🚗",

    -- 56
    Vehicles = "🚗",

    -- 57
    Travel = "✈️",

    -- 58
    Movement = "🏃",

    -- 59
    Movement2 = "🏃",

    -- 60
    Speed = "💨",

    -- 61
    Fly = "🪽",

    -- 62
    Flight = "🪽",

    -- 63
    Jump = "⬆️",

    -- 64
    Walk = "🚶",

    -- 65
    Run = "🏃",

    -- 66
    AntiAFK = "🛡️",

    -- 67
    Protection = "🛡️",

    -- 68
    Security = "🔐",

    -- 69
    Utility = "🔧",

    -- 70
    Utilities = "🔧",

    -- 71
    Tools = "🔨",

    -- 72
    Tool = "🔨",

    -- 73
    Debug = "🐞",

    -- 74
    Developer = "💻",

    -- 75
    Development = "💻",

    -- 76
    Code = "💻",

    -- 77
    Console = "⌨️",

    -- 78
    Log = "📋",

    -- 79
    Logs = "📋",

    -- 80
    Network = "📡",

    -- 81
    Performance = "📊",

    -- 82
    Stats = "📈",

    -- 83
    Statistics = "📊",

    -- 84
    Graph = "📈",

    -- 85
    Audio = "🔊",

    -- 86
    Sound = "🔊",

    -- 87
    Music = "🎵",

    -- 88
    Graphics = "🎨",

    -- 89
    Visuals = "🎨",

    -- 90
    Effects = "✨",

    -- 91
    Color = "🌈",

    -- 92
    Theme = "🎨",

    -- 93
    Language = "🌐",

    -- 94
    Languages = "🌐",

    -- 95
    Key = "🔑",

    -- 96
    Keys = "🔑",

    -- 97
    GetKey = "🔑",

    -- 98
    License = "🎫",

    -- 99
    Premium = "💎",

    -- 100
    VIP = "👑"
}

--==============================================================
-- TAB ICON NORMALIZER
--==============================================================

local OldGetTabIcon =
    Library.GetTabIcon

function Library:GetTabIcon(name)

    name =
        tostring(name or "")

    if self.TabIcons[name] then

        return self.TabIcons[name]

    end

    local clean =
        name:gsub(
            "%s+",
            ""
        )

    if self.TabIcons[clean] then

        return self.TabIcons[clean]

    end

    local lower =
        string.lower(
            clean
        )

    for key, icon in pairs(
        self.TabIcons
    ) do

        if string.lower(
            tostring(key)
        ) == lower then

            return icon

        end

    end

    if OldGetTabIcon then

        local success,
            icon =
            pcall(
                OldGetTabIcon,
                self,
                name
            )

        if success
            and icon
        then

            return icon

        end

    end

    return "●"

end

--==============================================================
-- SET TAB ICON
--==============================================================

function Library:SetTabIcon(
    name,
    icon
)

    name =
        tostring(name or "")

    icon =
        tostring(icon or "●")

    if name == "" then
        return false
    end

    self.TabIcons[name] =
        icon

    for _, window in ipairs(
        self.Windows or {}
    ) do

        for _, tab in ipairs(
            window.Tabs or {}
        ) do

            if tab.Name == name
                and tab.Icon
            then

                pcall(function()

                    tab:SetIcon(
                        icon
                    )

                end)

            end

        end

    end

    return true

end

--==============================================================
-- WINDOW INTERFACE CONFIG
--==============================================================

local OldCreateWindow =
    Library.CreateWindow

Library.CreateWindow =
    function(
        self,
        options
    )

        options =
            options or {}

        --======================================================
        -- CREATE ORIGINAL LIBRARY WINDOW
        --======================================================

        local window =
            OldCreateWindow(
                self,
                options
            )

        if not window then
            return window
        end

        --======================================================
        -- BASIC REFERENCES
        --======================================================

        window.Interface =
            options.Interface
            or {}

        --======================================================
        -- TITLE
        --======================================================

        if options.Title
            and window.TitleLabel
        then

            window.Title =
                tostring(
                    options.Title
                )

            window.TitleLabel.Text =
                window.Title

        end

        --======================================================
        -- SUBTITLE
        --======================================================

        if options.Subtitle
            and window.SubtitleLabel
        then

            window.Subtitle =
                tostring(
                    options.Subtitle
                )

            window.SubtitleLabel.Text =
                window.Subtitle

        end

        --======================================================
        -- SIZE
        --======================================================

        if options.Width
            or options.MenuWidth
        then

            self.Settings.MenuWidth =
                math.clamp(
                    tonumber(
                        options.Width
                        or options.MenuWidth
                    )
                    or 507,
                    300,
                    1200
                )

        end

        if options.Height
            or options.MenuHeight
        then

            self.Settings.MenuHeight =
                math.clamp(
                    tonumber(
                        options.Height
                        or options.MenuHeight
                    )
                    or 384,
                    220,
                    900
                )

        end

        --======================================================
        -- SIDEBAR
        --======================================================

        if options.SidebarWidth then

            self.Settings.SidebarWidth =
                math.clamp(
                    tonumber(
                        options.SidebarWidth
                    )
                    or 145,
                    90,
                    300
                )

        end

        --======================================================
        -- TRANSPARENCY
        --======================================================

        if options.Transparency ~= nil then

            self:SetTransparency(
                tonumber(
                    options.Transparency
                )
                or 57
            )

        end

        --======================================================
        -- UI SCALE
        --======================================================

        if options.UIScale then

            self.Settings.UIScale =
                math.clamp(
                    tonumber(
                        options.UIScale
                    )
                    or 100,
                    60,
                    150
                )

        end

        --======================================================
        -- CORNER
        --======================================================

        if options.CornerRadius then

            self.Settings.CornerRadius =
                math.clamp(
                    tonumber(
                        options.CornerRadius
                    )
                    or 10,
                    0,
                    30
                )

        end

        --======================================================
        -- DRAG
        --======================================================

        if options.Dragging ~= nil then

            self.Settings.Dragging =
                options.Dragging == true

        end

        --======================================================
        -- SEARCH
        --======================================================

        if options.TabSearch ~= nil then

            self.Settings.TabSearch =
                options.TabSearch == true

        end

        --======================================================
        -- NOTIFICATIONS
        --======================================================

        if options.Notifications ~= nil then

            self.Settings.Notifications =
                options.Notifications == true

        end

        --======================================================
        -- THEME
        --======================================================

        if options.Theme then

            self:SetTheme(
                tostring(
                    options.Theme
                )
            )

        end

        --======================================================
        -- ACCENT
        --======================================================

        if options.Accent then

            self:SetAccent(
                tostring(
                    options.Accent
                )
            )

        end

        --======================================================
        -- CUSTOM COLORS
        --======================================================

        if type(
            options.Colors
        ) == "table"
        then

            for colorName,
                colorValue
                in pairs(
                    options.Colors
                )
            do

                if typeof(
                    colorValue
                ) == "Color3"
                then

                    self.Theme[colorName] =
                        colorValue

                elseif type(
                    colorValue
                ) == "table"
                then

                    self.Theme[colorName] =
                        Color3.fromRGB(
                            tonumber(
                                colorValue[1]
                            )
                            or 0,

                            tonumber(
                                colorValue[2]
                            )
                            or 0,

                            tonumber(
                                colorValue[3]
                            )
                            or 0
                        )

                end

            end

        end

        --======================================================
        -- REFRESH
        --======================================================

        pcall(function()

            window:Refresh()

        end)

        return window

    end

--==============================================================
-- WINDOW SET INTERFACE
--==============================================================

function Library:SetInterface(
    window,
    options
)

    if not window
        or type(options) ~= "table"
    then

        return false

    end

    --==========================================================
    -- TITLE
    --==========================================================

    if options.Title
        and window.TitleLabel
    then

        window.Title =
            tostring(
                options.Title
            )

        window.TitleLabel.Text =
            window.Title

    end

    --==========================================================
    -- SUBTITLE
    --==========================================================

    if options.Subtitle
        and window.SubtitleLabel
    then

        window.Subtitle =
            tostring(
                options.Subtitle
            )

        window.SubtitleLabel.Text =
            window.Subtitle

    end

    --==========================================================
    -- WIDTH
    --==========================================================

    if options.Width
        or options.MenuWidth
    then

        self.Settings.MenuWidth =
            math.clamp(
                tonumber(
                    options.Width
                    or options.MenuWidth
                )
                or 507,
                300,
                1200
            )

    end

    --==========================================================
    -- HEIGHT
    --==========================================================

    if options.Height
        or options.MenuHeight
    then

        self.Settings.MenuHeight =
            math.clamp(
                tonumber(
                    options.Height
                    or options.MenuHeight
                )
                or 384,
                220,
                900
            )

    end

    --==========================================================
    -- SIDEBAR
    --==========================================================

    if options.SidebarWidth then

        self.Settings.SidebarWidth =
            math.clamp(
                tonumber(
                    options.SidebarWidth
                )
                or 145,
                90,
                300
            )

    end

    --==========================================================
    -- TRANSPARENCY
    --==========================================================

    if options.Transparency ~= nil then

        self:SetTransparency(
            options.Transparency
        )

    end

    --==========================================================
    -- UI SCALE
    --==========================================================

    if options.UIScale then

        self.Settings.UIScale =
            math.clamp(
                tonumber(
                    options.UIScale
                )
                or 100,
                60,
                150
            )

    end

    --==========================================================
    -- CORNER
    --==========================================================

    if options.CornerRadius then

        self.Settings.CornerRadius =
            math.clamp(
                tonumber(
                    options.CornerRadius
                )
                or 10,
                0,
                30
            )

    end

    --==========================================================
    -- DRAGGING
    --==========================================================

    if options.Dragging ~= nil then

        self.Settings.Dragging =
            options.Dragging == true

    end

    --==========================================================
    -- SEARCH
    --==========================================================

    if options.TabSearch ~= nil then

        self.Settings.TabSearch =
            options.TabSearch == true

    end

    --==========================================================
    -- NOTIFICATIONS
    --==========================================================

    if options.Notifications ~= nil then

        self.Settings.Notifications =
            options.Notifications == true

    end

    --==========================================================
    -- THEME
    --==========================================================

    if options.Theme then

        self:SetTheme(
            tostring(
                options.Theme
            )
        )

    end

    --==========================================================
    -- ACCENT
    --==========================================================

    if options.Accent then

        self:SetAccent(
            tostring(
                options.Accent
            )
        )

    end

    --==========================================================
    -- CUSTOM COLORS
    --==========================================================

    if type(
        options.Colors
    ) == "table"
    then

        for colorName,
            colorValue
            in pairs(
                options.Colors
            )
        do

            if typeof(
                colorValue
            ) == "Color3"
            then

                self.Theme[colorName] =
                    colorValue

            elseif type(
                colorValue
            ) == "table"
            then

                self.Theme[colorName] =
                    Color3.fromRGB(
                        tonumber(
                            colorValue[1]
                        )
                        or 0,

                        tonumber(
                            colorValue[2]
                        )
                        or 0,

                        tonumber(
                            colorValue[3]
                        )
                        or 0
                    )

            end

        end

    end

    pcall(function()

        window:Refresh()

    end)

    return true

end

--==============================================================
-- OPTIONAL GETKEY SYSTEM
--==============================================================

Library.KeySystem = {
    Enabled = false,
    Unlocked = false,
    Key = nil,
    Validator = nil,
    Gui = nil,
    Input = nil,
    Status = nil
}

--==============================================================
-- KEY MENU DESTROY
--==============================================================

function Library:DestroyKeyMenu()

    if self.KeySystem.Gui then

        pcall(function()

            self.KeySystem.Gui:Destroy()

        end)

    end

    self.KeySystem.Gui =
        nil

    self.KeySystem.Input =
        nil

    self.KeySystem.Status =
        nil

end

--==============================================================
-- KEY VALIDATION
--==============================================================

function Library:ValidateKey(
    key
)

    key =
        tostring(
            key or ""
        )

    if key == "" then

        return false

    end

    --==========================================================
    -- CUSTOM VALIDATOR
    --==========================================================

    if typeof(
        self.KeySystem.Validator
    ) == "function"
    then

        local success,
            result =
            pcall(
                self.KeySystem.Validator,
                key
            )

        if success
            and result == true
        then

            return true

        end

        return false

    end

    --==========================================================
    -- STATIC KEY
    --==========================================================

    if self.KeySystem.Key ~= nil then

        return key ==
            tostring(
                self.KeySystem.Key
            )

    end

    return false

end

--==============================================================
-- OPEN MAIN AFTER KEY
--==============================================================

function Library:UnlockKey(
    key
)

    if not self:ValidateKey(
        key
    ) then

        if self.KeySystem.Status then

            self.KeySystem.Status.Text =
                "❌ Key không đúng"

        end

        return false

    end

    self.KeySystem.Unlocked =
        true

    if self.KeySystem.Gui then

        pcall(function()

            self.KeySystem.Gui:Destroy()

        end)

        self.KeySystem.Gui =
            nil

    end

    return true

end

--==============================================================
-- SET KEY
--==============================================================

function Library:SetKey(
    key
)

    self.KeySystem.Key =
        tostring(
            key or ""
        )

    return true

end

--==============================================================
-- KEY STATUS
--==============================================================

function Library:IsKeyUnlocked()

    return
        self.KeySystem.Unlocked
        == true

end

--==============================================================
-- KEY MENU
--==============================================================

function Library:CreateKeyMenu(
    options
)

    options =
        options or {}

    --==========================================================
    -- RESET OLD
    --==========================================================

    self:DestroyKeyMenu()

    self.KeySystem.Enabled =
        true

    self.KeySystem.Unlocked =
        false

    self.KeySystem.Key =
        options.Key

    self.KeySystem.Validator =
        options.Validator

    local PlayerGui =
        LocalPlayer:WaitForChild(
            "PlayerGui"
        )

    --==========================================================
    -- SCREEN GUI
    --==========================================================

    local Gui =
        Instance.new(
            "ScreenGui"
        )

    Gui.Name =
        "LONG_GetKey"

    Gui.ResetOnSpawn =
        false

    Gui.IgnoreGuiInset =
        true

    Gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    Gui.Parent =
        PlayerGui

    self.KeySystem.Gui =
        Gui

    --==========================================================
    -- BACKGROUND
    --==========================================================

    local Background =
        Instance.new(
            "Frame"
        )

    Background.Size =
        UDim2.fromScale(
            1,
            1
        )

    Background.BackgroundColor3 =
        Color3.fromRGB(
            0,
            0,
            0
        )

    Background.BackgroundTransparency =
        0.35

    Background.BorderSizePixel =
        0

    Background.Parent =
        Gui

    --==========================================================
    -- CARD
    --==========================================================

    local Card =
        Instance.new(
            "Frame"
        )

    Card.AnchorPoint =
        Vector2.new(
            0.5,
            0.5
        )

    Card.Position =
        UDim2.fromScale(
            0.5,
            0.5
        )

    Card.Size =
        UDim2.fromOffset(
            options.Width
            or 350,
            options.Height
            or 220
        )

    Card.BackgroundColor3 =
        self.Theme.Background

    Card.BackgroundTransparency =
        0

    Card.BorderSizePixel =
        0

    Card.Parent =
        Gui

    local CardCorner =
        Instance.new(
            "UICorner"
        )

    CardCorner.CornerRadius =
        UDim.new(
            0,
            14
        )

    CardCorner.Parent =
        Card

    local CardStroke =
        Instance.new(
            "UIStroke"
        )

    CardStroke.Color =
        self.Theme.Border

    CardStroke.Thickness =
        1

    CardStroke.Parent =
        Card

    --==========================================================
    -- TITLE
    --==========================================================

    local Title =
        Instance.new(
            "TextLabel"
        )

    Title.Position =
        UDim2.fromOffset(
            20,
            18
        )

    Title.Size =
        UDim2.new(
            1,
            -40,
            0,
            30
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        tostring(
            options.Title
            or "LONG GET KEY"
        )

    Title.Font =
        Enum.Font.GothamBold

    Title.TextSize =
        18

    Title.TextColor3 =
        self.Theme.Text

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.Parent =
        Card

    --==========================================================
    -- SUBTITLE
    --==========================================================

    local Subtitle =
        Instance.new(
            "TextLabel"
        )

    Subtitle.Position =
        UDim2.fromOffset(
            20,
            50
        )

    Subtitle.Size =
        UDim2.new(
            1,
            -40,
            0,
            35
        )

    Subtitle.BackgroundTransparency =
        1

    Subtitle.Text =
        tostring(
            options.Subtitle
            or "Nhập Key để mở Menu"
        )

    Subtitle.Font =
        Enum.Font.Gotham

    Subtitle.TextSize =
        12

    Subtitle.TextColor3 =
        self.Theme.SubText

    Subtitle.TextWrapped =
        true

    Subtitle.TextXAlignment =
        Enum.TextXAlignment.Left

    Subtitle.Parent =
        Card

    --==========================================================
    -- KEY INPUT
    --==========================================================

    local Input =
        Instance.new(
            "TextBox"
        )

    Input.Position =
        UDim2.fromOffset(
            20,
            95
        )

    Input.Size =
        UDim2.new(
            1,
            -40,
            0,
            42
        )

    Input.BackgroundColor3 =
        self.Theme.Tertiary

    Input.BackgroundTransparency =
        0

    Input.BorderSizePixel =
        0

    Input.Text =
        ""

    Input.PlaceholderText =
        tostring(
            options.Placeholder
            or "Nhập Key..."
        )

    Input.PlaceholderColor3 =
        self.Theme.SubText

    Input.TextColor3 =
        self.Theme.Text

    Input.Font =
        Enum.Font.Gotham

    Input.TextSize =
        12

    Input.ClearTextOnFocus =
        false

    Input.Parent =
        Card

    local InputCorner =
        Instance.new(
            "UICorner"
        )

    InputCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    InputCorner.Parent =
        Input

    local InputPadding =
        Instance.new(
            "UIPadding"
        )

    InputPadding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    InputPadding.PaddingRight =
        UDim.new(
            0,
            12
        )

    InputPadding.Parent =
        Input

    self.KeySystem.Input =
        Input

    --==========================================================
    -- STATUS
    --==========================================================

    local Status =
        Instance.new(
            "TextLabel"
        )

    Status.Position =
        UDim2.fromOffset(
            20,
            142
        )

    Status.Size =
        UDim2.new(
            1,
            -40,
            0,
            22
        )

    Status.BackgroundTransparency =
        1

    Status.Text =
        ""

    Status.Font =
        Enum.Font.Gotham

    Status.TextSize =
        11

    Status.TextColor3 =
        self.Theme.SubText

    Status.TextXAlignment =
        Enum.TextXAlignment.Left

    Status.Parent =
        Card

    self.KeySystem.Status =
        Status

    --==========================================================
    -- BUTTON
    --==========================================================

    local Button =
        Instance.new(
            "TextButton"
        )

    Button.Position =
        UDim2.fromOffset(
            20,
            170
        )

    Button.Size =
        UDim2.new(
            1,
            -40,
            0,
            36
        )

    Button.BackgroundColor3 =
        self.Theme.Accent

    Button.BorderSizePixel =
        0

    Button.Text =
        tostring(
            options.ButtonText
            or "Xác nhận Key"
        )

    Button.Font =
        Enum.Font.GothamBold

    Button.TextSize =
        12

    Button.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    Button.AutoButtonColor =
        false

    Button.Parent =
        Card

    local ButtonCorner =
        Instance.new(
            "UICorner"
        )

    ButtonCorner.CornerRadius =
        UDim.new(
            0,
            8
        )

    ButtonCorner.Parent =
        Button

    --==========================================================
    -- VERIFY
    --==========================================================

    local function Verify()

        local key =
            Input.Text

        if self:UnlockKey(
            key
        ) then

            if typeof(
                options.OnSuccess
            ) == "function"
            then

                task.spawn(
                    function()

                        pcall(
                            options.OnSuccess
                        )

                    end
                )

            end

            return

        end

        Status.Text =
            tostring(
                options.InvalidText
                or "❌ Key không đúng"
            )

    end

    Button.MouseButton1Click:Connect(
        Verify
    )

    Input.FocusLost:Connect(
        function(
            enterPressed
        )

        if enterPressed then

            Verify()

        end

        end
    )

    --==========================================================
    -- OPTIONAL GET KEY BUTTON
    --==========================================================

    if typeof(
        options.GetKey
    ) == "function"
    then

        local GetButton =
            Instance.new(
                "TextButton"
            )

        GetButton.Position =
            UDim2.fromOffset(
                20,
                212
            )

        GetButton.Size =
            UDim2.new(
                1,
                -40,
                0,
                30
            )

        GetButton.BackgroundTransparency =
            1

        GetButton.Text =
            tostring(
                options.GetKeyText
                or "Lấy Key"
            )

        GetButton.Font =
            Enum.Font.GothamMedium

        GetButton.TextSize =
            11

        GetButton.TextColor3 =
            self.Theme.Accent

        GetButton.Parent =
            Card

        GetButton.MouseButton1Click:Connect(
            function()

                pcall(
                    options.GetKey
                )

            end
        )

    end

    return {

        Gui = Gui,

        Input = Input,

        Status = Status,

        Verify = Verify,

        Destroy = function()

            self:DestroyKeyMenu()

        end,

        Unlock = function(
            key
        )

            return self:UnlockKey(
                key
            )

        end

    }

end

--==============================================================
-- WINDOW KEY MENU
--==============================================================

function Library:CreateWindowKeyMenu(
    window,
    options
)

    local keyMenu =
        self:CreateKeyMenu(
            options
        )

    if window then

        window.KeyMenu =
            keyMenu

    end

    return keyMenu

end

--==============================================================
-- WINDOW KEY API
--==============================================================

function Library.AttachKeyMenu(
    window,
    options
)

    if not window then
        return nil
    end

    local keyMenu =
        Library:CreateKeyMenu(
            options
        )

    window.KeyMenu =
        keyMenu

    return keyMenu

end

--==============================================================
-- LIBRARY GLOBAL API
--==============================================================

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

--==============================================================
-- FORCE FINAL SETTINGS
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
-- DOCUMENTATION / CREATOR HELP
--==============================================================

Library.Version =
    "12.0"

Library.Features = {

    "100 Tab Icons",
    "Automatic Tab Icon",
    "Custom Tab Icon",
    "Optional GetKey",
    "Static Key",
    "Custom Key Validator",
    "Custom Interface",
    "Theme",
    "Accent",
    "Transparency",
    "Menu Size",
    "Sidebar",
    "UI Scale",
    "Hide / Show",
    "Position",
    "Animation",
    "Search",
    "Notification",
    "Slider",
    "Dropdown",
    "Multi Dropdown",
    "Textbox",
    "Keybind",
    "Reset",
    "Settings Tab"
}

--==============================================================
-- RETURN
--==============================================================

return Library
