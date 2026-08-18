-- Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketPlaceService = game:GetService("MarketplaceService")

-- Configuration
local VALID_KEY = "nhatlongfree"
local SCRIPT_2_URL = "https://raw.githubusercontent.com/longkawoa/Script-roblox-/refs/heads/main/README.md"
local AVATAR_ID = "rbxassetid://4500383345"

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

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Rainbow UIStroke (Border)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Rainbow Animation
task.spawn(function()
    local hue = 0
    while task.wait() do
        hue = (hue + 0.005) % 1
        UIStroke.Color = Color3.fromHSV(hue, 0.8, 1)
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
AvatarImage.Parent = MainFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 8)
AvatarCorner.Parent = AvatarImage

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
ConfirmButton.BackgroundColor3 = Color3.fromRGB(50, 120, 240)
ConfirmButton.Font = Enum.Font.SourceSansBold
ConfirmButton.TextSize = 15
ConfirmButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = ConfirmButton

-- Notification Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.Position = UDim2.new(0, 10, 0, 220)
StatusLabel.Text = ""
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = MainFrame

-- Note Label (ShiftLock Notice)
local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, -20, 0, 30)
NoteLabel.Position = UDim2.new(0, 10, 1, -35)
NoteLabel.Text = "Note: Please turn off Shift Lock to use GUI properly."
NoteLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
NoteLabel.TextSize = 12
NoteLabel.Font = Enum.Font.SourceSans
NoteLabel.BackgroundTransparency = 1
NoteLabel.Parent = MainFrame

-- Function: Play Notification Text
local function setStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

-- Button Animation & Click Logic
ConfirmButton.MouseEnter:Connect(function()
    TweenService:Create(ConfirmButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 140, 255)}):Play()
end)

ConfirmButton.MouseLeave:Connect(function()
    TweenService:Create(ConfirmButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 120, 240)}):Play()
end)

ConfirmButton.MouseButton1Click:Connect(function()
    local inputKey = KeyBox.Text
    
    if not isCorrectGame then
        setStatus("Error: Invalid Game! Required: The Strongest Battlegrounds", Color3.fromRGB(255, 60, 60))
        return
    end
    
    if inputKey == VALID_KEY then
        setStatus("Success! Key verified. Loading Script 2...", Color3.fromRGB(0, 255, 120))
        task.wait(1.5)
        
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
