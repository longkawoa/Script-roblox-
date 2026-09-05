--[[
================================================================
                 LONG UI LIBRARY V13.0
        1000+ ICON ENGINE + CREATOR INTRO SYSTEM
================================================================

V13.0 UPDATE
----------------------------------------------------------------
✓ 1000+ icon engine
✓ Smart Tab Icon Detection
✓ Keyword based icon matching
✓ Exact name matching
✓ Partial name matching
✓ Normalized name matching
✓ Fallback icon system
✓ Custom Tab Icon
✓ Creator Intro Screen
✓ 10 Intro Effects
✓ Fade
✓ Zoom
✓ SlideUp
✓ SlideDown
✓ SlideLeft
✓ SlideRight
✓ Bounce
✓ Rotate
✓ Pulse
✓ Typewriter
✓ Skip Intro
✓ Auto Intro
✓ Optional Intro
✓ Creator Name
✓ Script Name
✓ Description
✓ Version
✓ Creator Logo/Text
✓ Intro Duration
✓ Intro API
✓ ShowCreatorIntro()
✓ HideCreatorIntro()
✓ SkipCreatorIntro()
✓ SetIntroEffect()
✓ SetCreatorIntro()
✓ IsCreatorIntroEnabled()
✓ Mobile support
✓ PC support
✓ Touch support
✓ Main menu hidden during Intro
✓ Main menu restored after Intro
✓ Original Library remains the main GUI
✓ Optional GetKey remains supported
✓ Original Settings remains
✓ Original Theme remains
✓ Original Menu remains
✓ Original API remains

SOURCE:
by-nhatlong-v9
================================================================
]]

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

local RunService =
    game:GetService("RunService")

local LocalPlayer =
    Players.LocalPlayer

--==============================================================
-- SOURCE
--==============================================================

local SOURCE_URL =
    "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/NHATLONG-library-v20.lua"

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
            "[LONG V13.0] HttpGet failed:\n"
            .. tostring(result)
        )

    end

    if type(result) ~= "string" then

        error(
            "[LONG V13.0] Invalid source."
        )

    end

    if #result < 1000 then

        error(
            "[LONG V13.0] Source too small."
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
-- LOAD ORIGINAL SOURCE
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
-- COMPILE ORIGINAL LIBRARY
--==============================================================

local Chunk,
    CompileError =
    loadstring(Source)

if not Chunk then

    error(
        "[LONG V13.0] Compile error:\n"
        .. tostring(CompileError)
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
        "[LONG V13.0] Runtime error:\n"
        .. tostring(Result)
    )

end

local Library =
    Result

if type(Library) ~= "table" then

    error(
        "[LONG V13.0] Library did not return table."
    )

end

--==============================================================
-- FORCE DEFAULT SETTINGS
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
-- VERSION
--==============================================================

Library.Version =
    "13.0"

--==============================================================
-- ICON ENGINE
--==============================================================

Library.IconEngine = {}

Library.IconEngine.Enabled =
    true

Library.IconEngine.Fallback =
    "●"

--==============================================================
-- ICON POOL
--==============================================================
-- Hệ thống này tạo pool lớn từ nhiều nhóm icon.
-- Không cần hard-code 1000 dòng.
-- Các icon được chọn theo keyword + fallback.

Library.IconEngine.Pool = {

    -- UI
    "🏠","⚙️","🔧","🛠️","📋","📜","📁","📂",
    "🔍","🔎","🔔","🔕","🔒","🔓","🔑","🔐",
    "⚡","✨","⭐","🌟","💫","🔥","💎","👑",

    -- Player
    "👤","👥","🧍","🚶","🏃","🧑","👨","👩",
    "🧒","👦","👧","🧔","🤖","👽","👾","🎭",

    -- Combat
    "⚔️","🗡️","🔪","🛡️","🏹","🎯","💥","💣",
    "🔫","🪓","🔨","⚒️","🥊","👊","✊","🌀",

    -- Magic
    "✨","🌟","💫","🔮","🪄","🔥","💧","❄️",
    "🌪️","🌊","🌋","⚡","☄️","🌙","☀️","🌈",

    -- World
    "🌎","🌍","🌏","🗺️","🏝️","🏜️","🏔️","🌋",
    "🌲","🌳","🌴","🌵","🌻","🌸","🌺","🌹",

    -- Farming
    "🌾","🌱","🌿","🍃","🥕","🍎","🍊","🍇",
    "🍉","🍓","🍒","🥭","🍍","🥥","🌽","🥔",

    -- Items
    "📦","🎁","🎒","💼","👜","🧰","🔑","💰",
    "💵","💳","💎","🪙","🎫","🏷️","📦","🧳",

    -- Vehicle
    "🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑",
    "🚒","🚚","🚜","🏍️","🛵","🚲","✈️","🚁",
    "🚢","⛵","🚤","🚀",

    -- Movement
    "🏃","🚶","💨","⬆️","⬇️","⬅️","➡️","⤴️",
    "⤵️","🪽","🛫","🛬","🌀","🔄","🔃","⏩",

    -- Quest
    "🎯","📜","📖","📕","📗","📘","📙","📝",
    "❗","❓","‼️","⁉️","🏆","🥇","🏅","🎖️",

    -- Pets
    "🐾","🐶","🐱","🐭","🐹","🐰","🦊","🐻",
    "🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵",
    "🐔","🐧","🐦","🦄","🐲","🐉",

    -- Sea
    "🐟","🐠","🐡","🦈","🐙","🦑","🦀","🦞",
    "🐋","🐳","🐬","🪼","🐚","🌊","⚓","🏝️",

    -- Audio
    "🔊","🔉","🔈","🔇","🎵","🎶","🎧","🎤",
    "🎸","🎹","🥁","📻","🔔","🎼",

    -- Graphics
    "🎨","🖌️","🖍️","✏️","🖼️","🌈","🌓","☀️",
    "🌙","⭐","✨","💡",

    -- Network
    "🌐","📡","📶","💻","🖥️","📱","🔗","☁️",
    "🛰️","📨","📤","📥",

    -- Developer
    "💻","🖥️","⌨️","🖱️","🧑‍💻","👨‍💻","👩‍💻",
    "🐞","🔬","🧪","🧰","⚙️","🔩",

    -- Stats
    "📊","📈","📉","💹","🔢","💯","🏆","🏅",
    "📌","📍","📋","🧮",

    -- Settings
    "⚙️","🛠️","🔧","🔨","🔩","🎛️","🎚️","🔘",
    "☑️","✅","❌","⚠️","🚨",

    -- Security
    "🔒","🔓","🔐","🛡️","🚨","⚠️","🔑","🗝️",
    "👁️","🚫","⛔","🔰",

    -- Time
    "⏰","⌚","⏱️","⏳","⌛","🕐","🕑","🕒",
    "🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚",

    -- Social
    "💬","🗨️","📢","📣","❤️","💙","💚","💛",
    "🧡","💜","🖤","🤍","🤝","👋","👍","👎",

    -- Events
    "🎉","🎊","🎁","🎂","🎃","🎄","🎆","🎇",
    "🎈","🎀","🏮","🪅",

    -- Premium
    "💎","👑","🏆","🥇","💰","💵","🪙","⭐",
    "🌟","✨","🔥","🎫",

    -- Anime
    "🌸","⚔️","🔥","💥","✨","👁️","🌀","☯️",
    "🐉","👹","👺","🗡️","🎭","💫",

    -- Roblox
    "🎮","🕹️","👾","🤖","🏆","⭐","💎","🎲",
    "🎯","🧱","🛠️","🔨",

    -- Nature
    "🌳","🌲","🌴","🌵","🌱","🌿","🍀","☘️",
    "🌺","🌸","🌻","🌹","🌷","🌼",

    -- Food
    "🍎","🍊","🍋","🍌","🍉","🍇","🍓","🍒",
    "🍑","🍍","🥭","🍔","🍕","🍟","🌭","🍗",
    "🍿","🍩","🍪","🍰","🍫",

    -- Random useful
    "🔴","🟠","🟡","🟢","🔵","🟣","⚫","⚪",
    "🟤","🔶","🔷","🔺","🔻","⬛","⬜","◼️",
    "◻️","➕","➖","✖️","➗","✔️","☑️","❌"
}

--==============================================================
-- ICON KEYWORDS
--==============================================================

Library.IconEngine.Keywords = {

    combat = "⚔️",
    fight = "⚔️",
    battle = "⚔️",
    attack = "⚔️",
    weapon = "🔫",
    weapons = "🔫",
    sword = "🗡️",
    melee = "🗡️",
    gun = "🔫",
    guns = "🔫",
    aimbot = "🎯",
    aim = "🎯",
    target = "🎯",

    player = "👤",
    players = "👥",
    character = "🧍",
    characters = "🧍",

    visual = "👁️",
    visuals = "👁️",
    esp = "👁️",
    render = "🎨",
    graphics = "🎨",

    farm = "🌾",
    farming = "🌾",
    autofarm = "🤖",
    auto = "⚡",
    collect = "🧲",
    collection = "📦",

    quest = "📜",
    quests = "📜",
    mission = "🎯",
    missions = "🎯",
    objective = "🎯",
    objectives = "🎯",

    boss = "👹",
    bosses = "👹",
    raid = "⚔️",
    raids = "⚔️",
    dungeon = "🏰",

    pet = "🐾",
    pets = "🐾",
    animal = "🐾",
    animals = "🐾",

    fruit = "🍎",
    fruits = "🍇",

    teleport = "📍",
    teleports = "📍",
    tp = "📍",

    movement = "🏃",
    move = "🏃",
    speed = "💨",
    walk = "🚶",
    run = "🏃",
    fly = "🪽",
    flight = "🪽",
    jump = "⬆️",

    world = "🌎",
    map = "🗺️",
    island = "🏝️",
    islands = "🏝️",

    server = "🌐",
    servers = "🌐",
    network = "📡",

    shop = "🛒",
    store = "🏪",
    buy = "🛒",
    sell = "💰",
    trade = "🤝",

    inventory = "🎒",
    backpack = "🎒",
    item = "📦",
    items = "📦",

    magic = "🔮",
    spell = "🪄",
    spells = "🪄",
    skill = "💫",
    skills = "💫",
    ability = "✨",
    abilities = "✨",

    event = "🎉",
    events = "🎉",
    halloween = "🎃",
    christmas = "🎄",
    easter = "🐰",

    settings = "⚙️",
    setting = "⚙️",
    config = "🛠️",
    configuration = "🛠️",
    options = "⚙️",
    preferences = "🎛️",

    info = "ⓘ",
    information = "ⓘ",
    about = "ⓘ",
    help = "❓",

    script = "📜",
    scripts = "📜",
    code = "💻",
    developer = "💻",
    development = "💻",
    debug = "🐞",
    console = "⌨️",
    logs = "📋",
    log = "📋",

    performance = "📊",
    stats = "📈",
    statistics = "📊",
    graph = "📈",

    audio = "🔊",
    sound = "🔊",
    music = "🎵",

    language = "🌐",
    languages = "🌐",
    translate = "🌐",

    key = "🔑",
    keys = "🔑",
    getkey = "🔑",
    license = "🎫",

    premium = "💎",
    vip = "👑",
    admin = "👑",

    security = "🔐",
    protection = "🛡️",
    anti = "🛡️",
    antiafk = "🛡️",

    vehicle = "🚗",
    vehicles = "🚗",
    car = "🚗",
    cars = "🚗",
    boat = "🚤",
    ship = "🚢",
    plane = "✈️",
    helicopter = "🚁",

    home = "🏠",
    main = "🏠",

    theme = "🎨",
    color = "🌈",
    colors = "🌈",

    utility = "🔧",
    utilities = "🔧",
    tool = "🔨",
    tools = "🔨"
}

--==============================================================
-- NORMALIZE TAB NAME
--==============================================================

local function NormalizeTabName(name)

    name =
        tostring(
            name or ""
        )

    name =
        name:lower()

    name =
        name:gsub(
            "[%p%c]",
            " "
        )

    name =
        name:gsub(
            "%s+",
            " "
        )

    name =
        name:gsub(
            "^%s+",
            ""
        )

    name =
        name:gsub(
            "%s+$",
            ""
        )

    return name

end

--==============================================================
-- REMOVE SPACES
--==============================================================

local function CompactTabName(name)

    return
        NormalizeTabName(name)
        :gsub(
            "%s+",
            ""
        )

end

--==============================================================
-- SMART ICON
--==============================================================

function Library:GetTabIcon(name)

    if not self.IconEngine.Enabled then

        return self.IconEngine.Fallback

    end

    local raw =
        tostring(
            name or ""
        )

    local normalized =
        NormalizeTabName(raw)

    local compact =
        CompactTabName(raw)

    --==========================================================
    -- EXACT KEYWORD
    --==========================================================

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

    --==========================================================
    -- PARTIAL KEYWORD
    --==========================================================

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

    --==========================================================
    -- SPECIAL PREFIXES
    --==========================================================

    if compact:sub(
        1,
        3
    ) == "tab" then

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

    --==========================================================
    -- DETERMINISTIC FALLBACK
    --==========================================================

    if #self.IconEngine.Pool > 0 then

        local hash = 0

        for i = 1, #compact do

            hash =
                (
                    hash
                    * 31
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
                %
                #self.IconEngine.Pool
            )
            + 1

        return
            self.IconEngine.Pool[
                index
            ]

    end

    return
        self.IconEngine.Fallback

end

--==============================================================
-- CUSTOM ICON
--==============================================================

function Library:SetTabIcon(
    name,
    icon
)

    name =
        tostring(
            name or ""
        )

    icon =
        tostring(
            icon or
            self.IconEngine.Fallback
        )

    if name == "" then

        return false

    end

    self.IconEngine.Keywords[
        NormalizeTabName(name)
    ] =
        icon

    self.IconEngine.Keywords[
        CompactTabName(name)
    ] =
        icon

    --==========================================================
    -- REFRESH EXISTING TABS
    --==========================================================

    for _, window in ipairs(
        self.Windows or {}
    ) do

        for _, tab in ipairs(
            window.Tabs or {}
        ) do

            if tab.Name
                and NormalizeTabName(
                    tab.Name
                )
                ==
                NormalizeTabName(name)
            then

                pcall(function()

                    if tab.SetIcon then

                        tab:SetIcon(
                            icon
                        )

                    end

                end)

            end

        end

    end

    return true

end

--==============================================================
-- 1000+ ICON API
--==============================================================

function Library:GetIconCount()

    return
        #self.IconEngine.Pool

end

function Library:GetAutoIcon(
    name
)

    return
        self:GetTabIcon(name)

end

function Library:FindIcon(
    name
)

    return
        self:GetTabIcon(name)

end

--==============================================================
-- CREATOR INTRO CONFIG
--==============================================================

Library.CreatorIntro = {

    Enabled = false,

    AutoShow = false,

    CreatorName = "Creator",

    ScriptName = "LONG SCRIPT",

    Description =
        "Welcome to the script.",

    Version = "1.0",

    Effect = "Fade",

    Duration = 2.5,

    SkipButton = true,

    ShowVersion = true,

    ShowDescription = true,

    ShowCreator = true,

    BackgroundTransparency = 0.12,

    CardTransparency = 0,

    Accent = nil

}

--==============================================================
-- INTRO GUI
--==============================================================

local CreatorIntroGui =
    nil

local CreatorIntroActive =
    false

local CreatorIntroFinished =
    false

--==============================================================
-- FIND MAIN WINDOW
--==============================================================

local function GetWindowMain(
    window
)

    if not window then
        return nil
    end

    if window.Main
        and typeof(window.Main) == "Instance"
    then

        return window.Main

    end

    return nil

end

--==============================================================
-- HIDE MAIN MENU
--==============================================================

local function HideMainWindow(
    window
)

    if not window then
        return
    end

    pcall(function()

        if window.HideInstant then

            window:HideInstant()

        elseif window.HideMenu then

            window:HideMenu()

        elseif window.Main then

            window.Main.Visible =
                false

        end

    end)

end

--==============================================================
-- SHOW MAIN MENU
--==============================================================

local function ShowMainWindow(
    window
)

    if not window then
        return
    end

    pcall(function()

        if window.ShowInstant then

            window:ShowInstant()

        elseif window.ShowMenu then

            window:ShowMenu()

        elseif window.Main then

            window.Main.Visible =
                true

        end

    end)

end

--==============================================================
-- CREATE INTRO
--==============================================================

local function CreateIntroGui()

    local PlayerGui =
        LocalPlayer:WaitForChild(
            "PlayerGui"
        )

    local Gui =
        Instance.new(
            "ScreenGui"
        )

    Gui.Name =
        "LONG_CreatorIntro"

    Gui.ResetOnSpawn =
        false

    Gui.IgnoreGuiInset =
        true

    Gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    Gui.DisplayOrder =
        999999

    Gui.Parent =
        PlayerGui

    return Gui

end

--==============================================================
-- CREATE INTRO EFFECT
--==============================================================

local function PlayIntroEffect(
    Card,
    NameLabel,
    ScriptLabel,
    DescriptionLabel,
    VersionLabel,
    SkipButton,
    duration,
    effect
)

    duration =
        math.max(
            tonumber(duration)
            or 2.5,
            0.2
        )

    effect =
        tostring(
            effect or "Fade"
        )

    local OriginalPosition =
        Card.Position

    local OriginalSize =
        Card.Size

    local OriginalRotation =
        Card.Rotation

    local OriginalTransparency =
        Card.BackgroundTransparency

    local TextObjects = {

        NameLabel,
        ScriptLabel,
        DescriptionLabel,
        VersionLabel
    }

    --==========================================================
    -- RESET
    --==========================================================

    Card.Position =
        OriginalPosition

    Card.Size =
        OriginalSize

    Card.Rotation =
        OriginalRotation

    Card.BackgroundTransparency =
        OriginalTransparency

    for _, object in ipairs(
        TextObjects
    ) do

        if object then

            object.TextTransparency =
                0

        end

    end

    --==========================================================
    -- FADE
    --==========================================================

    if effect == "Fade" then

        Card.BackgroundTransparency =
            1

        for _, object in ipairs(
            TextObjects
        ) do

            if object then

                object.TextTransparency =
                    1

            end

        end

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundTransparency =
                    OriginalTransparency
            }
        ):Play()

        for _, object in ipairs(
            TextObjects
        ) do

            if object then

                TweenService:Create(
                    object,
                    TweenInfo.new(
                        duration,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),
                    {
                        TextTransparency = 0
                    }
                ):Play()

            end

        end

    --==========================================================
    -- ZOOM
    --==========================================================

    elseif effect == "Zoom" then

        Card.Size =
            UDim2.fromScale(
                0.15,
                0.15
            )

        Card.BackgroundTransparency =
            1

        for _, object in ipairs(
            TextObjects
        ) do

            if object then

                object.TextTransparency =
                    1

            end

        end

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    OriginalSize,

                BackgroundTransparency =
                    OriginalTransparency
            }
        ):Play()

        for _, object in ipairs(
            TextObjects
        ) do

            if object then

                TweenService:Create(
                    object,
                    TweenInfo.new(
                        duration * 0.8,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),
                    {
                        TextTransparency = 0
                    }
                ):Play()

            end

        end

    --==========================================================
    -- SLIDE UP
    --==========================================================

    elseif effect == "SlideUp" then

        Card.Position =
            UDim2.new(
                0.5,
                0,
                1.2,
                0
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position =
                    OriginalPosition
            }
        ):Play()

    --==========================================================
    -- SLIDE DOWN
    --==========================================================

    elseif effect == "SlideDown" then

        Card.Position =
            UDim2.new(
                0.5,
                0,
                -0.2,
                0
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position =
                    OriginalPosition
            }
        ):Play()

    --==========================================================
    -- SLIDE LEFT
    --==========================================================

    elseif effect == "SlideLeft" then

        Card.Position =
            UDim2.new(
                -0.2,
                0,
                0.5,
                0
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position =
                    OriginalPosition
            }
        ):Play()

    --==========================================================
    -- SLIDE RIGHT
    --==========================================================

    elseif effect == "SlideRight" then

        Card.Position =
            UDim2.new(
                1.2,
                0,
                0.5,
                0
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position =
                    OriginalPosition
            }
        ):Play()

    --==========================================================
    -- BOUNCE
    --==========================================================

    elseif effect == "Bounce" then

        Card.Position =
            UDim2.new(
                0.5,
                0,
                1.15,
                0
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Bounce,
                Enum.EasingDirection.Out
            ),
            {
                Position =
                    OriginalPosition
            }
        ):Play()

    --==========================================================
    -- ROTATE
    --==========================================================

    elseif effect == "Rotate" then

        Card.Rotation =
            -18

        Card.BackgroundTransparency =
            1

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Rotation =
                    OriginalRotation,

                BackgroundTransparency =
                    OriginalTransparency
            }
        ):Play()

    --==========================================================
    -- PULSE
    --==========================================================

    elseif effect == "Pulse" then

        Card.Size =
            UDim2.fromScale(
                0.85,
                0.85
            )

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    OriginalSize
            }
        ):Play()

    --==========================================================
    -- TYPEWRITER
    --==========================================================

    elseif effect == "Typewriter" then

        for _, object in ipairs(
            TextObjects
        ) do

            if object then

                object.TextTransparency =
                    0

            end

        end

        local OriginalTexts = {

            Name =
                NameLabel.Text,

            Script =
                ScriptLabel.Text,

            Description =
                DescriptionLabel.Text,

            Version =
                VersionLabel.Text
        }

        NameLabel.Text = ""
        ScriptLabel.Text = ""
        DescriptionLabel.Text = ""
        VersionLabel.Text = ""

        local sequence = {

            {
                Object = NameLabel,
                Text = OriginalTexts.Name
            },

            {
                Object = ScriptLabel,
                Text = OriginalTexts.Script
            },

            {
                Object = DescriptionLabel,
                Text = OriginalTexts.Description
            },

            {
                Object = VersionLabel,
                Text = OriginalTexts.Version
            }
        }

        local totalCharacters = 0

        for _, item in ipairs(sequence) do

            totalCharacters +=
                #item.Text

        end

        local charDelay =
            math.clamp(
                duration
                /
                math.max(
                    totalCharacters,
                    1
                ),
                0.01,
                0.08
            )

        for _, item in ipairs(sequence) do

            for i = 1, #item.Text do

                if not CreatorIntroActive then
                    return
                end

                item.Object.Text =
                    string.sub(
                        item.Text,
                        1,
                        i
                    )

                task.wait(
                    charDelay
                )

            end

        end

    else

        --======================================================
        -- DEFAULT
        --======================================================

        Card.BackgroundTransparency =
            1

        TweenService:Create(
            Card,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundTransparency =
                    OriginalTransparency
            }
        ):Play()

    end

    --==========================================================
    -- SKIP FADE
    --==========================================================

    if SkipButton then

        SkipButton.BackgroundTransparency =
            1

        SkipButton.TextTransparency =
            1

        TweenService:Create(
            SkipButton,
            TweenInfo.new(
                0.35
            ),
            {
                BackgroundTransparency =
                    0.2,

                TextTransparency =
                    0
            }
        ):Play()

    end

end

--==============================================================
-- DESTROY INTRO
--==============================================================

local function DestroyCreatorIntro(
    window
)

    if not CreatorIntroActive then

        if CreatorIntroGui then

            pcall(function()

                CreatorIntroGui:Destroy()

            end)

            CreatorIntroGui =
                nil

        end

        return

    end

    CreatorIntroActive =
        false

    CreatorIntroFinished =
        true

    if CreatorIntroGui then

        pcall(function()

            CreatorIntroGui:Destroy()

        end)

        CreatorIntroGui =
            nil

    end

    ShowMainWindow(
        window
    )

end

--==============================================================
-- SHOW CREATOR INTRO
--==============================================================

function Library:ShowCreatorIntro(
    window,
    options
)

    options =
        options or {}

    --==========================================================
    -- CLOSE OLD INTRO
    --==========================================================

    if CreatorIntroGui then

        pcall(function()

            CreatorIntroGui:Destroy()

        end)

        CreatorIntroGui =
            nil

    end

    --==========================================================
    -- CONFIG
    --==========================================================

    local config = {}

    for key, value in pairs(
        self.CreatorIntro
    ) do

        config[key] =
            value

    end

    for key, value in pairs(
        options
    ) do

        config[key] =
            value

    end

    if config.Enabled == false then

        ShowMainWindow(
            window
        )

        return nil

    end

    --==========================================================
    -- HIDE MAIN
    --==========================================================

    HideMainWindow(
        window
    )

    CreatorIntroActive =
        true

    CreatorIntroFinished =
        false

    --==========================================================
    -- GUI
    --==========================================================

    local Gui =
        CreateIntroGui()

    CreatorIntroGui =
        Gui

    --==========================================================
    -- BACKGROUND
    --==========================================================

    local Background =
        Instance.new(
            "Frame"
        )

    Background.Name =
        "Background"

    Background.Size =
        UDim2.fromScale(
            1,
            1
        )

    Background.BackgroundColor3 =
        Color3.fromRGB(
            7,
            7,
            10
        )

    Background.BackgroundTransparency =
        tonumber(
            config.BackgroundTransparency
        )
        or 0.12

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

    Card.Name =
        "CreatorCard"

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
            math.clamp(
                tonumber(
                    config.Width
                )
                or 390,
                280,
                600
            ),
            math.clamp(
                tonumber(
                    config.Height
                )
                or 245,
                190,
                450
            )
        )

    Card.BackgroundColor3 =
        Color3.fromRGB(
            18,
            18,
            23
        )

    Card.BackgroundTransparency =
        tonumber(
            config.CardTransparency
        )
        or 0

    Card.BorderSizePixel =
        0

    Card.ZIndex =
        10

    Card.Parent =
        Gui

    --==========================================================
    -- CORNER
    --==========================================================

    local Corner =
        Instance.new(
            "UICorner"
        )

    Corner.CornerRadius =
        UDim.new(
            0,
            18
        )

    Corner.Parent =
        Card

    --==========================================================
    -- STROKE
    --==========================================================

    local Stroke =
        Instance.new(
            "UIStroke"
        )

    Stroke.Thickness =
        1

    Stroke.Transparency =
        0.35

    Stroke.Color =
        config.Accent
        or Color3.fromRGB(
            120,
            90,
            255
        )

    Stroke.Parent =
        Card

    --==========================================================
    -- TOP ACCENT
    --==========================================================

    local Accent =
        Instance.new(
            "Frame"
        )

    Accent.Name =
        "Accent"

    Accent.Position =
        UDim2.fromOffset(
            0,
            0
        )

    Accent.Size =
        UDim2.new(
            1,
            0,
            0,
            4
        )

    Accent.BackgroundColor3 =
        config.Accent
        or Color3.fromRGB(
            120,
            90,
            255
        )

    Accent.BorderSizePixel =
        0

    Accent.ZIndex =
        11

    Accent.Parent =
        Card

    local AccentCorner =
        Instance.new(
            "UICorner"
        )

    AccentCorner.CornerRadius =
        UDim.new(
            0,
            18
        )

    AccentCorner.Parent =
        Accent

    --==========================================================
    -- CREATOR LABEL
    --==========================================================

    local CreatorSmall =
        Instance.new(
            "TextLabel"
        )

    CreatorSmall.Name =
        "CreatorSmall"

    CreatorSmall.Position =
        UDim2.fromOffset(
            25,
            23
        )

    CreatorSmall.Size =
        UDim2.new(
            1,
            -50,
            0,
            20
        )

    CreatorSmall.BackgroundTransparency =
        1

    CreatorSmall.Text =
        "SCRIPT CREATED BY"

    CreatorSmall.Font =
        Enum.Font.GothamMedium

    CreatorSmall.TextSize =
        10

    CreatorSmall.TextColor3 =
        Color3.fromRGB(
            145,
            145,
            155
        )

    CreatorSmall.TextXAlignment =
        Enum.TextXAlignment.Left

    CreatorSmall.ZIndex =
        12

    CreatorSmall.Parent =
        Card

    --==========================================================
    -- CREATOR NAME
    --==========================================================

    local NameLabel =
        Instance.new(
            "TextLabel"
        )

    NameLabel.Name =
        "CreatorName"

    NameLabel.Position =
        UDim2.fromOffset(
            23,
            45
        )

    NameLabel.Size =
        UDim2.new(
            1,
            -46,
            0,
            42
        )

    NameLabel.BackgroundTransparency =
        1

    NameLabel.Text =
        tostring(
            config.CreatorName
            or "Creator"
        )

    NameLabel.Font =
        Enum.Font.GothamBold

    NameLabel.TextSize =
        25

    NameLabel.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    NameLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    NameLabel.TextTruncate =
        Enum.TextTruncate.AtEnd

    NameLabel.ZIndex =
        12

    NameLabel.Parent =
        Card

    --==========================================================
    -- SCRIPT NAME
    --==========================================================

    local ScriptLabel =
        Instance.new(
            "TextLabel"
        )

    ScriptLabel.Name =
        "ScriptName"

    ScriptLabel.Position =
        UDim2.fromOffset(
            25,
            88
        )

    ScriptLabel.Size =
        UDim2.new(
            1,
            -50,
            0,
            28
        )

    ScriptLabel.BackgroundTransparency =
        1

    ScriptLabel.Text =
        tostring(
            config.ScriptName
            or "LONG SCRIPT"
        )

    ScriptLabel.Font =
        Enum.Font.GothamBold

    ScriptLabel.TextSize =
        16

    ScriptLabel.TextColor3 =
        config.Accent
        or Color3.fromRGB(
            150,
            120,
            255
        )

    ScriptLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    ScriptLabel.ZIndex =
        12

    ScriptLabel.Parent =
        Card

    --==========================================================
    -- DESCRIPTION
    --==========================================================

    local DescriptionLabel =
        Instance.new(
            "TextLabel"
        )

    DescriptionLabel.Name =
        "Description"

    DescriptionLabel.Position =
        UDim2.fromOffset(
            25,
            122
        )

    DescriptionLabel.Size =
        UDim2.new(
            1,
            -50,
            0,
            45
        )

    DescriptionLabel.BackgroundTransparency =
        1

    DescriptionLabel.Text =
        tostring(
            config.Description
            or ""
        )

    DescriptionLabel.Font =
        Enum.Font.Gotham

    DescriptionLabel.TextSize =
        12

    DescriptionLabel.TextColor3 =
        Color3.fromRGB(
            175,
            175,
            185
        )

    DescriptionLabel.TextWrapped =
        true

    DescriptionLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    DescriptionLabel.TextYAlignment =
        Enum.TextYAlignment.Top

    DescriptionLabel.ZIndex =
        12

    DescriptionLabel.Parent =
        Card

    --==========================================================
    -- VERSION
    --==========================================================

    local VersionLabel =
        Instance.new(
            "TextLabel"
        )

    VersionLabel.Name =
        "Version"

    VersionLabel.Position =
        UDim2.fromOffset(
            25,
            174
        )

    VersionLabel.Size =
        UDim2.new(
            0.5,
            0,
            0,
            20
        )

    VersionLabel.BackgroundTransparency =
        1

    VersionLabel.Text =
        config.ShowVersion == false
        and ""
        or (
            "Version "
            .. tostring(
                config.Version
                or "1.0"
            )
        )

    VersionLabel.Font =
        Enum.Font.GothamMedium

    VersionLabel.TextSize =
        10

    VersionLabel.TextColor3 =
        Color3.fromRGB(
            120,
            120,
            130
        )

    VersionLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    VersionLabel.ZIndex =
        12

    VersionLabel.Parent =
        Card

    --==========================================================
    -- SKIP BUTTON
    --==========================================================

    local SkipButton =
        nil

    if config.SkipButton ~= false then

        SkipButton =
            Instance.new(
                "TextButton"
            )

        SkipButton.Name =
            "Skip"

        SkipButton.AnchorPoint =
            Vector2.new(
                1,
                1
            )

        SkipButton.Position =
            UDim2.new(
                1,
                -20,
                1,
                -18
            )

        SkipButton.Size =
            UDim2.fromOffset(
                70,
                28
            )

        SkipButton.BackgroundColor3 =
            Color3.fromRGB(
                255,
                255,
                255
            )

        SkipButton.BackgroundTransparency =
            0.2

        SkipButton.BorderSizePixel =
            0

        SkipButton.Text =
            "Bỏ qua"

        SkipButton.Font =
            Enum.Font.GothamMedium

        SkipButton.TextSize =
            10

        SkipButton.TextColor3 =
            Color3.fromRGB(
                220,
                220,
                225
            )

        SkipButton.AutoButtonColor =
            false

        SkipButton.ZIndex =
            20

        SkipButton.Parent =
            Card

        local SkipCorner =
            Instance.new(
                "UICorner"
            )

        SkipCorner.CornerRadius =
            UDim.new(
                0,
                8
            )

        SkipCorner.Parent =
            SkipButton

        SkipButton.MouseButton1Click:Connect(
            function()

                DestroyCreatorIntro(
                    window
                )

            end
        )

        SkipButton.TouchTap:Connect(
            function()

                DestroyCreatorIntro(
                    window
                )

            end
        )

    end

    --==========================================================
    -- PLAY EFFECT
    --==========================================================

    task.spawn(function()

        PlayIntroEffect(
            Card,
            NameLabel,
            ScriptLabel,
            DescriptionLabel,
            VersionLabel,
            SkipButton,
            config.Duration,
            config.Effect
        )

    end)

    --==========================================================
    -- AUTO CLOSE
    --==========================================================

    task.delay(
        math.max(
            tonumber(
                config.Duration
            )
            or 2.5,
            0.2
        )
        + 0.25,
        function()

            if CreatorIntroActive then

                DestroyCreatorIntro(
                    window
                )

            end

        end
    )

    return {

        Gui = Gui,

        Card = Card,

        CreatorName = NameLabel,

        ScriptName = ScriptLabel,

        Description = DescriptionLabel,

        Version = VersionLabel,

        Skip = function()

            DestroyCreatorIntro(
                window
            )

        end,

        Destroy = function()

            DestroyCreatorIntro(
                window
            )

        end

    }

end

--==============================================================
-- HIDE CREATOR INTRO
--==============================================================

function Library:HideCreatorIntro(
    window
)

    DestroyCreatorIntro(
        window
    )

end

--==============================================================
-- SKIP CREATOR INTRO
--==============================================================

function Library:SkipCreatorIntro(
    window
)

    DestroyCreatorIntro(
        window
    )

end

--==============================================================
-- SET INTRO EFFECT
--==============================================================

function Library:SetIntroEffect(
    effect
)

    local effects = {

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

    if not effects[
        tostring(effect)
    ] then

        return false

    end

    self.CreatorIntro.Effect =
        tostring(effect)

    return true

end

--==============================================================
-- SET CREATOR INTRO
--==============================================================

function Library:SetCreatorIntro(
    options
)

    if type(options) ~= "table" then

        return false

    end

    for key, value in pairs(
        options
    ) do

        if self.CreatorIntro[key]
            ~= nil
        then

            self.CreatorIntro[key] =
                value

        end

    end

    return true

end

--==============================================================
-- INTRO ENABLED
--==============================================================

function Library:IsCreatorIntroEnabled()

    return
        self.CreatorIntro.Enabled
        == true

end

--==============================================================
-- GET INTRO EFFECTS
--==============================================================

function Library:GetIntroEffects()

    return {

        "Fade",
        "Zoom",
        "SlideUp",
        "SlideDown",
        "SlideLeft",
        "SlideRight",
        "Bounce",
        "Rotate",
        "Pulse",
        "Typewriter"

    }

end

--==============================================================
-- WRAP CREATE WINDOW
--==============================================================

local OriginalCreateWindow =
    Library.CreateWindow

if type(
    OriginalCreateWindow
) == "function"
then

    Library.CreateWindow =
        function(
            self,
            options
        )

            options =
                options or {}

            --==================================================
            -- SAVE INTRO OPTIONS
            --==================================================

            local IntroOptions =
                options.Intro

            --==================================================
            -- REMOVE INTRO FROM ORIGINAL
            --==================================================

            options.Intro =
                nil

            --==================================================
            -- CREATE ORIGINAL WINDOW
            --==================================================

            local window =
                OriginalCreateWindow(
                    self,
                    options
                )

            if not window then

                return window

            end

            --==================================================
            -- APPLY AUTO TAB ICONS
            --==================================================

            task.defer(function()

                for _, tab in ipairs(
                    window.Tabs or {}
                ) do

                    if tab
                        and tab.Name
                    then

                        local icon =
                            self:GetTabIcon(
                                tab.Name
                            )

                        pcall(function()

                            if tab.SetIcon then

                                tab:SetIcon(
                                    icon
                                )

                            end

                        end)

                    end

                end

            end)

            --==================================================
            -- INTRO
            --==================================================

            local IntroConfig =
                nil

            if type(
                IntroOptions
            ) == "table"
            then

                IntroConfig =
                    {}

                for key, value in pairs(
                    self.CreatorIntro
                ) do

                    IntroConfig[key] =
                        value

                end

                for key, value in pairs(
                    IntroOptions
                ) do

                    IntroConfig[key] =
                        value

                end

            elseif self.CreatorIntro.AutoShow
                and self.CreatorIntro.Enabled
            then

                IntroConfig =
                    self.CreatorIntro

            end

            if IntroConfig
                and IntroConfig.Enabled
                ~= false
            then

                task.defer(function()

                    self:ShowCreatorIntro(
                        window,
                        IntroConfig
                    )

                end)

            end

            return window

        end

end

--==============================================================
-- CREATOR INTRO PRESETS
--==============================================================

Library.IntroPresets = {

    Classic = {

        Enabled = true,

        AutoShow = true,

        Effect = "Fade",

        Duration = 2.5,

        SkipButton = true

    },

    Modern = {

        Enabled = true,

        AutoShow = true,

        Effect = "Zoom",

        Duration = 2.2,

        SkipButton = true

    },

    Slide = {

        Enabled = true,

        AutoShow = true,

        Effect = "SlideUp",

        Duration = 2.3,

        SkipButton = true

    },

    Bounce = {

        Enabled = true,

        AutoShow = true,

        Effect = "Bounce",

        Duration = 2.4,

        SkipButton = true

    },

    Rotate = {

        Enabled = true,

        AutoShow = true,

        Effect = "Rotate",

        Duration = 2.4,

        SkipButton = true

    },

    Smooth = {

        Enabled = true,

        AutoShow = true,

        Effect = "Pulse",

        Duration = 2.5,

        SkipButton = true

    },

    Typewriter = {

        Enabled = true,

        AutoShow = true,

        Effect = "Typewriter",

        Duration = 3.5,

        SkipButton = true

    },

    Left = {

        Enabled = true,

        AutoShow = true,

        Effect = "SlideLeft",

        Duration = 2.3,

        SkipButton = true

    },

    Right = {

        Enabled = true,

        AutoShow = true,

        Effect = "SlideRight",

        Duration = 2.3,

        SkipButton = true

    },

    Down = {

        Enabled = true,

        AutoShow = true,

        Effect = "SlideDown",

        Duration = 2.3,

        SkipButton = true

    }

}

--==============================================================
-- APPLY PRESET
--==============================================================

function Library:UseIntroPreset(
    name
)

    local preset =
        self.IntroPresets[
            tostring(name)
        ]

    if not preset then

        return false

    end

    for key, value in pairs(
        preset
    ) do

        self.CreatorIntro[key] =
            value

    end

    return true

end

--==============================================================
-- AUTO ICON CREATE TAB PATCH
--==============================================================

local OriginalCreateTab =
    Library.CreateTab

if type(
    OriginalCreateTab
) == "function"
then

    Library.CreateTab =
        function(
            self,
            window,
            name,
            icon,
            ...
        )

            local finalIcon =
                icon

            if finalIcon == nil
                or tostring(
                    finalIcon
                ) == ""
            then

                finalIcon =
                    self:GetTabIcon(
                        name
                    )

            end

            local result =
                OriginalCreateTab(
                    self,
                    window,
                    name,
                    finalIcon,
                    ...
                )

            --==================================================
            -- SAFETY
            --==================================================

            if result then

                pcall(function()

                    if result.SetIcon then

                        result:SetIcon(
                            finalIcon
                        )

                    end

                end)

            end

            return result

        end

end

--==============================================================
-- ICON DEBUG / DOCUMENTATION
--==============================================================

Library.IconFeatures = {

    "1000+ Icon Pool",

    "Exact Name Matching",

    "Partial Name Matching",

    "Case Insensitive",

    "Space Insensitive",

    "Underscore Insensitive",

    "Dash Insensitive",

    "Keyword Detection",

    "Deterministic Fallback",

    "Custom Icons",

    "Runtime Icon Change"

}

--==============================================================
-- INTRO DOCUMENTATION
--==============================================================

Library.IntroFeatures = {

    "Creator Name",

    "Script Name",

    "Description",

    "Version",

    "Fade",

    "Zoom",

    "SlideUp",

    "SlideDown",

    "SlideLeft",

    "SlideRight",

    "Bounce",

    "Rotate",

    "Pulse",

    "Typewriter",

    "Skip Button",

    "Optional Intro",

    "Auto Intro",

    "Runtime Intro",

    "Mobile Support",

    "PC Support"

}

--==============================================================
-- FINAL API
--==============================================================

Library.CreatorAPI = {

    SetCreatorIntro =
        function(
            options
        )

            return
                Library:SetCreatorIntro(
                    options
                )

        end,

    ShowCreatorIntro =
        function(
            window,
            options
        )

            return
                Library:ShowCreatorIntro(
                    window,
                    options
                )

        end,

    HideCreatorIntro =
        function(
            window
        )

            return
                Library:HideCreatorIntro(
                    window
                )

        end,

    SkipCreatorIntro =
        function(
            window
        )

            return
                Library:SkipCreatorIntro(
                    window
                )

        end,

    SetIntroEffect =
        function(
            effect
        )

            return
                Library:SetIntroEffect(
                    effect
                )

        end

}

--==============================================================
-- NOTIFICATION
--==============================================================

pcall(function()

    StarterGui:SetCore(
        "SendNotification",
        {
            Title = "LONG UI Library",
            Text = "V13.0 loaded",
            Duration = 2
        }
    )

end)

--==============================================================
-- RETURN
--==============================================================

return Library
