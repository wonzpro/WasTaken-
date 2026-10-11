--[[
    __        __         _____ ___  _  _______ _   _ 
    \ \      / /_ _ ___ |_   _/ _ \| |/ / ____| \ | |
     \ \ /\ / / _` / __|  | || | | | ' /|  _| |  \| |
      \ V  V / (_| \__ \  | || |_| | . \| |___| |\  |
       \_/\_/ \__,_|___/  |_| \___/|_|\_\_____|_| \_|
                                                     
    WasTaken Premium Muscle Legends Hub (Full Mega Edition)
    Theme: Cyber-Dark Purple
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:Service("VirtualUser")

-- =======================================================
-- CONFIG / AYARLAR (WasTaken Manuel Kontrol Paneli)
-- =======================================================
-- UYARI: Aşağıdaki tırnak içine, kendi oluşturduğunuz key.txt dosyasının GitHub RAW linkini yapıştırın!
local KeyRawUrl = "https://raw.githubusercontent.com/wonzpro/WasTaken-/refs/heads/main/key.txt"
local DiscordLink = "https://discord.gg/WasTaken" 
-- =======================================================

-- GitHub'dan şifreyi canlı çekme mekanizması
local success, fetchedKey = pcall(function()
    return game:HttpGet(KeyRawUrl)
end)

local CorrectKey = success and string.gsub(fetchedKey, "%s+", "") or "WasTakenAcilDurumKey"

-- Anti-AFK (Oyundan Atılmayı Engeller)
if getgenv().AntiAFK == nil then
    getgenv().AntiAFK = true
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- Bildirim Sistemi
local function SendNotification(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- GUI Tasarımı (Key Ekranı)
local KeyGui = Instance.new("ScreenGui")
KeyGui.Parent = game:GetService("CoreGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 350, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -175, 0.4, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui
KeyFrame.Active = true
KeyFrame.Draggable = true

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(140, 20, 255)
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Text = "WasTaken Hub - Key Verification"
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.TextSize = 16
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 10)

local KeyInfo = Instance.new("TextLabel", KeyFrame)
KeyInfo.Text = "Key almak için Discord sunucumuza katılın!"
KeyInfo.Position = UDim2.new(0, 0, 0, 50)
KeyInfo.Size = UDim2.new(1, 0, 0, 30)
KeyInfo.BackgroundTransparency = 1
KeyInfo.TextColor3 = Color3.fromRGB(200, 180, 220)
KeyInfo.TextSize = 14

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.PlaceholderText = "Anahtarı buraya yapıştırın..."
KeyInput.Size = UDim2.new(0, 280, 0, 35)
KeyInput.Position = UDim2.new(0, 35, 0, 90)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 30, 55)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput)

local DiscordBtn = Instance.new("TextButton", KeyFrame)
DiscordBtn.Text = "Discord Linkini Kopyala"
DiscordBtn.Size = UDim2.new(0, 135, 0, 35)
DiscordBtn.Position = UDim2.new(0, 35, 0, 145)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DiscordBtn)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Text = "Anahtarı Kontrol Et"
CheckBtn.Size = UDim2.new(0, 135, 0, 35)
CheckBtn.Position = UDim2.new(0, 180, 0, 145)
CheckBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 255)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CheckBtn)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    DiscordBtn.Text = "Kopyalandı!"
    task.wait(2)
    DiscordBtn.Text = "Discord Linkini Kopyala"
end)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()
        SendNotification("WasTaken Hub", "Giriş Başarılı! Arayüz Yükleniyor...", 4)
        task.wait(0.5)
        LoadMainHub()
    else
        CheckBtn.Text = "Hatalı Key!"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.wait(2)
        CheckBtn.Text = "Anahtarı Kontrol Et"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 255)
    end
end)

function LoadMainHub()
    local MainGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    _G.FastFarm = false
    _G.FastPushup = false
    _G.FastRebirth = false
    _G.AutoBoss = false
    _G.LockPos = false
    _G.AutoCrystal = false
    _G.AutoEvolve = false
    local SavedPos = nil
    
    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 480, 0, 380)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(140, 20, 255)
    
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
    
    local LogoText = Instance.new("TextLabel", TopBar)
    LogoText.Text = "🔱 WasTaken Hub Premium v2.0"
    LogoText.Size = UDim2.new(0, 300, 1, 0)
    LogoText.Position = UDim2.new(0, 15, 0, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.TextColor3 = Color3.fromRGB(180, 80, 255)
    LogoText.Font = Enum.Font.SourceSansBold
    LogoText.TextSize = 20
    LogoText.TextXAlignment = Enum.TextXAlignment.Left
    
    local MinimizeBtn = Instance.new("TextButton", TopBar)
    MinimizeBtn.Text = "—"
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -45, 0, 7)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 55)
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", MinimizeBtn)
    
    local MiniLogo = Instance.new("TextButton", MainGui)
    MiniLogo.Size = UDim2.new(0, 65, 0, 65)
    MiniLogo.Position = UDim2.new(0.02, 0, 0.8, 0)
    MiniLogo.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
    MiniLogo.Text = "WT"
    MiniLogo.TextColor3 = Color3.fromRGB(180, 80, 255)
    MiniLogo.Font = Enum.Font.SourceSansBold
    MiniLogo.TextSize = 24
    MiniLogo.Visible = false
    MiniLogo.Active = true
    MiniLogo.Draggable = true
    Instance.new("UICorner", MiniLogo).CornerRadius = UDim.new(0, 50)
    Instance.new("UIStroke", MiniLogo).Color = Color3.fromRGB(140, 20, 255)

    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
            MainFrame.Visible = false
            MiniLogo.Visible = true
            MiniLogo.Size = UDim2.new(0, 0, 0, 0)
            MiniLogo:TweenSize(UDim2.new(0, 65, 0, 65), "Out", "Back", 0.3, true)
        end)
    end)

    MiniLogo.MouseButton1Click:Connect(function()
        MiniLogo:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
            MiniLogo.Visible = false
            MainFrame.Visible = true
            MainFrame:TweenSize(UDim2.new(0, 480, 0, 380), "Out", "Back", 0.3, true)
        end)
    end)

    local function makeToggle(text, pos, callback)
        local btn = Instance.new("TextButton", MainFrame)
        btn.Size = UDim2.new(0, 210, 0, 40)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(30, 22, 45)
        btn.Text = text .. ": KAPALI"
        btn.TextColor3 = Color3.fromRGB(220, 200, 255)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        Instance.new("UICorner", btn)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(70, 45, 100)
        
        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            if state then
                btn.Text = text .. ": AÇIK"
                btn.BackgroundColor3 = Color3.fromRGB(80, 20, 140)
                stroke.Color = Color3.fromRGB(180, 80, 255)
            else
                btn.Text = text .. ": KAPALI"
                btn.BackgroundColor3 = Color3.fromRGB(30, 22, 45)
                stroke.Color = Color3.fromRGB(70, 45, 100)
            end
            callback(state)
        end)
        return btn
    end

    -- Özelliklerin Döngü Tanımlamaları
    makeToggle("Fast Kaldırma", UDim2.new(0, 20, 0, 60), function(val) _G.FastFarm = val end)
    task.spawn(function()
        while true do
            if _G.FastFarm then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then LocalPlayer.muscleEvent:FireServer("rep") end
            end
            task.wait(0.005)
        end
    end)

    makeToggle("Fast Şınav/Mekik", UDim2.new(0, 250, 0, 60), function(val) _G.FastPushup = val end)
    task.spawn(function()
        while true do
            if _G.FastPushup then
                if not LocalPlayer.Character:FindFirstChildOfClass("Tool") then LocalPlayer.muscleEvent:FireServer("pushups") end
            end
            task.wait(0.005)
        end
    end)

makeToggle("Fast Rebirth", UDim2.new(0, 20, 0, 110), function(val) _G.FastRebirth = val end)
task.spawn(function()
while true do
if _G.FastRebirth then LocalPlayer.muscleEvent:FireServer("rebirthRequest") end
task.wait(0.1)
end
end)
makeToggle("Auto Boss Killer", UDim2.new(0, 250, 0, 110), function(val) _G.AutoBoss = val end)
task.spawn(function()
while true do
if _G.AutoBoss then
for _, v in pairs(workspace:GetChildren()) do
if v:FindFirstChild("Humanoid") and (v.Name == "Magma Fiend" or v.Name == "🤖 Cyber Fiend 🤖" or v.Name == "Krampus") then
LocalPlayer.muscleEvent:FireServer("punch", v.Name)
end
end
end
task.wait(0.05)
end
end)
makeToggle("Lock Position (Safe)", UDim2.new(0, 20, 0, 160), function(val)
_G.LockPos = val
if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame
else
SavedPos = nil
end
end)
task.spawn(function()
while true do
if _G.LockPos and SavedPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos
end
task.wait(0.01)
end
end)
makeToggle("Auto Open Crystal", UDim2.new(0, 250, 0, 160), function(val) _G.AutoCrystal = val end)
task.spawn(function()
while true do
if _G.AutoCrystal then
game:GetService("Players").LocalPlayer.muscleEvent:FireServer("openCrystal", "Blue Crystal")
end
task.wait(0.5)
end
end)
makeToggle("Auto Evolve Pets", UDim2.new(0, 20, 0, 210), function(val) _G.AutoEvolve = val end)
task.spawn(function()
while true do
if _G.AutoEvolve then
game:GetService("Players").LocalPlayer.muscleEvent:FireServer("autoEvolvePet")
end
task.wait(1)
end
end)
local TeleportBtn = Instance.new("TextButton", MainFrame)
TeleportBtn.Size = UDim2.new(0, 210, 0, 40)
TeleportBtn.Position = UDim2.new(0, 250, 0, 210)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 70)
TeleportBtn.Text = "⚡ Efsanevi Kas Alanına Git"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBtn)
Instance.new("UIStroke", TeleportBtn).Color = Color3.fromRGB(140, 20, 255)
TeleportBtn.MouseButton1Click:Connect(function()
local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
if hrp then
hrp.CFrame = CFrame.new(-2500, 15, -2500)
SendNotification("WasTaken Hub", "Güvenli bölgeye ışınlanıldı!", 3)
end
end)
-- TextBox Girişleri (Hız ve Zıplama)
local SpeedInput = Instance.new("TextBox", MainFrame)
SpeedInput.PlaceholderText = "Hız Değeri Girin (Örn: 100)"
SpeedInput.Size = UDim2.new(0, 210, 0, 35)
SpeedInput.Position = UDim2.new(0, 20, 0, 265)
SpeedInput.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedInput)
Instance.new("UIStroke", SpeedInput).Color = Color3.fromRGB(100, 50, 150)
SpeedInput.FocusLost:Connect(function(enterPressed)
if enterPressed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
SendNotification("WasTaken Hub", "Hız güncellendi: " .. SpeedInput.Text, 3)
end
end)
local JumpInput = Instance.new("TextBox", MainFrame)
JumpInput.PlaceholderText = "Zıplama Gücü Girin (Örn: 120)"
JumpInput.Size = UDim2.new(0, 210, 0, 35)
JumpInput.Position = UDim2.new(0, 250, 0, 265)
JumpInput.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JumpInput)
Instance.new("UIStroke", JumpInput).Color = Color3.fromRGB(100, 50, 150)
JumpInput.FocusLost:Connect(function(enterPressed)
if enterPressed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50
SendNotification("WasTaken Hub", "Zıplama güncellendi: " .. JumpInput.Text, 3)
end
end)
local Footer = Instance.new("TextLabel", MainFrame)
Footer.Text = "🛡️ Powered by WasTaken Core Infrastructure"
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.BackgroundTransparency = 1
Footer.TextColor3 = Color3.fromRGB(110, 90, 130)
Footer.TextSize = 13
SendNotification("WasTaken Hub", "Sistem Kusursuz Olarak Aktif Edildi!", 5)
end
