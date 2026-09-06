--==============================================================
-- NHATLONG LIBRARY
-- FINAL FULL SCRIPT
--==============================================================
-- Giữ nguyên hệ thống Library gốc
-- + Smart Icon
-- + Fallback Icon
-- + Creator Intro
-- + 10 Intro Effects
-- + Mobile / PC / Touch
-- + Safe Loading
-- + Default UI Settings
--==============================================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- CONFIG
--==============================================================

local CONFIG = {
    SourceURL =
        "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/NHATLONG-library-v21.lua",

    MenuWidth = 507,
    MenuHeight = 384,

    Transparency = 57,

    AnimationSpeed = 1.0,

    FloatingButton = false,

    Theme = "Black",

    IconEngine = true,

    FallbackIcon = "●",

    CreatorIntro = {
        Enabled = false,
        AutoShow = false,

        CreatorName = "BY NHATLONG",
        ScriptName = "LONG SCRIPT",

        Description =
            "Welcome to the script.",

        Version = "FINAL",

        Effect = "SlideDown",

        Duration = 2.5,

        SkipButton = true,

        ShowVersion = true,
        ShowDescription = true,
        ShowCreator = true,

        BackgroundTransparency = 0.12,
        CardTransparency = 0
    }
}

--==============================================================
-- SAFE HTTP
--==============================================================

local function SafeHttpGet(url)

    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        error(
            "[NHATLONG] HttpGet failed:\n"
            .. tostring(result)
        )
    end

    if type(result) ~= "string" then
        error("[NHATLONG] Invalid source.")
    end

    if #result < 1000 then
        error("[NHATLONG] Source too small.")
    end

    return result
end

--==============================================================
-- LOAD ORIGINAL LIBRARY
--==============================================================

local Source = SafeHttpGet(CONFIG.SourceURL)

--==============================================================
-- DEFAULT SETTINGS PATCH
--==============================================================

Source = Source:gsub(
    "AnimationSpeed%s*=%s*[%d%.]+,",
    "AnimationSpeed = 1.0,"
)

Source = Source:gsub(
    "FloatingButton%s*=%s*true,",
    "FloatingButton = false,"
)

--==============================================================
-- COMPILE
--==============================================================

local Chunk, CompileError = loadstring(Source)

if not Chunk then
    error(
        "[NHATLONG] Compile error:\n"
        .. tostring(CompileError)
    )
end

--==============================================================
-- EXECUTE
--==============================================================

local Success, Library = pcall(function()
    return Chunk()
end)

if not Success then
    error(
        "[NHATLONG] Runtime error:\n"
        .. tostring(Library)
    )
end

if type(Library) ~= "table" then
    error("[NHATLONG] Library did not return table.")
end

--==============================================================
-- FORCE SETTINGS
--==============================================================

pcall(function()

    Library.Settings = Library.Settings or {}

    Library.Settings.MenuWidth =
        CONFIG.MenuWidth

    Library.Settings.MenuHeight =
        CONFIG.MenuHeight

    Library.Settings.Transparency =
        CONFIG.Transparency

    Library.Settings.AnimationSpeed =
        CONFIG.AnimationSpeed

    Library.Settings.FloatingButton =
        CONFIG.FloatingButton

end)

--==============================================================
-- VERSION
--==============================================================

Library.Version = "FINAL"

--==============================================================
-- ICON ENGINE
--==============================================================

Library.IconEngine = Library.IconEngine or {}

Library.IconEngine.Enabled =
    CONFIG.IconEngine

Library.IconEngine.Fallback =
    CONFIG.FallbackIcon

Library.IconEngine.Pool =
    Library.IconEngine.Pool or {}

Library.IconEngine.Keywords =
    Library.IconEngine.Keywords or {}

--==============================================================
-- EXTRA ICON POOL
--==============================================================

local ExtraIcons = {

    "🏠","⚙️","🔧","🛠️","📋","📜","📁","📂",
    "🔍","🔎","🔔","🔕","🔒","🔓","🔑","🔐",

    "⚡","✨","⭐","🌟","💫","🔥","💎","👑",

    "👤","👥","🧍","🚶","🏃","🤖","👽","👾",

    "⚔️","🗡️","🛡️","🏹","🎯","💥","🔨","🥊",

    "🔮","🪄","💧","❄️","🌪️","🌊","🌋","☄️",

    "🌎","🌍","🌏","🗺️","🏝️","🏜️","🏔️",
    "🌲","🌳","🌴","🌵","🌻","🌸","🌺","🌹",

    "🌾","🌱","🌿","🍃","🥕","🍎","🍊","🍇",
    "🍉","🍓","🍒","🥭","🍍","🥥","🌽","🥔",

    "📦","🎁","🎒","💼","👜","🧰","💰","💵",
    "💳","🪙","🎫","🏷️",

    "🚗","🚕","🚙","🚌","🏎️","🚓","🚑","🚒",
    "🚚","🚜","🏍️","🛵","🚲","✈️","🚁","🚢",
    "⛵","🚤","🚀",

    "🏃","🚶","💨","⬆️","⬇️","⬅️","➡️",
    "⤴️","⤵️","🪽","🛫","🛬","🔄","🔃",

    "🎯","📖","📝","❗","❓","‼️","⁉️",
    "🏆","🥇","🏅","🎖️",

    "🐾","🐶","🐱","🐭","🐹","🐰","🦊","🐻",
    "🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵",
    "🐔","🐧","🐦","🦄","🐲","🐉",

    "🐟","🐠","🐡","🦈","🐙","🦑","🦀","🦞",
    "🐋","🐳","🐬","🪼","🐚","⚓",

    "🔊","🔉","🔈","🔇","🎵","🎶","🎧","🎤",
    "🎸","🎹","🥁","📻","🎼",

    "🎨","🖌️","🖍️","✏️","🖼️","🌈","🌓",
    "☀️","🌙","💡",

    "🌐","📡","📶","💻","🖥️","⌨️","🖱️",
    "📱","🔗","☁️","🛰️","📨","📤","📥",

    "📊","📈","📉","💹","🔢","💯","📌","📍",
    "🧮",

    "☑️","✅","❌","⚠️","🚨",

    "🔒","🔓","🔐","🛡️","🗝️","👁️",
    "🚫","⛔","🔰",

    "⏰","⌚","⏱️","⏳","⌛",
    "🕐","🕑","🕒","🕓","🕔","🕕",
    "🕖","🕗","🕘","🕙","🕚",

    "💬","🗨️","📢","📣",
    "❤️","💙","💚","💛","🧡","💜","🖤","🤍",
    "🤝","👋","👍","👎",

    "🎉","🎊","🎁","🎂","🎃","🎄",
    "🎆","🎇","🎈","🎀","🏮","🪅",

    "🎮","🕹️","👾","🤖","🎲","🧱",

    "🍔","🍕","🍟","🌭","🍗","🍿","🍩",
    "🍪","🍰","🍫",

    "🔴","🟠","🟡","🟢","🔵","🟣",
    "⚫","⚪","🟤","🔶","🔷","🔺","🔻",
    "⬛","⬜","◼️","◻️",

    "➕","➖","✖️","➗","✔️","☑️","❌",

    "♻️","☢️","☣️","⚜️","♻️","⚙️",
    "♟️","♞","♜","♛","♚",

    "☁️","🌧️","⛈️","🌩️","🌨️","🌤️",
    "🌥️","🌦️","🌈",

    "📡","📶","🔗","🔗","🛰️",
    "📡","🌐",

    "🧠","👀","👂","👄","🫀","🫁",
    "🦾","🦿","🧬","🔬","🧪",

    "💻","🖥️","📱","⌨️","🖱️",
    "💾","💿","📀","🗂️",

    "🛒","🏪","🏦","🏛️","🏢",
    "🏭","🏗️","🏠","🏡","🏰",

    "🎓","📚","📕","📗","📘","📙",
    "📓","📔","📒","📖",

    "🧩","🎲","🎮","🎰","🃏","♠️",
    "♥️","♦️","♣️",

    "🔋","🔌","💡","🔦","🕯️",

    "🛠️","🔧","🔨","⚒️","⛏️",
    "🪛","🔩","⚙️"
}

for _, icon in ipairs(ExtraIcons) do
    table.insert(
        Library.IconEngine.Pool,
        icon
    )
end

--==============================================================
-- NORMALIZE
--==============================================================

local function NormalizeName(name)

    name = tostring(name or "")

    name = name:lower()

    name = name:gsub(
        "[%p%c]",
        " "
    )

    name = name:gsub(
        "%s+",
        " "
    )

    name = name:gsub(
        "^%s+",
        ""
    )

    name = name:gsub(
        "%s+$",
        ""
    )

    return name
end

local function CompactName(name)

    return NormalizeName(name)
        :gsub("%s+", "")

end

--==============================================================
-- SMART ICON
--==============================================================

function Library:GetTabIcon(name)

    if not self.IconEngine.Enabled then
        return self.IconEngine.Fallback
    end

    local raw = tostring(name or "")

    local normalized =
        NormalizeName(raw)

    local compact =
        CompactName(raw)

    -- EXACT

    if self.IconEngine.Keywords[
        normalized
    ] then

        return self.IconEngine.Keywords[
            normalized
        ]

    end

    if self.IconEngine.Keywords[
        compact
    ] then

        return self.IconEngine.Keywords[
            compact
        ]

    end

    -- PARTIAL

    for keyword, icon in pairs(
        self.IconEngine.Keywords
    ) do

        if string.find(
            compact,
            keyword,
            1,
            true
        ) then

            return icon

        end

    end

    -- TAB PREFIX

    if compact:sub(1,3) == "tab" then

        local remaining =
            compact:sub(4)

        for keyword, icon in pairs(
            self.IconEngine.Keywords
        ) do

            if string.find(
                remaining,
                keyword,
                1,
                true
            ) then

                return icon

            end

        end

    end

    -- FALLBACK HASH

    if #self.IconEngine.Pool > 0 then

        local hash = 0

        for i = 1, #compact do

            hash =
                (
                    hash * 31
                    + string.byte(
                        compact,
                        i
                    )
                )
                % 2147483647

        end

        local index =
            (
                hash
                % #self.IconEngine.Pool
            ) + 1

        return self.IconEngine.Pool[index]
    end

    return self.IconEngine.Fallback
end

--==============================================================
-- CUSTOM ICON
--==============================================================

function Library:SetTabIcon(
    name,
    icon
)

    name = tostring(name or "")

    icon =
        tostring(
            icon
            or self.IconEngine.Fallback
        )

    if name == "" then
        return false
    end

    self.IconEngine.Keywords[
        NormalizeName(name)
    ] = icon

    self.IconEngine.Keywords[
        CompactName(name)
    ] = icon

    for _, window in ipairs(
        self.Windows or {}
    ) do

        for _, tab in ipairs(
            window.Tabs or {}
        ) do

            if tab.Name
                and NormalizeName(
                    tab.Name
                )
                ==
                NormalizeName(name)
            then

                pcall(function()

                    if tab.SetIcon then

                        tab:SetIcon(icon)

                    end

                end)

            end

        end

    end

    return true
end

--==============================================================
-- ICON API
--==============================================================

function Library:GetIconCount()

    return #self.IconEngine.Pool

end

function Library:GetAutoIcon(name)

    return self:GetTabIcon(name)

end

function Library:FindIcon(name)

    return self:GetTabIcon(name)

end

--==============================================================
-- CREATOR INTRO
--==============================================================

Library.CreatorIntro =
    Library.CreatorIntro or {}

for key, value in pairs(
    CONFIG.CreatorIntro
) do

    Library.CreatorIntro[key] =
        value

end

--==============================================================
-- SAFE NOTIFICATION
--==============================================================

function Library:SafeNotify(
    title,
    text,
    duration
)

    pcall(function()

        StarterGui:SetCore(
            "SendNotification",
            {
                Title =
                    tostring(
                        title or "LONG UI"
                    ),

                Text =
                    tostring(
                        text or ""
                    ),

                Duration =
                    duration or 3
            }
        )

    end)

end

--==============================================================
-- CREATOR INTRO EFFECT
--==============================================================

function Library:SetIntroEffect(effect)

    local allowed = {

        Fade = true,
        Zoom = true,

        SlideUp = true,
        SlideDown = true,

        SlideLeft = true,
        SlideRight = true,

        Bounce = true,
        Rotate = true,

        Pulse = true,
        Typewriter = true
    }

    if allowed[effect] then

        self.CreatorIntro.Effect =
            effect

        return true

    end

    return false
end

--==============================================================
-- INTRO STATE
--==============================================================

local IntroGui = nil
local IntroActive = false

--==============================================================
-- CREATE INTRO
--==============================================================

function Library:ShowCreatorIntro()

    if IntroActive then
        return
    end

    if not self.CreatorIntro.Enabled then
        return
    end

    IntroActive = true

    local gui =
        Instance.new("ScreenGui")

    gui.Name =
        "NHATLONG_CreatorIntro"

    gui.ResetOnSpawn = false

    gui.IgnoreGuiInset = true

    pcall(function()
        gui.Parent =
            game:GetService(
                "CoreGui"
            )
    end)

    if not gui.Parent then

        gui.Parent =
            LocalPlayer:
            WaitForChild(
                "PlayerGui"
            )

    end

    IntroGui = gui

    --==========================================================
    -- BACKGROUND
    --==========================================================

    local background =
        Instance.new("Frame")

    background.Size =
        UDim2.fromScale(1,1)

    background.Position =
        UDim2.fromScale(0,0)

    background.BackgroundColor3 =
        Color3.fromRGB(
            0,
            0,
            0
        )

    background.BackgroundTransparency =
        self.CreatorIntro.BackgroundTransparency

    background.BorderSizePixel = 0

    background.Parent = gui

    --==========================================================
    -- CARD
    --==========================================================

    local card =
        Instance.new("Frame")

    card.AnchorPoint =
        Vector2.new(
            0.5,
            0.5
        )

    card.Position =
        UDim2.fromScale(
            0.5,
            0.5
        )

    card.Size =
        UDim2.fromOffset(
            360,
            210
        )

    card.BackgroundColor3 =
        Color3.fromRGB(
            15,
            15,
            15
        )

    card.BackgroundTransparency =
        self.CreatorIntro.CardTransparency

    card.BorderSizePixel = 0

    card.Parent = background

    local corner =
        Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(
            0,
            16
        )

    corner.Parent = card

    local stroke =
        Instance.new("UIStroke")

    stroke.Color =
        Color3.fromRGB(
            255,
            255,
            255
        )

    stroke.Transparency = 0.82

    stroke.Thickness = 1

    stroke.Parent = card

    --==========================================================
    -- CREATOR
    --==========================================================

    local creator =
        Instance.new("TextLabel")

    creator.BackgroundTransparency = 1

    creator.Size =
        UDim2.new(
            1,
            -30,
            0,
            40
        )

    creator.Position =
        UDim2.fromOffset(
            15,
            20
        )

    creator.Font =
        Enum.Font.GothamBold

    creator.TextSize = 24

    creator.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

    creator.Text =
        tostring(
            self.CreatorIntro.CreatorName
        )

    creator.Parent = card

    --==========================================================
    -- SCRIPT NAME
    --==========================================================

    local scriptName =
        Instance.new("TextLabel")

    scriptName.BackgroundTransparency = 1

    scriptName.Size =
        UDim2.new(
            1,
            -30,
            0,
            35
        )

    scriptName.Position =
        UDim2.fromOffset(
            15,
            65
        )

    scriptName.Font =
        Enum.Font.GothamSemibold

    scriptName.TextSize = 19

    scriptName.TextColor3 =
        Color3.fromRGB(
            220,
            220,
            220
        )

    scriptName.Text =
        tostring(
            self.CreatorIntro.ScriptName
        )

    scriptName.Parent = card

    --==========================================================
    -- DESCRIPTION
    --==========================================================

    local description =
        Instance.new("TextLabel")

    description.BackgroundTransparency = 1

    description.Size =
        UDim2.new(
            1,
            -40,
            0,
            45
        )

    description.Position =
        UDim2.fromOffset(
            20,
            105
        )

    description.Font =
        Enum.Font.Gotham

    description.TextSize = 13

    description.TextWrapped = true

    description.TextColor3 =
        Color3.fromRGB(
            170,
            170,
            170
        )

    description.Text =
        tostring(
            self.CreatorIntro.Description
        )

    description.Parent = card

    --==========================================================
    -- VERSION
    --==========================================================

    local version =
        Instance.new("TextLabel")

    version.BackgroundTransparency = 1

    version.Size =
        UDim2.new(
            1,
            -30,
            0,
            20
        )

    version.Position =
        UDim2.fromOffset(
            15,
            155
        )

    version.Font =
        Enum.Font.Gotham

    version.TextSize = 12

    version.TextColor3 =
        Color3.fromRGB(
            130,
            130,
            130
        )

    version.Text =
        "Version "
        .. tostring(
            self.CreatorIntro.Version
        )

    version.Parent = card

    --==========================================================
    -- SKIP
    --==========================================================

    if self.CreatorIntro.SkipButton then

        local skip =
            Instance.new("TextButton")

        skip.AnchorPoint =
            Vector2.new(
                1,
                1
            )

        skip.Position =
            UDim2.new(
                1,
                -12,
                1,
                -10
            )

        skip.Size =
            UDim2.fromOffset(
                70,
                26
            )

        skip.BackgroundTransparency = 1

        skip.Font =
            Enum.Font.Gotham

        skip.TextSize = 12

        skip.TextColor3 =
            Color3.fromRGB(
                140,
                140,
                140
            )

        skip.Text =
            "Bỏ qua"

        skip.Parent = card

        skip.MouseButton1Click:Connect(
            function()

                self:SkipCreatorIntro()

            end
        )

    end

    --==========================================================
    -- EFFECT
    --==========================================================

    local effect =
        self.CreatorIntro.Effect

    if effect == "Fade" then

        card.BackgroundTransparency = 1

        TweenService:Create(
            card,
            TweenInfo.new(
                0.45,
                Enum.EasingStyle.Quad
            ),
            {
                BackgroundTransparency =
                    self.CreatorIntro.CardTransparency
            }
        ):Play()

    elseif effect == "Zoom" then

        card.Size =
            UDim2.fromOffset(
                20,
                20
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.5,
                Enum.EasingStyle.Back
            ),
            {
                Size =
                    UDim2.fromOffset(
                        360,
                        210
                    )
            }
        ):Play()

    elseif effect == "SlideDown" then

        card.Position =
            UDim2.fromScale(
                0.5,
                -0.5
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.6,
                Enum.EasingStyle.Quint
            ),
            {
                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    )
            }
        ):Play()

    elseif effect == "SlideUp" then

        card.Position =
            UDim2.fromScale(
                0.5,
                1.5
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.6,
                Enum.EasingStyle.Quint
            ),
            {
                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    )
            }
        ):Play()

    elseif effect == "SlideLeft" then

        card.Position =
            UDim2.fromScale(
                -0.5,
                0.5
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.6,
                Enum.EasingStyle.Quint
            ),
            {
                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    )
            }
        ):Play()

    elseif effect == "SlideRight" then

        card.Position =
            UDim2.fromScale(
                1.5,
                0.5
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.6,
                Enum.EasingStyle.Quint
            ),
            {
                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    )
            }
        ):Play()

    elseif effect == "Bounce" then

        card.Position =
            UDim2.fromScale(
                0.5,
                -0.5
            )

        TweenService:Create(
            card,
            TweenInfo.new(
                0.8,
                Enum.EasingStyle.Bounce
            ),
            {
                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    )
            }
        ):Play()

    elseif effect == "Rotate" then

        card.Rotation = -180

        TweenService:Create(
            card,
            TweenInfo.new(
                0.7,
                Enum.EasingStyle.Back
            ),
            {
                Rotation = 0
            }
        ):Play()

    elseif effect == "Pulse" then

        task.spawn(function()

            while IntroActive
                and card.Parent do

                TweenService:Create(
                    card,
                    TweenInfo.new(
                        0.45,
                        Enum.EasingStyle.Sine
                    ),
                    {
                        Size =
                            UDim2.fromOffset(
                                370,
                                215
                            )
                    }
                ):Play()

                task.wait(0.45)

                TweenService:Create(
                    card,
                    TweenInfo.new(
                        0.45,
                        Enum.EasingStyle.Sine
                    ),
                    {
                        Size =
                            UDim2.fromOffset(
                                360,
                                210
                            )
                    }
                ):Play()

                task.wait(0.45)

            end

        end)

    elseif effect == "Typewriter" then

        local full =
            description.Text

        description.Text = ""

        task.spawn(function()

            for i = 1, #full do

                if not IntroActive then
                    break
                end

                description.Text =
                    string.sub(
                        full,
                        1,
                        i
                    )

                task.wait(0.025)

            end

        end)

    end

    --==========================================================
    -- AUTO CLOSE
    --==========================================================

    task.delay(
        self.CreatorIntro.Duration,
        function()

            if IntroActive then

                self:HideCreatorIntro()

            end

        end
    )

end

--==============================================================
-- HIDE INTRO
--==============================================================

function Library:HideCreatorIntro()

    if not IntroActive then
        return
    end

    IntroActive = false

    if IntroGui then

        local gui = IntroGui

        IntroGui = nil

        local background =
            gui:FindFirstChildWhichIsA(
                "Frame"
            )

        if background then

            local card =
                background:FindFirstChild(
                    "Frame"
                )

            if card then

                TweenService:Create(
                    card,
                    TweenInfo.new(
                        0.25,
                        Enum.EasingStyle.Quad
                    ),
                    {
                        Size =
                            UDim2.fromOffset(
                                20,
                                20
                            ),
                        BackgroundTransparency = 1
                    }
                ):Play()

            end

        end

        task.delay(
            0.3,
            function()

                pcall(function()
                    gui:Destroy()
                end)

            end
        )

    end

end

--==============================================================
-- SKIP
--==============================================================

function Library:SkipCreatorIntro()

    self:HideCreatorIntro()

end

--==============================================================
-- INTRO CONFIG API
--==============================================================

function Library:SetCreatorIntro(config)

    if type(config) ~= "table" then
        return false
    end

    for key, value in pairs(config) do

        if self.CreatorIntro[key]
            ~= nil
        then

            self.CreatorIntro[key] =
                value

        end

    end

    return true
end

function Library:IsCreatorIntroEnabled()

    return
        self.CreatorIntro.Enabled
        == true

end

--==============================================================
-- OPTIONAL AUTO INTRO
--==============================================================

if self == nil then
    -- no-op
end

if Library.CreatorIntro.Enabled
    and Library.CreatorIntro.AutoShow
then

    task.defer(function()

        Library:ShowCreatorIntro()

    end)

end

--==============================================================
-- FINAL RETURN
--==============================================================

return Library
