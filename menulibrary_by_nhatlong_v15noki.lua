--[[
================================================================
                    LONG UI LIBRARY V12.0
================================================================
                    MODERN ROBLOX UI LIBRARY
================================================================

FEATURES
----------------------------------------------------------------
✓ 100+ automatic tab icons
✓ Smart icon detection by tab name
✓ Custom tab icon
✓ Library main menu
✓ Optional GetKey / Key System
✓ Custom GetKey UI without removing Library UI
✓ Dark / Purple / Blue / Red / Green / Light themes
✓ Glass / Transparent mode
✓ Accent presets
✓ RGB Accent
✓ 7 languages
✓ English
✓ Vietnamese
✓ Chinese
✓ Japanese
✓ Korean
✓ Spanish
✓ French
✓ Menu Width / Height
✓ Sidebar Width
✓ UI Scale
✓ Transparency
✓ Corner Radius
✓ Animation Speed
✓ Search
✓ Notification
✓ Toggle
✓ Button
✓ Slider
✓ Dropdown
✓ Multi Dropdown
✓ Textbox
✓ Keybind
✓ Hide / Show
✓ Instant Hide / Show
✓ Position API
✓ Center API
✓ Clamp Position
✓ PC + Mobile drag
✓ Touch support
✓ Close confirmation
✓ Setting always LAST
✓ Responsive viewport
✓ Automatic screen fitting
✓ Custom UI configuration
✓ Reset settings
✓ Theme refresh
✓ Accent refresh
✓ Language refresh
✓ Cleanup / Destroy
✓ No automatic floating button
================================================================
]]

--==============================================================
-- SERVICES
--==============================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local TextService = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- LIBRARY
--==============================================================

local Library = {}

Library.Version = "12.0"
Library.Name = "LONG UI LIBRARY"

Library.Windows = {}
Library.Values = {}

--==============================================================
-- DEFAULT SETTINGS
--==============================================================

Library.Settings = {

    -- Smaller default menu
    MenuWidth = 507,
    MenuHeight = 384,

    SidebarWidth = 145,

    UIScale = 100,

    CornerRadius = 10,

    AnimationSpeed = 18,

    Transparency = 57,

    GlassMode = false,

    TabSearch = true,

    Notifications = true,

    Dragging = true,

    CloseConfirmation = true,

    ShowTabIcons = true,

    AutoFitScreen = true,

    AccentPreset = "Purple",

    ThemePreset = "Purple",

    Language = "Vietnamese",

    Font = "Gotham",

}

--==============================================================
-- DEFAULT SETTINGS COPY
--==============================================================

local DefaultSettings = {}

for key, value in pairs(Library.Settings) do
    DefaultSettings[key] = value
end

--==============================================================
-- THEMES
--==============================================================

Library.ThemePresets = {

    Purple = {
        Background = Color3.fromRGB(22, 22, 30),
        Secondary = Color3.fromRGB(27, 27, 37),
        Tertiary = Color3.fromRGB(34, 34, 46),
        Border = Color3.fromRGB(67, 67, 82),
        Accent = Color3.fromRGB(145, 80, 255),
        Text = Color3.fromRGB(245, 245, 250),
        SubText = Color3.fromRGB(165, 165, 180),
        On = Color3.fromRGB(85, 220, 130),
        Off = Color3.fromRGB(85, 85, 100),
        SliderBackground = Color3.fromRGB(50, 50, 65),
        Danger = Color3.fromRGB(235, 70, 80),
    },

    Blue = {
        Background = Color3.fromRGB(18, 22, 30),
        Secondary = Color3.fromRGB(23, 28, 40),
        Tertiary = Color3.fromRGB(30, 36, 50),
        Border = Color3.fromRGB(55, 70, 95),
        Accent = Color3.fromRGB(65, 145, 255),
        Text = Color3.fromRGB(245, 248, 255),
        SubText = Color3.fromRGB(165, 175, 195),
        On = Color3.fromRGB(80, 220, 130),
        Off = Color3.fromRGB(80, 90, 105),
        SliderBackground = Color3.fromRGB(45, 55, 75),
        Danger = Color3.fromRGB(235, 70, 80),
    },

    Red = {
        Background = Color3.fromRGB(28, 18, 20),
        Secondary = Color3.fromRGB(38, 22, 25),
        Tertiary = Color3.fromRGB(50, 27, 30),
        Border = Color3.fromRGB(90, 50, 55),
        Accent = Color3.fromRGB(235, 65, 80),
        Text = Color3.fromRGB(255, 245, 245),
        SubText = Color3.fromRGB(195, 165, 170),
        On = Color3.fromRGB(80, 220, 130),
        Off = Color3.fromRGB(100, 70, 75),
        SliderBackground = Color3.fromRGB(70, 40, 45),
        Danger = Color3.fromRGB(255, 70, 70),
    },

    Green = {
        Background = Color3.fromRGB(18, 28, 23),
        Secondary = Color3.fromRGB(22, 38, 29),
        Tertiary = Color3.fromRGB(28, 50, 37),
        Border = Color3.fromRGB(50, 90, 65),
        Accent = Color3.fromRGB(70, 210, 125),
        Text = Color3.fromRGB(242, 255, 247),
        SubText = Color3.fromRGB(165, 195, 175),
        On = Color3.fromRGB(80, 225, 130),
        Off = Color3.fromRGB(70, 100, 80),
        SliderBackground = Color3.fromRGB(42, 70, 52),
        Danger = Color3.fromRGB(235, 70, 80),
    },

    Dark = {
        Background = Color3.fromRGB(12, 12, 14),
        Secondary = Color3.fromRGB(18, 18, 21),
        Tertiary = Color3.fromRGB(25, 25, 29),
        Border = Color3.fromRGB(48, 48, 54),
        Accent = Color3.fromRGB(150, 150, 160),
        Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(150, 150, 155),
        On = Color3.fromRGB(80, 210, 120),
        Off = Color3.fromRGB(65, 65, 70),
        SliderBackground = Color3.fromRGB(42, 42, 47),
        Danger = Color3.fromRGB(225, 65, 75),
    },

    Light = {
        Background = Color3.fromRGB(242, 243, 247),
        Secondary = Color3.fromRGB(250, 250, 252),
        Tertiary = Color3.fromRGB(232, 233, 239),
        Border = Color3.fromRGB(205, 207, 216),
        Accent = Color3.fromRGB(125, 75, 230),
        Text = Color3.fromRGB(30, 30, 35),
        SubText = Color3.fromRGB(105, 106, 115),
        On = Color3.fromRGB(45, 185, 95),
        Off = Color3.fromRGB(175, 177, 185),
        SliderBackground = Color3.fromRGB(210, 212, 220),
        Danger = Color3.fromRGB(220, 60, 70),
    },

}

Library.Theme = {}

for key, value in pairs(Library.ThemePresets.Purple) do
    Library.Theme[key] = value
end

Library.Theme.Transparency = 0.57

--==============================================================
-- ACCENT PRESETS
--==============================================================

Library.AccentPresets = {

    Purple = Color3.fromRGB(145, 80, 255),

    Blue = Color3.fromRGB(65, 145, 255),

    Red = Color3.fromRGB(235, 65, 80),

    Green = Color3.fromRGB(70, 210, 125),

    White = Color3.fromRGB(245, 245, 245),

    Black = Color3.fromRGB(25, 25, 28),

    Yellow = Color3.fromRGB(245, 190, 55),

    Cyan = Color3.fromRGB(60, 210, 220),

    Pink = Color3.fromRGB(255, 85, 170),

    Orange = Color3.fromRGB(255, 145, 55),

}

--==============================================================
-- 100+ ICONS
--==============================================================

Library.Icons = {

    Home = "⌂",
    House = "⌂",
    Player = "●",
    Players = "♟",
    User = "●",
    Character = "♙",
    Combat = "⚔",
    Sword = "⚔",
    Weapon = "⚔",
    Gun = "⌁",
    Aim = "◎",
    Target = "◎",
    Kill = "☠",
    Damage = "✚",
    Defense = "♜",
    Shield = "⬟",
    Health = "♥",
    Heart = "♥",
    Movement = "➤",
    Speed = "➤",
    Fly = "✈",
    Flight = "✈",
    Jump = "↑",
    Walk = "➜",
    Teleport = "⌖",
    Position = "⌖",
    World = "◎",
    Map = "▧",
    Location = "⌖",
    Visual = "◉",
    ESP = "◉",
    Display = "▣",
    Camera = "▣",
    Graphics = "▤",
    Render = "▤",
    Effects = "✦",
    Item = "◇",
    Items = "◇",
    Inventory = "▦",
    Backpack = "▦",
    Shop = "$",
    Store = "$",
    Money = "$",
    Cash = "$",
    Coin = "●",
    Bank = "▣",
    Farm = "♨",
    Farming = "♨",
    AutoFarm = "♨",
    Collect = "✦",
    Quest = "?",
    Mission = "!",
    Task = "✓",
    Event = "★",
    Events = "★",
    Pet = "♣",
    Pets = "♣",
    Vehicle = "▰",
    Car = "▰",
    Boat = "≈",
    House2 = "⌂",
    Base = "▣",
    Server = "▤",
    Servers = "▤",
    Admin = "♛",
    Moderation = "♛",
    Script = "⌘",
    Scripts = "⌘",
    Code = "</>",
    Developer = "</>",
    Console = "▤",
    Debug = "⚙",
    Settings = "⚙",
    Setting = "⚙",
    Config = "⚙",
    Configuration = "⚙",
    Theme = "◐",
    Color = "◈",
    Language = "文",
    Key = "⚿",
    Security = "⚿",
    Lock = "▣",
    Unlock = "□",
    Discord = "◈",
    Community = "♟",
    Friends = "♟",
    Social = "♟",
    Chat = "☏",
    Message = "☏",
    Notification = "●",
    Notifications = "●",
    Music = "♫",
    Sound = "♫",
    Audio = "♫",
    Video = "▶",
    Time = "◷",
    Clock = "◷",
    Day = "☀",
    Night = "☾",
    Weather = "☁",
    Performance = "↯",
    FPS = "↯",
    Network = "⌁",
    Internet = "⌁",
    Utility = "⚒",
    Utilities = "⚒",
    Tools = "⚒",
    Misc = "✦",
    Miscellaneous = "✦",
    Information = "ⓘ",
    Info = "ⓘ",
    Help = "?",
    About = "ⓘ",
    Logs = "▤",
    History = "◴",
    Favorites = "★",
    Star = "★",
    Premium = "♛",
    VIP = "♛",
    Rank = "♜",
    Level = "▲",
    Skills = "✧",
    Ability = "✧",
    Abilities = "✧",
    Magic = "✧",
    Anime = "✦",
    Dungeon = "▣",
    Boss = "♛",
    Raid = "⚔",
    PvP = "⚔",
    PvE = "⚔",
    AntiAFK = "◉",
    AFK = "◉",
    Rejoin = "↻",
    Refresh = "↻",
    Reload = "↻",
    Close = "×",
    Search = "⌕",
    Filter = "≡",
    Menu = "☰",
    Home2 = "⌂",

}

--==============================================================
-- SMART ICON KEYWORDS
--==============================================================

local IconKeywords = {

    {"setting", "⚙"},
    {"config", "⚙"},
    {"setup", "⚙"},
    {"home", "⌂"},
    {"main", "⌂"},
    {"player", "●"},
    {"character", "♙"},
    {"combat", "⚔"},
    {"weapon", "⚔"},
    {"sword", "⚔"},
    {"fight", "⚔"},
    {"aim", "◎"},
    {"target", "◎"},
    {"esp", "◉"},
    {"visual", "◉"},
    {"display", "▣"},
    {"camera", "▣"},
    {"graphic", "▤"},
    {"render", "▤"},
    {"movement", "➤"},
    {"move", "➤"},
    {"speed", "➤"},
    {"fly", "✈"},
    {"flight", "✈"},
    {"teleport", "⌖"},
    {"tp", "⌖"},
    {"world", "◎"},
    {"map", "▧"},
    {"location", "⌖"},
    {"item", "◇"},
    {"inventory", "▦"},
    {"backpack", "▦"},
    {"shop", "$"},
    {"store", "$"},
    {"money", "$"},
    {"cash", "$"},
    {"coin", "●"},
    {"farm", "♨"},
    {"auto farm", "♨"},
    {"quest", "?"},
    {"mission", "!"},
    {"task", "✓"},
    {"event", "★"},
    {"pet", "♣"},
    {"vehicle", "▰"},
    {"car", "▰"},
    {"boat", "≈"},
    {"server", "▤"},
    {"admin", "♛"},
    {"script", "⌘"},
    {"code", "</>"},
    {"developer", "</>"},
    {"console", "▤"},
    {"debug", "⚙"},
    {"theme", "◐"},
    {"color", "◈"},
    {"language", "文"},
    {"ngôn ngữ", "文"},
    {"key", "⚿"},
    {"security", "⚿"},
    {"lock", "▣"},
    {"discord", "◈"},
    {"community", "♟"},
    {"friend", "♟"},
    {"social", "♟"},
    {"chat", "☏"},
    {"message", "☏"},
    {"notification", "●"},
    {"music", "♫"},
    {"sound", "♫"},
    {"audio", "♫"},
    {"video", "▶"},
    {"time", "◷"},
    {"clock", "◷"},
    {"weather", "☁"},
    {"performance", "↯"},
    {"fps", "↯"},
    {"network", "⌁"},
    {"utility", "⚒"},
    {"tool", "⚒"},
    {"misc", "✦"},
    {"help", "?"},
    {"info", "ⓘ"},
    {"about", "ⓘ"},
    {"history", "◴"},
    {"favorite", "★"},
    {"premium", "♛"},
    {"vip", "♛"},
    {"rank", "♜"},
    {"level", "▲"},
    {"skill", "✧"},
    {"ability", "✧"},
    {"magic", "✧"},
    {"anime", "✦"},
    {"dungeon", "▣"},
    {"boss", "♛"},
    {"raid", "⚔"},
    {"pvp", "⚔"},
    {"pve", "⚔"},
    {"afk", "◉"},
    {"rejoin", "↻"},
    {"refresh", "↻"},
    {"search", "⌕"},

}

--==============================================================
-- GET TAB ICON
--==============================================================

function Library:GetTabIcon(name)

    name = tostring(name or "")
    
    if self.Icons[name] then
        return self.Icons[name]
    end

    local lower = string.lower(name)

    for _, data in ipairs(IconKeywords) do

        if string.find(lower, data[1], 1, true) then
            return data[2]
        end

    end

    return "◆"

end

--==============================================================
-- LANGUAGE SYSTEM
--==============================================================

Library.Languages = {

    English = {

        Search = "Search tab...",
        Settings = "Settings",
        Theme = "Theme",
        ThemePreset = "Theme Preset",
        Light = "Light",
        GlassMode = "Glass Mode",
        Transparency = "Transparency",
        AccentColor = "Accent Color",
        MenuSize = "Menu Size",
        MenuWidth = "Menu Width",
        MenuHeight = "Menu Height",
        SidebarWidth = "Sidebar Width",
        UIScale = "UI Scale",
        CornerRadius = "Corner Radius",
        AnimationSpeed = "Animation Speed",
        Behavior = "Behavior",
        TabSearch = "Tab Search",
        Notifications = "Notifications",
        Dragging = "Dragging",
        AutoFit = "Auto Fit Screen",
        ShowIcons = "Show Tab Icons",
        Language = "Language",
        CustomColors = "Custom Colors",
        RGB = "RGB",
        Reset = "Reset",
        ResetSettings = "Reset UI Settings",
        ResetTheme = "Reset Theme",
        Restore = "Restore Window",
        Hide = "Hide",
        Show = "Show",
        Close = "Close",
        Cancel = "Cancel",
        Confirm = "Confirm",
        CloseTitle = "Confirm Close",
        CloseMessage = "Are you sure you want to destroy this menu?",
        Destroyed = "Menu GUI destroyed.",
        GetKey = "Get Key",
        EnterKey = "Enter Key",
        Verify = "Verify",
        InvalidKey = "Invalid key.",
        ValidKey = "Key verified.",
        KeySystem = "Key System",
        Copy = "Copy",
        Success = "Success",
        Failed = "Failed",
        Library = "Library",
        Appearance = "Appearance",
        General = "General",
        Position = "Position",
        Center = "Center",
        ResetPosition = "Reset Position",
        Glass = "Glass / Transparent",
        On = "On",
        Off = "Off",

    },

    Vietnamese = {

        Search = "Tìm tab...",
        Settings = "Cài đặt",
        Theme = "Giao diện",
        ThemePreset = "Chủ đề",
        Light = "Sáng",
        GlassMode = "Chế độ kính",
        Transparency = "Độ trong suốt",
        AccentColor = "Màu nhấn",
        MenuSize = "Kích thước Menu",
        MenuWidth = "Menu Width",
        MenuHeight = "Menu Height",
        SidebarWidth = "Sidebar Width",
        UIScale = "Tỷ lệ giao diện",
        CornerRadius = "Bo góc",
        AnimationSpeed = "Tốc độ hiệu ứng",
        Behavior = "Hành vi",
        TabSearch = "Tìm kiếm Tab",
        Notifications = "Thông báo",
        Dragging = "Kéo Menu",
        AutoFit = "Tự động vừa màn hình",
        ShowIcons = "Hiện icon Tab",
        Language = "Ngôn ngữ",
        CustomColors = "Màu tùy chỉnh",
        RGB = "RGB",
        Reset = "Đặt lại",
        ResetSettings = "Đặt lại cài đặt",
        ResetTheme = "Đặt lại giao diện",
        Restore = "Mở lại Menu",
        Hide = "Ẩn",
        Show = "Mở",
        Close = "Đóng",
        Cancel = "Hủy",
        Confirm = "Xác nhận",
        CloseTitle = "Xác nhận đóng Menu",
        CloseMessage = "Bạn có chắc muốn đóng và destroy Menu GUI?",
        Destroyed = "Đã destroy Menu GUI.",
        GetKey = "Lấy Key",
        EnterKey = "Nhập Key",
        Verify = "Xác minh",
        InvalidKey = "Key không hợp lệ.",
        ValidKey = "Key hợp lệ.",
        KeySystem = "Hệ thống Key",
        Copy = "Sao chép",
        Success = "Thành công",
        Failed = "Thất bại",
        Library = "Library",
        Appearance = "Giao diện",
        General = "Chung",
        Position = "Vị trí",
        Center = "Căn giữa",
        ResetPosition = "Đặt lại vị trí",
        Glass = "Trong / Kính",
        On = "Bật",
        Off = "Tắt",

    },

    Chinese = {

        Search = "搜索标签...",
        Settings = "设置",
        Theme = "主题",
        ThemePreset = "主题预设",
        Light = "浅色",
        GlassMode = "玻璃模式",
        Transparency = "透明度",
        AccentColor = "强调色",
        MenuSize = "菜单大小",
        MenuWidth = "菜单宽度",
        MenuHeight = "菜单高度",
        SidebarWidth = "侧边栏宽度",
        UIScale = "界面缩放",
        CornerRadius = "圆角",
        AnimationSpeed = "动画速度",
        Behavior = "行为",
        TabSearch = "标签搜索",
        Notifications = "通知",
        Dragging = "拖动",
        AutoFit = "自动适应屏幕",
        ShowIcons = "显示标签图标",
        Language = "语言",
        CustomColors = "自定义颜色",
        RGB = "RGB",
        Reset = "重置",
        ResetSettings = "重置界面设置",
        ResetTheme = "重置主题",
        Restore = "恢复窗口",
        Hide = "隐藏",
        Show = "显示",
        Close = "关闭",
        Cancel = "取消",
        Confirm = "确认",
        CloseTitle = "确认关闭",
        CloseMessage = "确定要销毁菜单吗？",
        Destroyed = "菜单已销毁。",
        GetKey = "获取 Key",
        EnterKey = "输入 Key",
        Verify = "验证",
        InvalidKey = "Key 无效。",
        ValidKey = "Key 有效。",
        KeySystem = "Key 系统",
        Copy = "复制",
        Success = "成功",
        Failed = "失败",
        Library = "Library",
        Appearance = "外观",
        General = "常规",
        Position = "位置",
        Center = "居中",
        ResetPosition = "重置位置",
        Glass = "玻璃 / 透明",
        On = "开启",
        Off = "关闭",

    },

    Japanese = {

        Search = "タブを検索...",
        Settings = "設定",
        Theme = "テーマ",
        ThemePreset = "テーマプリセット",
        Light = "ライト",
        GlassMode = "ガラスモード",
        Transparency = "透明度",
        AccentColor = "アクセントカラー",
        MenuSize = "メニューサイズ",
        MenuWidth = "メニュー幅",
        MenuHeight = "メニュー高さ",
        SidebarWidth = "サイドバー幅",
        UIScale = "UIスケール",
        CornerRadius = "角の丸み",
        AnimationSpeed = "アニメーション速度",
        Behavior = "動作",
        TabSearch = "タブ検索",
        Notifications = "通知",
        Dragging = "ドラッグ",
        AutoFit = "画面に自動調整",
        ShowIcons = "タブアイコン",
        Language = "言語",
        CustomColors = "カスタムカラー",
        RGB = "RGB",
        Reset = "リセット",
        ResetSettings = "UI設定をリセット",
        ResetTheme = "テーマをリセット",
        Restore = "ウィンドウを復元",
        Hide = "隠す",
        Show = "表示",
        Close = "閉じる",
        Cancel = "キャンセル",
        Confirm = "確認",
        CloseTitle = "終了確認",
        CloseMessage = "メニューを削除しますか？",
        Destroyed = "メニューを削除しました。",
        GetKey = "Keyを取得",
        EnterKey = "Keyを入力",
        Verify = "確認",
        InvalidKey = "無効なKeyです。",
        ValidKey = "Keyを確認しました。",
        KeySystem = "Keyシステム",
        Copy = "コピー",
        Success = "成功",
        Failed = "失敗",
        Library = "Library",
        Appearance = "外観",
        General = "一般",
        Position = "位置",
        Center = "中央",
        ResetPosition = "位置をリセット",
        Glass = "ガラス / 透明",
        On = "オン",
        Off = "オフ",

    },

    Korean = {

        Search = "탭 검색...",
        Settings = "설정",
        Theme = "테마",
        ThemePreset = "테마 프리셋",
        Light = "라이트",
        GlassMode = "유리 모드",
        Transparency = "투명도",
        AccentColor = "강조 색상",
        MenuSize = "메뉴 크기",
        MenuWidth = "메뉴 너비",
        MenuHeight = "메뉴 높이",
        SidebarWidth = "사이드바 너비",
        UIScale = "UI 크기",
        CornerRadius = "모서리",
        AnimationSpeed = "애니메이션 속도",
        Behavior = "동작",
        TabSearch = "탭 검색",
        Notifications = "알림",
        Dragging = "드래그",
        AutoFit = "화면 자동 맞춤",
        ShowIcons = "탭 아이콘 표시",
        Language = "언어",
        CustomColors = "사용자 색상",
        RGB = "RGB",
        Reset = "초기화",
        ResetSettings = "UI 설정 초기화",
        ResetTheme = "테마 초기화",
        Restore = "창 복원",
        Hide = "숨기기",
        Show = "표시",
        Close = "닫기",
        Cancel = "취소",
        Confirm = "확인",
        CloseTitle = "닫기 확인",
        CloseMessage = "메뉴를 삭제하시겠습니까?",
        Destroyed = "메뉴가 삭제되었습니다.",
        GetKey = "Key 받기",
        EnterKey = "Key 입력",
        Verify = "확인",
        InvalidKey = "잘못된 Key입니다.",
        ValidKey = "Key가 확인되었습니다.",
        KeySystem = "Key 시스템",
        Copy = "복사",
        Success = "성공",
        Failed = "실패",
        Library = "Library",
        Appearance = "외관",
        General = "일반",
        Position = "위치",
        Center = "가운데",
        ResetPosition = "위치 초기화",
        Glass = "유리 / 투명",
        On = "켜기",
        Off = "끄기",

    },

    Spanish = {

        Search = "Buscar pestaña...",
        Settings = "Configuración",
        Theme = "Tema",
        ThemePreset = "Tema preestablecido",
        Light = "Claro",
        GlassMode = "Modo cristal",
        Transparency = "Transparencia",
        AccentColor = "Color de acento",
        MenuSize = "Tamaño del menú",
        MenuWidth = "Ancho",
        MenuHeight = "Alto",
        SidebarWidth = "Ancho lateral",
        UIScale = "Escala UI",
        CornerRadius = "Bordes",
        AnimationSpeed = "Velocidad",
        Behavior = "Comportamiento",
        TabSearch = "Buscar pestañas",
        Notifications = "Notificaciones",
        Dragging = "Arrastrar",
        AutoFit = "Ajustar pantalla",
        ShowIcons = "Mostrar iconos",
        Language = "Idioma",
        CustomColors = "Colores personalizados",
        RGB = "RGB",
        Reset = "Restablecer",
        ResetSettings = "Restablecer configuración",
        ResetTheme = "Restablecer tema",
        Restore = "Restaurar ventana",
        Hide = "Ocultar",
        Show = "Mostrar",
        Close = "Cerrar",
        Cancel = "Cancelar",
        Confirm = "Confirmar",
        CloseTitle = "Confirmar cierre",
        CloseMessage = "¿Seguro que quieres destruir el menú?",
        Destroyed = "Menú destruido.",
        GetKey = "Obtener Key",
        EnterKey = "Introducir Key",
        Verify = "Verificar",
        InvalidKey = "Key inválida.",
        ValidKey = "Key válida.",
        KeySystem = "Sistema Key",
        Copy = "Copiar",
        Success = "Éxito",
        Failed = "Fallido",
        Library = "Library",
        Appearance = "Apariencia",
        General = "General",
        Position = "Posición",
        Center = "Centrar",
        ResetPosition = "Restablecer posición",
        Glass = "Cristal / Transparente",
        On = "Activado",
        Off = "Desactivado",

    },

    French = {

        Search = "Rechercher un onglet...",
        Settings = "Paramètres",
        Theme = "Thème",
        ThemePreset = "Thème prédéfini",
        Light = "Clair",
        GlassMode = "Mode verre",
        Transparency = "Transparence",
        AccentColor = "Couleur d'accent",
        MenuSize = "Taille du menu",
        MenuWidth = "Largeur",
        MenuHeight = "Hauteur",
        SidebarWidth = "Largeur latérale",
        UIScale = "Échelle UI",
        CornerRadius = "Coins",
        AnimationSpeed = "Vitesse",
        Behavior = "Comportement",
        TabSearch = "Recherche d'onglets",
        Notifications = "Notifications",
        Dragging = "Déplacement",
        AutoFit = "Ajustement écran",
        ShowIcons = "Afficher les icônes",
        Language = "Langue",
        CustomColors = "Couleurs personnalisées",
        RGB = "RGB",
        Reset = "Réinitialiser",
        ResetSettings = "Réinitialiser les paramètres",
        ResetTheme = "Réinitialiser le thème",
        Restore = "Restaurer la fenêtre",
        Hide = "Masquer",
        Show = "Afficher",
        Close = "Fermer",
        Cancel = "Annuler",
        Confirm = "Confirmer",
        CloseTitle = "Confirmer la fermeture",
        CloseMessage = "Voulez-vous vraiment détruire le menu ?",
        Destroyed = "Menu détruit.",
        GetKey = "Obtenir la Key",
        EnterKey = "Entrer la Key",
        Verify = "Vérifier",
        InvalidKey = "Key invalide.",
        ValidKey = "Key valide.",
        KeySystem = "Système Key",
        Copy = "Copier",
        Success = "Succès",
        Failed = "Échec",
        Library = "Library",
        Appearance = "Apparence",
        General = "Général",
        Position = "Position",
        Center = "Centrer",
        ResetPosition = "Réinitialiser la position",
        Glass = "Verre / Transparent",
        On = "Activé",
        Off = "Désactivé",

    },

}

--==============================================================
-- TRANSLATION
--==============================================================

function Library:GetText(key)

    local language =
        self.Languages[self.Settings.Language]
        or self.Languages.English

    return language[key]
        or self.Languages.English[key]
        or key

end

Library.T = Library.GetText

--==============================================================
-- SAFE COLOR
--==============================================================

local function ClampColor(value)

    if typeof(value) == "Color3" then
        return value
    end

    return Color3.new(1, 1, 1)

end

--==============================================================
-- UTILITY
--==============================================================

local function New(className, properties)

    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do

        pcall(function()
            object[property] = value
        end)

    end

    return object

end

local function AddCorner(object, radius)

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(
            0,
            radius or Library.Settings.CornerRadius
        )

    corner.Parent = object

    return corner

end

local function AddStroke(object, color)

    local stroke = Instance.new("UIStroke")

    stroke.Color =
        color
        or Library.Theme.Border

    stroke.Thickness = 1

    stroke.Transparency = 0

    stroke.Parent = object

    return stroke

end

local function Tween(object, properties, speed)

    local duration =
        speed
        or Library.Settings.AnimationSpeed / 100

    duration =
        math.max(
            duration,
            0
        )

    if duration <= 0 then

        for property, value in pairs(properties) do

            pcall(function()
                object[property] = value
            end)

        end

        return nil

    end

    local tween =
        TweenService:Create(
            object,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            properties
        )

    tween:Play()

    return tween

end

--==============================================================
-- GLASS TRANSPARENCY
--==============================================================

function Library:GetSurfaceTransparency(role)

    if not self.Settings.GlassMode then
        return 0
    end

    local value =
        math.clamp(
            self.Settings.Transparency / 100,
            0,
            0.90
        )

    if role == "Background" then
        return math.min(value + 0.05, 0.90)
    end

    if role == "Secondary" then
        return math.min(value + 0.10, 0.92)
    end

    if role == "Tertiary" then
        return math.min(value + 0.03, 0.88)
    end

    return 0

end

--==============================================================
-- THEME ROLE
--==============================================================

local function SetRole(object, role)

    if not object then
        return object
    end

    pcall(function()
        object:SetAttribute("LONGThemeRole", role)
    end)

    return object

end

--==============================================================
-- APPLY THEME TO OBJECT
--==============================================================

function Library:ApplyThemeObject(object)

    if not object then
        return
    end

    local role

    pcall(function()
        role = object:GetAttribute("LONGThemeRole")
    end)

    if not role then
        return
    end

    local color = self.Theme[role]

    if color then

        pcall(function()
            object.BackgroundColor3 = color
        end)

        pcall(function()
            object.TextColor3 = color
        end)

        pcall(function()
            object.ImageColor3 = color
        end)

    end

    if role == "Background"
        or role == "Secondary"
        or role == "Tertiary"
    then

        pcall(function()

            object.BackgroundTransparency =
                self:GetSurfaceTransparency(role)

        end)

    end

end

--==============================================================
-- SET THEME
--==============================================================

function Library:SetTheme(themeName)

    themeName =
        tostring(themeName or "Purple")

    local preset =
        self.ThemePresets[themeName]

    if not preset then
        return false
    end

    self.Settings.ThemePreset =
        themeName

    for key, value in pairs(preset) do
        self.Theme[key] = value
    end

    -- Keep current accent if user selected one
    if self.Settings.AccentPreset
        and self.AccentPresets[self.Settings.AccentPreset]
    then

        self.Theme.Accent =
            self.AccentPresets[
                self.Settings.AccentPreset
            ]

    end

    self:RefreshAll()

    return true

end

--==============================================================
-- SET ACCENT
--==============================================================

function Library:SetAccentColor(name)

    name =
        tostring(name or "Purple")

    local color =
        self.AccentPresets[name]

    if not color then
        return false
    end

    self.Settings.AccentPreset =
        name

    self.Theme.Accent =
        color

    self:RefreshAll()

    return true

end

--==============================================================
-- RGB ACCENT
--==============================================================

function Library:SetRGB(r, g, b)

    r = math.clamp(tonumber(r) or 255, 0, 255)
    g = math.clamp(tonumber(g) or 255, 0, 255)
    b = math.clamp(tonumber(b) or 255, 0, 255)

    self.Settings.AccentPreset =
        "Custom RGB"

    self.Theme.Accent =
        Color3.fromRGB(r, g, b)

    self:RefreshAll()

    return true

end

--==============================================================
-- GLASS
--==============================================================

function Library:SetGlassMode(value, transparency)

    self.Settings.GlassMode =
        value == true

    if transparency ~= nil then

        self.Settings.Transparency =
            math.clamp(
                tonumber(transparency) or 57,
                0,
                90
            )

    end

    self:RefreshAll()

    return true

end

--==============================================================
-- LANGUAGE
--==============================================================

function Library:SetLanguage(language)

    if not self.Languages[language] then
        return false
    end

    self.Settings.Language =
        language

    self:RefreshAll()

    return true

end

--==============================================================
-- FONT
--==============================================================

function Library:GetFont()

    local fonts = {

        Gotham = Enum.Font.Gotham,
        GothamBold = Enum.Font.GothamBold,
        SourceSans = Enum.Font.SourceSans,
        SourceSansBold = Enum.Font.SourceSansBold,
        Arial = Enum.Font.Arial,
        Code = Enum.Font.Code,

    }

    return fonts[self.Settings.Font]
        or Enum.Font.Gotham

end

--==============================================================
-- WINDOW CLASS
--==============================================================

local WindowObject = {}
WindowObject.__index = WindowObject

--==============================================================
-- WINDOW THEME REFRESH
--==============================================================

function WindowObject:RefreshTheme()

    if not self.ScreenGui then
        return
    end

    for _, object in ipairs(
        self.ScreenGui:GetDescendants()
    ) do

        Library:ApplyThemeObject(object)

        pcall(function()

            local role =
                object:GetAttribute(
                    "LONGStrokeRole"
                )

            if role == "Border" then

                object.Color =
                    Library.Theme.Border

            end

        end)

    end

    if self.Main then

        self.Main.BackgroundColor3 =
            Library.Theme.Background

        self.Main.BackgroundTransparency =
            Library:GetSurfaceTransparency(
                "Background"
            )

    end

end

--==============================================================
-- WINDOW POSITION
--==============================================================

function WindowObject:GetViewport()

    local camera =
        workspace.CurrentCamera

    if not camera then
        return Vector2.new(1920, 1080)
    end

    return camera.ViewportSize

end

function WindowObject:ClampPosition()

    if not self.Main
        or not self.Main.Parent
    then
        return false
    end

    local viewport =
        self:GetViewport()

    local scale =
        self.UIScale
        and self.UIScale.Scale
        or 1

    local width =
        self.Main.Size.X.Offset * scale

    local height =
        self.Main.Size.Y.Offset * scale

    local margin = 8

    local x =
        self.Main.AbsolutePosition.X
        + width / 2

    local y =
        self.Main.AbsolutePosition.Y
        + height / 2

    local minX =
        width / 2 + margin

    local maxX =
        viewport.X - width / 2 - margin

    local minY =
        height / 2 + margin

    local maxY =
        viewport.Y - height / 2 - margin

    if maxX < minX then
        x = viewport.X / 2
    else
        x = math.clamp(x, minX, maxX)
    end

    if maxY < minY then
        y = viewport.Y / 2
    else
        y = math.clamp(y, minY, maxY)
    end

    self.Main.AnchorPoint =
        Vector2.new(0.5, 0.5)

    self.Main.Position =
        UDim2.fromOffset(x, y)

    return true

end

function WindowObject:Center()

    local viewport =
        self:GetViewport()

    self.Main.AnchorPoint =
        Vector2.new(0.5, 0.5)

    self.Main.Position =
        UDim2.fromOffset(
            viewport.X / 2,
            viewport.Y / 2
        )

    return true

end

function WindowObject:SetPosition(x, y)

    x = tonumber(x)
    y = tonumber(y)

    if not x or not y then
        return false
    end

    self.Main.AnchorPoint =
        Vector2.new(0.5, 0.5)

    self.Main.Position =
        UDim2.fromOffset(x, y)

    return self:ClampPosition()

end

function WindowObject:GetPosition()

    return {

        X = self.Main.AbsolutePosition.X
            + self.Main.AbsoluteSize.X / 2,

        Y = self.Main.AbsolutePosition.Y
            + self.Main.AbsoluteSize.Y / 2,

    }

end

function WindowObject:ResetPosition()

    return self:Center()

end

--==============================================================
-- WINDOW SIZE
--==============================================================

function WindowObject:SetSize(width, height)

    width =
        math.max(
            tonumber(width) or Library.Settings.MenuWidth,
            320
        )

    height =
        math.max(
            tonumber(height) or Library.Settings.MenuHeight,
            240
        )

    Library.Settings.MenuWidth =
        width

    Library.Settings.MenuHeight =
        height

    self:Refresh()

    return true

end

function WindowObject:SetScale(scale)

    scale =
        math.clamp(
            tonumber(scale) or 100,
            50,
            150
        )

    Library.Settings.UIScale =
        scale

    self.UIScale.Scale =
        scale / 100

    self:ClampPosition()

    return true

end

--==============================================================
-- HIDE / SHOW
--==============================================================

function WindowObject:HideInstant()

    if not self.Main then
        return false
    end

    local position =
        self:GetPosition()

    self.SavedPosition =
        position

    self.Main.Visible =
        false

    return true

end

function WindowObject:ShowInstant()

    if not self.Main then
        return false
    end

    self.Main.Visible =
        true

    if self.SavedPosition then

        self:SetPosition(
            self.SavedPosition.X,
            self.SavedPosition.Y
        )

    else

        self:ClampPosition()

    end

    return true

end

function WindowObject:Hide()

    return self:HideInstant()

end

function WindowObject:Show()

    return self:ShowInstant()

end

function WindowObject:Toggle()

    if self.Main.Visible then
        return self:Hide()
    else
        return self:Show()
    end

end

function WindowObject:ToggleInstant()

    return self:Toggle()

end

function WindowObject:IsVisible()

    return self.Main
        and self.Main.Visible == true

end

function WindowObject:IsHidden()

    return not self:IsVisible()

end

function WindowObject:Restore()

    return self:ShowInstant()

end

function WindowObject:HideMenu()

    return self:HideInstant()

end

function WindowObject:ShowMenu()

    return self:ShowInstant()

end

function WindowObject:ToggleMenu()

    return self:Toggle()

end

function WindowObject:IsMinimized()

    return false

end

--==============================================================
-- DRAG
--==============================================================

function WindowObject:BindDrag(handle)

    if not handle then
        return
    end

    local dragging = false
    local dragStart
    local startPosition

    local inputChanged

    handle.InputBegan:Connect(
        function(input)

            if not Library.Settings.Dragging then
                return
            end

            if input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or input.UserInputType ==
                Enum.UserInputType.Touch
            then

                dragging = true

                dragStart =
                    input.Position

                startPosition =
                    self.Main.Position

                input.Changed:Connect(
                    function()

                        if input.UserInputState ==
                            Enum.UserInputState.End
                        then

                            dragging = false

                        end

                    end
                )

            end

        end
    )

    inputChanged =
        UserInputService.InputChanged:Connect(
            function(input)

                if not dragging then
                    return
                end

                if input.UserInputType ==
                    Enum.UserInputType.MouseMovement
                    or input.UserInputType ==
                    Enum.UserInputType.Touch
                then

                    local delta =
                        input.Position
                        - dragStart

                    self.Main.Position =
                        UDim2.new(
                            startPosition.X.Scale,
                            startPosition.X.Offset
                                + delta.X,

                            startPosition.Y.Scale,
                            startPosition.Y.Offset
                                + delta.Y
                        )

                end

            end
        )

    table.insert(
        self.Connections,
        inputChanged
    )

end

--==============================================================
-- NOTIFICATION
--==============================================================

function WindowObject:Notify(data)

    if not Library.Settings.Notifications then
        return
    end

    data =
        type(data) == "table"
        and data
        or {
            Title = "LONG",
            Content = tostring(data),
            Duration = 3,
        }

    local title =
        data.Title or "LONG"

    local content =
        data.Content
        or data.Text
        or ""

    local duration =
        tonumber(data.Duration)
        or 3

    pcall(function()

        StarterGui:SetCore(
            "SendNotification",
            {
                Title = title,
                Text = content,
                Duration = duration,
            }
        )

    end)

end

--==============================================================
-- REFRESH WINDOW
--==============================================================

function WindowObject:Refresh()

    if not self.Main then
        return
    end

    self.Main.Size =
        UDim2.fromOffset(
            Library.Settings.MenuWidth,
            Library.Settings.MenuHeight
        )

    self.UIScale.Scale =
        Library.Settings.UIScale / 100

    self.Sidebar.Size =
        UDim2.new(
            0,
            Library.Settings.SidebarWidth,
            1,
            -56
        )

    self.Search.Visible =
        Library.Settings.TabSearch

    self:RefreshTheme()

    self:ClampPosition()

end

--==============================================================
-- TAB VISIBILITY
--==============================================================

function WindowObject:UpdateTabSearch(query)

    query =
        string.lower(
            tostring(query or "")
        )

    for _, tab in ipairs(self.Tabs) do

        local match =
            query == ""
            or string.find(
                string.lower(tab.Name),
                query,
                1,
                true
            )

        tab.Button.Visible =
            match

    end

end

--==============================================================
-- SELECT TAB
--==============================================================

function WindowObject:SelectTab(tab)

    if not tab then
        return
    end

    self.ActiveTab =
        tab

    for _, other in ipairs(self.Tabs) do

        local active =
            other == tab

        other.Page.Visible =
            active

        if active then

            other.Button.BackgroundColor3 =
                Library.Theme.Accent

            other.Button.BackgroundTransparency =
                0

            other.Label.TextColor3 =
                Color3.new(1,1,1)

            other.Icon.TextColor3 =
                Color3.new(1,1,1)

        else

            other.Button.BackgroundColor3 =
                Library.Theme.Tertiary

            other.Button.BackgroundTransparency =
                Library:GetSurfaceTransparency(
                    "Tertiary"
                )

            other.Label.TextColor3 =
                Library.Theme.Text

            other.Icon.TextColor3 =
                Library.Theme.SubText

        end

    end

end

--==============================================================
-- CREATE TAB
--==============================================================

function WindowObject:CreateTab(name, icon)

    name =
        tostring(name or "Tab")

    icon =
        icon
        or Library:GetTabIcon(name)

    local tabIndex =
        #self.Tabs + 1

    local tab = {

        Name = name,
        Icon = icon,
        Index = tabIndex,

        Sections = {},

    }

    --==========================================================
    -- TAB BUTTON
    --==========================================================

    local button =
        New(
            "TextButton",
            {

                Name = "Tab_" .. name,

                Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        50
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Tertiary"
                    ),

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text = "",

                LayoutOrder =
                    tabIndex,

                Parent =
                    self.TabList,

            }
        )

    SetRole(
        button,
        "Tertiary"
    )

    AddCorner(
        button,
        math.max(
            8,
            Library.Settings.CornerRadius
        )
    )

    --==========================================================
    -- ICON
    --==========================================================

    local iconLabel =
        New(
            "TextLabel",
            {

                Name = "Icon",

                Position =
                    UDim2.fromOffset(
                        12,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        28,
                        50
                    ),

                BackgroundTransparency = 1,

                Text =
                    Library.Settings.ShowTabIcons
                    and icon
                    or "",

                Font =
                    Enum.Font.GothamBold,

                TextSize = 19,

                TextColor3 =
                    Library.Theme.SubText,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                Parent = button,

            }
        )

    --==========================================================
    -- LABEL
    --==========================================================

    local label =
        New(
            "TextLabel",
            {

                Name = "Label",

                Position =
                    UDim2.fromOffset(
                        48,
                        0
                    ),

                Size =
                    UDim2.new(
                        1,
                        -58,
                        1,
                        0
                    ),

                BackgroundTransparency = 1,

                Text = name,

                Font =
                    Library:GetFont(),

                TextSize = 14,

                TextColor3 =
                    Library.Theme.Text,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextTruncate =
                    Enum.TextTruncate.AtEnd,

                Parent = button,

            }
        )

    --==========================================================
    -- PAGE
    --==========================================================

    local page =
        New(
            "ScrollingFrame",
            {

                Name = "Page",

                Size =
                    UDim2.new(
                        1,
                        0,
                        1,
                        0
                    ),

                BackgroundTransparency = 1,

                BorderSizePixel = 0,

                ScrollBarThickness = 3,

                ScrollBarImageColor3 =
                    Library.Theme.Accent,

                CanvasSize =
                    UDim2.new(
                        0,
                        0,
                        0,
                        0
                    ),

                AutomaticCanvasSize =
                    Enum.AutomaticSize.Y,

                Visible = false,

                Parent =
                    self.Content,

            }
        )

    local padding =
        New(
            "UIPadding",
            {

                PaddingTop =
                    UDim.new(0, 10),

                PaddingBottom =
                    UDim.new(0, 10),

                PaddingLeft =
                    UDim.new(0, 10),

                PaddingRight =
                    UDim.new(0, 10),

                Parent = page,

            }
        )

    local layout =
        New(
            "UIListLayout",
            {

                Padding =
                    UDim.new(0, 10),

                SortOrder =
                    Enum.SortOrder.LayoutOrder,

                Parent = page,

            }
        )

    tab.Button = button
    tab.Label = label
    tab.Icon = iconLabel
    tab.Page = page
    tab.Layout = layout

    table.insert(
        self.Tabs,
        tab
    )

    --==========================================================
    -- CLICK
    --==========================================================

    button.Activated:Connect(
        function()

            self:SelectTab(tab)

        end
    )

    --==========================================================
    -- SETTING ALWAYS LAST
    --==========================================================

    self:UpdateTabOrders()

    --==========================================================
    -- FIRST USER TAB
    --==========================================================

    if not self.ActiveTab
        and not tab.IsSetting
    then

        self:SelectTab(tab)

    end

    return tab

end

--==============================================================
-- TAB ORDER
--==============================================================

function WindowObject:UpdateTabOrders()

    local order = 1

    for _, tab in ipairs(self.Tabs) do

        if not tab.IsSetting then

            tab.Index = order

            tab.Button.LayoutOrder =
                order

            order += 1

        end

    end

    if self.SettingTab then

        self.SettingTab.Index =
            order + 100000

        self.SettingTab.Button.LayoutOrder =
            order + 100000

    end

end

--==============================================================
-- SECTION
--==============================================================

function WindowObject:CreateSection(tab, name)

    local section = {}

    name =
        tostring(name or "Section")

    local frame =
        New(
            "Frame",
            {

                Name = "Section_" .. name,

                Size =
                    UDim2.new(
                        1,
                        -6,
                        0,
                        0
                    ),

                AutomaticSize =
                    Enum.AutomaticSize.Y,

                BackgroundColor3 =
                    Library.Theme.Secondary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Secondary"
                    ),

                BorderSizePixel = 0,

                Parent = tab.Page,

            }
        )

    SetRole(
        frame,
        "Secondary"
    )

    AddCorner(
        frame,
        Library.Settings.CornerRadius
    )

    AddStroke(
        frame,
        Library.Theme.Border
    )

    local title =
        New(
            "TextLabel",
            {

                Size =
                    UDim2.new(
                        1,
                        -24,
                        0,
                        38
                    ),

                Position =
                    UDim2.fromOffset(
                        12,
                        0
                    ),

                BackgroundTransparency = 1,

                Text = name,

                Font =
                    Enum.Font.GothamBold,

                TextSize = 15,

                TextColor3 =
                    Library.Theme.Text,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent = frame,

            }
        )

    local content =
        New(
            "Frame",
            {

                Position =
                    UDim2.fromOffset(
                        10,
                        40
                    ),

                Size =
                    UDim2.new(
                        1,
                        -20,
                        0,
                        0
                    ),

                AutomaticSize =
                    Enum.AutomaticSize.Y,

                BackgroundTransparency = 1,

                Parent = frame,

            }
        )

    local layout =
        New(
            "UIListLayout",
            {

                Padding =
                    UDim.new(0, 8),

                SortOrder =
                    Enum.SortOrder.LayoutOrder,

                Parent = content,

            }
        )

    local padding =
        New(
            "UIPadding",
            {

                PaddingBottom =
                    UDim.new(0, 10),

                Parent = content,

            }
        )

    section.Frame = frame
    section.Content = content

    table.insert(
        tab.Sections,
        section
    )

    --==========================================================
    -- LABEL
    --==========================================================

    function section:CreateLabel(text)

        local label =
            New(
                "TextLabel",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            30
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or ""),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.SubText,

                    TextWrapped = true,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = content,

                }
            )

        SetRole(
            label,
            "SubText"
        )

        return label

    end

    --==========================================================
    -- BUTTON
    --==========================================================

    function section:CreateButton(text, callback)

        local button =
            New(
                "TextButton",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            40
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    AutoButtonColor = false,

                    Text =
                        tostring(text or "Button"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    Parent = content,

                }
            )

        SetRole(
            button,
            "Tertiary"
        )

        AddCorner(
            button,
            8
        )

        AddStroke(
            button,
            Library.Theme.Border
        )

        button.Activated:Connect(
            function()

                if callback then

                    task.spawn(
                        callback
                    )

                end

            end
        )

        return button

    end

    --==========================================================
    -- TOGGLE
    --==========================================================

    function section:CreateToggle(text, default, callback)

        local value =
            default == true

        local button =
            New(
                "TextButton",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            42
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    AutoButtonColor = false,

                    Text = "",

                    Parent = content,

                }
            )

        SetRole(
            button,
            "Tertiary"
        )

        AddCorner(button, 8)

        local label =
            New(
                "TextLabel",
                {

                    Position =
                        UDim2.fromOffset(
                            12,
                            0
                        ),

                    Size =
                        UDim2.new(
                            1,
                            -70,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Toggle"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = button,

                }
            )

        local switch =
            New(
                "Frame",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0.5
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -10,
                            0.5,
                            0
                        ),

                    Size =
                        UDim2.fromOffset(
                            42,
                            22
                        ),

                    BackgroundColor3 =
                        value
                        and Library.Theme.On
                        or Library.Theme.Off,

                    BorderSizePixel = 0,

                    Parent = button,

                }
            )

        AddCorner(
            switch,
            20
        )

        local circle =
            New(
                "Frame",
                {

                    AnchorPoint =
                        Vector2.new(
                            0,
                            0.5
                        ),

                    Position =
                        value
                        and UDim2.new(
                            1,
                            -19,
                            0.5,
                            0
                        )
                        or UDim2.new(
                            0,
                            3,
                            0.5,
                            0
                        ),

                    Size =
                        UDim2.fromOffset(
                            16,
                            16
                        ),

                    BackgroundColor3 =
                        Color3.new(
                            1,
                            1,
                            1
                        ),

                    BorderSizePixel = 0,

                    Parent = switch,

                }
            )

        AddCorner(
            circle,
            20
        )

        local function update()

            switch.BackgroundColor3 =
                value
                and Library.Theme.On
                or Library.Theme.Off

            Tween(
                circle,
                {

                    Position =
                        value
                        and UDim2.new(
                            1,
                            -19,
                            0.5,
                            0
                        )
                        or UDim2.new(
                            0,
                            3,
                            0.5,
                            0
                        ),

                }
            )

        end

        button.Activated:Connect(
            function()

                value =
                    not value

                update()

                if callback then

                    task.spawn(
                        callback,
                        value
                    )

                end

            end
        )

        local object = {

            SetValue = function(_, newValue)

                value =
                    newValue == true

                update()

                if callback then

                    task.spawn(
                        callback,
                        value
                    )

                end

            end,

            GetValue = function()

                return value

            end,

            Button = button,

        }

        return object

    end

    --==========================================================
    -- SLIDER
    --==========================================================

    function section:CreateSlider(text, min, max, default, callback)

        min =
            tonumber(min)
            or 0

        max =
            tonumber(max)
            or 100

        default =
            tonumber(default)
            or min

        if max < min then
            min, max = max, min
        end

        local value =
            math.clamp(
                default,
                min,
                max
            )

        local holder =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            65
                        ),

                    BackgroundTransparency = 1,

                    Parent = content,

                }
            )

        local label =
            New(
                "TextLabel",
                {

                    Size =
                        UDim2.new(
                            1,
                            -70,
                            0,
                            28
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Slider"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = holder,

                }
            )

        local valueLabel =
            New(
                "TextLabel",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -2,
                            0,
                            2
                        ),

                    Size =
                        UDim2.fromOffset(
                            65,
                            25
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(value),

                    Font =
                        Enum.Font.GothamBold,

                    TextSize = 12,

                    TextColor3 =
                        Library.Theme.Accent,

                    TextXAlignment =
                        Enum.TextXAlignment.Right,

                    Parent = holder,

                }
            )

        local bar =
            New(
                "Frame",
                {

                    Position =
                        UDim2.fromOffset(
                            0,
                            36
                        ),

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            7
                        ),

                    BackgroundColor3 =
                        Library.Theme.SliderBackground,

                    BorderSizePixel = 0,

                    Parent = holder,

                }
            )

        SetRole(
            bar,
            "SliderBackground"
        )

        AddCorner(
            bar,
            10
        )

        local fill =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            (value - min)
                            / (max - min),
                            0,
                            1,
                            0
                        ),

                    BackgroundColor3 =
                        Library.Theme.Accent,

                    BorderSizePixel = 0,

                    Parent = bar,

                }
            )

        SetRole(
            fill,
            "Accent"
        )

        AddCorner(
            fill,
            10
        )

        local dragging = false

        local function setFromX(x)

            local percent =
                math.clamp(
                    (
                        x
                        - bar.AbsolutePosition.X
                    )
                    / bar.AbsoluteSize.X,
                    0,
                    1
                )

            value =
                min
                + (max - min)
                * percent

            value =
                math.floor(
                    value * 100
                    + 0.5
                ) / 100

            fill.Size =
                UDim2.new(
                    percent,
                    0,
                    1,
                    0
                )

            valueLabel.Text =
                tostring(value)

            if callback then

                task.spawn(
                    callback,
                    value
                )

            end

        end

        bar.InputBegan:Connect(
            function(input)

                if input.UserInputType ==
                    Enum.UserInputType.MouseButton1
                    or input.UserInputType ==
                    Enum.UserInputType.Touch
                then

                    dragging = true

                    setFromX(
                        input.Position.X
                    )

                end

            end
        )

        UserInputService.InputChanged:Connect(
            function(input)

                if dragging
                    and (
                        input.UserInputType ==
                        Enum.UserInputType.MouseMovement
                        or input.UserInputType ==
                        Enum.UserInputType.Touch
                    )
                then

                    setFromX(
                        input.Position.X
                    )

                end

            end
        )

        UserInputService.InputEnded:Connect(
            function(input)

                if input.UserInputType ==
                    Enum.UserInputType.MouseButton1
                    or input.UserInputType ==
                    Enum.UserInputType.Touch
                then

                    dragging = false

                end

            end
        )

        return {

            SetValue = function(_, newValue)

                value =
                    math.clamp(
                        tonumber(newValue)
                        or min,
                        min,
                        max
                    )

                local percent =
                    (value - min)
                    / (max - min)

                fill.Size =
                    UDim2.new(
                        percent,
                        0,
                        1,
                        0
                    )

                valueLabel.Text =
                    tostring(value)

            end,

            GetValue = function()

                return value

            end,

        }

    end

    --==========================================================
    -- DROPDOWN
    --==========================================================

    function section:CreateDropdown(text, options, default, callback)

        options =
            options or {}

        local value =
            default
            or options[1]

        local holder =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            45
                        ),

                    AutomaticSize =
                        Enum.AutomaticSize.Y,

                    BackgroundTransparency = 1,

                    Parent = content,

                }
            )

        local button =
            New(
                "TextButton",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            42
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    AutoButtonColor = false,

                    Text = "",

                    Parent = holder,

                }
            )

        SetRole(
            button,
            "Tertiary"
        )

        AddCorner(
            button,
            8
        )

        local label =
            New(
                "TextLabel",
                {

                    Position =
                        UDim2.fromOffset(
                            12,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.55,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Dropdown"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = button,

                }
            )

        local selected =
            New(
                "TextLabel",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -30,
                            0,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.40,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(value or ""),

                    Font =
                        Library:GetFont(),

                    TextSize = 12,

                    TextColor3 =
                        Library.Theme.Accent,

                    TextXAlignment =
                        Enum.TextXAlignment.Right,

                    TextTruncate =
                        Enum.TextTruncate.AtEnd,

                    Parent = button,

                }
            )

        local arrow =
            New(
                "TextLabel",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -8,
                            0,
                            0
                        ),

                    Size =
                        UDim2.fromOffset(
                            18,
                            42
                        ),

                    BackgroundTransparency = 1,

                    Text = "⌄",

                    Font =
                        Enum.Font.GothamBold,

                    TextSize = 16,

                    TextColor3 =
                        Library.Theme.SubText,

                    Parent = button,

                }
            )

        local list =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            0
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    Visible = false,

                    Parent = holder,

                }
            )

        SetRole(
            list,
            "Tertiary"
        )

        AddCorner(list, 8)

        local listLayout =
            New(
                "UIListLayout",
                {

                    Padding =
                        UDim.new(0, 4),

                    Parent = list,

                }
            )

        local listPadding =
            New(
                "UIPadding",
                {

                    PaddingTop =
                        UDim.new(0, 5),

                    PaddingBottom =
                        UDim.new(0, 5),

                    PaddingLeft =
                        UDim.new(0, 5),

                    PaddingRight =
                        UDim.new(0, 5),

                    Parent = list,

                }
            )

        local opened = false

        local function rebuild()

            for _, child in ipairs(list:GetChildren()) do

                if child:IsA("TextButton") then
                    child:Destroy()
                end

            end

            for _, option in ipairs(options) do

                local optionButton =
                    New(
                        "TextButton",
                        {

                            Size =
                                UDim2.new(
                                    1,
                                    0,
                                    0,
                                    34
                                ),

                            BackgroundColor3 =
                                Library.Theme.Secondary,

                            BackgroundTransparency =
                                Library:GetSurfaceTransparency(
                                    "Secondary"
                                ),

                            BorderSizePixel = 0,

                            AutoButtonColor = false,

                            Text =
                                tostring(option),

                            Font =
                                Library:GetFont(),

                            TextSize = 12,

                            TextColor3 =
                                Library.Theme.Text,

                            Parent = list,

                        }
                    )

                SetRole(
                    optionButton,
                    "Secondary"
                )

                AddCorner(
                    optionButton,
                    6
                )

                optionButton.Activated:Connect(
                    function()

                        value =
                            option

                        selected.Text =
                            tostring(value)

                        opened = false

                        list.Visible =
                            false

                        holder.Size =
                            UDim2.new(
                                1,
                                0,
                                0,
                                45
                            )

                        if callback then

                            task.spawn(
                                callback,
                                value
                            )

                        end

                    end
                )

            end

            task.defer(
                function()

                    local height =
                        listLayout.AbsoluteContentSize.Y
                        + 10

                    list.Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            height
                        )

                end
            )

        end

        button.Activated:Connect(
            function()

                opened =
                    not opened

                list.Visible =
                    opened

                if opened then

                    rebuild()

                    task.defer(
                        function()

                            holder.Size =
                                UDim2.new(
                                    1,
                                    0,
                                    0,
                                    45
                                    + list.AbsoluteSize.Y
                                    + 8
                                )

                        end
                    )

                else

                    holder.Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            45
                        )

                end

            end
        )

        return {

            SetValue = function(_, newValue)

                value =
                    newValue

                selected.Text =
                    tostring(value)

            end,

            GetValue = function()

                return value

            end,

            Refresh = rebuild,

        }

    end

    --==========================================================
    -- MULTI DROPDOWN
    --==========================================================

    function section:CreateMultiDropdown(text, options, defaults, callback)

        options =
            options or {}

        defaults =
            defaults or {}

        local selectedValues = {}

        for _, item in ipairs(defaults) do
            selectedValues[item] = true
        end

        local holder =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            45
                        ),

                    AutomaticSize =
                        Enum.AutomaticSize.Y,

                    BackgroundTransparency = 1,

                    Parent = content,

                }
            )

        local button =
            New(
                "TextButton",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            42
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    AutoButtonColor = false,

                    Text = "",

                    Parent = holder,

                }
            )

        SetRole(
            button,
            "Tertiary"
        )

        AddCorner(
            button,
            8
        )

        local title =
            New(
                "TextLabel",
                {

                    Position =
                        UDim2.fromOffset(
                            12,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.45,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Multi Dropdown"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = button,

                }
            )

        local selectedLabel =
            New(
                "TextLabel",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -10,
                            0,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.50,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text = "0 selected",

                    Font =
                        Library:GetFont(),

                    TextSize = 12,

                    TextColor3 =
                        Library.Theme.Accent,

                    TextXAlignment =
                        Enum.TextXAlignment.Right,

                    Parent = button,

                }
            )

        local list =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            0
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    Visible = false,

                    Parent = holder,

                }
            )

        SetRole(
            list,
            "Tertiary"
        )

        AddCorner(list, 8)

        local layout =
            New(
                "UIListLayout",
                {

                    Padding =
                        UDim.new(0, 4),

                    Parent = list,

                }
            )

        local padding =
            New(
                "UIPadding",
                {

                    PaddingTop =
                        UDim.new(0, 5),

                    PaddingBottom =
                        UDim.new(0, 5),

                    PaddingLeft =
                        UDim.new(0, 5),

                    PaddingRight =
                        UDim.new(0, 5),

                    Parent = list,

                }
            )

        local opened = false

        local function updateText()

            local count = 0

            for _, enabled in pairs(selectedValues) do

                if enabled then
                    count += 1
                end

            end

            selectedLabel.Text =
                tostring(count)
                .. " selected"

        end

        local function rebuild()

            for _, child in ipairs(list:GetChildren()) do

                if child:IsA("TextButton") then
                    child:Destroy()
                end

            end

            for _, option in ipairs(options) do

                local enabled =
                    selectedValues[option] == true

                local optionButton =
                    New(
                        "TextButton",
                        {

                            Size =
                                UDim2.new(
                                    1,
                                    0,
                                    0,
                                    34
                                ),

                            BackgroundColor3 =
                                enabled
                                and Library.Theme.Accent
                                or Library.Theme.Secondary,

                            BackgroundTransparency =
                                enabled
                                and 0
                                or Library:GetSurfaceTransparency(
                                    "Secondary"
                                ),

                            BorderSizePixel = 0,

                            AutoButtonColor = false,

                            Text =
                                (enabled and "✓ " or "")
                                .. tostring(option),

                            Font =
                                Library:GetFont(),

                            TextSize = 12,

                            TextColor3 =
                                Color3.new(
                                    1,
                                    1,
                                    1
                                ),

                            Parent = list,

                        }
                    )

                optionButton.Activated:Connect(
                    function()

                        selectedValues[option] =
                            not selectedValues[option]

                        updateText()

                        rebuild()

                        if callback then

                            task.spawn(
                                callback,
                                selectedValues
                            )

                        end

                    end
                )

            end

            task.defer(
                function()

                    list.Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            layout.AbsoluteContentSize.Y
                            + 10
                        )

                end
            )

        end

        button.Activated:Connect(
            function()

                opened =
                    not opened

                list.Visible =
                    opened

                if opened then

                    rebuild()

                    task.defer(
                        function()

                            holder.Size =
                                UDim2.new(
                                    1,
                                    0,
                                    0,
                                    45
                                    + list.AbsoluteSize.Y
                                    + 8
                                )

                        end
                    )

                else

                    holder.Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            45
                        )

                end

            end
        )

        updateText()

        return {

            SetValues = function(_, values)

                selectedValues = {}

                for _, item in ipairs(values or {}) do
                    selectedValues[item] = true
                end

                updateText()

            end,

            GetValues = function()

                local result = {}

                for item, enabled in pairs(selectedValues) do

                    if enabled then
                        table.insert(result, item)
                    end

                end

                return result

            end,

        }

    end

    --==========================================================
    -- TEXTBOX
    --==========================================================

    function section:CreateTextbox(text, placeholder, default, callback)

        local holder =
            New(
                "Frame",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            70
                        ),

                    BackgroundTransparency = 1,

                    Parent = content,

                }
            )

        local title =
            New(
                "TextLabel",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            25
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Textbox"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = holder,

                }
            )

        local box =
            New(
                "TextBox",
                {

                    Position =
                        UDim2.fromOffset(
                            0,
                            30
                        ),

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            38
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    Text =
                        tostring(default or ""),

                    PlaceholderText =
                        tostring(
                            placeholder
                            or ""
                        ),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    PlaceholderColor3 =
                        Library.Theme.SubText,

                    ClearTextOnFocus = false,

                    Parent = holder,

                }
            )

        SetRole(
            box,
            "Tertiary"
        )

        AddCorner(box, 8)

        AddStroke(
            box,
            Library.Theme.Border
        )

        box.FocusLost:Connect(
            function(enterPressed)

                if callback then

                    task.spawn(
                        callback,
                        box.Text,
                        enterPressed
                    )

                end

            end
        )

        return {

            SetValue = function(_, value)

                box.Text =
                    tostring(value or "")

            end,

            GetValue = function()

                return box.Text

            end,

            Box = box,

        }

    end

    --==========================================================
    -- KEYBIND
    --==========================================================

    function section:CreateKeybind(text, default, callback)

        local key =
            default
            or Enum.KeyCode.RightShift

        local button =
            New(
                "TextButton",
                {

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            42
                        ),

                    BackgroundColor3 =
                        Library.Theme.Tertiary,

                    BackgroundTransparency =
                        Library:GetSurfaceTransparency(
                            "Tertiary"
                        ),

                    BorderSizePixel = 0,

                    AutoButtonColor = false,

                    Text = "",

                    Parent = content,

                }
            )

        SetRole(
            button,
            "Tertiary"
        )

        AddCorner(button, 8)

        local label =
            New(
                "TextLabel",
                {

                    Position =
                        UDim2.fromOffset(
                            12,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.60,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(text or "Keybind"),

                    Font =
                        Library:GetFont(),

                    TextSize = 13,

                    TextColor3 =
                        Library.Theme.Text,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    Parent = button,

                }
            )

        local keyLabel =
            New(
                "TextLabel",
                {

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        ),

                    Position =
                        UDim2.new(
                            1,
                            -12,
                            0,
                            0
                        ),

                    Size =
                        UDim2.new(
                            0.35,
                            0,
                            1,
                            0
                        ),

                    BackgroundTransparency = 1,

                    Text =
                        tostring(key.Name),

                    Font =
                        Enum.Font.GothamBold,

                    TextSize = 12,

                    TextColor3 =
                        Library.Theme.Accent,

                    TextXAlignment =
                        Enum.TextXAlignment.Right,

                    Parent = button,

                }
            )

        local listening = false

        button.Activated:Connect(
            function()

                listening =
                    not listening

                if listening then

                    keyLabel.Text =
                        "Press key..."

                else

                    keyLabel.Text =
                        tostring(key.Name)

                end

            end
        )

        local connection =
            UserInputService.InputBegan:Connect(
                function(input, processed)

                    if processed then
                        return
                    end

                    if listening then

                        if input.KeyCode
                            ~= Enum.KeyCode.Unknown
                        then

                            key =
                                input.KeyCode

                            listening =
                                false

                            keyLabel.Text =
                                tostring(
                                    key.Name
                                )

                        end

                        return

                    end

                    if input.KeyCode == key then

                        if callback then

                            task.spawn(
                                callback,
                                key
                            )

                        end

                    end

                end
            )

        table.insert(
            selfWindow.Connections,
            connection
        )

        return {

            SetKey = function(_, newKey)

                if typeof(newKey)
                    == "EnumItem"
                then

                    key =
                        newKey

                    keyLabel.Text =
                        tostring(
                            key.Name
                        )

                end

            end,

            GetKey = function()

                return key

            end,

        }

    end

    return section

end

--==============================================================
-- FIX SELF WINDOW REFERENCE
--==============================================================

-- The CreateSection function above uses selfWindow.
-- Set dynamically when CreateTab/Section is called.

--==============================================================
-- SETTING TAB
--==============================================================

function WindowObject:CreateSettingTab()

    local tab =
        self:CreateTab(
            Library:GetText("Settings"),
            "⚙"
        )

    tab.IsSetting = true

    self.SettingTab =
        tab

    self:UpdateTabOrders()

    --==========================================================
    -- THEME
    --==========================================================

    local themeSection =
        self:CreateSection(
            tab,
            Library:GetText("Theme")
        )

    themeSection:CreateDropdown(
        Library:GetText("ThemePreset"),
        {
            "Purple",
            "Blue",
            "Red",
            "Green",
            "Dark",
            "Light",
        },
        Library.Settings.ThemePreset,
        function(value)

            Library:SetTheme(value)

        end
    )

    themeSection:CreateToggle(
        Library:GetText("GlassMode"),
        Library.Settings.GlassMode,
        function(value)

            Library:SetGlassMode(
                value,
                Library.Settings.Transparency
            )

        end
    )

    themeSection:CreateSlider(
        Library:GetText("Transparency"),
        0,
        90,
        Library.Settings.Transparency,
        function(value)

            Library.Settings.Transparency =
                value

            if Library.Settings.GlassMode then

                Library:RefreshAll()

            end

        end
    )

    themeSection:CreateDropdown(
        Library:GetText("AccentColor"),
        {
            "Purple",
            "Blue",
            "Red",
            "Green",
            "White",
            "Black",
            "Yellow",
            "Cyan",
            "Pink",
            "Orange",
        },
        Library.Settings.AccentPreset,
        function(value)

            Library:SetAccentColor(value)

        end
    )

    --==========================================================
    -- MENU SIZE
    --==========================================================

    local sizeSection =
        self:CreateSection(
            tab,
            Library:GetText("MenuSize")
        )

    sizeSection:CreateSlider(
        Library:GetText("MenuWidth"),
        360,
        900,
        Library.Settings.MenuWidth,
        function(value)

            Library.Settings.MenuWidth =
                value

            self:Refresh()

        end
    )

    sizeSection:CreateSlider(
        Library:GetText("MenuHeight"),
        280,
        700,
        Library.Settings.MenuHeight,
        function(value)

            Library.Settings.MenuHeight =
                value

            self:Refresh()

        end
    )

    sizeSection:CreateSlider(
        Library:GetText("SidebarWidth"),
        100,
        240,
        Library.Settings.SidebarWidth,
        function(value)

            Library.Settings.SidebarWidth =
                value

            self:Refresh()

        end
    )

    sizeSection:CreateSlider(
        Library:GetText("UIScale"),
        50,
        130,
        Library.Settings.UIScale,
        function(value)

            Library.Settings.UIScale =
                value

            self.UIScale.Scale =
                value / 100

            self:ClampPosition()

        end
    )

    sizeSection:CreateSlider(
        Library:GetText("CornerRadius"),
        0,
        25,
        Library.Settings.CornerRadius,
        function(value)

            Library.Settings.CornerRadius =
                value

            self:RefreshCorners()

        end
    )

    --==========================================================
    -- BEHAVIOR
    --==========================================================

    local behavior =
        self:CreateSection(
            tab,
            Library:GetText("Behavior")
        )

    behavior:CreateToggle(
        Library:GetText("TabSearch"),
        Library.Settings.TabSearch,
        function(value)

            Library.Settings.TabSearch =
                value

            self.Search.Visible =
                value

        end
    )

    behavior:CreateToggle(
        Library:GetText("Notifications"),
        Library.Settings.Notifications,
        function(value)

            Library.Settings.Notifications =
                value

        end
    )

    behavior:CreateToggle(
        Library:GetText("Dragging"),
        Library.Settings.Dragging,
        function(value)

            Library.Settings.Dragging =
                value

        end
    )

    behavior:CreateToggle(
        Library:GetText("AutoFit"),
        Library.Settings.AutoFitScreen,
        function(value)

            Library.Settings.AutoFitScreen =
                value

        end
    )

    behavior:CreateToggle(
        Library:GetText("ShowIcons"),
        Library.Settings.ShowTabIcons,
        function(value)

            Library.Settings.ShowTabIcons =
                value

            for _, otherTab in ipairs(self.Tabs) do

                otherTab.Icon.Text =
                    value
                    and otherTab.Icon:GetAttribute(
                        "OriginalIcon"
                    )
                    or ""

            end

        end
    )

    --==========================================================
    -- LANGUAGE
    --==========================================================

    local languageSection =
        self:CreateSection(
            tab,
            Library:GetText("Language")
        )

    languageSection:CreateDropdown(
        Library:GetText("Language"),
        {
            "English",
            "Vietnamese",
            "Chinese",
            "Japanese",
            "Korean",
            "Spanish",
            "French",
        },
        Library.Settings.Language,
        function(value)

            Library:SetLanguage(value)

        end
    )

    --==========================================================
    -- POSITION
    --==========================================================

    local positionSection =
        self:CreateSection(
            tab,
            Library:GetText("Position")
        )

    positionSection:CreateButton(
        Library:GetText("Center"),
        function()

            self:Center()

        end
    )

    positionSection:CreateButton(
        Library:GetText("ResetPosition"),
        function()

            self:ResetPosition()

        end
    )

    --==========================================================
    -- RESET
    --==========================================================

    local resetSection =
        self:CreateSection(
            tab,
            Library:GetText("Reset")
        )

    resetSection:CreateButton(
        Library:GetText("ResetSettings"),
        function()

            for key, value in pairs(DefaultSettings) do

                Library.Settings[key] =
                    value

            end

            Library:SetTheme(
                "Purple"
            )

            Library:SetAccentColor(
                "Purple"
            )

            Library:RefreshAll()

            self:Notify({

                Title = "LONG",

                Content =
                    Library:GetText(
                        "Success"
                    ),

                Duration = 3,

            })

        end
    )

    resetSection:CreateButton(
        Library:GetText("ResetTheme"),
        function()

            Library:SetTheme(
                "Purple"
            )

            Library:SetAccentColor(
                "Purple"
            )

        end
    )

    --==========================================================
    -- WINDOW
    --==========================================================

    local windowSection =
        self:CreateSection(
            tab,
            Library:GetText("Library")
        )

    windowSection:CreateButton(
        Library:GetText("Restore"),
        function()

            self:ShowInstant()

        end
    )

    windowSection:CreateButton(
        Library:GetText("Hide"),
        function()

            self:HideInstant()

        end
    )

end

--==============================================================
-- REFRESH CORNERS
--==============================================================

function WindowObject:RefreshCorners()

    if not self.ScreenGui then
        return
    end

    for _, object in ipairs(
        self.ScreenGui:GetDescendants()
    ) do

        if object:IsA("UICorner") then

            pcall(function()

                object.CornerRadius =
                    UDim.new(
                        0,
                        Library.Settings.CornerRadius
                    )

            end)

        end

    end

end

--==============================================================
-- CLOSE CONFIRMATION
--==============================================================

function WindowObject:CreateCloseConfirmation()

    if not Library.Settings.CloseConfirmation then

        self:Destroy()

        return

    end

    if self.CloseConfirmation
        and self.CloseConfirmation.Parent
    then
        return
    end

    local overlay =
        New(
            "Frame",
            {

                Name =
                    "CloseConfirmation",

                Size =
                    UDim2.fromScale(
                        1,
                        1
                    ),

                BackgroundColor3 =
                    Color3.new(
                        0,
                        0,
                        0
                    ),

                BackgroundTransparency =
                    0.45,

                BorderSizePixel = 0,

                ZIndex = 1000,

                Parent =
                    self.ScreenGui,

            }
        )

    local box =
        New(
            "Frame",
            {

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    ),

                Size =
                    UDim2.fromOffset(
                        310,
                        160
                    ),

                BackgroundColor3 =
                    Library.Theme.Secondary,

                BorderSizePixel = 0,

                ZIndex = 1001,

                Parent = overlay,

            }
        )

    SetRole(
        box,
        "Secondary"
    )

    AddCorner(box, 12)

    AddStroke(
        box,
        Library.Theme.Border
    )

    local title =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        16,
                        13
                    ),

                Size =
                    UDim2.new(
                        1,
                        -32,
                        0,
                        28
                    ),

                BackgroundTransparency = 1,

                Text =
                    Library:GetText(
                        "CloseTitle"
                    ),

                Font =
                    Enum.Font.GothamBold,

                TextSize = 15,

                TextColor3 =
                    Library.Theme.Text,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                ZIndex = 1002,

                Parent = box,

            }
        )

    local message =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        16,
                        47
                    ),

                Size =
                    UDim2.new(
                        1,
                        -32,
                        0,
                        44
                    ),

                BackgroundTransparency = 1,

                Text =
                    Library:GetText(
                        "CloseMessage"
                    ),

                Font =
                    Library:GetFont(),

                TextSize = 12,

                TextWrapped = true,

                TextColor3 =
                    Library.Theme.SubText,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                ZIndex = 1002,

                Parent = box,

            }
        )

    local cancel =
        New(
            "TextButton",
            {

                Position =
                    UDim2.new(
                        0,
                        16,
                        1,
                        -50
                    ),

                Size =
                    UDim2.new(
                        0.5,
                        -21,
                        0,
                        35
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text =
                    Library:GetText(
                        "Cancel"
                    ),

                Font =
                    Enum.Font.GothamBold,

                TextSize = 12,

                TextColor3 =
                    Library.Theme.Text,

                ZIndex = 1002,

                Parent = box,

            }
        )

    SetRole(
        cancel,
        "Tertiary"
    )

    AddCorner(cancel, 8)

    local confirm =
        New(
            "TextButton",
            {

                AnchorPoint =
                    Vector2.new(
                        1,
                        0
                    ),

                Position =
                    UDim2.new(
                        1,
                        -16,
                        1,
                        -50
                    ),

                Size =
                    UDim2.new(
                        0.5,
                        -21,
                        0,
                        35
                    ),

                BackgroundColor3 =
                    Library.Theme.Danger,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text =
                    Library:GetText(
                        "Close"
                    ),

                Font =
                    Enum.Font.GothamBold,

                TextSize = 12,

                TextColor3 =
                    Color3.new(
                        1,
                        1,
                        1
                    ),

                ZIndex = 1002,

                Parent = box,

            }
        )

    AddCorner(confirm, 8)

    cancel.Activated:Connect(
        function()

            overlay:Destroy()

            self.CloseConfirmation =
                nil

        end
    )

    confirm.Activated:Connect(
        function()

            overlay:Destroy()

            self.CloseConfirmation =
                nil

            self:Destroy()

        end
    )

    self.CloseConfirmation =
        overlay

end

--==============================================================
-- GET KEY SYSTEM
--==============================================================
-- Optional.
--
-- Example:
--
-- local KeyWindow = Library:CreateKeySystem({
--     Title = "My Script",
--     Subtitle = "Enter your key",
--     Key = "1234",
--     GetKeyURL = "https://example.com/getkey",
--     VerifyCallback = function(key)
--         return key == "1234"
--     end,
--     OnSuccess = function(key)
--         print("KEY OK")
--     end
-- })
--
-- The normal Library window remains available.
--==============================================================

function Library:CreateKeySystem(options)

    options =
        options or {}

    local keyWindow = {}

    local screenGui =
        New(
            "ScreenGui",
            {

                Name =
                    "LONG_KeySystem",

                ResetOnSpawn = false,

                ZIndexBehavior =
                    Enum.ZIndexBehavior.Sibling,

                IgnoreGuiInset = true,

                Parent =
                    LocalPlayer:WaitForChild(
                        "PlayerGui"
                    ),

            }
        )

    local scale =
        New(
            "UIScale",
            {

                Scale = 1,

                Parent =
                    screenGui,

            }
        )

    local main =
        New(
            "Frame",
            {

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    ),

                Size =
                    UDim2.fromOffset(
                        options.Width
                        or 390,

                        options.Height
                        or 235
                    ),

                BackgroundColor3 =
                    Library.Theme.Background,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Background"
                    ),

                BorderSizePixel = 0,

                ClipsDescendants = true,

                Parent =
                    screenGui,

            }
        )

    SetRole(
        main,
        "Background"
    )

    AddCorner(
        main,
        Library.Settings.CornerRadius
    )

    AddStroke(
        main,
        Library.Theme.Border
    )

    --==========================================================
    -- TOP
    --==========================================================

    local title =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        22,
                        20
                    ),

                Size =
                    UDim2.new(
                        1,
                        -44,
                        0,
                        30
                    ),

                BackgroundTransparency = 1,

                Text =
                    options.Title
                    or "LONG KEY SYSTEM",

                Font =
                    Enum.Font.GothamBold,

                TextSize = 20,

                TextColor3 =
                    Library.Theme.Text,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent = main,

            }
        )

    local subtitle =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        22,
                        53
                    ),

                Size =
                    UDim2.new(
                        1,
                        -44,
                        0,
                        32
                    ),

                BackgroundTransparency = 1,

                Text =
                    options.Subtitle
                    or "Enter your key to continue.",

                Font =
                    Library:GetFont(),

                TextSize = 12,

                TextColor3 =
                    Library.Theme.SubText,

                TextWrapped = true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent = main,

            }
        )

    --==========================================================
    -- KEY BOX
    --==========================================================

    local keyBox =
        New(
            "TextBox",
            {

                Position =
                    UDim2.fromOffset(
                        22,
                        92
                    ),

                Size =
                    UDim2.new(
                        1,
                        -44,
                        0,
                        40
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Tertiary"
                    ),

                BorderSizePixel = 0,

                PlaceholderText =
                    Library:GetText(
                        "EnterKey"
                    ),

                Text = "",

                Font =
                    Library:GetFont(),

                TextSize = 13,

                TextColor3 =
                    Library.Theme.Text,

                PlaceholderColor3 =
                    Library.Theme.SubText,

                ClearTextOnFocus = false,

                Parent = main,

            }
        )

    SetRole(
        keyBox,
        "Tertiary"
    )

    AddCorner(keyBox, 8)

    --==========================================================
    -- VERIFY
    --==========================================================

    local verify =
        New(
            "TextButton",
            {

                Position =
                    UDim2.fromOffset(
                        22,
                        143
                    ),

                Size =
                    UDim2.new(
                        0.5,
                        -27,
                        0,
                        40
                    ),

                BackgroundColor3 =
                    Library.Theme.Accent,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text =
                    Library:GetText(
                        "Verify"
                    ),

                Font =
                    Enum.Font.GothamBold,

                TextSize = 13,

                TextColor3 =
                    Color3.new(
                        1,
                        1,
                        1
                    ),

                Parent = main,

            }
        )

    AddCorner(verify, 8)

    --==========================================================
    -- GET KEY
    --==========================================================

    local getKey =
        New(
            "TextButton",
            {

                AnchorPoint =
                    Vector2.new(
                        1,
                        0
                    ),

                Position =
                    UDim2.new(
                        1,
                        -22,
                        0,
                        143
                    ),

                Size =
                    UDim2.new(
                        0.5,
                        -27,
                        0,
                        40
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Tertiary"
                    ),

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text =
                    options.GetKeyText
                    or Library:GetText(
                        "GetKey"
                    ),

                Font =
                    Enum.Font.GothamBold,

                TextSize = 13,

                TextColor3 =
                    Library.Theme.Text,

                Parent = main,

            }
        )

    SetRole(
        getKey,
        "Tertiary"
    )

    AddCorner(getKey, 8)

    --==========================================================
    -- STATUS
    --==========================================================

    local status =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        22,
                        194
                    ),

                Size =
                    UDim2.new(
                        1,
                        -44,
                        0,
                        25
                    ),

                BackgroundTransparency = 1,

                Text = "",

                Font =
                    Enum.Font.Gotham,

                TextSize = 12,

                TextColor3 =
                    Library.Theme.SubText,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent = main,

            }
        )

    --==========================================================
    -- VERIFY FUNCTION
    --==========================================================

    local function verifyKey()

        local entered =
            keyBox.Text

        local valid = false

        if options.VerifyCallback then

            local success, result =
                pcall(
                    options.VerifyCallback,
                    entered
                )

            if success then
                valid = result == true
            end

        elseif options.Key then

            if type(options.Key) == "table" then

                for _, validKey in ipairs(
                    options.Key
                ) do

                    if entered == tostring(validKey) then
                        valid = true
                        break
                    end

                end

            else

                valid =
                    entered
                    == tostring(options.Key)

            end

        else

            -- If no verification rule is supplied,
            -- accept any non-empty key.
            valid =
                entered ~= ""

        end

        if valid then

            status.Text =
                Library:GetText(
                    "ValidKey"
                )

            status.TextColor3 =
                Library.Theme.On

            if options.OnSuccess then

                task.spawn(
                    options.OnSuccess,
                    entered
                )

            end

            if options.HideOnSuccess ~= false then

                task.delay(
                    0.25,
                    function()

                        if screenGui
                            and screenGui.Parent
                        then

                            screenGui:Destroy()

                        end

                    end
                )

            end

        else

            status.Text =
                Library:GetText(
                    "InvalidKey"
                )

            status.TextColor3 =
                Library.Theme.Danger

            if options.OnFailed then

                task.spawn(
                    options.OnFailed,
                    entered
                )

            end

        end

    end

    verify.Activated:Connect(
        verifyKey
    )

    keyBox.FocusLost:Connect(
        function(enterPressed)

            if enterPressed then
                verifyKey()
            end

        end
    )

    --==========================================================
    -- GET KEY CALLBACK / URL
    --==========================================================

    getKey.Activated:Connect(
        function()

            if options.GetKeyCallback then

                task.spawn(
                    options.GetKeyCallback
                )

                return

            end

            if options.GetKeyURL then

                pcall(
                    function()

                        if setclipboard then

                            setclipboard(
                                tostring(
                                    options.GetKeyURL
                                )
                            )

                        end

                    end
                )

                status.Text =
                    tostring(
                        options.GetKeyURL
                    )

                status.TextColor3 =
                    Library.Theme.Accent

                return

            end

            status.Text =
                "GetKeyURL not configured."

        end
    )

    keyWindow.ScreenGui =
        screenGui

    keyWindow.Main =
        main

    keyWindow.KeyBox =
        keyBox

    keyWindow.Status =
        status

    keyWindow.Verify =
        verify

    keyWindow.GetKey =
        getKey

    keyWindow.Close =
        function()

            if screenGui then
                screenGui:Destroy()
            end

        end

    keyWindow.Destroy =
        keyWindow.Close

    keyWindow.Show =
        function()

            main.Visible = true

        end

    keyWindow.Hide =
        function()

            main.Visible = false

        end

    return keyWindow

end

--==============================================================
-- WINDOW CREATION
--==============================================================

function Library:CreateWindow(options)

    options =
        options or {}

    local self =
        setmetatable(
            {},
            WindowObject
        )

    self.Connections = {}
    self.Tabs = {}
    self.ActiveTab = nil

    -- IMPORTANT:
    -- CreateSection references this window.
    selfWindow = self

    --==========================================================
    -- SCREEN GUI
    --==========================================================

    local screenGui =
        New(
            "ScreenGui",
            {

                Name =
                    options.Name
                    or "LONG_UI_LIBRARY",

                ResetOnSpawn = false,

                ZIndexBehavior =
                    Enum.ZIndexBehavior.Sibling,

                IgnoreGuiInset = true,

                Parent =
                    LocalPlayer:WaitForChild(
                        "PlayerGui"
                    ),

            }
        )

    self.ScreenGui =
        screenGui

    --==========================================================
    -- MAIN
    --==========================================================

    local main =
        New(
            "Frame",
            {

                Name = "Main",

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.fromScale(
                        0.5,
                        0.5
                    ),

                Size =
                    UDim2.fromOffset(
                        Library.Settings.MenuWidth,
                        Library.Settings.MenuHeight
                    ),

                BackgroundColor3 =
                    Library.Theme.Background,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Background"
                    ),

                BorderSizePixel = 0,

                ClipsDescendants = true,

                Parent =
                    screenGui,

            }
        )

    SetRole(
        main,
        "Background"
    )

    AddCorner(
        main,
        Library.Settings.CornerRadius
    )

    AddStroke(
        main,
        Library.Theme.Border
    )

    self.Main =
        main

    --==========================================================
    -- UI SCALE
    --==========================================================

    local uiScale =
        New(
            "UIScale",
            {

                Scale =
                    Library.Settings.UIScale
                    / 100,

                Parent =
                    main,

            }
        )

    self.UIScale =
        uiScale

    --==========================================================
    -- TOPBAR
    --==========================================================

    local topbar =
        New(
            "Frame",
            {

                Name = "Topbar",

                Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        56
                    ),

                BackgroundColor3 =
                    Library.Theme.Secondary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Secondary"
                    ),

                BorderSizePixel = 0,

                ClipsDescendants = true,

                Parent =
                    main,

            }
        )

    SetRole(
        topbar,
        "Secondary"
    )

    self.Topbar =
        topbar

    --==========================================================
    -- TITLE
    --==========================================================

    local title =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        16,
                        7
                    ),

                Size =
                    UDim2.new(
                        1,
                        -145,
                        0,
                        25
                    ),

                BackgroundTransparency = 1,

                Text =
                    options.Title
                    or "LONG",

                Font =
                    Enum.Font.GothamBold,

                TextSize = 17,

                TextColor3 =
                    Library.Theme.Text,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent =
                    topbar,

            }
        )

    local subtitle =
        New(
            "TextLabel",
            {

                Position =
                    UDim2.fromOffset(
                        16,
                        31
                    ),

                Size =
                    UDim2.new(
                        1,
                        -145,
                        0,
                        18
                    ),

                BackgroundTransparency = 1,

                Text =
                    options.Subtitle
                    or "LONG UI LIBRARY V12.0",

                Font =
                    Library:GetFont(),

                TextSize = 10,

                TextColor3 =
                    Library.Theme.SubText,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Parent =
                    topbar,

            }
        )

    self.Title =
        title

    self.Subtitle =
        subtitle

    --==========================================================
    -- HIDE
    --==========================================================

    local hide =
        New(
            "TextButton",
            {

                AnchorPoint =
                    Vector2.new(
                        1,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        1,
                        -52,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        40,
                        34
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text = "—",

                Font =
                    Enum.Font.GothamBold,

                TextSize = 18,

                TextColor3 =
                    Library.Theme.Text,

                Parent =
                    topbar,

            }
        )

    SetRole(
        hide,
        "Tertiary"
    )

    AddCorner(
        hide,
        8
    )

    --==========================================================
    -- CLOSE
    --==========================================================

    local close =
        New(
            "TextButton",
            {

                AnchorPoint =
                    Vector2.new(
                        1,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        1,
                        -8,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        40,
                        34
                    ),

                BackgroundColor3 =
                    Library.Theme.Danger,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text = "×",

                Font =
                    Enum.Font.GothamBold,

                TextSize = 19,

                TextColor3 =
                    Color3.new(
                        1,
                        1,
                        1
                    ),

                Parent =
                    topbar,

            }
        )

    AddCorner(
        close,
        8
    )

    self.HideButton =
        hide

    self.CloseButton =
        close

    --==========================================================
    -- SIDEBAR
    --==========================================================

    local sidebar =
        New(
            "Frame",
            {

                Name = "Sidebar",

                Position =
                    UDim2.fromOffset(
                        0,
                        56
                    ),

                Size =
                    UDim2.new(
                        0,
                        Library.Settings.SidebarWidth,
                        1,
                        -56
                    ),

                BackgroundColor3 =
                    Library.Theme.Secondary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Secondary"
                    ),

                BorderSizePixel = 0,

                ClipsDescendants = true,

                Parent =
                    main,

            }
        )

    SetRole(
        sidebar,
        "Secondary"
    )

    self.Sidebar =
        sidebar

    --==========================================================
    -- SEARCH
    --==========================================================

    local search =
        New(
            "TextBox",
            {

                Name = "Search",

                Position =
                    UDim2.fromOffset(
                        10,
                        10
                    ),

                Size =
                    UDim2.new(
                        1,
                        -20,
                        0,
                        38
                    ),

                BackgroundColor3 =
                    Library.Theme.Tertiary,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Tertiary"
                    ),

                BorderSizePixel = 0,

                PlaceholderText =
                    Library:GetText(
                        "Search"
                    ),

                Text = "",

                Font =
                    Library:GetFont(),

                TextSize = 12,

                TextColor3 =
                    Library.Theme.Text,

                PlaceholderColor3 =
                    Library.Theme.SubText,

                ClearTextOnFocus = false,

                Parent =
                    sidebar,

            }
        )

    SetRole(
        search,
        "Tertiary"
    )

    AddCorner(
        search,
        8
    )

    self.Search =
        search

    --==========================================================
    -- TAB LIST
    --==========================================================

    local tabList =
        New(
            "ScrollingFrame",
            {

                Name = "TabList",

                Position =
                    UDim2.fromOffset(
                        10,
                        58
                    ),

                Size =
                    UDim2.new(
                        1,
                        -20,
                        1,
                        -68
                    ),

                BackgroundTransparency = 1,

                BorderSizePixel = 0,

                ScrollBarThickness = 2,

                ScrollBarImageColor3 =
                    Library.Theme.Accent,

                AutomaticCanvasSize =
                    Enum.AutomaticSize.Y,

                CanvasSize =
                    UDim2.new(
                        0,
                        0,
                        0,
                        0
                    ),

                Parent =
                    sidebar,

            }
        )

    local tabLayout =
        New(
            "UIListLayout",
            {

                Padding =
                    UDim.new(
                        0,
                        8
                    ),

                SortOrder =
                    Enum.SortOrder.LayoutOrder,

                Parent =
                    tabList,

            }
        )

    self.TabList =
        tabList

    --==========================================================
    -- CONTENT
    --==========================================================

    local content =
        New(
            "Frame",
            {

                Name = "Content",

                Position =
                    UDim2.new(
                        0,
                        Library.Settings.SidebarWidth,
                        0,
                        56
                    ),

                Size =
                    UDim2.new(
                        1,
                        -Library.Settings.SidebarWidth,
                        1,
                        -56
                    ),

                BackgroundColor3 =
                    Library.Theme.Background,

                BackgroundTransparency =
                    Library:GetSurfaceTransparency(
                        "Background"
                    ),

                BorderSizePixel = 0,

                ClipsDescendants = true,

                Parent =
                    main,

            }
        )

    SetRole(
        content,
        "Background"
    )

    self.Content =
        content

    --==========================================================
    -- SEARCH
    --==========================================================

    search:GetPropertyChangedSignal(
        "Text"
    ):Connect(
        function()

            self:UpdateTabSearch(
                search.Text
            )

        end
    )

    --==========================================================
    -- HIDE
    --==========================================================

    hide.Activated:Connect(
        function()

            self:HideInstant()

        end
    )

    --==========================================================
    -- CLOSE
    --==========================================================

    close.Activated:Connect(
        function()

            self:CreateCloseConfirmation()

        end
    )

    --==========================================================
    -- DRAG
    --==========================================================

    self:BindDrag(
        topbar
    )

    --==========================================================
    -- VIEWPORT AUTO FIT
    --==========================================================

    local camera =
        workspace.CurrentCamera

    if camera then

        local connection =
            camera:GetPropertyChangedSignal(
                "ViewportSize"
            ):Connect(
                function()

                    if Library.Settings.AutoFitScreen then

                        self:ClampPosition()

                    end

                end
            )

        table.insert(
            self.Connections,
            connection
        )

    end

    --==========================================================
    -- SETTING
    --==========================================================

    self:CreateSettingTab()

    --==========================================================
    -- SETTING SHOULD NOT BE DEFAULT
    --==========================================================

    self:UpdateTabOrders()

    --==========================================================
    -- USER PROVIDED TABS
    --==========================================================

    if type(options.Tabs) == "table" then

        for _, tabInfo in ipairs(options.Tabs) do

            if type(tabInfo) == "table" then

                local tab =
                    self:CreateTab(
                        tabInfo.Name
                        or "Tab",

                        tabInfo.Icon
                    )

                if tabInfo.Callback then

                    task.spawn(
                        tabInfo.Callback,
                        tab
                    )

                end

            end

        end

    end

    --==========================================================
    -- DEFAULT TAB
    --==========================================================

    local firstUserTab

    for _, tab in ipairs(self.Tabs) do

        if not tab.IsSetting then

            firstUserTab =
                tab

            break

        end

    end

    if firstUserTab then

        self:SelectTab(
            firstUserTab
        )

    else

        self:SelectTab(
            self.SettingTab
        )

    end

    --==========================================================
    -- REGISTER WINDOW
    --==========================================================

    table.insert(
        self.Windows or {},
        self
    )

    table.insert(
        Library.Windows,
        self
    )

    --==========================================================
    -- INITIAL REFRESH
    --==========================================================

    task.defer(
        function()

            if self.Main
                and self.Main.Parent
            then

                self:Refresh()

            end

        end
    )

    return self

end

--==============================================================
-- LIBRARY REFRESH ALL
--==============================================================

function Library:RefreshAll()

    for _, window in ipairs(
        self.Windows
    ) do

        if window
            and window.Main
            and window.Main.Parent
        then

            window:RefreshTheme()
            window:RefreshCorners()

            if window.Search then

                window.Search.PlaceholderText =
                    self:GetText(
                        "Search"
                    )

            end

            if window.SettingTab then

                window.SettingTab.Label.Text =
                    self:GetText(
                        "Settings"
                    )

            end

        end

    end

end

--==============================================================
-- VALUE API
--==============================================================

function Library:SetValue(name, value)

    self.Values[name] =
        value

    return value

end

function Library:GetValue(name, default)

    local value =
        self.Values[name]

    if value == nil then
        return default
    end

    return value

end

--==============================================================
-- WINDOW DESTROY
--==============================================================

function WindowObject:Destroy()

    if self.Destroyed then
        return
    end

    self.Destroyed =
        true

    for _, connection in ipairs(
        self.Connections
    ) do

        pcall(function()
            connection:Disconnect()
        end)

    end

    self.Connections = {}

    if self.ScreenGui then

        pcall(function()
            self.ScreenGui:Destroy()
        end)

    end

    for index, window in ipairs(
        Library.Windows
    ) do

        if window == self then

            table.remove(
                Library.Windows,
                index
            )

            break

        end

    end

end

WindowObject.Unload =
    WindowObject.Destroy

--==============================================================
-- LIBRARY DESTROY
--==============================================================

function Library:Destroy()

    for _, window in ipairs(
        self.Windows
    ) do

        pcall(function()
            window:Destroy()
        end)

    end

    self.Windows = {}

end

Library.Unload =
    Library.Destroy

--==============================================================
-- GLOBAL POSITION / WINDOW HELPERS
--==============================================================

function Library:GetWindow()

    return self.Windows[1]

end

function Library:HideAll()

    for _, window in ipairs(
        self.Windows
    ) do

        pcall(function()
            window:HideInstant()
        end)

    end

end

function Library:ShowAll()

    for _, window in ipairs(
        self.Windows
    ) do

        pcall(function()
            window:ShowInstant()
        end)

    end

end

function Library:ToggleAll()

    for _, window in ipairs(
        self.Windows
    ) do

        pcall(function()
            window:Toggle()
        end)

    end

end

--==============================================================
-- ANIMATION API
--==============================================================

function Library:SetAnimationSpeed(value)

    value =
        math.clamp(
            tonumber(value) or 18,
            0,
            100
        )

    self.Settings.AnimationSpeed =
        value

    return true

end

function Library:GetAnimationSpeed()

    return self.Settings.AnimationSpeed

end

--==============================================================
-- CUSTOM UI CONFIG
--==============================================================
-- Không xoá giao diện mặc định.
-- Người tạo có thể chỉnh thêm:
--
-- Library.Settings.MenuWidth = 507
-- Library.Settings.MenuHeight = 384
-- Library.Settings.SidebarWidth = 145
-- Library.Settings.UIScale = 100
-- Library.Settings.CornerRadius = 10
-- Library.Settings.GlassMode = true
--
-- hoặc:
--
-- Library:SetTheme("Light")
-- Library:SetAccentColor("Red")
-- Library:SetLanguage("English")
-- Library:SetRGB(255, 120, 50)
--
--==============================================================

function Library:Configure(config)

    if type(config) ~= "table" then
        return false
    end

    for key, value in pairs(config) do

        if self.Settings[key] ~= nil then

            self.Settings[key] =
                value

        end

    end

    if config.Theme then

        self:SetTheme(
            config.Theme
        )

    end

    if config.Accent then

        self:SetAccentColor(
            config.Accent
        )

    end

    if config.Language then

        self:SetLanguage(
            config.Language
        )

    end

    if config.RGB then

        local rgb =
            config.RGB

        if type(rgb) == "table" then

            self:SetRGB(
                rgb[1],
                rgb[2],
                rgb[3]
            )

        end

    end

    self:RefreshAll()

    return true

end

--==============================================================
-- EXAMPLE API DOCUMENTATION
--==============================================================
--
-- local Library = loadstring(game:HttpGet("YOUR_LIBRARY_URL"))()
--
-- local Window = Library:CreateWindow({
--     Title = "My Script",
--     Subtitle = "LONG UI V12",
-- })
--
-- local MainTab =
--     Window:CreateTab("Main")
--
-- local Section =
--     Window:CreateSection(
--         MainTab,
--         "Main Features"
--     )
--
-- Section:CreateButton(
--     "Hello",
--     function()
--         print("Hello")
--     end
-- )
--
-- Section:CreateToggle(
--     "Auto Farm",
--     false,
--     function(value)
--         print(value)
--     end
-- )
--
-- Section:CreateSlider(
--     "Walk Speed",
--     16,
--     200,
--     16,
--     function(value)
--         print(value)
--     end
-- )
--
-- Section:CreateDropdown(
--     "Mode",
--     {
--         "Easy",
--         "Normal",
--         "Hard"
--     },
--     "Normal",
--     function(value)
--         print(value)
--     end
-- )
--
-- Section:CreateMultiDropdown(
--     "Targets",
--     {
--         "Players",
--         "NPC",
--         "Boss"
--     },
--     {
--         "Players"
--     },
--     function(values)
--     end
-- )
--
-- Section:CreateTextbox(
--     "Name",
--     "Enter name...",
--     "",
--     function(value)
--     end
-- )
--
-- Section:CreateKeybind(
--     "Toggle Menu",
--     Enum.KeyCode.RightShift,
--     function()
--         Window:Toggle()
--     end
-- )
--
--==============================================================
-- GET KEY EXAMPLE
--==============================================================
--
-- local KeyWindow =
--     Library:CreateKeySystem({
--
--     Title = "MY SCRIPT",
--
--     Subtitle =
--         "Enter the key to continue.",
--
--     Key = "LONG-123",
--
--     GetKeyURL =
--         "https://example.com/getkey",
--
--     OnSuccess =
--         function(key)
--
--             print(
--                 "Key accepted:",
--                 key
--             )
--
--         end,
--
-- })
--
--==============================================================
-- CUSTOM GET KEY VERIFICATION
--==============================================================
--
-- local KeyWindow =
--     Library:CreateKeySystem({
--
--     Title = "My Key System",
--
--     VerifyCallback =
--         function(key)
--
--             return key == "ABC123"
--
--         end,
--
--     GetKeyCallback =
--         function()
--
--             print("Open your own GetKey system")
--
--         end,
--
--     OnSuccess =
--         function()
--
--             print("Unlocked")
--
--         end,
--
-- })
--
--==============================================================
-- IMPORTANT
--==============================================================
-- Setting tab is always moved to the END.
--
-- Example:
--
-- Window:CreateTab("Main")
-- Window:CreateTab("Player")
-- Window:CreateTab("Combat")
-- Window:CreateTab("Visual")
-- Window:CreateTab("New Tab")
--
-- Result:
--
-- Main
-- Player
-- Combat
-- Visual
-- New Tab
-- Settings
--
--==============================================================

return Library
