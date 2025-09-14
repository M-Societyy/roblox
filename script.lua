
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(loadingFill, TweenInfo.new(1, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        }):Play()
        
        wait(1)
        screenGui:Destroy()
    end)
end

createWelcomeAnimation()

-- Datos mejorados para ESP con más personajes
local brainrotData = {
    ["Skibidi"] = 1000,
    ["Ohio"] = 950,
    ["Sigma"] = 900,
    ["Rizz"] = 850,
    ["Gyatt"] = 800,
    ["Fanum Tax"] = 750,
    ["Mewing"] = 700,
    ["Sussy Baka"] = 650,
    ["Among Us"] = 600,
    ["Impostor"] = 550,
    ["Chad"] = 500,
    ["Gigachad"] = 1200,
    ["Based"] = 450,
    ["Cringe"] = 400,
    ["Poggers"] = 350,
    ["Sheesh"] = 300,
    ["No Cap"] = 250,
    ["Bussin"] = 200,
    ["Slay"] = 150,
    ["Periodt"] = 100,
    ["Bet"] = 90,
    ["Vibe Check"] = 80,
    ["Main Character"] = 70,
    ["NPC"] = 60,
    ["Touch Grass"] = 50,
    ["Ratio"] = 40,
    ["L + Ratio"] = 30,
    ["Cope"] = 20,
    ["Seethe"] = 10,
    ["Mald"] = 5
}

-- Función ESP completamente funcional y optimizada
function getBestBrainrot()
    local best, value = nil, -1
    local candidates, slotsScanned, basesScanned = 0, 0, 0
    
    for baseNum = 1, 8 do
        local baseName = "Base" .. baseNum
        local base = Workspace:FindFirstChild(baseName)
        if base then
            basesScanned = basesScanned + 1
            for slotNum = 1, 6 do
                local slotName = "Slot" .. slotNum
                local slot = base:FindFirstChild(slotName)
                if slot then
                    slotsScanned = slotsScanned + 1
                    for itemName, itemValue in pairs(brainrotData) do
                        local item = slot:FindFirstChild(itemName)
                        if item then
                            candidates = candidates + 1
                            if itemValue > value then
                                best = item
                                value = itemValue
                            end
                        end
                    end
                end
            end
        end
    end
    
    return best, value, candidates, slotsScanned, basesScanned
end

-- Función para remover ESP mejorada
function removeESP()
    if currentHighlight then
        currentHighlight:Destroy()
        currentHighlight = nil
    end
    if currentESPObj and currentESPObj:FindFirstChild("BillboardGui") then
        currentESPObj.BillboardGui:Destroy()
    end
    currentESPObj = nil
end

-- Sistema ESP completamente funcional con toggle
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
function toggleFly(enabled)
    flyEnabled = enabled
    msocietyConfig.flyEnabled = enabled
    
    if flyEnabled then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = humanoidRootPart
            
            bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            bodyAngularVelocity.Parent = humanoidRootPart
            
            if flyConnection then
                flyConnection:Disconnect()
            end
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled or not character or not character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local camera = Workspace.CurrentCamera
                local moveVector = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector - Vector3.new(0, 1, 0)
                end
                
                if bodyVelocity then
                    bodyVelocity.Velocity = moveVector * msocietyConfig.flySpeed
                end
            end)
            
            OrionLib:MakeNotification({
                Name = "Vuelo M-Society Activado",
                Content = "Vuelo premium activado - Usa WASD + Espacio/Shift",
                Image = "rbxassetid://6031075938",
                Time = 3
            })
        end
    else
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyAngularVelocity then
            bodyAngularVelocity:Destroy()
            bodyAngularVelocity = nil
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        OrionLib:MakeNotification({
            Name = "Vuelo M-Society Desactivado",
            Content = "Vuelo desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Sistema noclip mejorado y más estable
function toggleNoclip(enabled)
    noclipEnabled = enabled
    msocietyConfig.noclipEnabled = enabled
    
    if noclipEnabled then
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "Noclip M-Society Activado",
            Content = "Noclip ultra potente activado",
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
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Noclip M-Society Desactivado",
            Content = "Noclip desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Sistema de velocidad mejorado
function toggleSpeed(enabled)
    speedEnabled = enabled
    msocietyConfig.speedEnabled = enabled
    
    if speedEnabled then
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = msocietyConfig.walkSpeed
        end
        
        OrionLib:MakeNotification({
            Name = "Speed M-Society Activado",
            Content = "Velocidad personalizada activada: " .. msocietyConfig.walkSpeed,
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    else
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
        
        OrionLib:MakeNotification({
            Name = "Speed M-Society Desactivado",
            Content = "Velocidad restaurada a normal",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Sistema aimbot mejorado
function toggleAimbot(enabled)
    aimbotEnabled = enabled
    msocietyConfig.aimbotEnabled = enabled
    
    if aimbotEnabled then
        if aimbotConnection then
            aimbotConnection:Disconnect()
        end
        
        aimbotConnection = RunService.Heartbeat:Connect(function()
            if not aimbotEnabled then return end
            
            local camera = Workspace.CurrentCamera
            local closestPlayer = nil
            local shortestDistance = msocietyConfig.aimbotFOV
            
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                    local head = otherPlayer.Character.Head
                    local screenPoint, onScreen = camera:WorldToScreenPoint(head.Position)
                    
                    if onScreen then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        if distance < shortestDistance then
                            closestPlayer = otherPlayer
                            shortestDistance = distance
                        end
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                local targetPosition = closestPlayer.Character.Head.Position
                local currentCFrame = camera.CFrame
                local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
                
                camera.CFrame = currentCFrame:Lerp(targetCFrame, msocietyConfig.aimbotSmoothness)
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "Aimbot M-Society Activado",
            Content = "Aimbot premium activado con FOV: " .. msocietyConfig.aimbotFOV,
            Image = "rbxassetid://6031075938",
            Time = 3
        })
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        
        OrionLib:MakeNotification({
            Name = "Aimbot M-Society Desactivado",
            Content = "Aimbot desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
end

-- Auto-collect completamente funcional y optimizado
function toggleAutoCollect(enabled)
    isAutoCollectToggling = enabled
    
    if isAutoCollectToggling then
        if autoCollectConnection then
            autoCollectConnection:Disconnect()
            autoCollectConnection = nil
        end
        
        autoCollectConnection = RunService.Heartbeat:Connect(function()
            if not isAutoCollectToggling then return end
            
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local playerBase = nil
            for baseNum = 1, 8 do
                local baseName = "Base" .. baseNum
                local base = Workspace:FindFirstChild(baseName)
                if base and base:FindFirstChild("Owner") and base.Owner.Value == player then
                    playerBase = base
                    break
                end
            end
            
            if playerBase then
                for _, child in pairs(playerBase:GetChildren()) do
                    if child.Name == "Collect" and child:IsA("BasePart") then
                        local distance = (character.HumanoidRootPart.Position - child.Position).Magnitude
                        if distance <= 50 then
                            firetouchinterest(character.HumanoidRootPart, child, 0)
                            firetouchinterest(character.HumanoidRootPart, child, 1)
                            collectedItems = collectedItems + 1
                        end
                    end
                end
            end
        end)
        
        OrionLib:MakeNotification({
            Name = "Auto Collect M-Society Activado",
            Content = "Auto collect optimizado activado",
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

-- Sistema de keybinds funcional
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == msocietyConfig.keybinds.fly then
        toggleFly(not flyEnabled)
    elseif input.KeyCode == msocietyConfig.keybinds.noclip then
        toggleNoclip(not noclipEnabled)
    elseif input.KeyCode == msocietyConfig.keybinds.speed then
        toggleSpeed(not speedEnabled)
    elseif input.KeyCode == msocietyConfig.keybinds.esp then
        toggleESP(not isESPToggling)
    elseif input.KeyCode == msocietyConfig.keybinds.aimbot then
        toggleAimbot(not aimbotEnabled)
    end
end)

local Window = OrionLib:MakeWindow({
    Name = "M-Society Ultimate Premium Script",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MSocietyUltimate",
    IntroText = "M-Society Ultimate Premium"
})

local MainTab = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local MovementTab = Window:MakeTab({
    Name = "Movimiento",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local CombatTab = Window:MakeTab({
    Name = "Combate",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local VisualTab = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local UtilityTab = Window:MakeTab({
    Name = "Utilidades",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local FunTab = Window:MakeTab({
    Name = "Diversion",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local KeybindsTab = Window:MakeTab({
    Name = "Keybinds",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local StatsTab = Window:MakeTab({
    Name = "Estadisticas",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local InfoTab = Window:MakeTab({
    Name = "Informacion",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

local mainSection = MainTab:AddSection({
    Name = "Auto-Collect M-Society Premium"
})

local movementSection = MovementTab:AddSection({
    Name = "Movimiento Avanzado M-Society"
})

local combatSection = CombatTab:AddSection({
    Name = "Combate Premium M-Society"
})

local espSection = VisualTab:AddSection({
    Name = "ESP Premium M-Society"
})

local exploitSection = ExploitTab:AddSection({
    Name = "Exploits Avanzados M-Society"
})

local utilitySection = UtilityTab:AddSection({
    Name = "Utilidades Premium M-Society"
})

local funSection = FunTab:AddSection({
    Name = "Funciones Divertidas M-Society"
})

local keybindsSection = KeybindsTab:AddSection({
    Name = "Configuracion de Keybinds M-Society"
})

mainSection:AddToggle({
    Name = "Auto Collect M-Society Optimizado",
    Default = false,
    Callback = function(Value)
        toggleAutoCollect(Value)
    end
})

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

-- Funciones adicionales premium
exploitSection:AddToggle({
    Name = "Invisibilidad M-Society",
    Default = false,
    Callback = function(Value)
        invisibilityEnabled = Value
        local character = player.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") or part:IsA("Accessory") then
                    part.Transparency = Value and 1 or 0
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Invisibilidad Activada" or "Invisibilidad Desactivada",
            Content = Value and "Ahora eres invisible" or "Visibilidad restaurada",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
})

exploitSection:AddToggle({
    Name = "God Mode M-Society",
    Default = false,
    Callback = function(Value)
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            if Value then
                character.Humanoid.MaxHealth = math.huge
                character.Humanoid.Health = math.huge
            else
                character.Humanoid.MaxHealth = 100
                character.Humanoid.Health = 100
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "God Mode Activado" or "God Mode Desactivado",
            Content = Value and "Eres inmortal" or "Mortalidad restaurada",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
})

exploitSection:AddToggle({
    Name = "Infinite Jump M-Society",
    Default = false,
    Callback = function(Value)
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            if Value then
                character.Humanoid.JumpPower = 200
                character.Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
                    if character.Humanoid.Jump then
                        character.Humanoid:ChangeState("Jumping")
                    end
                end)
            else
                character.Humanoid.JumpPower = 50
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Infinite Jump Activado" or "Infinite Jump Desactivado",
            Content = Value and "Salto infinito activado" or "Salto normal restaurado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
})

utilitySection:AddToggle({
    Name = "Anti-Kick M-Society",
    Default = false,
    Callback = function(Value)
        if Value then
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return old(self, ...)
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Anti-Kick Activado" or "Anti-Kick Desactivado",
            Content = Value and "Proteccion contra kicks activada" or "Proteccion desactivada",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
})

utilitySection:AddToggle({
    Name = "Auto-Respawn M-Society",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while Value do
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0 then
                        player:LoadCharacter()
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

funSection:AddToggle({
    Name = "Rastro Arcoiris M-Society",
    Default = false,
    Callback = function(Value)
        trailEnabled = Value
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if Value then
                local trail = Instance.new("Trail")
                local attachment1 = Instance.new("Attachment")
                local attachment2 = Instance.new("Attachment")
                
                attachment1.Position = Vector3.new(-2, 0, 0)
                attachment2.Position = Vector3.new(2, 0, 0)
                attachment1.Parent = character.HumanoidRootPart
                attachment2.Parent = character.HumanoidRootPart
                
                trail.Attachment0 = attachment1
                trail.Attachment1 = attachment2
                trail.Lifetime = 2
                trail.MinLength = 0
                trail.FaceCamera = true
                trail.Parent = character.HumanoidRootPart
                
                spawn(function()
                    while trailEnabled and trail.Parent do
                        trail.Color = ColorSequence.new(Color3.fromHSV(tick() % 5 / 5, 1, 1))
                        wait(0.1)
                    end
                end)
            else
                for _, child in pairs(character.HumanoidRootPart:GetChildren()) do
                    if child:IsA("Trail") or child:IsA("Attachment") then
                        child:Destroy()
                    end
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = Value and "Rastro Arcoiris Activado" or "Rastro Arcoiris Desactivado",
            Content = Value and "Rastro premium activado" or "Rastro desactivado",
            Image = "rbxassetid://6031075938",
            Time = 2
        })
    end
})

-- Sistema de keybinds personalizable
keybindsSection:AddBind({
    Name = "Keybind Vuelo",
    Default = Enum.KeyCode.F,
    Hold = false,
    Callback = function()
        toggleFly(not flyEnabled)
    end
})

keybindsSection:AddBind({
    Name = "Keybind Noclip",
    Default = Enum.KeyCode.N,
    Hold = false,
    Callback = function()
        toggleNoclip(not noclipEnabled)
    end
})

keybindsSection:AddBind({
    Name = "Keybind Speed",
    Default = Enum.KeyCode.G,
    Hold = false,
    Callback = function()
        toggleSpeed(not speedEnabled)
    end
})

keybindsSection:AddBind({
    Name = "Keybind ESP",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        toggleESP(not isESPToggling)
    end
})

keybindsSection:AddBind({
    Name = "Keybind Aimbot",
    Default = Enum.KeyCode.T,
    Hold = false,
    Callback = function()
        toggleAimbot(not aimbotEnabled)
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

infoSection:AddParagraph("M-Society Ultimate", "El script mas avanzado y profesional para Roblox con mas de 30 funciones premium incluyendo ESP personalizable con efectos arcoiris, aimbot avanzado con precision ajustable, sistema de vuelo profesional con controles WASD, auto-collect optimizado, noclip extra potente, invisibilidad completa, god mode, infinite jump, anti-kick, auto-respawn y muchas caracteristicas mas.")

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

OrionLib:Init()

OrionLib:MakeNotification({
    Name = "M-Society Ultimate Cargado",
    Content = "Script premium cargado exitosamente! Discord: https://discord.gg/9QRngbrMKS",
    Image = "rbxassetid://6031075938",
    Time = 5
})
