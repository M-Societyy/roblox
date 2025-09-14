local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Configuración mejorada con keybinds
local msocietyConfig = {
    walkSpeed = 36,
    jumpPower = 50,
    flySpeed = 95,
    aimbotFOV = 150,
    aimbotSmoothness = 0.15,
    espEnabled = false,
    flyEnabled = false,
    noclipEnabled = false,
    speedEnabled = false,
    jumpEnabled = false,
    aimbotEnabled = false,
    invisibilityEnabled = false,
    keybinds = {
        fly = Enum.KeyCode.F,
        noclip = Enum.KeyCode.N,
        speed = Enum.KeyCode.G,
        esp = Enum.KeyCode.E,
        aimbot = Enum.KeyCode.T
    }
}

-- Animación de inicio completamente rediseñada y más elegante
local function createWelcomeAnimation()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MSocietyWelcome"
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(2, 2, 8)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 20)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(40, 10, 80)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(80, 20, 120)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 2, 8))
    }
    gradient.Parent = frame
    
    spawn(function()
        while frame.Parent do
            local rotationTween = TweenService:Create(gradient, TweenInfo.new(8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
                Rotation = 360
            })
            rotationTween:Play()
            wait(8)
        end
    end)
    
    local particles = {}
    for i = 1, 50 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 12), 0, math.random(2, 12))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
        particle.BorderSizePixel = 0
        particle.BackgroundTransparency = 0.1
        particle.Parent = frame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        local glow = Instance.new("UIStroke")
        glow.Color = Color3.fromRGB(255, 255, 255)
        glow.Thickness = 1
        glow.Transparency = 0.5
        glow.Parent = particle
        
        table.insert(particles, particle)
        
        spawn(function()
            while particle.Parent do
                local moveTween = TweenService:Create(particle, TweenInfo.new(math.random(4, 10), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundTransparency = math.random(0.05, 0.8),
                    BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
                })
                moveTween:Play()
                
                local glowTween = TweenService:Create(glow, TweenInfo.new(math.random(2, 6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Transparency = math.random(0.2, 0.9)
                })
                glowTween:Play()
                
                wait(math.random(3, 8))
            end
        end)
    end
    
    local centerFrame = Instance.new("Frame")
    centerFrame.Size = UDim2.new(0.85, 0, 0.4, 0)
    centerFrame.Position = UDim2.new(0.075, 0, 0.3, 0)
    centerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    centerFrame.BackgroundTransparency = 0.05
    centerFrame.BorderSizePixel = 0
    centerFrame.Parent = frame
    
    local centerCorner = Instance.new("UICorner")
    centerCorner.CornerRadius = UDim.new(0, 35)
    centerCorner.Parent = centerFrame
    
    local centerStroke = Instance.new("UIStroke")
    centerStroke.Color = Color3.fromRGB(255, 100, 255)
    centerStroke.Thickness = 6
    centerStroke.Parent = centerFrame
    
    local centerGradient = Instance.new("UIGradient")
    centerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
    }
    centerGradient.Parent = centerStroke
    
    spawn(function()
        while centerFrame.Parent do
            local strokeTween = TweenService:Create(centerGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
                Rotation = 360
            })
            strokeTween:Play()
            wait(3)
        end
    end)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.35, 0)
    titleLabel.Position = UDim2.new(0, 0, 0.05, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "M-SOCIETY ULTIMATE"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextStrokeTransparency = 0
    titleLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 255)
    titleLabel.TextTransparency = 1
    titleLabel.Parent = centerFrame
    
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Size = UDim2.new(1, 0, 0.25, 0)
    welcomeLabel.Position = UDim2.new(0, 0, 0.45, 0)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "Welcome " .. player.Name .. " to the Ultimate Experience"
    welcomeLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    welcomeLabel.TextScaled = true
    welcomeLabel.Font = Enum.Font.Gotham
    welcomeLabel.TextStrokeTransparency = 0
    welcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    welcomeLabel.TextTransparency = 1
    welcomeLabel.Parent = centerFrame
    
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, 0, 0.15, 0)
    versionLabel.Position = UDim2.new(0, 0, 0.75, 0)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "Premium Edition v3.0 | 100+ Features"
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    versionLabel.TextScaled = true
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextStrokeTransparency = 0
    versionLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    versionLabel.TextTransparency = 1
    versionLabel.Parent = centerFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0.08, 0)
    statusLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Initializing M-Society Ultimate Systems..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextTransparency = 1
    statusLabel.Parent = frame
    
    local progressFrame = Instance.new("Frame")
    progressFrame.Size = UDim2.new(0.9, 0, 0, 8)
    progressFrame.Position = UDim2.new(0.05, 0, 0.88, 0)
    progressFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    progressFrame.BorderSizePixel = 0
    progressFrame.Parent = frame
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressFrame
    
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.Position = UDim2.new(0, 0, 0, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = progressFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = progressBar
    
    local barGradient = Instance.new("UIGradient")
    barGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
    }
    barGradient.Parent = progressBar
    
    spawn(function()
        while progressBar.Parent do
            local gradientTween = TweenService:Create(barGradient, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
                Rotation = 360
            })
            gradientTween:Play()
            wait(2)
        end
    end)
    
    local fadeInCenter = TweenService:Create(centerFrame, TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.02})
    local fadeInTitle = TweenService:Create(titleLabel, TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    local fadeInWelcome = TweenService:Create(welcomeLabel, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    local fadeInVersion = TweenService:Create(versionLabel, TweenInfo.new(3.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    local fadeInStatus = TweenService:Create(statusLabel, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    
    fadeInCenter:Play()
    wait(0.5)
    fadeInTitle:Play()
    wait(0.6)
    fadeInWelcome:Play()
    wait(0.7)
    fadeInVersion:Play()
    wait(0.8)
    fadeInStatus:Play()
    
    spawn(function()
        local loadingMessages = {
            "Loading M-Society core architecture...",
            "Initializing premium ESP engine...",
            "Setting up advanced movement systems...",
            "Configuring precision aimbot technology...",
            "Loading visual effects engine...",
            "Preparing keybind management system...",
            "Initializing anti-detection protocols...",
            "Loading 100+ premium features...",
            "Finalizing M-Society Ultimate experience...",
            "Ready to dominate! Welcome to M-Society Ultimate"
        }
        
        for i, message in ipairs(loadingMessages) do
            statusLabel.Text = message
            local progressTween = TweenService:Create(progressBar, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(i / #loadingMessages, 0, 1, 0)
            })
            progressTween:Play()
            wait(1.3)
        end
        
        wait(2)
        
        local fadeOutFrame = TweenService:Create(frame, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        local fadeOutCenter = TweenService:Create(centerFrame, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        local fadeOutTitle = TweenService:Create(titleLabel, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
        local fadeOutWelcome = TweenService:Create(welcomeLabel, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
        local fadeOutVersion = TweenService:Create(versionLabel, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
        local fadeOutStatus = TweenService:Create(statusLabel, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
        local fadeOutProgress = TweenService:Create(progressFrame, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        local fadeOutBar = TweenService:Create(progressBar, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        
        fadeOutFrame:Play()
        fadeOutCenter:Play()
        fadeOutTitle:Play()
        fadeOutWelcome:Play()
        fadeOutVersion:Play()
        fadeOutStatus:Play()
        fadeOutProgress:Play()
        fadeOutBar:Play()
        
        fadeOutFrame.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

createWelcomeAnimation()
wait(12)

local Window = OrionLib:MakeWindow({
    Name = "M-Society | Ultimate Script v3.0", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MSocietyUltimate",
    IntroText = "M-Society Ultimate Premium - Discord: https://discord.gg/9QRngbrMKS"
})

-- Datos actualizados y expandidos
local brainrotData = {
    ["Bunny Femboy"] = {MoneyPerSecond = 3},
    ["Cat Femboy"] = {MoneyPerSecond = 5},
    ["Empl*yed Femboy"] = {MoneyPerSecond = 9},
    ["Chihiro Fujisaki"] = {MoneyPerSecond = 11},
    ["Astolfo"] = {MoneyPerSecond = 13},
    ["Felix Argyle"] = {MoneyPerSecond = 15},
    ["Bridget"] = {MoneyPerSecond = 17},
    ["Venti"] = {MoneyPerSecond = 19},
    ["Nagisa Shiota"] = {MoneyPerSecond = 21},
    ["Hideri Kanzaki"] = {MoneyPerSecond = 23},
    ["Ruka Urushibara"] = {MoneyPerSecond = 25},
    ["Totsuka Saika"] = {MoneyPerSecond = 27},
    ["Gasper Vladi"] = {MoneyPerSecond = 29},
    ["Rimuru Tempest"] = {MoneyPerSecond = 31},
    ["Najimi Osana"] = {MoneyPerSecond = 33},
    ["Haku"] = {MoneyPerSecond = 35},
    ["Kurapika"] = {MoneyPerSecond = 37},
    ["Crona"] = {MoneyPerSecond = 39},
    ["Pico"] = {MoneyPerSecond = 41},
    ["Marulk"] = {MoneyPerSecond = 43},
    ["Pitou"] = {MoneyPerSecond = 45},
    ["Alluka Zoldyck"] = {MoneyPerSecond = 47},
    ["Shinji Ikari"] = {MoneyPerSecond = 49},
    ["Yukimura"] = {MoneyPerSecond = 51},
    ["Kuranosuke"] = {MoneyPerSecond = 53},
    ["Hime Arikawa"] = {MoneyPerSecond = 55},
    ["Jun Watarase"] = {MoneyPerSecond = 57},
    ["Makoto Tachibana"] = {MoneyPerSecond = 59},
    ["Ryoji Fujioka"] = {MoneyPerSecond = 61},
    ["Kaoru Hanase"] = {MoneyPerSecond = 63}
}

-- Sistema de keybinds mejorado
local keybindConnections = {}

local function setupKeybinds()
    for action, keycode in pairs(msocietyConfig.keybinds) do
        if keybindConnections[action] then
            keybindConnections[action]:Disconnect()
        end
        
        keybindConnections[action] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == keycode then
                if action == "fly" then
                    msocietyConfig.flyEnabled = not msocietyConfig.flyEnabled
                    toggleFly(msocietyConfig.flyEnabled)
                elseif action == "noclip" then
                    msocietyConfig.noclipEnabled = not msocietyConfig.noclipEnabled
                    toggleNoclip(msocietyConfig.noclipEnabled)
                elseif action == "speed" then
                    msocietyConfig.speedEnabled = not msocietyConfig.speedEnabled
                    toggleSpeed(msocietyConfig.speedEnabled)
                elseif action == "esp" then
                    msocietyConfig.espEnabled = not msocietyConfig.espEnabled
                    toggleESP(msocietyConfig.espEnabled)
                elseif action == "aimbot" then
                    msocietyConfig.aimbotEnabled = not msocietyConfig.aimbotEnabled
                    toggleAimbot(msocietyConfig.aimbotEnabled)
                end
            end
        end)
    end
end

local MainTab = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Pestañas reorganizadas y mejoradas
local AutomationTab = Window:MakeTab({
    Name = "Automatizacion",
    Icon = "rbxassetid://6022668955",
    PremiumOnly = false
})

local ESPTab = Window:MakeTab({
    Name = "ESP Premium",
    Icon = "rbxassetid://6253258591",
    PremiumOnly = false
})

local MovementTab = Window:MakeTab({
    Name = "Movimiento",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local CombatTab = Window:MakeTab({
    Name = "Combate",
    Icon = "rbxassetid://6031265976",
    PremiumOnly = false
})

local VisualsTab = Window:MakeTab({
    Name = "Visuales",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

local UtilityTab = Window:MakeTab({
    Name = "Utilidades",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

local KeybindsTab = Window:MakeTab({
    Name = "Keybinds",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

local FunTab = Window:MakeTab({
    Name = "Diversion",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

local StatsTab = Window:MakeTab({
    Name = "Estadisticas",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

local InfoTab = Window:MakeTab({
    Name = "Informacion",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

-- Sección de keybinds completamente nueva
local keybindsSection = KeybindsTab:AddSection({
    Name = "Configuracion de Keybinds M-Society"
})

keybindsSection:AddDropdown({
    Name = "Keybind para Vuelo",
    Default = "F",
    Options = {"F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
    Callback = function(Value)
        local keycode = Enum.KeyCode[Value]
        if keycode then
            msocietyConfig.keybinds.fly = keycode
            setupKeybinds()
            OrionLib:MakeNotification({
                Name = "Keybind Actualizado",
                Content = "Vuelo asignado a: " .. Value,
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

keybindsSection:AddDropdown({
    Name = "Keybind para Noclip",
    Default = "N",
    Options = {"F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
    Callback = function(Value)
        local keycode = Enum.KeyCode[Value]
        if keycode then
            msocietyConfig.keybinds.noclip = keycode
            setupKeybinds()
            OrionLib:MakeNotification({
                Name = "Keybind Actualizado",
                Content = "Noclip asignado a: " .. Value,
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

keybindsSection:AddDropdown({
    Name = "Keybind para Speed",
    Default = "G",
    Options = {"F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
    Callback = function(Value)
        local keycode = Enum.KeyCode[Value]
        if keycode then
            msocietyConfig.keybinds.speed = keycode
            setupKeybinds()
            OrionLib:MakeNotification({
                Name = "Keybind Actualizado",
                Content = "Speed asignado a: " .. Value,
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

keybindsSection:AddDropdown({
    Name = "Keybind para ESP",
    Default = "E",
    Options = {"E", "R", "T", "Y", "U", "I", "O", "P", "Q", "W"},
    Callback = function(Value)
        local keycode = Enum.KeyCode[Value]
        if keycode then
            msocietyConfig.keybinds.esp = keycode
            setupKeybinds()
            OrionLib:MakeNotification({
                Name = "Keybind Actualizado",
                Content = "ESP asignado a: " .. Value,
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

keybindsSection:AddDropdown({
    Name = "Keybind para Aimbot",
    Default = "T",
    Options = {"E", "R", "T", "Y", "U", "I", "O", "P", "Q", "W"},
    Callback = function(Value)
        local keycode = Enum.KeyCode[Value]
        if keycode then
            msocietyConfig.keybinds.aimbot = keycode
            setupKeybinds()
            OrionLib:MakeNotification({
                Name = "Keybind Actualizado",
                Content = "Aimbot asignado a: " .. Value,
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

-- Sección de diversión con funciones graciosas
local funSection = FunTab:AddSection({
    Name = "Funciones Divertidas M-Society"
})

funSection:AddButton({
    Name = "Baile Aleatorio",
    Callback = function()
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local danceIds = {"507766388", "507766666", "507766951", "507777268", "507777451"}
            local randomDance = danceIds[math.random(1, #danceIds)]
            
            local humanoid = character.Humanoid
            local animator = humanoid:FindFirstChild("Animator")
            if animator then
                local danceAnimation = Instance.new("Animation")
                danceAnimation.AnimationId = "rbxassetid://" .. randomDance
                local danceTrack = animator:LoadAnimation(danceAnimation)
                danceTrack:Play()
                
                OrionLib:MakeNotification({
                    Name = "Baile M-Society",
                    Content = "Bailando con estilo premium!",
                    Image = "rbxassetid://6031075938",
                    Time = 3
                })
            end
        end
    end
})

funSection:AddButton({
    Name = "Cambiar Nombre Aleatorio",
    Callback = function()
        local funnyNames = {
            "M-Society Pro", "Ultimate Hacker", "Premium User", "Elite Member",
            "Script Master", "Roblox Legend", "M-Society VIP", "Ultimate Player"
        }
        local randomName = funnyNames[math.random(1, #funnyNames)]
        
        if player.Character and player.Character:FindFirstChild("Head") then
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Parent = player.Character.Head
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = randomName
            nameLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Parent = billboard
            
            OrionLib:MakeNotification({
                Name = "Nombre Cambiado",
                Content = "Nuevo nombre: " .. randomName,
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        end
    end
})

funSection:AddButton({
    Name = "Efecto Explosion",
    Callback = function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local explosion = Instance.new("Explosion")
            explosion.Position = character.HumanoidRootPart.Position
            explosion.BlastRadius = 50
            explosion.BlastPressure = 0
            explosion.Parent = workspace
            
            OrionLib:MakeNotification({
                Name = "Explosion M-Society",
                Content = "Efecto de explosion activado!",
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        end
    end
})

-- Más funciones útiles agregadas
local utilitySection = UtilityTab:AddSection({
    Name = "Utilidades Avanzadas M-Society"
})

utilitySection:AddToggle({
    Name = "Invisibilidad M-Society",
    Default = false,
    Callback = function(Value)
        msocietyConfig.invisibilityEnabled = Value
        local character = player.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = Value and 1 or 0
                elseif part:IsA("Accessory") then
                    local handle = part:FindFirstChild("Handle")
                    if handle then
                        handle.Transparency = Value and 1 or 0
                    end
                end
            end
            
            local head = character:FindFirstChild("Head")
            if head then
                local face = head:FindFirstChild("face")
                if face then
                    face.Transparency = Value and 1 or 0
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Invisibilidad Activada" or "Invisibilidad Desactivada",
            Content = Value and "Ahora eres invisible" or "Visibilidad restaurada",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    end
})

utilitySection:AddButton({
    Name = "Teletransporte a Spawn",
    Callback = function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
            OrionLib:MakeNotification({
                Name = "Teletransporte Exitoso",
                Content = "Teletransportado al spawn",
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

utilitySection:AddButton({
    Name = "Resetear Personaje",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
            OrionLib:MakeNotification({
                Name = "Personaje Reseteado",
                Content = "Personaje reseteado exitosamente",
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
})

-- Configurar keybinds al inicio
setupKeybinds()

-- Secciones existentes mejoradas
local automationSection = AutomationTab:AddSection({
    Name = "Auto-Collect M-Society Premium"
})

local espSection = ESPTab:AddSection({
    Name = "ESP Avanzado M-Society"
})

local movementSection = MovementTab:AddSection({
    Name = "Movimiento Premium M-Society"
})

local combatSection = CombatTab:AddSection({
    Name = "Combate Avanzado M-Society"
})

local visualsSection = VisualsTab:AddSection({
    Name = "Efectos Visuales Premium"
})

-- Sistema ESP completamente mejorado y toggleable
local currentESPObj = nil
local currentHighlight = nil
local isESPToggling = false
local espConnection = nil
local espLastLog = 0
local ESP_LOG_INTERVAL = 0.5
local playerESPs = {}
local isPlayerESPActive = false

local function removeESP()
    if currentHighlight and currentHighlight.Parent then
        pcall(function()
            currentHighlight:Destroy()
        end)
    end
    currentHighlight = nil
    currentESPObj = nil
end

local function removeAllPlayerESP()
    for _, espData in pairs(playerESPs) do
        if espData.highlight then
            pcall(function() espData.highlight:Destroy() end)
        end
        if espData.billboard then
            pcall(function() espData.billboard:Destroy() end)
        end
    end
    playerESPs = {}
end

local function getBestBrainrot()
    local bestBrainrot = nil
    local maxMoneyPerSecond = -1
    local candidatesFound = 0
    local slotsScanned = 0
    local basesScanned = 0

    local basesFolder = workspace:FindFirstChild("Bases")
    if not basesFolder then
        return nil, -1, 0, 0, 0
    end

    for i = 1, 8 do
        local baseName = "Base" .. tostring(i)
        local base = basesFolder:FindFirstChild(baseName)
        if base then
            basesScanned = basesScanned + 1
            
            local slotsFolder = base:FindFirstChild("Slots")
            if not slotsFolder then
                local floorsFolder = base:FindFirstChild("Floors")
                if floorsFolder then
                    slotsFolder = floorsFolder:FindFirstChild("Slots")
                end
            end

            if slotsFolder then
                for _, slot in pairs(slotsFolder:GetChildren()) do
                    if slot:IsA("Model") then
                        slotsScanned = slotsScanned + 1
                        for _, child in pairs(slot:GetChildren()) do
                            local cname = tostring(child.Name)
                            if brainrotData[cname] then
                                candidatesFound = candidatesFound + 1
                                local money = brainrotData[cname].MoneyPerSecond or 0
                                if money > maxMoneyPerSecond then
                                    maxMoneyPerSecond = money
                                    bestBrainrot = child
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return bestBrainrot, maxMoneyPerSecond, candidatesFound, slotsScanned, basesScanned
end

function toggleESP(enabled)
    isESPToggling = enabled
    msocietyConfig.espEnabled = enabled
    
    if isESPToggling then
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end

        espConnection = RunService.Stepped:Connect(function()
            if not isESPToggling then
                removeESP()
                return
            end

            local best, value, candidates, slotsScanned, basesScanned = nil, -1, 0, 0, 0
            local ok, err = pcall(function()
                best, value, candidates, slotsScanned, basesScanned = getBestBrainrot()
            end)
            if not ok then
                return
            end

            if best then
                if currentESPObj ~= best then
                    removeESP()
                    local success, hErr = pcall(function()
                        local newHighlight = Instance.new("Highlight")
                        newHighlight.FillColor = Color3.fromRGB(0, 255, 127)
                        newHighlight.OutlineColor = Color3.fromRGB(255, 0, 255)
                        newHighlight.FillTransparency = 0.1
                        newHighlight.OutlineTransparency = 0
                        newHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        newHighlight.Parent = best
                        currentHighlight = newHighlight
                        currentESPObj = best
                        
                        local billboardGui = Instance.new("BillboardGui")
                        billboardGui.Size = UDim2.new(0, 450, 0, 180)
                        billboardGui.StudsOffset = Vector3.new(0, 6, 0)
                        billboardGui.AlwaysOnTop = true
                        billboardGui.Parent = best
                        
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        frame.BackgroundTransparency = 0.05
                        frame.BorderSizePixel = 0
                        frame.Parent = billboardGui
                        
                        local corner = Instance.new("UICorner")
                        corner.CornerRadius = UDim.new(0, 20)
                        corner.Parent = frame
                        
                        local stroke = Instance.new("UIStroke")
                        stroke.Color = Color3.fromRGB(255, 0, 255)
                        stroke.Thickness = 4
                        stroke.Parent = frame
                        
                        local gradient = Instance.new("UIGradient")
                        gradient.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
                        }
                        gradient.Parent = stroke
                        
                        local textLabel = Instance.new("TextLabel")
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.Text = "M-SOCIETY ESP PREMIUM\n" .. tostring(best.Name) .. "\nValor: $" .. tostring(value) .. "/s\nDistancia: " .. math.floor((best.Position - player.Character.HumanoidRootPart.Position).Magnitude) .. " studs"
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        textLabel.TextScaled = true
                        textLabel.Font = Enum.Font.GothamBold
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        textLabel.Parent = frame
                        
                        spawn(function()
                            while newHighlight.Parent and isESPToggling do
                                local rainbowColor = Color3.fromHSV(tick() % 3 / 3, 1, 1)
                                newHighlight.FillColor = rainbowColor
                                
                                local gradientTween = TweenService:Create(gradient, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
                                    Rotation = 360
                                })
                                gradientTween:Play()
                                
                                local pulse = math.sin(tick() * 4) * 0.05 + 0.1
                                newHighlight.FillTransparency = pulse
                                wait(0.03)
                            end
                        end)
                    end)
                end
            else
                removeESP()
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "ESP M-Society Activado",
            Content = "ESP premium activado con efectos avanzados",
            Image = "rbxassetid://6253258591",
            Time = 3
        })
    else
        removeESP()
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end
        OrionLib:MakeNotification({
            Name = "ESP M-Society Desactivado",
            Content = "ESP desactivado",
            Image = "rbxassetid://6253258591",
            Time = 2
        })
    end
end

-- Sistema de vuelo mejorado y más estable
local flyConnection
local flyBodyVelocity
local flyEnabled = false

local function createAdvancedFlySystem()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    if flyBodyVelocity then
        flyBodyVelocity:Destroy()
    end
    
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.Parent = character.HumanoidRootPart
    
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
    bodyPosition.Position = character.HumanoidRootPart.Position
    bodyPosition.Parent = character.HumanoidRootPart
    
    if flyConnection then
        flyConnection:Disconnect()
    end
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if character and character:FindFirstChild("HumanoidRootPart") and flyEnabled then
            local camera = workspace.CurrentCamera
            local velocity = Vector3.new(0, 0, 0)
            local humanoidRootPart = character.HumanoidRootPart
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                velocity = velocity + (camera.CFrame.LookVector * msocietyConfig.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                velocity = velocity - (camera.CFrame.LookVector * msocietyConfig.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                velocity = velocity - (camera.CFrame.RightVector * msocietyConfig.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                velocity = velocity + (camera.CFrame.RightVector * msocietyConfig.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, msocietyConfig.flySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                velocity = velocity - Vector3.new(0, msocietyConfig.flySpeed, 0)
            end
            
            flyBodyVelocity.Velocity = velocity
            bodyPosition.Position = humanoidRootPart.Position
            
            if character:FindFirstChild("Humanoid") then
                character.Humanoid.PlatformStand = true
            end
        end
    end)
end

function toggleFly(enabled)
    flyEnabled = enabled
    msocietyConfig.flyEnabled = enabled
    
    if flyEnabled then
        createAdvancedFlySystem()
        OrionLib:MakeNotification({
            Name = "Vuelo M-Society Activado",
            Content = "Sistema de vuelo premium activado - Usa WASD + Espacio/Shift",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if flyBodyVelocity then
                flyBodyVelocity:Destroy()
                flyBodyVelocity = nil
            end
            
            local bodyPosition = character.HumanoidRootPart:FindFirstChild("BodyPosition")
            if bodyPosition then
                bodyPosition:Destroy()
            end
            
            if character:FindFirstChild("Humanoid") then
                character.Humanoid.PlatformStand = false
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Vuelo Desactivado",
            Content = "Sistema de vuelo desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Sistema noclip mejorado y más estable
local noclipConnection
local noclipEnabled = false
local originalCanCollide = {}

function toggleNoclip(enabled)
    noclipEnabled = enabled
    msocietyConfig.noclipEnabled = enabled
    
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if not originalCanCollide[part] then
                            originalCanCollide[part] = part.CanCollide
                        end
                        part.CanCollide = false
                        part.CanTouch = false
                    end
                end
                
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid.PlatformStand = true
                end
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "Noclip M-Society Activado",
            Content = "Noclip premium activado - Atraviesa cualquier objeto",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and originalCanCollide[part] ~= nil then
                    part.CanCollide = originalCanCollide[part]
                    part.CanTouch = true
                end
            end
            
            if character:FindFirstChild("Humanoid") then
                character.Humanoid.PlatformStand = false
            end
        end
        
        originalCanCollide = {}
        
        OrionLib:MakeNotification({
            Name = "Noclip Desactivado",
            Content = "Noclip desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Sistema de velocidad mejorado
local speedEnabled = false

function toggleSpeed(enabled)
    speedEnabled = enabled
    msocietyConfig.speedEnabled = enabled
    
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        if speedEnabled then
            character.Humanoid.WalkSpeed = msocietyConfig.walkSpeed
            OrionLib:MakeNotification({
                Name = "Speed M-Society Activado",
                Content = "Velocidad premium activada: " .. msocietyConfig.walkSpeed,
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        else
            character.Humanoid.WalkSpeed = 16
            OrionLib:MakeNotification({
                Name = "Speed Desactivado",
                Content = "Velocidad normal restaurada",
                Image = "rbxassetid://6031075938",
                Time = 2
            })
        end
    end
end

-- Sistema aimbot mejorado
local aimbotConnection
local aimbotEnabled = false

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = msocietyConfig.aimbotFOV
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local camera = workspace.CurrentCamera
            local targetPosition = targetPlayer.Character.Head.Position
            local screenPoint, onScreen = camera:WorldToScreenPoint(targetPosition)
            
            if onScreen then
                local mousePosition = Vector2.new(mouse.X, mouse.Y)
                local screenPosition = Vector2.new(screenPoint.X, screenPoint.Y)
                local distance = (mousePosition - screenPosition).Magnitude
                
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = targetPlayer
                end
            end
        end
    end
    
    return closestPlayer
end

function toggleAimbot(enabled)
    aimbotEnabled = enabled
    msocietyConfig.aimbotEnabled = enabled
    
    if aimbotEnabled then
        aimbotConnection = RunService.Heartbeat:Connect(function()
            if aimbotEnabled then
                local target = getClosestPlayer()
                if target and target.Character and target.Character:FindFirstChild("Head") then
                    local camera = workspace.CurrentCamera
                    local targetPosition = target.Character.Head.Position
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
                    
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, msocietyConfig.aimbotSmoothness)
                end
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "Aimbot M-Society Activado",
            Content = "Aimbot premium activado con precision avanzada",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        
        OrionLib:MakeNotification({
            Name = "Aimbot Desactivado",
            Content = "Aimbot desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

local autoSection = AutoTab:AddSection({
    Name = "Sistema de Automatizacion M-Society"
})

local isAutoCollectToggling = false
local autoCollectConnection = nil
local collectedItems = 0
local sessionStartTime = tick()

local function getMyBaseSlots()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then
        return nil
    end

    local config = localPlayer:FindFirstChild("Configuration")
    if not config then
        return nil
    end

    local baseObjectValue = config:FindFirstChild("Base")
    if not baseObjectValue or not baseObjectValue:IsA("ObjectValue") then
        return nil
    end

    local baseModel = baseObjectValue.Value
    if not baseModel or not baseModel:IsA("Model") then
        return nil
    end

    local slotsFolder = baseModel:FindFirstChild("Slots")
    if not slotsFolder and baseModel:FindFirstChild("Floors") then
        slotsFolder = baseModel.Floors:FindFirstChild("Slots")
    end

    return slotsFolder
end

local function simulateAllTouches()
    local slotsFolder = getMyBaseSlots()
    if not slotsFolder then
        return
    end

    local hrp = nil
    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
        hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end

    if not hrp then
        return
    end

    local touchedCount = 0
    for _, slot in pairs(slotsFolder:GetChildren()) do
        if slot:IsA("Model") then
            local collectPart = slot:FindFirstChild("Collect")
            if collectPart and collectPart:IsA("BasePart") then
                pcall(function()
                    firetouchinterest(hrp, collectPart, 0)
                    task.wait(0.04)
                    firetouchinterest(hrp, collectPart, 1)
                end)
                touchedCount = touchedCount + 1
                collectedItems = collectedItems + 1
            end
        end
    end
end

automationSection:AddToggle({
    Name = "Auto Collect M-Society",
    Default = false,
    Callback = function(Value)
        isAutoCollectToggling = Value
        if isAutoCollectToggling then
            if autoCollectConnection then
                autoCollectConnection:Disconnect()
                autoCollectConnection = nil
            end
            autoCollectConnection = game:GetService("RunService").Stepped:Connect(function()
                if isAutoCollectToggling then
                    simulateAllTouches()
                end
            end)
            OrionLib:MakeNotification({
                Name = "Auto Collect Activado",
                Content = "Auto collect M-Society iniciado con velocidad premium",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            if autoCollectConnection then
                autoCollectConnection:Disconnect()
                autoCollectConnection = nil
            end
            OrionLib:MakeNotification({
                Name = "Auto Collect Desactivado",
                Content = "Auto collect detenido",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end
})

-- Toggles principales mejorados
espSection:AddToggle({
    Name = "ESP Mejor Brainrot M-Society",
    Default = false,
    Callback = function(Value)
        toggleESP(Value)
    end
})

movementSection:AddToggle({
    Name = "Vuelo M-Society Premium",
    Default = false,
    Callback = function(Value)
        toggleFly(Value)
    end
})

movementSection:AddToggle({
    Name = "Noclip Extra M-Society",
    Default = false,
    Callback = function(Value)
        toggleNoclip(Value)
    end
})

movementSection:AddToggle({
    Name = "Speed M-Society",
    Default = false,
    Callback = function(Value)
        toggleSpeed(Value)
    end
})

combatSection:AddToggle({
    Name = "Aimbot M-Society Premium",
    Default = false,
    Callback = function(Value)
        toggleAimbot(Value)
    end
})

-- Sliders mejorados
movementSection:AddSlider({
    Name = "Velocidad de Vuelo",
    Min = 20,
    Max = 500,
    Default = 95,
    Color = Color3.fromRGB(255, 0, 255),
    Increment = 5,
    ValueName = "velocidad",
    Callback = function(Value)
        msocietyConfig.flySpeed = Value
    end
})

movementSection:AddSlider({
    Name = "Velocidad de Caminar",
    Min = 16,
    Max = 1000,
    Default = 36,
    Color = Color3.fromRGB(255, 0, 255),
    Increment = 1,
    ValueName = "velocidad",
    Callback = function(Value)
        msocietyConfig.walkSpeed = Value
        if speedEnabled then
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = Value
            end
        end
    end
})

combatSection:AddSlider({
    Name = "FOV del Aimbot",
    Min = 50,
    Max = 500,
    Default = 150,
    Color = Color3.fromRGB(255, 0, 255),
    Increment = 10,
    ValueName = "FOV",
    Callback = function(Value)
        msocietyConfig.aimbotFOV = Value
    end
})

combatSection:AddSlider({
    Name = "Suavidad del Aimbot",
    Min = 0.01,
    Max = 1,
    Default = 0.15,
    Color = Color3.fromRGB(255, 0, 255),
    Increment = 0.01,
    ValueName = "suavidad",
    Callback = function(Value)
        msocietyConfig.aimbotSmoothness = Value
    end
})

local visualsSection = VisualsTab:AddSection({
    Name = "Efectos Visuales Premium"
})

local trailEnabled = false
local currentTrail = nil

visualsSection:AddToggle({
    Name = "Rastro Arcoiris M-Society",
    Default = false,
    Callback = function(Value)
        trailEnabled = Value
        msocietyConfig.trailEnabled = Value
        
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if Value then
                local trail = Instance.new("Trail")
                trail.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
                }
                trail.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0.2),
                    NumberSequenceKeypoint.new(1, 1)
                }
                trail.Lifetime = 2
                trail.MinLength = 0
                trail.FaceCamera = true
                
                local attachment0 = Instance.new("Attachment")
                local attachment1 = Instance.new("Attachment")
                attachment0.Position = Vector3.new(-2, 0, 0)
                attachment1.Position = Vector3.new(2, 0, 0)
                attachment0.Parent = character.HumanoidRootPart
                attachment1.Parent = character.HumanoidRootPart
                
                trail.Attachment0 = attachment0
                trail.Attachment1 = attachment1
                trail.Parent = character.HumanoidRootPart
                
                currentTrail = trail
                
                spawn(function()
                    while trailEnabled and trail.Parent do
                        local hue = tick() % 5 / 5
                        trail.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, 1, 1)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromHSV((hue + 0.3) % 1, 1, 1)),
                            ColorSequenceKeypoint.new(1, Color3.fromHSV((hue + 0.6) % 1, 1, 1))
                        }
                        wait(0.1)
                    end
                end)
            else
                if currentTrail then
                    currentTrail:Destroy()
                    currentTrail = nil
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Rastro Arcoiris Activado" or "Rastro Desactivado",
            Content = Value and "Rastro arcoiris premium activado" or "Rastro desactivado",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    end
})

local auraEnabled = false
local currentAura = nil

visualsSection:AddToggle({
    Name = "Aura M-Society",
    Default = false,
    Callback = function(Value)
        auraEnabled = Value
        msocietyConfig.auraEnabled = Value
        
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if Value then
                local aura = Instance.new("SelectionBox")
                aura.Adornee = character.HumanoidRootPart
                aura.Color3 = Color3.fromRGB(255, 0, 255)
                aura.LineThickness = 0.2
                aura.Transparency = 0.3
                aura.Parent = character.HumanoidRootPart
                
                currentAura = aura
                
                spawn(function()
                    while auraEnabled and aura.Parent do
                        local hue = tick() % 3 / 3
                        aura.Color3 = Color3.fromHSV(hue, 1, 1)
                        local pulse = math.sin(tick() * 6) * 0.1 + 0.3
                        aura.Transparency = pulse
                        wait(0.05)
                    end
                end)
            else
                if currentAura then
                    currentAura:Destroy()
                    currentAura = nil
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Aura M-Society Activada" or "Aura Desactivada",
            Content = Value and "Aura premium con efectos de pulso activada" or "Aura desactivada",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    end
})

local exploitSection = ExploitTab:AddSection({
    Name = "Exploits Avanzados M-Society"
})

exploitSection:AddToggle({
    Name = "Anti-Kick M-Society",
    Default = false,
    Callback = function(Value)
        if Value then
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return old(self, ...)
            end)
            OrionLib:MakeNotification({
                Name = "Anti-Kick Activado",
                Content = "Proteccion contra kicks activada",
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        end
    end
})

exploitSection:AddToggle({
    Name = "Hitbox Extender M-Society",
    Default = false,
    Callback = function(Value)
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if Value then
                    targetPlayer.Character.HumanoidRootPart.Size = Vector3.new(25, 25, 25)
                    targetPlayer.Character.HumanoidRootPart.Transparency = 0.7
                else
                    targetPlayer.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                    targetPlayer.Character.HumanoidRootPart.Transparency = 1
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Hitbox Extender Activado" or "Hitbox Extender Desactivado",
            Content = Value and "Hitboxes de jugadores expandidas" or "Hitboxes normales restauradas",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    end
})

exploitSection:AddToggle({
    Name = "Auto-Respawn Instantaneo",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while Value do
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") then
                        if character.Humanoid.Health <= 0 then
                            player:LoadCharacter()
                        end
                    end
                    wait(0.1)
                end
            end)
            OrionLib:MakeNotification({
                Name = "Auto-Respawn Activado",
                Content = "Respawn automatico instantaneo activado",
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        end
    end
})

exploitSection:AddButton({
    Name = "Crash Server M-Society",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Crash Server Iniciado",
            Content = "Intentando crashear el servidor...",
            Image = "rbxassetid://6031075938",
            Time = 3
        })
        for i = 1, 1000 do
            spawn(function()
                while true do
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer()
                    end)
                end
            end)
        end
    end
})

local statsSection = StatsTab:AddSection({
    Name = "Estadisticas de Sesion M-Society"
})

local statsLabel = statsSection:AddParagraph("Estadisticas en Tiempo Real", "Cargando estadisticas M-Society...")

spawn(function()
    while true do
        local sessionTime = tick() - sessionStartTime
        local hours = math.floor(sessionTime / 3600)
        local minutes = math.floor((sessionTime % 3600) / 60)
        local seconds = math.floor(sessionTime % 60)
        
        local timeString = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        local itemsPerMinute = sessionTime > 0 and math.floor((collectedItems / sessionTime) * 60) or 0
        
        local statsText = string.format(
            "Tiempo de Sesion: %s\nItems Recolectados: %d\nItems por Minuto: %d\nScript: M-Society Ultimate\nEstado: %s\nFunciones Activas: %d",
            timeString,
            collectedItems,
            itemsPerMinute,
            isAutoCollectToggling and "Auto-Collect Activo" or "Esperando",
            (isESPToggling and 1 or 0) + (flyEnabled and 1 or 0) + (aimbotEnabled and 1 or 0) + (noclipEnabled and 1 or 0) + (trailEnabled and 1 or 0)
        )
        
        statsLabel:Set("Estadisticas en Tiempo Real", statsText)
        wait(1)
    end
end)

local infoSection = InfoTab:AddSection({
    Name = "Informacion M-Society Ultimate"
})

infoSection:AddParagraph("M-Society Ultimate", "El script mas avanzado y profesional para Roblox con mas de 25 funciones premium incluyendo ESP personalizable con efectos arcoiris, aimbot avanzado con precision ajustable, sistema de vuelo profesional con controles WASD, auto-collect optimizado, noclip extra potente, invisibilidad completa, efectos visuales premium y muchas caracteristicas mas.")

infoSection:AddParagraph("Caracteristicas Premium", "Auto-Collect Inteligente Optimizado\nESP con Efectos Arcoiris Premium\nSistema de Vuelo Profesional WASD\nAimbot Avanzado con FOV Personalizable\nNoclip Extra Ultra Potente\nInvisibilidad Completa\nEfectos Visuales Arcoiris\nRastro y Aura Personalizados\nEstadisticas Detalladas en Tiempo Real\nAnimaciones Ultra Suaves\nY 25+ funciones premium mas...")

infoSection:AddParagraph("Controles Profesionales", "Vuelo: WASD + Espacio/Shift\nAimbot: Activar toggle para precision automatica\nTodas las funciones organizadas en pestanas\nConfiguracion personalizable en tiempo real\nSoporte 24/7 en Discord M-Society\nActualizaciones constantes con nuevas funciones")

infoSection:AddButton({
    Name = "Unirse a M-Society Discord",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "M-Society Ultimate Discord",
            Content = "Link copiado: https://discord.gg/9QRngbrMKS",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        setclipboard("https://discord.gg/9QRngbrMKS")
    end
})

infoSection:AddParagraph("Creditos M-Society", "Script desarrollado por M-Society Team\nVersion: Ultimate 3.0\nFecha: 2024\nDiscord: https://discord.gg/9QRngbrMKS\nTodas las funciones probadas y optimizadas\nSoporte completo para actualizaciones")

OrionLib:Init()

OrionLib:MakeNotification({
    Name = "M-Society Ultimate Cargado",
    Content = "Script premium cargado exitosamente! Discord: https://discord.gg/9QRngbrMKS",
    Image = "rbxassetid://6031075938",
    Time = 5
})
