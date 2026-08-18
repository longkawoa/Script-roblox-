-- Services Optimization
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser") -- Thêm VirtualUser cho chức năng Anti-AFK
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Global Configuration States
local Config = {
    AutoKill = false,
    SingleTarget = false,
    TargetPlayerName = "",
    
    AttackStyle = "Atomic", -- Atomic, Laying, Behind
    Distance = 8,
    Speed = 10,
    
    AutoClick = false,
    
    AutoKeys = {
        [Enum.KeyCode.One] = false,
        [Enum.KeyCode.Two] = false,
        [Enum.KeyCode.Three] = false,
        [Enum.KeyCode.Four] = false,
        [Enum.KeyCode.G] = false
    },
    
    SpectateTargetName = "",
    TeleportPlayerName = "",
    TeleportPlayerToggle = false,
    TeleportLocation = "Atoms",
    TeleportLocationToggle = false,
    
    AutoAFK = false -- Biến lưu trạng thái Auto AFK
}

local CurrentTarget = nil

-- Hệ thống Anti-AFK (Ngăn bị kích khỏi server)
LP.Idled:Connect(function()
    if Config.AutoAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Helper Function: Get list of player names
local function GetPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP then
            table.insert(names, player.Name)
        end
    end
    return names
end

-- Helper Function: Get closest player
local function GetClosestPlayer()
    local myChar = LP.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    
    local closestPlayer = nil
    local shortestDistance = math.huge
    local myPos = myChar.HumanoidRootPart.Position

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.Health > 0 then
                local distance = (myPos - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

-- Helper Function: Find Location Object anywhere in Workspace
local function FindLocationCFrame(locName)
    local targetObj = Workspace:FindFirstChild(locName, true)
    if targetObj then
        if targetObj:IsA("Model") then
            if targetObj.PrimaryPart then
                return targetObj.PrimaryPart.CFrame
            else
                local part = targetObj:FindFirstChildWhichIsA("BasePart", true)
                if part then return part.CFrame end
            end
        elseif targetObj:IsA("BasePart") then
            return targetObj.CFrame
        end
    end
    return nil
end

-- INIT KEY PRESS LOOPS
for keyCode, _ in pairs(Config.AutoKeys) do
    task.spawn(function()
        while task.wait(0.5) do
            if Config.AutoKeys[keyCode] and (Config.AutoKill or Config.SingleTarget) then
                VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
            end
        end
    end)
end

-- Auto Click Loop
task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoClick and (Config.AutoKill or Config.SingleTarget) then
            if LP.Character and LP.Character:FindFirstChild("Communicate") then
                LP.Character.Communicate:FireServer({
                    Mobile = true,
                    Goal = "LeftClick",
                    MousePos = CFrame.new(
                        440.95, 437.50, -36.83, 
                        -0.23, 0.13, -0.96, 
                        -0, 0.99, 0.13, 
                        0.97, 0.03, -0.22
                    )
                })
            end
        end
    end
end)

-- MAIN RENDER STEPPED LOOP
RunService.RenderStepped:Connect(function()
    -- Kiểm tra nhân vật của mình
    local myChar = LP.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    local myHRP = myChar.HumanoidRootPart

    -- No Clip during Auto Attack
    local shouldCollide = not (Config.AutoKill or Config.SingleTarget)
    for _, part in ipairs(myChar:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = shouldCollide
        end
    end

    -- Teleport Location Toggle Logic
    if Config.TeleportLocationToggle then
        local targetCFrame = FindLocationCFrame(Config.TeleportLocation)
        if targetCFrame then
            myHRP.CFrame = targetCFrame
        end
        return
    end

    -- Teleport Player Toggle Logic
    if Config.TeleportPlayerToggle then
        local p = Players:FindFirstChild(Config.TeleportPlayerName)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            myHRP.CFrame = p.Character.HumanoidRootPart.CFrame
        end
        return
    end

    -- Target selection logic
    if Config.AutoKill then
        if not CurrentTarget or not CurrentTarget.Character or not CurrentTarget.Character:FindFirstChild("Humanoid") or CurrentTarget.Character.Humanoid.Health <= 0 then
            CurrentTarget = GetClosestPlayer()
        end
    elseif Config.SingleTarget then
        CurrentTarget = Players:FindFirstChild(Config.TargetPlayerName)
    else
        CurrentTarget = nil
    end

    -- Orbit / Follow target logic
    if CurrentTarget and CurrentTarget.Character and CurrentTarget.Character:FindFirstChild("HumanoidRootPart") then
        local targetHRP = CurrentTarget.Character.HumanoidRootPart
        local targetPos = targetHRP.Position

        if Config.AttackStyle == "Atomic" or Config.AttackStyle == "Nguyên tử" then
            local t = tick() * (Config.Speed * 0.3)
            local x = Config.Distance * math.sin(t)
            local z = (Config.Distance * math.sin(2 * t)) / 2
            local y = (Config.Distance * 0.5) * math.cos(t * 1.5)
            myHRP.CFrame = CFrame.new(targetPos + Vector3.new(x, y, z), targetPos)

        elseif Config.AttackStyle == "Laying" or Config.AttackStyle == "Nằm" then
            myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, -Config.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)

        elseif Config.AttackStyle == "Behind" or Config.AttackStyle == "Sau lưng" then
            local offsetCFrame = targetHRP.CFrame * CFrame.new(0, 0, Config.Distance)
            myHRP.CFrame = CFrame.new(offsetCFrame.Position, offsetCFrame.Position + targetHRP.CFrame.LookVector)
        end
    end
end)

------------------------------------------------------------------------
-- SMALL TOGGLE GUI BUTTON
------------------------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "VietcoToggleBtn"
ToggleGui.ResetOnSpawn = false

local success = pcall(function() ToggleGui.Parent = CoreGui end)
if not success then ToggleGui.Parent = LP:WaitForChild("PlayerGui") end

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Parent = ToggleGui
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleBtn.Image = "rbxassetid://4500383345"
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

------------------------------------------------------------------------
-- KAVO UI LIBRARY INIT
------------------------------------------------------------------------
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local WindowName = "vietco hub  <font color='rgb(150,150,150)' size='12'>by nhatlong</font>"
local Window = Library.CreateLib(WindowName, "BloodTheme")

-- ==========================================
-- UI DRAG FIX & TOGGLE CONNECTIONS
-- ==========================================
task.spawn(function()
    local KavoMainFrame = nil
    
    for _, gui in pairs(CoreGui:GetDescendants()) do
        if gui:IsA("TextLabel") and gui.Text:find("vietco hub") then
            gui.RichText = true
        end
        
        if gui:IsA("Frame") and gui.Name == "Main" then
            gui.Active = true
            KavoMainFrame = gui
            
            local dragging, dragInput, dragStart, startPos
            
            gui.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = gui.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            gui.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if input == dragInput and dragging then
                    local delta = input.Position - dragStart
                    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
        end
    end
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if KavoMainFrame then
            KavoMainFrame.Visible = not KavoMainFrame.Visible
        end
    end)
end)

-- ==========================================
-- TAB 1: AUTO KILL
-- ==========================================
local Tab1 = Window:NewTab("Auto Kill")

local SecKill = Tab1:NewSection("Auto Attack Settings")
SecKill:NewToggle("Auto Kill (Nearest Target)", "Automatically locks and attacks closest player", function(state)
    Config.AutoKill = state
    if not state then CurrentTarget = nil end
end)

local SecSingle = Tab1:NewSection("Single Target Attack")
local DropdownSingle = SecSingle:NewDropdown("Select Player", "Choose target from player list", GetPlayerNames(), function(selected)
    Config.TargetPlayerName = selected
end)
SecSingle:NewButton("Refresh Player List", "Update server player list", function()
    DropdownSingle:Refresh(GetPlayerNames())
end)
SecSingle:NewToggle("Single Target Kill", "Lock and attack selected player", function(state)
    Config.SingleTarget = state
end)

local SecStyle = Tab1:NewSection("Attack Style Settings")
SecStyle:NewDropdown("Attack Style", "Select attack movement trajectory", {"Atomic", "Laying", "Behind"}, function(selected)
    Config.AttackStyle = selected
end)

local SecDistance = Tab1:NewSection("Distance Settings")
SecDistance:NewTextBox("Nhập Khoảng Cách (Distance)", "Ví dụ: 8", function(text)
    local val = tonumber(text)
    if val then Config.Distance = val end
end)

local SecSpeed = Tab1:NewSection("Speed Settings")
SecSpeed:NewTextBox("Nhập Tốc Độ (Speed)", "Ví dụ: 10", function(text)
    local val = tonumber(text)
    if val then Config.Speed = val end
end)

local SecSkills = Tab1:NewSection("Auto Skills & Auto Click")
SecSkills:NewToggle("Auto Attack (Click)", "Requires Auto Kill / Single Target", function(state)
    Config.AutoClick = state
end)
SecSkills:NewToggle("Auto Rage Skill [G]", "Requires Auto Kill / Single Target", function(state)
    Config.AutoKeys[Enum.KeyCode.G] = state
end)
SecSkills:NewToggle("Auto Skill 1", "Requires Auto Kill / Single Target", function(state)
    Config.AutoKeys[Enum.KeyCode.One] = state
end)
SecSkills:NewToggle("Auto Skill 2", "Requires Auto Kill / Single Target", function(state)
    Config.AutoKeys[Enum.KeyCode.Two] = state
end)
SecSkills:NewToggle("Auto Skill 3", "Requires Auto Kill / Single Target", function(state)
    Config.AutoKeys[Enum.KeyCode.Three] = state
end)
SecSkills:NewToggle("Auto Skill 4", "Requires Auto Kill / Single Target", function(state)
    Config.AutoKeys[Enum.KeyCode.Four] = state
end)

-- ==========================================
-- TAB 2: TELEPORT & SPECTATE
-- ==========================================
local Tab2 = Window:NewTab("Teleport")

local SecTelePlayer = Tab2:NewSection("Player Teleport")
local DropdownTelePlayer = SecTelePlayer:NewDropdown("Select Player", "Choose target player", GetPlayerNames(), function(selected)
    Config.TeleportPlayerName = selected
end)
SecTelePlayer:NewButton("Refresh List", "Refresh online player list", function()
    DropdownTelePlayer:Refresh(GetPlayerNames())
end)
SecTelePlayer:NewToggle("Teleport To Player", "Continuously teleport to selected player", function(state)
    Config.TeleportPlayerToggle = state
end)

local SecTelePlaces = Tab2:NewSection("Location Teleport")
SecTelePlaces:NewDropdown("Select Location", "Choose map hidden location", {"Atoms", "Death Cutscene"}, function(selected)
    Config.TeleportLocation = selected
end)
SecTelePlaces:NewToggle("Teleport To Location", "Teleport to chosen location (Atoms/Cutscene)", function(state)
    Config.TeleportLocationToggle = state
end)

-- LOGIC QUAN SÁT (ĐÃ CHUYỂN SANG DẠNG DROPDOWN VÀ GIỮ NÚT RESET)
local SecSpectate = Tab2:NewSection("Spectate / Quan sát")
local DropdownSpectate = SecSpectate:NewDropdown("Chọn Người Chơi", "Chọn tên từ danh sách", GetPlayerNames(), function(selected)
    Config.SpectateTargetName = selected
end)

SecSpectate:NewButton("Làm Mới Danh Sách", "Cập nhật danh sách người chơi", function()
    DropdownSpectate:Refresh(GetPlayerNames())
end)

SecSpectate:NewToggle("Quan sát / Hủy quan sát", "Bật để xem, tắt để về nhân vật của mình", function(state)
    if state then
        -- Logic Quan Sát theo Tên trong Dropdown
        local targetPlayer = Players:FindFirstChild(Config.SpectateTargetName)

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Lỗi hệ thống",
                Text = "Không tìm thấy người chơi hoặc người chơi đã thoát!",
                Duration = 3
            })
        end
    else
        -- Logic Hủy Quan Sát (Reset Player View)
        if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = LP.Character:FindFirstChildOfClass("Humanoid")
        end
    end
end)

-- ==========================================
-- TAB 3: SETTING
-- ==========================================
local Tab3 = Window:NewTab("Setting")

-- THÊM CHỨC NĂNG AUTO AFK THEO YÊU CẦU
local SecAFK = Tab3:NewSection("Chức Năng Treo Máy")
SecAFK:NewToggle("Auto AFK", "Treo máy không bị văng khỏi sever (Anti-Kick)", function(state)
    Config.AutoAFK = state
    if state then
        StarterGui:SetCore("SendNotification", {
            Title = "Auto AFK Bật",
            Text = "Bạn có thể treo máy bao lâu tùy thích!",
            Duration = 3
        })
    end
end)

local SecSetting = Tab3:NewSection("Quản Lý Menu")

local ConfirmClose = false
SecSetting:NewToggle("Xác nhận đóng Menu", "Bật cái này trước khi bấm nút Đóng bên dưới", function(state)
    ConfirmClose = state
end)

SecSetting:NewButton("Đóng hoàn toàn Menu", "Xóa UI khỏi game", function()
    if ConfirmClose then
        if ToggleGui then ToggleGui:Destroy() end
        
        for _, gui in ipairs(CoreGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                local textLabel = gui.Main:FindFirstChild("Title", true)
                if textLabel and textLabel.Text:find("vietco hub") then
                    gui:Destroy()
                end
            end
        end
        
        Config.AutoKill = false
        Config.SingleTarget = false
        Config.TeleportPlayerToggle = false
        Config.TeleportLocationToggle = false
        Config.AutoClick = false
        Config.AutoAFK = false -- Tắt AFK khi đóng menu
        
        for k, v in pairs(Config.AutoKeys) do
            Config.AutoKeys[k] = false
        end
        
        -- Hủy luôn quan sát nếu đang bật lúc xóa UI
        if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = LP.Character:FindFirstChildOfClass("Humanoid")
        end
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Cảnh báo!",
            Text = "Hãy bật 'Xác nhận đóng Menu' trước để tránh bấm nhầm.",
            Duration = 3
        })
    end
end)
