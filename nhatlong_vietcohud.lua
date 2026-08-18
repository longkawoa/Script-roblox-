-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketPlaceService = game:GetService("MarketplaceService")

-- Configuration
local VALID_KEY = "nhatlongfree"
local SCRIPT_2_URL = "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/vietcohud-nokey-novip"
local AVATAR_ID = "rbxassetid://4500383345"
local NOTE_IMAGE_ID = "rbxassetid://3197615623"

-- Game Verification Data
local TargetGameNames = {
    ["the strongest battlegrounds"] = true,
    ["các chiến trường mạnh nhất"] = true
}

-- Fetch Current Game Name
local currentGameName = "Unknown Game"
pcall(function()
    local info = MarketPlaceService:GetProductInfo(game.PlaceId)
    currentGameName = info.Name
end)

local isCorrectGame = false
for targetName, _ in pairs(TargetGameNames) do
    if string.find(string.lower(currentGameName), string.lower(targetName)) then
        isCorrectGame = true
        break
    end
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GetKeyToVietCo"
ScreenGui.ResetOnSpawn = false

-- Secure parent attempt
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Main Frame (Đã đổi thành màu đen)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
-- Size & Position ban đầu để làm animation mở menu
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Đen tuyền
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Hiệu ứng Animation mở Menu đẹp mắt
local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 320),
    Position = UDim2.new(0.5, -210, 0.5, -160)
})
openTween:Play()

-- Viền màu xanh da trời bóng (Glowing Sky Blue Border)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(0, 191, 255) -- Xanh da trời
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Animation nhấp nháy cho viền bóng
task.spawn(function()
    while task.wait() do
        local tickTime = tick() * 3
        UIStroke.Transparency = 0.1 + math.abs(math.sin(tickTime)) * 0.4
        UIStroke.Thickness = 2 + math.abs(math.sin(tickTime)) * 2
    end
end)

-- Make GUI Draggable
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Avatar Image
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 60, 0, 60)
AvatarImage.Position = UDim2.new(0, 15, 0, 15)
AvatarImage.Image = AVATAR_ID
AvatarImage.BackgroundTransparency = 1
AvatarImage.AnchorPoint = Vector2.new(0.5, 0.5) -- Chuẩn bị tâm để xoay
AvatarImage.Position = UDim2.new(0, 45, 0, 45) 
AvatarImage.Parent = MainFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0) -- Tròn xoe để xoay đẹp hơn
AvatarCorner.Parent = AvatarImage

-- Animation Avatar xoay đẹp mắt
task.spawn(function()
    while task.wait() do
        AvatarImage.Rotation = AvatarImage.Rotation + 1.5
    end
end)

-- Game Display Container
local GameInfoContainer = Instance.new("Frame")
GameInfoContainer.Position = UDim2.new(0, 85, 0, 15)
GameInfoContainer.Size = UDim2.new(0, 320, 0, 60)
GameInfoContainer.BackgroundTransparency = 1
GameInfoContainer.Parent = MainFrame

-- Current Game Label (Top)
local CurrentGameLabel = Instance.new("TextLabel")
CurrentGameLabel.Size = UDim2.new(1, 0, 0, 25)
CurrentGameLabel.Position = UDim2.new(0, 0, 0, 0)
CurrentGameLabel.Text = "Current Game: " .. currentGameName
CurrentGameLabel.TextSize = 13
CurrentGameLabel.Font = Enum.Font.SourceSansBold
CurrentGameLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrentGameLabel.TextTruncate = Enum.TextTruncate.AtEnd
CurrentGameLabel.TextColor3 = isCorrectGame and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 60, 60)
CurrentGameLabel.BackgroundTransparency = 1
CurrentGameLabel.Parent = GameInfoContainer

-- Required Game Label (Bottom)
local RequiredGameLabel = Instance.new("TextLabel")
RequiredGameLabel.Size = UDim2.new(1, 0, 0, 25)
RequiredGameLabel.Position = UDim2.new(0, 0, 0, 25)
RequiredGameLabel.Text = "Required: The Strongest Battlegrounds"
RequiredGameLabel.TextSize = 12
RequiredGameLabel.Font = Enum.Font.SourceSans
RequiredGameLabel.TextXAlignment = Enum.TextXAlignment.Left
RequiredGameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
RequiredGameLabel.BackgroundTransparency = 1
RequiredGameLabel.Parent = GameInfoContainer

-- Tab Header (GetKey)
local KeyTabTitle = Instance.new("TextLabel")
KeyTabTitle.Size = UDim2.new(1, 0, 0, 30)
KeyTabTitle.Position = UDim2.new(0, 0, 0, 85)
KeyTabTitle.Text = "-- GET KEY TAB --"
KeyTabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTabTitle.Font = Enum.Font.SourceSansBold
KeyTabTitle.TextSize = 16
KeyTabTitle.BackgroundTransparency = 1
KeyTabTitle.Parent = MainFrame

-- Key TextBox Input
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 300, 0, 40)
KeyBox.Position = UDim2.new(0.5, -150, 0, 125)
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextSize = 14
KeyBox.Parent = MainFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 6)
KeyBoxCorner.Parent = KeyBox

-- Confirm Button
local ConfirmButton = Instance.new("TextButton")
ConfirmButton.Size = UDim2.new(0, 180, 0, 35)
ConfirmButton.Position = UDim2.new(0.5, -90, 0, 175)
ConfirmButton.Text = "CONFIRM"
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Đổi tone xanh cho hợp
ConfirmButton.Font = Enum.Font.SourceSansBold
ConfirmButton.TextSize = 15
ConfirmButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = ConfirmButton

-- Notification Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.Position = UDim2.new(0, 10, 0, 215)
StatusLabel.Text = ""
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = MainFrame

-- Note Image & Text
local NoteImage = Instance.new("ImageLabel")
NoteImage.Size = UDim2.new(0, 35, 0, 35)
NoteImage.Position = UDim2.new(0, 15, 1, -45)
NoteImage.Image = NOTE_IMAGE_ID
NoteImage.BackgroundTransparency = 1
NoteImage.Parent = MainFrame

local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, -70, 0, 45)
NoteLabel.Position = UDim2.new(0, 60, 1, -50)
NoteLabel.Text = "ghi chú: hãy tắt shitlock để dùng script\nxl vì scritp có khá nhiều lỗi nhưng tui sẽ update để fix"
NoteLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
NoteLabel.TextSize = 12
NoteLabel.Font = Enum.Font.SourceSans
NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
NoteLabel.TextWrapped = true
NoteLabel.BackgroundTransparency = 1
NoteLabel.Parent = MainFrame

-- Function: Play Notification Text
local function setStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

-- Button Animation & Click Logic
ConfirmButton.MouseEnter:Connect(function()
    TweenService:Create(ConfirmButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 191, 255)}):Play()
end)

ConfirmButton.MouseLeave:Connect(function()
    TweenService:Create(ConfirmButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
end)

ConfirmButton.MouseButton1Click:Connect(function()
    local inputKey = KeyBox.Text
    
    if not isCorrectGame then
        setStatus("Error: Invalid Game! Required: The Strongest Battlegrounds", Color3.fromRGB(255, 60, 60))
        return
    end
    
    if inputKey == VALID_KEY then
        setStatus("thành công đang loading script vietco hud", Color3.fromRGB(0, 255, 120))
        task.wait(1.5)
        
        -- Cấp hiệu ứng đóng nhẹ nhàng
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        closeTween.Completed:Wait()

        -- Close Main GUI
        ScreenGui:Destroy()
        
        -- Run Script 2
        task.spawn(function()
            loadstring(game:HttpGet(SCRIPT_2_URL))()
        end)
    else
        setStatus("Error: Incorrect Key! Please try again.", Color3.fromRGB(255, 60, 60))
    end
end)
