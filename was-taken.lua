--[[
    __        __         _____ ___  _  _______ _   _ 
    \ \      / /_ _ ___ |_   _/ _ \| |/ / ____| \ | |
     \ \ /\ / / _` / __|  | || | | | ' /|  _| |  \| |
      \ V  V / (_| \__ \  | || |_| | . \| |___| |\  |
       \_/\_/ \__,_|___/  |_| \___/|_|\_\_____|_| \_|
                                                     
    WasTaken Premium Muscle Legends Hub (v3.0 Ultimate Tab Edition)
    Theme: Cyber-Dark Purple & Metallic Dragon
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:Service("VirtualUser")

-- =======================================================
-- CONFIG / AYARLAR (WasTaken Manuel Kontrol Paneli)
-- =======================================================
local KeyRawUrl = "https://githubusercontent.com"
local DiscordLink = "https://discord.gg/WasTaken" 
local LogoAssetId = "rbxassetid://134267439126293" -- WasTaken Ejderha Logosu (Roblox Asset ID)
-- =======================================================

-- GitHub'dan şifreyi canlı çekme mekanizması
local success, fetchedKey = pcall(function()
    return game:HttpGet(KeyRawUrl)
end)
local CorrectKey = success and string.gsub(fetchedKey, "%s+", "") or "WasTaken2026"

-- Anti-AFK
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
        Duration = duration or 4;
    })
end

-- KEY GUI
local KeyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 360, 0, 240)
KeyFrame.Position = UDim2.new(0.5, -180, 0.4, -120)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", KeyFrame).Color = Color3.fromRGB(140, 20, 255)

local KeyLogo = Instance.new("ImageLabel", KeyFrame)
KeyLogo.Size = UDim2.new(0, 50, 0, 50)
KeyLogo.Position = UDim2.new(0.5, -25, 0, 15)
KeyLogo.BackgroundTransparency = 1
KeyLogo.Image = LogoAssetId

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.PlaceholderText = "WasTaken Erişim Anahtarı..."
KeyInput.Size = UDim2.new(0, 280, 0, 35)
KeyInput.Position = UDim2.new(0, 40, 0, 85)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local DiscordBtn = Instance.new("TextButton", KeyFrame)
DiscordBtn.Text = "Discord Get Key"
DiscordBtn.Size = UDim2.new(0, 135, 0, 35)
DiscordBtn.Position = UDim2.new(0, 40, 0, 140)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DiscordBtn)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Text = "Doğrula"
CheckBtn.Size = UDim2.new(0, 135, 0, 35)
CheckBtn.Position = UDim2.new(0, 185, 0, 140)
CheckBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 255)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CheckBtn)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    DiscordBtn.Text = "Link Kopyalandı!"
    task.wait(2)
    DiscordBtn.Text = "Discord Get Key"
end)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()
        SendNotification("WasTaken Hub", "Başarıyla Doğrulandı! Arayüz Açılıyor...", 3)
        LoadMainHub()
    else
        CheckBtn.Text = "Hatalı Anahtar!"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        task.wait(2)
        CheckBtn.Text = "Doğrula"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 255)
    end
end)

-- MAIN HUB YÜKLEME FONKSİYONU
function LoadMainHub()
    local MainGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    -- Küresel Döngü Değişkenleri
    _G.FastFarm = false
    _G.FastPushup = false
    _G.FastRebirth = false
    _G.AutoBoss = false
    _G.LockPos = false
    _G.AutoCrystal = false
    _G.AutoEvolve = false
    local SavedPos = nil

    -- Ana Menü Gövdesi
    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 560, 0, 400)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 16)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(140, 20, 255)

    -- Üst Bar (Top Bar)
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 12, 28)
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

    local HeaderLogo = Instance.new("ImageLabel", TopBar)
    HeaderLogo.Size = UDim2.new(0, 32, 0, 32)
    HeaderLogo.Position = UDim2.new(0, 12, 0, 6)
    HeaderLogo.BackgroundTransparency = 1
    HeaderLogo.Image = LogoAssetId

    local LogoText = Instance.new("TextLabel", TopBar)
    LogoText.Text = "WasTaken Hub v3.0"
    LogoText.Size = UDim2.new(0, 200, 1, 0)
    LogoText.Position = UDim2.new(0, 52, 0, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.TextColor3 = Color3.fromRGB(180, 80, 255)
    LogoText.Font = Enum.Font.SourceSansBold
    LogoText.TextSize = 18
    LogoText.TextXAlignment = Enum.TextXAlignment.Left

    local MinimizeBtn = Instance.new("TextButton", TopBar)
    MinimizeBtn.Text = "—"
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -45, 0, 7)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", MinimizeBtn)

    -- Küçük Logo Modu (Aşağı Alınca Çıkacak Yuvarlak Ejderha Butonu)
    local MiniLogo = Instance.new("ImageButton", MainGui)
    MiniLogo.Size = UDim2.new(0, 65, 0, 65)
    MiniLogo.Position = UDim2.new(0.02, 0, 0.8, 0)
    MiniLogo.BackgroundColor3 = Color3.fromRGB(20, 12, 28)
    MiniLogo.Image = LogoAssetId
    MiniLogo.Visible = false
    MiniLogo.Active = true
    MiniLogo.Draggable = true
    Instance.new("UICorner", MiniLogo).CornerRadius = UDim.new(0, 50)
    Instance.new("UIStroke", MiniLogo).Color = Color3.fromRGB(140, 20, 255)

    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true, function()
            MainFrame.Visible = false
            MiniLogo.Visible = true
            MiniLogo.Size = UDim2.new(0, 0, 0, 0)
            MiniLogo:TweenSize(UDim2.new(0, 65, 0, 65), "Out", "Back", 0.25, true)
        end)
    end)

    MiniLogo.MouseButton1Click:Connect(function()
        MiniLogo:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true, function()
            MiniLogo.Visible = false
            MainFrame.Visible = true
            MainFrame:TweenSize(UDim2.new(0, 560, 0, 400), "Out", "Back", 0.25, true)
        end)
    end)

    -- Sol Menü (Sidebar / Tabs Navigation)
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 140, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 12, 24)
    Sidebar.BorderSizePixel = 0

    -- Sağ İçerik Alanı (Container)
    local ContentContainer = Instance.new("Frame", MainFrame)
    ContentContainer.Size = UDim2.new(1, -140, 1, -45)
    ContentContainer.Position = UDim2.new(0, 140, 0, 45)
    ContentContainer.BackgroundTransparency = 1

    local tabs = {}
    local currentTab = nil

    local function createTab(name)
        local tabFrame = Instance.new("ScrollingFrame", ContentContainer)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        tabFrame.ScrollBarThickness = 4
        tabFrame.Visible = false
        
        local layout = Instance.new("UIListLayout", tabFrame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 10)
        
        local padding = Instance.new("UIPadding", tabFrame)
        padding.PaddingLeft = UDim.new(0, 15)
        padding.PaddingTop = UDim.new(0, 15)

        local tabButton = Instance.new("TextButton", Sidebar)
        tabButton.Size = UDim2.new(1, -10, 0, 35)
        tabButton.Position = UDim2.new(0, 5, 0, (#Sidebar:GetChildren() * 40) - 35)
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(180, 160, 200)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 14
        Instance.new("UICorner", tabButton)

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Frame.Visible = false
                t.Btn.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
                t.Btn.TextColor3 = Color3.fromRGB(180, 160, 200)
            end
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        tabs[name] = {Frame = tabFrame, Btn = tabButton}
        if currentTab == nil then
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            currentTab = name
end
return tabFrame
end
local function makeToggle(parent, text, callback)
local btn = Instance.new("TextButton", parent)
btn.Size = UDim2.new(0, 380, 0, 40)
btn.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
btn.Text = text .. ": KAPALI"
btn.TextColor3 = Color3.fromRGB(220, 200, 255)
btn.Font = Enum.Font.SourceSans
btn.TextSize = 14
Instance.new("UICorner", btn)
local stroke = Instance.new("UIStroke", btn)
stroke.Color = Color3.fromRGB(60, 40, 90)
local state = false
btn.MouseButton1Click:Connect(function()
state = not state
if state then
btn.Text = text .. ": AÇIK"
btn.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
stroke.Color = Color3.fromRGB(180, 80, 255)
else
btn.Text = text .. ": KAPALI"
btn.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
stroke.Color = Color3.fromRGB(60, 40, 90)
end
callback(state)
end)
return btn
end
-- SEKMELERİN OLUŞTURULMASI
local HomeTab = createTab("Ana Sayfa")
local FarmTab = createTab("Fast Farm")
-- İstediğin gibi Rebirth ve Boss kısımlarını tamamen ayırıp bağımsız sekmeler yaptık:
local RebirthTab = createTab("Rebirth Sistemi")
local BossTab = createTab("Boss & Savaş")
local CrystalTab = createTab("Kristal & Pet")
local TeleportTab = createTab("Işınlanma")
-- 1. ANA SAYFA SEKLESİ
local WelcomeYazi = Instance.new("TextLabel", HomeTab)
WelcomeYazi.Text = "WasTaken Premium Hub'a Hoş Geldiniz, " .. LocalPlayer.Name .. "!"
WelcomeYazi.Size = UDim2.new(0, 380, 0, 30)
WelcomeYazi.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeYazi.Font = Enum.Font.SourceSansBold
WelcomeYazi.TextSize = 16
WelcomeYazi.BackgroundTransparency = 1
-- 2. FAST FARM SEKLESİ
makeToggle(FarmTab, "Evrensel Fast Kaldırma", function(val) _G.FastFarm = val end)
task.spawn(function()
while true do
if _G.FastFarm then
local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool then LocalPlayer.muscleEvent:FireServer("rep") end
end
task.wait(0.005)
end
end)
makeToggle(FarmTab, "Fast Şınav/Mekik", function(val) _G.FastPushup = val end)
task.spawn(function()
while true do
if _G.FastPushup then
if not LocalPlayer.Character:FindFirstChildOfClass("Tool") then LocalPlayer.muscleEvent:FireServer("pushups") end
end
task.wait(0.005)
end
end)
makeToggle(FarmTab, "Lock Position (Safe Kasılma)", function(val)
_G.LockPos = val
if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame
else SavedPos = nil end
end)
task.spawn(function()
while true do
if _G.LockPos and SavedPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos
end
task.wait(0.01)
end
end)
-- 3. REBIRTH SEKLESİ (Tamamen Bağımsız Alan)
makeToggle(RebirthTab, "Oto Hızlı Rebirth (Fast Rebirth)", function(val) _G.FastRebirth = val end)
task.spawn(function()
while true do
if _G.FastRebirth then LocalPlayer.muscleEvent:FireServer("rebirthRequest") end
task.wait(0.1)
end
end)
-- 4. BOSS & SAVAŞ SEKLESİ (Tamamen Bağımsız Alan)
makeToggle(BossTab, "Otomatik Tüm Bossları Kes", function(val) _G.AutoBoss = val end)
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
-- 5. KRİSTAL & PET SEKLESİ
makeToggle(CrystalTab, "Oto Mavi Kristal Aç", function(val) _G.AutoCrystal = val end)
task.spawn(function()
while true do
if _G.AutoCrystal then LocalPlayer.muscleEvent:FireServer("openCrystal", "Blue Crystal") end
task.wait(0.5)
end
end)
makeToggle(CrystalTab, "Oto Pet Evrimleştir (Auto Evolve)", function(val) _G.AutoEvolve = val end)
task.spawn(function()
while true do
if _G.AutoEvolve then LocalPlayer.muscleEvent:FireServer("autoEvolvePet") end
task.wait(1)
end
end)
-- 6. IŞINLANMA VE STAT AYARLARI SEKLESİ
local TeleportBtn = Instance.new("TextButton", TeleportTab)
TeleportBtn.Size = UDim2.new(0, 380, 0, 40)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 70)
TeleportBtn.Text = "⚡ Efsanevi Kas Alanına Işınlan"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBtn)
TeleportBtn.MouseButton1Click:Connect(function()
local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
if hrp then
hrp.CFrame = CFrame.new(-2500, 15, -2500)
SendNotification("WasTaken Hub", "Efsanevi alana ışınlanıldı!", 2)
end
end)
local SpeedInput = Instance.new("TextBox", TeleportTab)
SpeedInput.PlaceholderText = "Karakter Hızı Ayarla (Örn: 100)"
SpeedInput.Size = UDim2.new(0, 380, 0, 35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedInput)
SpeedInput.FocusLost:Connect(function(enterPressed)
if enterPressed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
end
end)
local JumpInput = Instance.new("TextBox", TeleportTab)
JumpInput.PlaceholderText = "Zıplama Gücü Ayarla (Örn: 120)"
JumpInput.Size = UDim2.new(0, 380, 0, 35)
JumpInput.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JumpInput)
JumpInput.FocusLost:Connect(function(enterPressed)
if enterPressed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50
end
end)
end
