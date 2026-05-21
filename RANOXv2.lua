--[[
    MobileRayfield UI Library v1.0
    Adaptado para celular (tela pequena) com estrutura similar à Rayfield.
    Suporta temas: DarkBlue, Light, Dark, Aqua, Blood, Midnight, Rose, Violet.
    Guarde este script inteiro como uma biblioteca (ex: via loadstring) e use
    o retorno da função para construir a interface.
--]]

local Library = {}

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Variáveis globais da UI
local ActiveTheme = nil
local ScreenGui = nil
local WindowFrame = nil
local TabButtonsFrame = nil
local ContentFrame = nil
local CurrentTab = nil
local Tabs = {}
local UIKey = "MobileRayfield_" .. tostring(math.random(1, 1000000))

-- Temas
local Themes = {
    DarkBlue = {
        Background = Color3.fromRGB(30, 30, 45),
        TabBar = Color3.fromRGB(20, 20, 35),
        TabButton = Color3.fromRGB(40, 40, 60),
        TabButtonSelected = Color3.fromRGB(70, 130, 220),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(70, 130, 220),
        Button = Color3.fromRGB(50, 50, 75),
        ButtonHover = Color3.fromRGB(70, 130, 220),
        SliderBackground = Color3.fromRGB(40, 40, 60),
        SliderFill = Color3.fromRGB(70, 130, 220),
        ToggleOn = Color3.fromRGB(70, 130, 220),
        ToggleOff = Color3.fromRGB(60, 60, 80),
        InputBackground = Color3.fromRGB(40, 40, 60),
        InputText = Color3.fromRGB(255, 255, 255),
        DropdownBackground = Color3.fromRGB(40, 40, 60),
        DropdownOption = Color3.fromRGB(60, 60, 80),
        SectionLine = Color3.fromRGB(70, 130, 220),
        ScrollBar = Color3.fromRGB(70, 130, 220),
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 245),
        TabBar = Color3.fromRGB(230, 230, 230),
        TabButton = Color3.fromRGB(210, 210, 210),
        TabButtonSelected = Color3.fromRGB(100, 180, 255),
        Text = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(100, 180, 255),
        Button = Color3.fromRGB(200, 200, 200),
        ButtonHover = Color3.fromRGB(100, 180, 255),
        SliderBackground = Color3.fromRGB(210, 210, 210),
        SliderFill = Color3.fromRGB(100, 180, 255),
        ToggleOn = Color3.fromRGB(100, 180, 255),
        ToggleOff = Color3.fromRGB(170, 170, 170),
        InputBackground = Color3.fromRGB(210, 210, 210),
        InputText = Color3.fromRGB(30, 30, 30),
        DropdownBackground = Color3.fromRGB(210, 210, 210),
        DropdownOption = Color3.fromRGB(190, 190, 190),
        SectionLine = Color3.fromRGB(100, 180, 255),
        ScrollBar = Color3.fromRGB(100, 180, 255),
    },
    Dark = {
        Background = Color3.fromRGB(20, 20, 20),
        TabBar = Color3.fromRGB(15, 15, 15),
        TabButton = Color3.fromRGB(40, 40, 40),
        TabButtonSelected = Color3.fromRGB(100, 100, 100),
        Text = Color3.fromRGB(230, 230, 230),
        Accent = Color3.fromRGB(100, 100, 100),
        Button = Color3.fromRGB(50, 50, 50),
        ButtonHover = Color3.fromRGB(100, 100, 100),
        SliderBackground = Color3.fromRGB(40, 40, 40),
        SliderFill = Color3.fromRGB(100, 100, 100),
        ToggleOn = Color3.fromRGB(100, 100, 100),
        ToggleOff = Color3.fromRGB(60, 60, 60),
        InputBackground = Color3.fromRGB(40, 40, 40),
        InputText = Color3.fromRGB(230, 230, 230),
        DropdownBackground = Color3.fromRGB(40, 40, 40),
        DropdownOption = Color3.fromRGB(60, 60, 60),
        SectionLine = Color3.fromRGB(100, 100, 100),
        ScrollBar = Color3.fromRGB(100, 100, 100),
    },
    Aqua = {
        Background = Color3.fromRGB(20, 40, 45),
        TabBar = Color3.fromRGB(15, 30, 35),
        TabButton = Color3.fromRGB(40, 60, 65),
        TabButtonSelected = Color3.fromRGB(0, 200, 200),
        Text = Color3.fromRGB(220, 255, 255),
        Accent = Color3.fromRGB(0, 200, 200),
        Button = Color3.fromRGB(40, 70, 75),
        ButtonHover = Color3.fromRGB(0, 200, 200),
        SliderBackground = Color3.fromRGB(40, 60, 65),
        SliderFill = Color3.fromRGB(0, 200, 200),
        ToggleOn = Color3.fromRGB(0, 200, 200),
        ToggleOff = Color3.fromRGB(60, 80, 85),
        InputBackground = Color3.fromRGB(40, 60, 65),
        InputText = Color3.fromRGB(220, 255, 255),
        DropdownBackground = Color3.fromRGB(40, 60, 65),
        DropdownOption = Color3.fromRGB(60, 80, 85),
        SectionLine = Color3.fromRGB(0, 200, 200),
        ScrollBar = Color3.fromRGB(0, 200, 200),
    },
    Blood = {
        Background = Color3.fromRGB(45, 20, 20),
        TabBar = Color3.fromRGB(35, 15, 15),
        TabButton = Color3.fromRGB(60, 40, 40),
        TabButtonSelected = Color3.fromRGB(220, 50, 50),
        Text = Color3.fromRGB(255, 220, 220),
        Accent = Color3.fromRGB(220, 50, 50),
        Button = Color3.fromRGB(65, 45, 45),
        ButtonHover = Color3.fromRGB(220, 50, 50),
        SliderBackground = Color3.fromRGB(60, 40, 40),
        SliderFill = Color3.fromRGB(220, 50, 50),
        ToggleOn = Color3.fromRGB(220, 50, 50),
        ToggleOff = Color3.fromRGB(80, 60, 60),
        InputBackground = Color3.fromRGB(60, 40, 40),
        InputText = Color3.fromRGB(255, 220, 220),
        DropdownBackground = Color3.fromRGB(60, 40, 40),
        DropdownOption = Color3.fromRGB(80, 60, 60),
        SectionLine = Color3.fromRGB(220, 50, 50),
        ScrollBar = Color3.fromRGB(220, 50, 50),
    },
    Midnight = {
        Background = Color3.fromRGB(10, 10, 25),
        TabBar = Color3.fromRGB(8, 8, 20),
        TabButton = Color3.fromRGB(25, 25, 45),
        TabButtonSelected = Color3.fromRGB(80, 80, 180),
        Text = Color3.fromRGB(200, 200, 255),
        Accent = Color3.fromRGB(80, 80, 180),
        Button = Color3.fromRGB(30, 30, 50),
        ButtonHover = Color3.fromRGB(80, 80, 180),
        SliderBackground = Color3.fromRGB(25, 25, 45),
        SliderFill = Color3.fromRGB(80, 80, 180),
        ToggleOn = Color3.fromRGB(80, 80, 180),
        ToggleOff = Color3.fromRGB(45, 45, 65),
        InputBackground = Color3.fromRGB(25, 25, 45),
        InputText = Color3.fromRGB(200, 200, 255),
        DropdownBackground = Color3.fromRGB(25, 25, 45),
        DropdownOption = Color3.fromRGB(45, 45, 65),
        SectionLine = Color3.fromRGB(80, 80, 180),
        ScrollBar = Color3.fromRGB(80, 80, 180),
    },
    Rose = {
        Background = Color3.fromRGB(45, 25, 35),
        TabBar = Color3.fromRGB(35, 20, 28),
        TabButton = Color3.fromRGB(65, 40, 50),
        TabButtonSelected = Color3.fromRGB(255, 100, 150),
        Text = Color3.fromRGB(255, 220, 230),
        Accent = Color3.fromRGB(255, 100, 150),
        Button = Color3.fromRGB(70, 45, 55),
        ButtonHover = Color3.fromRGB(255, 100, 150),
        SliderBackground = Color3.fromRGB(65, 40, 50),
        SliderFill = Color3.fromRGB(255, 100, 150),
        ToggleOn = Color3.fromRGB(255, 100, 150),
        ToggleOff = Color3.fromRGB(85, 60, 70),
        InputBackground = Color3.fromRGB(65, 40, 50),
        InputText = Color3.fromRGB(255, 220, 230),
        DropdownBackground = Color3.fromRGB(65, 40, 50),
        DropdownOption = Color3.fromRGB(85, 60, 70),
        SectionLine = Color3.fromRGB(255, 100, 150),
        ScrollBar = Color3.fromRGB(255, 100, 150),
    },
    Violet = {
        Background = Color3.fromRGB(30, 20, 50),
        TabBar = Color3.fromRGB(25, 15, 40),
        TabButton = Color3.fromRGB(50, 35, 70),
        TabButtonSelected = Color3.fromRGB(150, 80, 255),
        Text = Color3.fromRGB(230, 210, 255),
        Accent = Color3.fromRGB(150, 80, 255),
        Button = Color3.fromRGB(55, 40, 75),
        ButtonHover = Color3.fromRGB(150, 80, 255),
        SliderBackground = Color3.fromRGB(50, 35, 70),
        SliderFill = Color3.fromRGB(150, 80, 255),
        ToggleOn = Color3.fromRGB(150, 80, 255),
        ToggleOff = Color3.fromRGB(70, 55, 90),
        InputBackground = Color3.fromRGB(50, 35, 70),
        InputText = Color3.fromRGB(230, 210, 255),
        DropdownBackground = Color3.fromRGB(50, 35, 70),
        DropdownOption = Color3.fromRGB(70, 55, 90),
        SectionLine = Color3.fromRGB(150, 80, 255),
        ScrollBar = Color3.fromRGB(150, 80, 255),
    }
}

-- Função auxiliar para criar elementos com nomes
local function createInstance(className, properties)
    local inst = Instance.new(className)
    for prop, value in pairs(properties) do
        inst[prop] = value
    end
    return inst
end

-- Notificação
function Library:Notify(data)
    local title = data.Title or "Notificação"
    local content = data.Content or ""
    local duration = data.Duration or 5
    local image = data.Image or 0

    local NotifyFrame = createInstance("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = ActiveTheme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 220, 0, 80),
        Position = UDim2.new(0.5, -110, 1, -90),
        AnchorPoint = Vector2.new(0.5, 1),
        ClipsDescendants = true,
    })
    local Corner = createInstance("UICorner", { Parent = NotifyFrame, CornerRadius = UDim.new(0, 8) })
    local TitleLabel = createInstance("TextLabel", {
        Parent = NotifyFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 25),
        Position = UDim2.new(0, 10, 0, 5),
        Text = title,
        TextColor3 = ActiveTheme.Text,
        Font = Enum.Font.SourceSansBold,
        TextSize = 16,
    })
    local ContentLabel = createInstance("TextLabel", {
        Parent = NotifyFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 40),
        Position = UDim2.new(0, 10, 0, 30),
        Text = content,
        TextColor3 = ActiveTheme.Text,
        Font = Enum.Font.SourceSans,
        TextSize = 14,
        TextWrapped = true,
    })
    if image ~= 0 then
        local Icon = createInstance("ImageLabel", {
            Parent = NotifyFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(1, -30, 0, 5),
            Image = "rbxassetid://" .. tostring(image),
        })
    end

    -- Animação de entrada
    NotifyFrame.Position = UDim2.new(0.5, -110, 1, 20)
    TweenService:Create(NotifyFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -110, 1, -90)}):Play()
    task.delay(duration, function()
        TweenService:Create(NotifyFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -110, 1, 20)}):Play()
        task.wait(0.5)
        NotifyFrame:Destroy()
    end)
end

-- Função principal para criar a janela
function Library:CreateWindow(settings)
    -- Limpar GUI anterior
    if ScreenGui then ScreenGui:Destroy() end

    -- Configurações padrão
    settings = settings or {}
    local WindowName = settings.Name or "Mobile UI"
    local ThemeName = settings.Theme or "DarkBlue"
    local LoadingTitle = settings.LoadingTitle or "Carregando..."
    local LoadingSubtitle = settings.LoadingSubtitle or ""
    settings.DisableRayfieldPrompts = settings.DisableRayfieldPrompts or false
    settings.DisableBuildWarnings = settings.DisableBuildWarnings or false
    settings.ConfigurationSaving = settings.ConfigurationSaving or {Enabled = false}
    settings.Discord = settings.Discord or {Enabled = false}
    settings.KeySystem = settings.KeySystem or false

    ActiveTheme = Themes[ThemeName] or Themes.DarkBlue

    -- Criar ScreenGui
    ScreenGui = createInstance("ScreenGui", {
        Parent = game:GetService("CoreGui"),
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
    })

    -- Frame principal da janela (tamanho de celular)
    WindowFrame = createInstance("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = ActiveTheme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 300, 0, 500),
        Position = UDim2.new(0.5, -150, 0.5, -250),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true,
    })
    createInstance("UICorner", { Parent = WindowFrame, CornerRadius = UDim.new(0, 10) })
    createInstance("UIStroke", { Parent = WindowFrame, Color = ActiveTheme.Accent, Thickness = 1.5 })

    -- Título
    local TitleBar = createInstance("Frame", {
        Parent = WindowFrame,
        BackgroundColor3 = ActiveTheme.TabBar,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 35),
    })
    createInstance("UICorner", { Parent = TitleBar, CornerRadius = UDim.new(0, 10) })
    createInstance("Frame", { Parent = TitleBar, BackgroundColor3 = ActiveTheme.TabBar, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 10), Position = UDim2.new(0, 0, 0, 25) }) -- remove corner inferior
    local TitleText = createInstance("TextLabel", {
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Text = WindowName,
        TextColor3 = ActiveTheme.Text,
        Font = Enum.Font.SourceSansBold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    -- Barra lateral de abas (esquerda)
    TabButtonsFrame = createInstance("ScrollingFrame", {
        Parent = WindowFrame,
        BackgroundColor3 = ActiveTheme.TabBar,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 60, 1, -35),
        Position = UDim2.new(0, 0, 0, 35),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = ActiveTheme.ScrollBar,
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    })

    -- Área de conteúdo (direita)
    ContentFrame = createInstance("Frame", {
        Parent = WindowFrame,
        BackgroundColor3 = ActiveTheme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -60, 1, -35),
        Position = UDim2.new(0, 60, 0, 35),
    })

    -- ScrollingFrame para o conteúdo das abas
    local ContentScroller = createInstance("ScrollingFrame", {
        Parent = ContentFrame,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = ActiveTheme.ScrollBar,
        Name = "ContentScroller",
    })
    -- Layout automático para organizar os elementos
    local UIListLayout = createInstance("UIListLayout", {
        Parent = ContentScroller,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
    })
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentScroller.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Variáveis da janela
    local Window = {}
    Window.Tabs = {}

    -- Função para criar uma aba
    function Window:CreateTab(TabName, IconID)
        local Tab = {}
        Tab.Name = TabName
        Tab.Icon = IconID or 0
        Tab.Elements = {}
        Tab.Container = createInstance("ScrollingFrame", {
            Parent = ContentScroller,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            Visible = false,
            Name = TabName,
        })
        local TabLayout = createInstance("UIListLayout", {
            Parent = Tab.Container,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4),
        })
        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.Container.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
        end)

        -- Botão na barra lateral
        local TabButton = createInstance("TextButton", {
            Parent = TabButtonsFrame,
            BackgroundColor3 = ActiveTheme.TabButton,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -4, 0, 45),
            Position = UDim2.new(0, 2, 0, (#Tabs * 48) + 2),
            Text = "",
        })
        createInstance("UICorner", { Parent = TabButton, CornerRadius = UDim.new(0, 6) })
        local TabIcon = createInstance("ImageLabel", {
            Parent = TabButton,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0.5, -12, 0, 4),
            Image = IconID ~= 0 and "rbxassetid://" .. tostring(IconID) or "",
        })
        local TabLabel = createInstance("TextLabel", {
            Parent = TabButton,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 12),
            Position = UDim2.new(0, 0, 1, -14),
            Text = TabName,
            TextColor3 = ActiveTheme.Text,
            Font = Enum.Font.SourceSans,
            TextSize = 10,
            TextScaled = true,
        })

        TabButton.MouseButton1Click:Connect(function()
            -- Selecionar esta aba
            for _, t in pairs(Window.Tabs) do
                t.Container.Visible = false
                t.Button.BackgroundColor3 = ActiveTheme.TabButton
            end
            Tab.Container.Visible = true
            TabButton.BackgroundColor3 = ActiveTheme.TabButtonSelected
            CurrentTab = Tab
        end)

        Tab.Button = TabButton
        Tab.ButtonIcon = TabIcon
        Tab.ButtonLabel = TabLabel

        -- Inserir a aba na lista
        table.insert(Window.Tabs, Tab)
        Tabs[TabName] = Tab

        -- Ajustar o tamanho do canvas da barra lateral
        TabButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, #Window.Tabs * 48 + 10)

        -- Se for a primeira aba, selecionar automaticamente
        if #Window.Tabs == 1 then
            TabButton.BackgroundColor3 = ActiveTheme.TabButtonSelected
            Tab.Container.Visible = true
            CurrentTab = Tab
        end

        -- Métodos para adicionar elementos
        function Tab:CreateSection(Name)
            local Section = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                BorderSizePixel = 0,
            })
            local Line = createInstance("Frame", {
                Parent = Section,
                BackgroundColor3 = ActiveTheme.SectionLine,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -10, 0, 2),
                Position = UDim2.new(0, 5, 0, 15),
            })
            local Label = createInstance("TextLabel", {
                Parent = Section,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 14),
                Position = UDim2.new(0, 5, 0, 0),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            return Section
        end

        function Tab:CreateButton(data)
            local Name = data.Name or "Button"
            local Callback = data.Callback or function() end
            local Button = createInstance("TextButton", {
                Parent = self.Container,
                BackgroundColor3 = ActiveTheme.Button,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -10, 0, 35),
                Position = UDim2.new(0, 5, 0, 0),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
            })
            createInstance("UICorner", { Parent = Button, CornerRadius = UDim.new(0, 6) })
            Button.MouseEnter:Connect(function() Button.BackgroundColor3 = ActiveTheme.ButtonHover end)
            Button.MouseLeave:Connect(function() Button.BackgroundColor3 = ActiveTheme.Button end)
            Button.MouseButton1Click:Connect(function()
                Callback()
            end)
            return Button
        end

        function Tab:CreateToggle(data)
            local Name = data.Name or "Toggle"
            local CurrentValue = data.CurrentValue or false
            local Flag = data.Flag or ""
            local Callback = data.Callback or function() end
            local ToggleFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 35),
                Position = UDim2.new(0, 5, 0, 0),
            })
            local Label = createInstance("TextLabel", {
                Parent = ToggleFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -50, 1, 0),
                Position = UDim2.new(0, 5, 0, 0),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local ToggleButton = createInstance("TextButton", {
                Parent = ToggleFrame,
                BackgroundColor3 = CurrentValue and ActiveTheme.ToggleOn or ActiveTheme.ToggleOff,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -45, 0.5, -10),
                Text = "",
            })
            createInstance("UICorner", { Parent = ToggleButton, CornerRadius = UDim.new(0, 10) })
            local ToggleKnob = createInstance("Frame", {
                Parent = ToggleButton,
                BackgroundColor3 = Color3.fromRGB(255,255,255),
                BorderSizePixel = 0,
                Size = UDim2.new(0, 16, 0, 16),
                Position = CurrentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
            })
            createInstance("UICorner", { Parent = ToggleKnob, CornerRadius = UDim.new(0, 8) })

            local function updateToggle()
                ToggleButton.BackgroundColor3 = CurrentValue and ActiveTheme.ToggleOn or ActiveTheme.ToggleOff
                TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {Position = CurrentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                Callback(CurrentValue)
            end

            ToggleButton.MouseButton1Click:Connect(function()
                CurrentValue = not CurrentValue
                updateToggle()
            end)
            updateToggle()
            return ToggleFrame
        end

        function Tab:CreateSlider(data)
            local Name = data.Name or "Slider"
            local Range = data.Range or {0, 100}
            local Increment = data.Increment or 1
            local Suffix = data.Suffix or ""
            local CurrentValue = data.CurrentValue or Range[1]
            local Flag = data.Flag or ""
            local Callback = data.Callback or function() end

            local SliderFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 50),
                Position = UDim2.new(0, 5, 0, 0),
            })
            local Label = createInstance("TextLabel", {
                Parent = SliderFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 18),
                Text = Name .. " (" .. CurrentValue .. Suffix .. ")",
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local SliderBar = createInstance("Frame", {
                Parent = SliderFrame,
                BackgroundColor3 = ActiveTheme.SliderBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -10, 0, 8),
                Position = UDim2.new(0, 5, 0, 25),
            })
            createInstance("UICorner", { Parent = SliderBar, CornerRadius = UDim.new(0, 4) })
            local SliderFill = createInstance("Frame", {
                Parent = SliderBar,
                BackgroundColor3 = ActiveTheme.SliderFill,
                BorderSizePixel = 0,
                Size = UDim2.new((CurrentValue - Range[1]) / (Range[2] - Range[1]), 0, 1, 0),
            })
            createInstance("UICorner", { Parent = SliderFill, CornerRadius = UDim.new(0, 4) })
            local SliderButton = createInstance("TextButton", {
                Parent = SliderBar,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
            })
            SliderButton.MouseButton1Down:Connect(function()
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    local mousePos = UserInputService:GetMouseLocation()
                    local barPos = SliderBar.AbsolutePosition
                    local barSize = SliderBar.AbsoluteSize
                    local relativeX = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                    local newValue = math.floor((Range[1] + (Range[2] - Range[1]) * relativeX) / Increment + 0.5) * Increment
                    newValue = math.clamp(newValue, Range[1], Range[2])
                    if newValue ~= CurrentValue then
                        CurrentValue = newValue
                        SliderFill.Size = UDim2.new((CurrentValue - Range[1]) / (Range[2] - Range[1]), 0, 1, 0)
                        Label.Text = Name .. " (" .. CurrentValue .. Suffix .. ")"
                        Callback(CurrentValue)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                    end
                end)
            end)
            return SliderFrame
        end

        function Tab:CreateDropdown(data)
            local Name = data.Name or "Dropdown"
            local Options = data.Options or {}
            local CurrentOption = data.CurrentOption or {}
            local MultipleOptions = data.MultipleOptions or false
            local Flag = data.Flag or ""
            local Callback = data.Callback or function() end

            local DropdownFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                ClipsDescendants = true,
            })
            local MainButton = createInstance("TextButton", {
                Parent = DropdownFrame,
                BackgroundColor3 = ActiveTheme.DropdownBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 30),
                Text = Name .. ": " .. table.concat(CurrentOption, ", "),
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextTruncate = Enum.TextTruncate.AtEnd,
            })
            createInstance("UICorner", { Parent = MainButton, CornerRadius = UDim.new(0, 6) })
            local OptionContainer = createInstance("ScrollingFrame", {
                Parent = DropdownFrame,
                BackgroundColor3 = ActiveTheme.DropdownBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 100),
                Position = UDim2.new(0, 0, 0, 30),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 2,
                Visible = false,
            })
            local OptionLayout = createInstance("UIListLayout", {
                Parent = OptionContainer,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2),
            })
            OptionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                OptionContainer.CanvasSize = UDim2.new(0, 0, 0, OptionLayout.AbsoluteContentSize.Y + 4)
            end)

            local function updateDropdown()
                local selected = {}
                for _, optButton in ipairs(OptionContainer:GetChildren()) do
                    if optButton:IsA("TextButton") and optButton.BackgroundColor3 == ActiveTheme.ButtonHover then
                        table.insert(selected, optButton.Text)
                    end
                end
                CurrentOption = selected
                MainButton.Text = Name .. ": " .. table.concat(CurrentOption, ", ")
                Callback(CurrentOption)
            end

            for _, optionName in ipairs(Options) do
                local OptionBtn = createInstance("TextButton", {
                    Parent = OptionContainer,
                    BackgroundColor3 = table.find(CurrentOption, optionName) and ActiveTheme.ButtonHover or ActiveTheme.DropdownOption,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -4, 0, 25),
                    Position = UDim2.new(0, 2, 0, 0),
                    Text = optionName,
                    TextColor3 = ActiveTheme.Text,
                    Font = Enum.Font.SourceSans,
                    TextSize = 13,
                })
                createInstance("UICorner", { Parent = OptionBtn, CornerRadius = UDim.new(0, 4) })
                OptionBtn.MouseButton1Click:Connect(function()
                    if MultipleOptions then
                        OptionBtn.BackgroundColor3 = OptionBtn.BackgroundColor3 == ActiveTheme.ButtonHover and ActiveTheme.DropdownOption or ActiveTheme.ButtonHover
                    else
                        -- Desmarcar todos os outros
                        for _, btn in ipairs(OptionContainer:GetChildren()) do
                            if btn:IsA("TextButton") then
                                btn.BackgroundColor3 = ActiveTheme.DropdownOption
                            end
                        end
                        OptionBtn.BackgroundColor3 = ActiveTheme.ButtonHover
                    end
                    updateDropdown()
                    if not MultipleOptions then
                        OptionContainer.Visible = false
                        DropdownFrame.Size = UDim2.new(1, -10, 0, 30)
                    end
                end)
            end

            MainButton.MouseButton1Click:Connect(function()
                OptionContainer.Visible = not OptionContainer.Visible
                DropdownFrame.Size = OptionContainer.Visible and UDim2.new(1, -10, 0, 130) or UDim2.new(1, -10, 0, 30)
            end)
            -- Fechar dropdown se clicar fora
            UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if not DropdownFrame:IsDescendantOf(WindowFrame) then return end
                    local pos = UserInputService:GetMouseLocation()
                    local absPos = DropdownFrame.AbsolutePosition
                    local absSize = DropdownFrame.AbsoluteSize
                    if pos.X < absPos.X or pos.X > absPos.X + absSize.X or pos.Y < absPos.Y or pos.Y > absPos.Y + absSize.Y then
                        OptionContainer.Visible = false
                        DropdownFrame.Size = UDim2.new(1, -10, 0, 30)
                    end
                end
            end)
            return DropdownFrame
        end

        function Tab:CreateInput(data)
            local Name = data.Name or "Input"
            local PlaceholderText = data.PlaceholderText or ""
            local RemoveTextAfterFocusLost = data.RemoveTextAfterFocusLost or false
            local Callback = data.Callback or function() end

            local InputFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 50),
                Position = UDim2.new(0, 5, 0, 0),
            })
            local Label = createInstance("TextLabel", {
                Parent = InputFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 18),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local TextBox = createInstance("TextBox", {
                Parent = InputFrame,
                BackgroundColor3 = ActiveTheme.InputBackground,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 28),
                Position = UDim2.new(0, 0, 0, 22),
                PlaceholderText = PlaceholderText,
                PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
                Text = "",
                TextColor3 = ActiveTheme.InputText,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                ClearTextOnFocus = false,
            })
            createInstance("UICorner", { Parent = TextBox, CornerRadius = UDim.new(0, 6) })
            TextBox.FocusLost:Connect(function(enterPressed)
                Callback(TextBox.Text)
                if RemoveTextAfterFocusLost then
                    TextBox.Text = ""
                end
            end)
            return InputFrame
        end

        function Tab:CreateColorPicker(data)
            local Name = data.Name or "Color Picker"
            local Color = data.Color or Color3.fromRGB(255,0,0)
            local Flag = data.Flag or ""
            local Callback = data.Callback or function() end

            local PickerFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 45),
                Position = UDim2.new(0, 5, 0, 0),
            })
            local Label = createInstance("TextLabel", {
                Parent = PickerFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -40, 1, 0),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local ColorButton = createInstance("TextButton", {
                Parent = PickerFrame,
                BackgroundColor3 = Color,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -35, 0.5, -15),
                Text = "",
            })
            createInstance("UICorner", { Parent = ColorButton, CornerRadius = UDim.new(0, 6) })

            -- Abrir um seletor de cores simplificado (não nativo, mas funcional)
            local ColorPickerOpen = false
            ColorButton.MouseButton1Click:Connect(function()
                if ColorPickerOpen then return end
                ColorPickerOpen = true
                local picker = createInstance("Frame", {
                    Parent = ScreenGui,
                    BackgroundColor3 = Color3.fromRGB(30,30,30),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, 200, 0, 200),
                    Position = UDim2.new(0.5, -100, 0.5, -100),
                })
                createInstance("UICorner", { Parent = picker, CornerRadius = UDim.new(0, 10) })
                -- Barras RGB
                local function createSlider(parent, colorComp, label, posY)
                    local frame = createInstance("Frame", {
                        Parent = parent,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, -20, 0, 40),
                        Position = UDim2.new(0, 10, 0, posY),
                    })
                    local lbl = createInstance("TextLabel", {
                        Parent = frame,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 30, 1, 0),
                        Text = label .. ":",
                        TextColor3 = Color3.fromRGB(255,255,255),
                        Font = Enum.Font.SourceSans,
                        TextSize = 14,
                    })
                    local bar = createInstance("Frame", {
                        Parent = frame,
                        BackgroundColor3 = Color3.fromRGB(50,50,50),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, -40, 0, 20),
                        Position = UDim2.new(0, 40, 0.5, -10),
                    })
                    createInstance("UICorner", { Parent = bar, CornerRadius = UDim.new(0, 4) })
                    local fill = createInstance("Frame", {
                        Parent = bar,
                        BackgroundColor3 = colorComp == "R" and Color3.fromRGB(255,0,0) or colorComp == "G" and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,0,255),
                        BorderSizePixel = 0,
                        Size = UDim2.new(Color[colorComp]/255, 0, 1, 0),
                    })
                    createInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(0, 4) })
                    local btn = createInstance("TextButton", {
                        Parent = bar,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        Text = "",
                    })
                    btn.MouseButton1Down:Connect(function()
                        local con
                        con = RunService.RenderStepped:Connect(function()
                            local mousePos = UserInputService:GetMouseLocation()
                            local barPos = bar.AbsolutePosition
                            local barSize = bar.AbsoluteSize
                            local relX = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                            local newVal = math.floor(relX * 255)
                            Color = Color3.new(colorComp == "R" and newVal/255 or Color.R, colorComp == "G" and newVal/255 or Color.G, colorComp == "B" and newVal/255 or Color.B)
                            fill.Size = UDim2.new(relX, 0, 1, 0)
                            ColorButton.BackgroundColor3 = Color
                            Callback(Color)
                        end)
                        UserInputService.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                con:Disconnect()
                            end
                        end)
                    end)
                end
                createSlider(picker, "R", "R", 10)
                createSlider(picker, "G", "G", 55)
                createSlider(picker, "B", "B", 100)
                local closeBtn = createInstance("TextButton", {
                    Parent = picker,
                    BackgroundColor3 = Color3.fromRGB(150,50,50),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -20, 0, 30),
                    Position = UDim2.new(0, 10, 0, 160),
                    Text = "Fechar",
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.SourceSansBold,
                    TextSize = 14,
                })
                createInstance("UICorner", { Parent = closeBtn, CornerRadius = UDim.new(0, 6) })
                closeBtn.MouseButton1Click:Connect(function()
                    picker:Destroy()
                    ColorPickerOpen = false
                end)
            end)
            return PickerFrame
        end

        function Tab:CreateKeybind(data)
            local Name = data.Name or "Keybind"
            local CurrentKeybind = data.CurrentKeybind or "E"
            local HoldToInteract = data.HoldToInteract or false
            local Flag = data.Flag or ""
            local Callback = data.Callback or function() end

            local KeybindFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 35),
                Position = UDim2.new(0, 5, 0, 0),
            })
            local Label = createInstance("TextLabel", {
                Parent = KeybindFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -80, 1, 0),
                Text = Name,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local KeyButton = createInstance("TextButton", {
                Parent = KeybindFrame,
                BackgroundColor3 = ActiveTheme.Button,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 70, 0, 28),
                Position = UDim2.new(1, -75, 0.5, -14),
                Text = CurrentKeybind,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14,
            })
            createInstance("UICorner", { Parent = KeyButton, CornerRadius = UDim.new(0, 6) })
            local listening = false
            KeyButton.MouseButton1Click:Connect(function()
                listening = true
                KeyButton.Text = "..."
                local connection
                connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if listening and not gameProcessed then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            CurrentKeybind = input.KeyCode.Name
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                            CurrentKeybind = "MB1"
                        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                            CurrentKeybind = "MB2"
                        end
                        KeyButton.Text = CurrentKeybind
                        listening = false
                        connection:Disconnect()
                        Callback(CurrentKeybind)
                    end
                end)
            end)
            return KeybindFrame
        end

        function Tab:CreateParagraph(data)
            local Title = data.Title or "Paragraph"
            local Content = data.Content or ""
            local ParaFrame = createInstance("Frame", {
                Parent = self.Container,
                BackgroundColor3 = ActiveTheme.Button,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -10, 0, 60),
                Position = UDim2.new(0, 5, 0, 0),
            })
            createInstance("UICorner", { Parent = ParaFrame, CornerRadius = UDim.new(0, 6) })
            local TitleLabel = createInstance("TextLabel", {
                Parent = ParaFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 20),
                Position = UDim2.new(0, 5, 0, 5),
                Text = Title,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local ContentLabel = createInstance("TextLabel", {
                Parent = ParaFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 25),
                Text = Content,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            return ParaFrame
        end

        function Tab:CreateLabel(Text)
            local Label = createInstance("TextLabel", {
                Parent = self.Container,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 20),
                Position = UDim2.new(0, 5, 0, 0),
                Text = Text,
                TextColor3 = ActiveTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            return Label
        end

        function Tab:CreateDivider()
            local Divider = createInstance("Frame", {
                Parent = self.Container,
                BackgroundColor3 = ActiveTheme.SectionLine,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -10, 0, 1),
                Position = UDim2.new(0, 5, 0, 0),
            })
            return Divider
        end

        return Tab
    end

    -- Adicionar métodos à janela
    function Window:SetTheme(themeName)
        if Themes[themeName] then
            ActiveTheme = Themes[themeName]
            -- Atualizar cores de toda a interface (simplificado)
            WindowFrame.BackgroundColor3 = ActiveTheme.Background
            TabButtonsFrame.BackgroundColor3 = ActiveTheme.TabBar
            -- etc. Em uma implementação completa, atualizaria todos os elementos filhos.
        end
    end

    return Window
end

return Library
