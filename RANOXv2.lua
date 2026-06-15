--[[
    RANOX HUB - GUERRA, CONFIGURAÇÕES E CRÉDITOS
    Desenvolvido por Keybrew
]]

local HttpService = game:GetService("HttpService")
local parts = {104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,83,65,77,85,67,65,82,65,82,79,78,79,66,47,48,45,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,82,65,78,79,88,95,73,78,84,69,70,65,82,67,69}
local function assembleURL(parts) local url = "" for _, part in ipairs(parts) do url = url .. string.char(part) end return url end
local RANOX = loadstring(game:HttpGet(assembleURL(parts)))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

-- Funções auxiliares
local function GetPlayerBase()
    local BasesFolder = Workspace:FindFirstChild("Bases")
    if BasesFolder then
        for _, folder in ipairs(BasesFolder:GetChildren()) do
            local attributeValue = folder:GetAttribute("OwnerUserId")
            if attributeValue and tonumber(attributeValue) == tonumber(LocalPlayer.UserId) then
                return folder
            end
        end
    end
    return nil
end

local function TeleportTo(object)
    if not object or not LocalPlayer.Character then return end
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local position = nil
    if object:IsA("Model") then
        position = object:GetPivot().Position
    elseif object:IsA("BasePart") then
        position = object.Position
    end
    if root and position then
        root.CFrame = CFrame.new(position + Vector3.new(0, 2, 0))
    end
end

-- Criação da janela
local Window = RANOX:CreateWindow({
    Title = "RANOX_HUB",
    Subtitle = "MESCLAR UMA BOMBA NUCLEAR"
})

-- ==================== ABA GUERRA ====================
Window:CreateTab("GUERRA", 4483362458)

-- 1. Toggle "Ataque a Cidade" (PRIMEIRO ELEMENTO)
Window:CreateToggle("GUERRA", {
    Text = "Ataque a Cidade",
    Description = "Lança nuke continuamente na cidade (posição fixa).",
    Default = false,
    Callback = function(isOn)
        _G.AtaqueCidade = isOn
        if not isOn then return end

        task.spawn(function()
            while _G.AtaqueCidade do
                local myBase = GetPlayerBase()
                if myBase and myBase:FindFirstChild("Nukes") then
                    local nukes = {}
                    for _, nuke in ipairs(myBase.Nukes:GetChildren()) do
                        if nuke.Name == "Nuke" and nuke.Parent then
                            table.insert(nukes, nuke)
                        end
                    end
                    if #nukes > 0 then
                        local chosenNuke = nukes[math.random(1, #nukes)]
                        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local oldPos = root and root.CFrame

                        -- Teleporta até a nuke e pega
                        TeleportTo(chosenNuke)
                        task.wait(0.05)
                        ReplicatedStorage.NukeRemotes.PickUp:FireServer(chosenNuke)
                        task.wait(0.05)

                        -- Lança na coordenada fixa da cidade
                        local args = { Vector3.new(417.1291809082031, 12.463900566101074, 136.78570556640625) }
                        ReplicatedStorage.NukeRemotes.LaunchConfirm:FireServer(unpack(args))

                        -- Volta para a posição original
                        if root and oldPos then
                            root.CFrame = oldPos
                        end
                    else
                        Window:NotifyCustom("GUERRA", "Sem nukes na base!", 4483362458)
                        task.wait(2)
                    end
                end
                task.wait(0.2)
            end
        end)
    end
})

-- 2. Label e dropdown de seleção de jogador
Window:CreateLabel("GUERRA", "Selecionar jogadores")

local function getPlayerList()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(list, player.Name)
        end
    end
    return list
end

_G.SelectedPlayer = nil
local dropdownGuerra

dropdownGuerra = Window:CreateDropdown("GUERRA", {
    Text = "Jogadores",
    Options = getPlayerList(),
    Description = "Escolha o alvo do ataque",
    Callback = function(selected)
        _G.SelectedPlayer = selected
    end
})

-- Botão para atualizar lista (abaixo do dropdown)
Window:CreateButton("GUERRA", "Atualizar Lista", function()
    local newList = getPlayerList()
    if dropdownGuerra then
        pcall(function() dropdownGuerra:Destroy() end)
        pcall(function() dropdownGuerra:Remove() end)
    end
    dropdownGuerra = Window:CreateDropdown("GUERRA", {
        Text = "Jogadores",
        Options = newList,
        Description = "Escolha o alvo do ataque",
        Callback = function(selected)
            _G.SelectedPlayer = selected
        end
    })
    Window:NotifyCustom("GUERRA", "Lista de jogadores atualizada!", 4483362458)
end)

-- 3. Toggle "Lançar Nuke Contínuo" (ataque ao jogador selecionado)
Window:CreateToggle("GUERRA", {
    Text = "Lançar Nuke Contínuo",
    Description = "Ataca o jogador selecionado sem parar.",
    Default = false,
    Callback = function(isOn)
        _G.LancarContinuo = isOn
        if not isOn then return end

        task.spawn(function()
            while _G.LancarContinuo do
                local targetPlayer = _G.SelectedPlayer and Players:FindFirstChild(_G.SelectedPlayer)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = targetPlayer.Character.HumanoidRootPart.Position

                    local myBase = GetPlayerBase()
                    if myBase and myBase:FindFirstChild("Nukes") then
                        local nukes = {}
                        for _, nuke in ipairs(myBase.Nukes:GetChildren()) do
                            if nuke.Name == "Nuke" and nuke.Parent then
                                table.insert(nukes, nuke)
                            end
                        end
                        if #nukes > 0 then
                            local chosenNuke = nukes[math.random(1, #nukes)]
                            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local oldPos = root and root.CFrame

                            TeleportTo(chosenNuke)
                            task.wait(0.05)
                            ReplicatedStorage.NukeRemotes.PickUp:FireServer(chosenNuke)
                            task.wait(0.05)
                            local args = { Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) }
                            ReplicatedStorage.NukeRemotes.LaunchConfirm:FireServer(unpack(args))

                            if root and oldPos then
                                root.CFrame = oldPos
                            end
                        else
                            Window:NotifyCustom("GUERRA", "Sem nukes na sua base!", 4483362458)
                            task.wait(2)
                        end
                    end
                else
                    Window:NotifyCustom("GUERRA", "Alvo não está mais no servidor!", 4483362458)
                    task.wait(2)
                end
                task.wait(0.2)
            end
        end)
    end
})

-- 4. Toggle "Ataque Aleatório" (jogador aleatório)
Window:CreateToggle("GUERRA", {
    Text = "Ataque Aleatório",
    Description = "Ataca um jogador aleatório continuamente.",
    Default = false,
    Callback = function(isOn)
        _G.AtaqueAleatorio = isOn
        if not isOn then return end

        task.spawn(function()
            while _G.AtaqueAleatorio do
                local players = Players:GetPlayers()
                local valid = {}
                for _, p in ipairs(players) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        table.insert(valid, p)
                    end
                end
                if #valid > 0 then
                    local target = valid[math.random(1, #valid)]
                    local targetPos = target.Character.HumanoidRootPart.Position

                    local myBase = GetPlayerBase()
                    if myBase and myBase:FindFirstChild("Nukes") then
                        local nukes = {}
                        for _, nuke in ipairs(myBase.Nukes:GetChildren()) do
                            if nuke.Name == "Nuke" and nuke.Parent then
                                table.insert(nukes, nuke)
                            end
                        end
                        if #nukes > 0 then
                            local chosenNuke = nukes[math.random(1, #nukes)]
                            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local oldPos = root and root.CFrame

                            TeleportTo(chosenNuke)
                            task.wait(0.05)
                            ReplicatedStorage.NukeRemotes.PickUp:FireServer(chosenNuke)
                            task.wait(0.05)
                            local args = { Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) }
                            ReplicatedStorage.NukeRemotes.LaunchConfirm:FireServer(unpack(args))

                            if root and oldPos then
                                root.CFrame = oldPos
                            end
                        else
                            Window:NotifyCustom("GUERRA", "Sem nukes na sua base!", 4483362458)
                            task.wait(2)
                        end
                    end
                end
                task.wait(0.5) -- intervalo um pouco maior para não sobrecarregar
            end
        end)
    end
})

-- Linha decorativa (opcional)
Window:CreateLine("GUERRA", Color3.fromRGB(255, 0, 0))

-- ==================== ABA CONFIGURAÇÃO ====================
Window:CreateTab("CONFIGURAÇÃO", 4483362458)
Window:CreateLabel("CONFIGURAÇÃO", "Selecionar Temas🎨")
-- ThemeBoxes
Window:CreateThemeBoxes("CONFIGURAÇÃO")

-- Toggles de utilidades
Window:CreateToggle("CONFIGURAÇÃO", {
    Text = "Anti-AFK",
    Description = "Evita ser desconectado por inatividade.",
    Default = false,
    Callback = function(isOn)
        if isOn then
            local VirtualUser = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

Window:CreateToggle("CONFIGURAÇÃO", {
    Text = "Modo Leve (FPS Boost)",
    Description = "Reduz gráficos para ganhar desempenho.",
    Default = false,
    Callback = function(isOn)
        if isOn then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("SunRays") or v:IsA("ColorCorrection") then
                    v.Enabled = false
                end
            end
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
            workspace.Terrain.TextureGrid = Enum.TerrainTextureGrid.NoTexture
        else
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 500
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("SunRays") or v:IsA("ColorCorrection") then
                    v.Enabled = true
                end
            end
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = true
                end
            end
            workspace.Terrain.TextureGrid = Enum.TerrainTextureGrid.Default
        end
    end
})

Window:CreateToggle("CONFIGURAÇÃO", {
    Text = "Mostrar FPS",
    Description = "Exibe o FPS no canto superior direito.",
    Default = false,
    Callback = function(isOn)
        if isOn then
            local fpsGui = Instance.new("ScreenGui")
            fpsGui.Name = "RANOX_FPS"
            fpsGui.Parent = LocalPlayer.PlayerGui
            local fpsLabel = Instance.new("TextLabel")
            fpsLabel.AnchorPoint = Vector2.new(1, 0)
            fpsLabel.Position = UDim2.new(1, -10, 0, 10)
            fpsLabel.Size = UDim2.new(0, 100, 0, 20)
            fpsLabel.BackgroundTransparency = 1
            fpsLabel.TextColor3 = Color3.new(1, 1, 1)
            fpsLabel.TextStrokeTransparency = 0
            fpsLabel.Text = "FPS: ..."
            fpsLabel.Parent = fpsGui
            local lastUpdate = 0
            local frameCount = 0
            RunService.RenderStepped:Connect(function()
                frameCount = frameCount + 1
                if tick() - lastUpdate >= 0.5 then
                    local fps = math.round(frameCount / (tick() - lastUpdate))
                    fpsLabel.Text = "FPS: " .. fps
                    lastUpdate = tick()
                    frameCount = 0
                end
            end)
            _G.FpsGui = fpsGui
        else
            if _G.FpsGui then _G.FpsGui:Destroy() end
        end
    end
})

Window:CreateToggle("CONFIGURAÇÃO", {
    Text = "Mostrar Ping",
    Description = "Exibe o ping no canto superior direito.",
    Default = false,
    Callback = function(isOn)
        if isOn then
            local pingGui = Instance.new("ScreenGui")
            pingGui.Name = "RANOX_PING"
            pingGui.Parent = LocalPlayer.PlayerGui
            local pingLabel = Instance.new("TextLabel")
            pingLabel.AnchorPoint = Vector2.new(1, 0)
            pingLabel.Position = UDim2.new(1, -10, 0, 35)
            pingLabel.Size = UDim2.new(0, 100, 0, 20)
            pingLabel.BackgroundTransparency = 1
            pingLabel.TextColor3 = Color3.new(1, 1, 1)
            pingLabel.TextStrokeTransparency = 0
            pingLabel.Text = "Ping: ..."
            pingLabel.Parent = pingGui
            task.spawn(function()
                while pingGui.Parent do
                    local ping = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats:FindFirstChild("Ping")
                    if ping then
                        pingLabel.Text = "Ping: " .. ping:GetValue() .. " ms"
                    end
                    task.wait(1)
                end
            end)
            _G.PingGui = pingGui
        else
            if _G.PingGui then _G.PingGui:Destroy() end
        end
    end
})

Window:CreateToggle("CONFIGURAÇÃO", {
    Text = "Limpar Terreno",
    Description = "Remove grama, pedras e arbustos para melhor visão.",
    Default = false,
    Callback = function(isOn)
        if isOn then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    local name = v.Name:lower()
                    if name:find("grass") or name:find("rock") or name:find("tree") or name:find("bush") then
                        v:Destroy()
                    end
                end
            end
            Window:NotifyCustom("CONFIGURAÇÃO", "Terreno limpo!", 4483362458)
        end
    end
})

-- ==================== ABA CRÉDITOS ====================
Window:CreateTab("CRÉDITOS", 4483362458)

-- PromoBox do canal
Window:CreatePromoBox("CRÉDITOS", "MEU CANAL", "RANOX OFC", 4483362458, "https://youtube.com/@rnox_ofc123?si=kH0iASKY-noURP8U", "Se inscreva!")

-- InfoBox com descrição
local infoItems = {
    "Com este script você pode selecionar qualquer jogador do servidor e lançar nukes contínuas na posição dele.",
    "Também é possível atacar a cidade com coordenadas fixas ou atacar um jogador aleatório automaticamente.",
    "As opções são independentes: você pode ativar Ataque à Cidade, Lançar Nuke Contínuo e Ataque Aleatório ao mesmo tempo.",
    "O sistema pega uma nuke da sua base, te teleporta até ela, faz o pickup e dispara no alvo, retornando à posição original.",
    "Ideal para dominar servidores de forma rápida e automática!",
    "Não se esqueça de atualizar a lista de jogadores quando novos entrarem."
}
Window:CreateInfoBox("CRÉDITOS", "O QUE O SCRIPT FAZ", infoItems)
