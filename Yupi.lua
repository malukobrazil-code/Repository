-- EMZ Panel Pro VIP (Interfaz MTH TEAM V22)
-- VERSIÓN COMPLETA CON MEJORAS
-- MODIFICADO: Barra 300x25, Panel 300x200 (con opción de cambiar tamaño)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

-- ANTI-AFK / ANTI-KICK (SIEMPRE ACTIVADO)
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- IDIOMAS
local idiomas = {
    español = {
        aimbot = "Aimbot",
        player = "Jugador",
        visuales = "Visuales",
        mundo = "Mundo",
        config = "Config",
        aimbot_toggle = "Aimbot",
        selector = "Selector ▼",
        suavizado = "Suavizado",
        visible = "Visible",
        normal = "Normal",
        aim_fov = "Aim FOV",
        fly = "Fly",
        fly_speed = "Fly Speed",
        speed = "Speed",
        walk_speed = "Walk Speed",
        noclip = "Noclip",
        infinite_jump = "Infinite Jump",
        esp_cuerpo = "ESP Cuerpo",
        esp_enemigos = "ESP Enemigos",
        esp_nombre = "ESP Nombre",
        esp_skeleton = "ESP Skeleton",
        esp_box = "ESP Box",
        esp_linea = "ESP Línea",
        esp_health = "ESP Health",
        fullbright = "Fullbright",
        remove_fog = "Remove Fog",
        anti_lag = "Anti-Lag / FPS Boost",
        hitbox = "Hitbox Extender",
        tamaño = "Tamaño",
        transparencia = "Transparencia",
        color_tema = "Color del Tema",
        rojo = "Rojo",
        azul = "Azul",
        verde = "Verde",
        morado = "Morado",
        naranja = "Naranja",
        rosa = "Rosa",
        cyan = "Cyan",
        amarillo = "Amarillo",
        tamaño_panel = "Tamaño del Panel",
        ancho = "Ancho",
        alto = "Alto",
        idioma = "Idioma",
        reset_all = "Reset All",
        enemigos = "Enemigos:",
        by = "By L-RASTA",
        cabeza = "Cabeza",
        cuello = "Cuello",
        pecho = "Pecho"
    },
    ingles = {
        aimbot = "Aimbot",
        player = "Player",
        visuales = "Visuals",
        mundo = "World",
        config = "Config",
        aimbot_toggle = "Aimbot",
        selector = "Selector ▼",
        suavizado = "Smoothing",
        visible = "Visible",
        normal = "Normal",
        aim_fov = "Aim FOV",
        fly = "Fly",
        fly_speed = "Fly Speed",
        speed = "Speed",
        walk_speed = "Walk Speed",
        noclip = "Noclip",
        infinite_jump = "Infinite Jump",
        esp_cuerpo = "ESP Body",
        esp_enemigos = "ESP Enemies",
        esp_nombre = "ESP Name",
        esp_skeleton = "ESP Skeleton",
        esp_box = "ESP Box",
        esp_linea = "ESP Line",
        esp_health = "ESP Health",
        fullbright = "Fullbright",
        remove_fog = "Remove Fog",
        anti_lag = "Anti-Lag / FPS Boost",
        hitbox = "Hitbox Extender",
        tamaño = "Size",
        transparencia = "Transparency",
        color_tema = "Theme Color",
        rojo = "Red",
        azul = "Blue",
        verde = "Green",
        morado = "Purple",
        naranja = "Orange",
        rosa = "Pink",
        cyan = "Cyan",
        amarillo = "Yellow",
        tamaño_panel = "Panel Size",
        ancho = "Width",
        alto = "Height",
        idioma = "Language",
        reset_all = "Reset All",
        enemigos = "Enemies:",
        by = "By L-RASTA",
        cabeza = "Head",
        cuello = "Neck",
        pecho = "Chest"
    },
    portugues = {
        aimbot = "Aimbot",
        player = "Jogador",
        visuales = "Visuais",
        mundo = "Mundo",
        config = "Config",
        aimbot_toggle = "Aimbot",
        selector = "Seletor ▼",
        suavizado = "Suavização",
        visible = "Visível",
        normal = "Normal",
        aim_fov = "Aim FOV",
        fly = "Voar",
        fly_speed = "Vel. Voo",
        speed = "Velocidade",
        walk_speed = "Vel. Andar",
        noclip = "Noclip",
        infinite_jump = "Pulo Infinito",
        esp_cuerpo = "ESP Corpo",
        esp_enemigos = "ESP Inimigos",
        esp_nombre = "ESP Nome",
        esp_skeleton = "ESP Esqueleto",
        esp_box = "ESP Caixa",
        esp_linea = "ESP Linha",
        esp_health = "ESP Vida",
        fullbright = "Fullbright",
        remove_fog = "Remover Névoa",
        anti_lag = "Anti-Lag",
        hitbox = "Hitbox Extender",
        tamaño = "Tamanho",
        transparencia = "Transparência",
        color_tema = "Cor do Tema",
        rojo = "Vermelho",
        azul = "Azul",
        verde = "Verde",
        morado = "Roxo",
        naranja = "Laranja",
        rosa = "Rosa",
        cyan = "Ciano",
        amarillo = "Amarelo",
        tamaño_panel = "Tam. Painel",
        ancho = "Largura",
        alto = "Altura",
        idioma = "Idioma",
        reset_all = "Reset All",
        enemigos = "Inimigos:",
        by = "Por L-RASTA",
        cabeza = "Cabeça",
        cuello = "Pescoço",
        pecho = "Peito"
    }
}

local lang = idiomas.español -- Idioma por defecto

-- VARIABLES GLOBALES
local flySpeed = 20
local walkSpeed = 20
local flying = false
local speedEnabled = false
local noclipEnabled = false
local espBodyEnabled = false
local espEnemyEnabled = false
local espBoxEnabled = false
local espLineEnabled = false
local espNameEnabled = false
local espSkeletonEnabled = false
local espHealthEnabled = false
local aimbotEnabled = false
local aimbotVisible = false
local aimbotFOV = 50
local aimbotTarget = "cabeza"
local aimbotSmooth = 1
local infiniteJumpEnabled = false
local fullbrightEnabled = false
local removeFogEnabled = false
local antiLagEnabled = false
local hitboxEnabled = false
local hitboxSize = 5
local hitboxTransparency = 0.4

-- VARIABLES DE TAMAÑO DEL PANEL
local panelWidth = 300
local panelHeight = 200
local barHeight = 25

local minValue = 20
local maxValue = 1000
local minFOV = 20
local maxFOV = 100
local originalFog = nil
local originalBrightness = nil
local originalAmbient = nil

local espBoxes = {}
local espLines = {}
local espNameLabels = {}
local espSkeletonLines = {}
local espHealthBars = {}
local hitboxRespawnConnections = {}

-- COLORES DEL TEMA
local coloresDisponibles = {
    {nombre = "Rojo", color = Color3.fromRGB(255, 50, 50)},
    {nombre = "Azul", color = Color3.fromRGB(50, 50, 255)},
    {nombre = "Verde", color = Color3.fromRGB(50, 255, 50)},
    {nombre = "Morado", color = Color3.fromRGB(150, 50, 255)},
    {nombre = "Naranja", color = Color3.fromRGB(255, 150, 50)},
    {nombre = "Rosa", color = Color3.fromRGB(255, 100, 200)},
    {nombre = "Cyan", color = Color3.fromRGB(50, 255, 255)},
    {nombre = "Amarillo", color = Color3.fromRGB(255, 255, 50)}
}
local colorTema = coloresDisponibles[1].color

-- GUI PRINCIPAL
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.Name = "DRIP_CLIENT_MOBILE"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- CONTADOR DE ENEMIGOS
local enemyCountDisplay = Instance.new("TextLabel", gui)
enemyCountDisplay.Name = "EnemyCountDisplay"
enemyCountDisplay.Size = UDim2.new(0, 200, 0, 40)
enemyCountDisplay.Position = UDim2.new(0.5, -100, 0, 20)
enemyCountDisplay.BackgroundTransparency = 1
enemyCountDisplay.Text = lang.enemigos .. " 0"
enemyCountDisplay.TextColor3 = colorTema
enemyCountDisplay.Font = Enum.Font.GothamBold
enemyCountDisplay.TextSize = 25
enemyCountDisplay.TextXAlignment = Enum.TextXAlignment.Center
enemyCountDisplay.Visible = false
enemyCountDisplay.ZIndex = 10

-- FOV CIRCLE
local fovCircle = nil

-- FUNCIÓN PARA ACTUALIZAR IDIOMA
local function actualizarIdioma(nuevoIdioma)
    if nuevoIdioma == "español" then
        lang = idiomas.español
    elseif nuevoIdioma == "inglés" then
        lang = idiomas.ingles
    elseif nuevoIdioma == "portugués" then
        lang = idiomas.portugues
    end
    enemyCountDisplay.Text = lang.enemigos .. " 0"
    barraTexto.Text = lang.by
    -- Recargar pestaña actual
    switchTab(activeTab)
end

-- ================== INTERFAZ ==================
local BARRA_ANCHO = 300
local BARRA_ALTO = 25
local PANEL_ANCHO = panelWidth
local PANEL_ALTO = panelHeight

-- BARRA SUPERIOR
local barraSuperior = Instance.new("Frame", gui)
barraSuperior.Name = "BarraSuperior"
barraSuperior.Size = UDim2.new(0, BARRA_ANCHO, 0, BARRA_ALTO)
barraSuperior.Position = UDim2.new(0.5, -BARRA_ANCHO/2, 0.5, -PANEL_ALTO/2 - BARRA_ALTO)
barraSuperior.BackgroundColor3 = colorTema
barraSuperior.BorderSizePixel = 0
barraSuperior.ZIndex = 10
barraSuperior.Visible = true

local barraCorner = Instance.new("UICorner", barraSuperior)
barraCorner.CornerRadius = UDim.new(0, 8)

local barraTexto = Instance.new("TextLabel", barraSuperior)
barraTexto.Name = "BarraTexto"
barraTexto.Size = UDim2.new(1, -40, 1, 0)
barraTexto.Position = UDim2.new(0, 25, 0, 0)
barraTexto.BackgroundTransparency = 1
barraTexto.Text = lang.by
barraTexto.TextColor3 = Color3.fromRGB(0, 0, 0)
barraTexto.Font = Enum.Font.GothamBlack
barraTexto.TextSize = 14
barraTexto.TextXAlignment = Enum.TextXAlignment.Center
barraTexto.TextYAlignment = Enum.TextYAlignment.Center
barraTexto.ZIndex = 11

local toggleButton = Instance.new("TextButton", barraSuperior)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, BARRA_ALTO, 0, BARRA_ALTO)
toggleButton.Position = UDim2.new(0, 0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Text = "◀"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.AutoButtonColor = false
toggleButton.ZIndex = 12

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, 6)

-- PANEL PRINCIPAL
local panel = Instance.new("Frame", gui)
panel.Name = "EMZ_Panel_VIP"
panel.Size = UDim2.new(0, PANEL_ANCHO, 0, PANEL_ALTO)
panel.Position = UDim2.new(0.5, -PANEL_ANCHO/2, 0.5, -PANEL_ALTO/2)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
panel.BorderSizePixel = 0
panel.Visible = true
panel.Active = true
panel.ZIndex = 5
panel.ClipsDescendants = true

local panelCorner = Instance.new("UICorner", panel)
panelCorner.CornerRadius = UDim.new(0, 8)

-- FUNCIÓN PARA ACTUALIZAR POSICIONES
local function actualizarPosiciones()
    local barraPos = barraSuperior.AbsolutePosition
    local barraSize = barraSuperior.AbsoluteSize
    panel.Position = UDim2.new(0, barraPos.X, 0, barraPos.Y + barraSize.Y)
end

-- ARRASTRAR BARRA
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new()
local moveConnection

barraSuperior.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = barraSuperior.Position
        if not moveConnection then
            moveConnection = UIS.InputChanged:Connect(function(move)
                if not dragging then return end
                if move.UserInputType ~= Enum.UserInputType.MouseMovement and move.UserInputType ~= Enum.UserInputType.Touch then return end
                local delta = move.Position - dragStart
                barraSuperior.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                actualizarPosiciones()
            end)
        end
    end
end)

barraSuperior.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        if moveConnection then
            moveConnection:Disconnect()
            moveConnection = nil
        end
    end
end)

-- ====== PESTAÑAS LATERALES ======
local tabPanel = Instance.new("Frame", panel)
tabPanel.Name = "TabPanel"
tabPanel.Size = UDim2.new(0, 60, 1, 0)
tabPanel.Position = UDim2.new(0, 0, 0, 0)
tabPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabPanel.BorderSizePixel = 0
tabPanel.ZIndex = 6

local tabLayout = Instance.new("UIListLayout", tabPanel)
tabLayout.Padding = UDim.new(0, 5)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Top
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabPadding = Instance.new("UIPadding", tabPanel)
tabPadding.PaddingTop = UDim.new(0, 10)
tabPadding.PaddingBottom = UDim.new(0, 10)

-- ====== CONTENEDOR DE CONTENIDO ======
local contentContainer = Instance.new("Frame", panel)
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, -60, 1, 0)
contentContainer.Position = UDim2.new(0, 60, 0, 0)
contentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
contentContainer.BorderSizePixel = 0
contentContainer.ZIndex = 6

local contentPadding = Instance.new("UIPadding", contentContainer)
contentPadding.PaddingLeft = UDim.new(0, 8)
contentPadding.PaddingRight = UDim.new(0, 8)
contentPadding.PaddingTop = UDim.new(0, 8)
contentPadding.PaddingBottom = UDim.new(0, 8)

local scroll = Instance.new("ScrollingFrame", contentContainer)
scroll.Name = "Scroll"
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.Position = UDim2.new(0, 0, 0, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = colorTema
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ZIndex = 7
scroll.ScrollBarImageTransparency = 0.5

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- ====== CREAR PESTAÑA LATERAL ======
local function createSideTab(name, emoji)
    local tab = Instance.new("Frame")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(0, 50, 0, 50)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tab.BorderSizePixel = 0
    tab.Parent = tabPanel
    tab.ZIndex = 7

    local tabCorner = Instance.new("UICorner", tab)
    tabCorner.CornerRadius = UDim.new(0, 8)

    local tabButton = Instance.new("TextButton", tab)
    tabButton.Size = UDim2.new(1, 0, 1, 0)
    tabButton.BackgroundTransparency = 1
    tabButton.Text = emoji .. "\n" .. name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 10
    tabButton.TextWrapped = true
    tabButton.AutoButtonColor = false
    tabButton.ZIndex = 8

    local indicator = Instance.new("Frame", tab)
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 1, -10)
    indicator.Position = UDim2.new(1, -3, 0.5, -5)
    indicator.BackgroundColor3 = colorTema
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.ZIndex = 8

    local indicatorCorner = Instance.new("UICorner", indicator)
    indicatorCorner.CornerRadius = UDim.new(0, 2)

    return tab, tabButton, indicator
end

-- ====== CREAR TOGGLE BUTTON ======
local function createToggleButton(text, getState, callback)
    local btn = Instance.new("Frame")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Parent = scroll
    btn.ZIndex = 8

    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 5)

    local clickButton = Instance.new("TextButton", btn)
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.AutoButtonColor = false
    clickButton.ZIndex = 9

    local stateBox = Instance.new("Frame", btn)
    stateBox.Name = "StateBox"
    stateBox.Size = UDim2.new(0, 16, 0, 16)
    stateBox.Position = UDim2.new(0, 8, 0.5, -8)
    stateBox.BackgroundColor3 = getState() and colorTema or Color3.fromRGB(80, 80, 80)
    stateBox.BorderSizePixel = 0
    stateBox.ZIndex = 9

    local boxCorner = Instance.new("UICorner", stateBox)
    boxCorner.CornerRadius = UDim.new(0, 3)

    local optionText = Instance.new("TextLabel", btn)
    optionText.Size = UDim2.new(1, -30, 1, 0)
    optionText.Position = UDim2.new(0, 28, 0, 0)
    optionText.BackgroundTransparency = 1
    optionText.Text = text
    optionText.TextColor3 = Color3.fromRGB(255, 255, 255)
    optionText.Font = Enum.Font.Gotham
    optionText.TextSize = 12
    optionText.TextXAlignment = Enum.TextXAlignment.Left
    optionText.TextYAlignment = Enum.TextYAlignment.Center
    optionText.ZIndex = 9

    clickButton.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn, stateBox, optionText
end

local function updateToggleState(stateBox, enabled)
    stateBox.BackgroundColor3 = enabled and colorTema or Color3.fromRGB(80, 80, 80)
end

-- ====== CREAR BOTÓN NORMAL ======
local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = colorTema
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    btn.Parent = scroll
    btn.ZIndex = 8

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 5)
    return btn
end

-- ====== CREAR SLIDER ======
local function createSlider(title, value, minVal, maxVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Parent = scroll
    frame.ZIndex = 8

    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 5)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -12, 0, 16)
    label.Position = UDim2.new(0, 6, 0, 6)
    label.Text = title .. " : " .. value
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9

    local sliderBar = Instance.new("Frame", frame)
    sliderBar.Name = "SliderBar"
    sliderBar.Size = UDim2.new(1, -16, 0, 5)
    sliderBar.Position = UDim2.new(0, 8, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBar.BorderSizePixel = 0
    sliderBar.ZIndex = 9

    local sbCorner = Instance.new("UICorner", sliderBar)
    sbCorner.CornerRadius = UDim.new(0, 2)

    local fill = Instance.new("Frame", sliderBar)
    fill.Name = "Fill"
    fill.Size = UDim2.new((value - minVal) / math.max(1, (maxVal - minVal)), 0, 1, 0)
    fill.BackgroundColor3 = colorTema
    fill.BorderSizePixel = 0
    fill.ZIndex = 10

    local fillCorner = Instance.new("UICorner", fill)
    fillCorner.CornerRadius = UDim.new(0, 2)

    local handle = Instance.new("Frame", sliderBar)
    handle.Name = "Handle"
    handle.Size = UDim2.new(0, 10, 0, 10)
    handle.AnchorPoint = Vector2.new(0.5, 0.5)
    handle.Position = UDim2.new(fill.Size.X.Scale, 0, 0.5, 0)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    handle.ZIndex = 11

    local handleCorner = Instance.new("UICorner", handle)
    handleCorner.CornerRadius = UDim.new(0, 5)

    local valueDisplay = Instance.new("TextLabel", sliderBar)
    valueDisplay.Name = "ValueDisplay"
    valueDisplay.Size = UDim2.new(0, 30, 0, 12)
    valueDisplay.AnchorPoint = Vector2.new(0.5, 0.5)
    valueDisplay.Position = UDim2.new(fill.Size.X.Scale, 0, 0.5, 0)
    valueDisplay.BackgroundTransparency = 1
    valueDisplay.Text = tostring(value)
    valueDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueDisplay.Font = Enum.Font.GothamBold
    valueDisplay.TextSize = 9
    valueDisplay.TextXAlignment = Enum.TextXAlignment.Center
    valueDisplay.ZIndex = 11

    local draggingSlider = false
    local sliderConnection
    local currentValue = value

    local function updateSliderValue(inputPos)
        local relativePos = inputPos.X - sliderBar.AbsolutePosition.X
        local barWidth = sliderBar.AbsoluteSize.X
        local percentage = math.clamp(relativePos / barWidth, 0, 1)
        return math.floor(minVal + percentage * (maxVal - minVal))
    end

    local function applyValue(newValue)
        currentValue = newValue
        label.Text = title .. " : " .. newValue
        valueDisplay.Text = tostring(newValue)
        fill.Size = UDim2.new((newValue - minVal) / math.max(1, (maxVal - minVal)), 0, 1, 0)
        handle.Position = UDim2.new(fill.Size.X.Scale, 0, 0.5, 0)
        valueDisplay.Position = UDim2.new(fill.Size.X.Scale, 0, 0.5, 0)
        if callback then callback(newValue) end
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            if not sliderConnection then
                sliderConnection = UIS.InputChanged:Connect(function(move)
                    if not draggingSlider then return end
                    if move.UserInputType ~= Enum.UserInputType.MouseMovement and move.UserInputType ~= Enum.UserInputType.Touch then return end
                    applyValue(updateSliderValue(move.Position))
                end)
            end
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
            if sliderConnection then
                sliderConnection:Disconnect()
                sliderConnection = nil
            end
        end
    end)

    return frame, function(val) applyValue(val) end, function() return currentValue end
end

-- ====== CREAR SELECTOR DE OPCIONES ======
local function createOptionSelector(title, options, currentValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Parent = scroll
    frame.ZIndex = 8

    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 5)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -12, 0, 16)
    label.Position = UDim2.new(0, 6, 0, 2)
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9

    local container = Instance.new("Frame", frame)
    container.Size = UDim2.new(1, -12, 0, 18)
    container.Position = UDim2.new(0, 6, 0, 20)
    container.BackgroundTransparency = 1
    container.ZIndex = 9

    local layout = Instance.new("UIListLayout", container)
    layout.Padding = UDim.new(0, 4)
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, opt in ipairs(options) do
        local btn = Instance.new("TextButton", container)
        btn.Size = UDim2.new(0, 40, 0, 18)
        btn.BackgroundColor3 = opt == currentValue and colorTema or Color3.fromRGB(60, 60, 60)
        btn.BorderSizePixel = 0
        btn.Text = opt
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 9
        btn.AutoButtonColor = false
        btn.ZIndex = 10

        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 3)

        btn.MouseButton1Click:Connect(function()
            callback(opt)
            for _, b in pairs(container:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end
            end
            btn.BackgroundColor3 = colorTema
        end)
    end
end

-- PESTAÑAS LATERALES
local aimbotTab, aimbotTabButton, aimbotIndicator = createSideTab("AIM", "🎯")
local playerTab, playerTabButton, playerIndicator = createSideTab("PLAYER", "👤")
local visualesTab, visualesTabButton, visualesIndicator = createSideTab("ESP", "👁")
local mundoTab, mundoTabButton, mundoIndicator = createSideTab("WORLD", "🌍")
local configTab, configTabButton, configIndicator = createSideTab("CONFIG", "⚙️")

local activeTab = "AIM"
local lastTab = "AIM"

-- ====== PANEL FLOTANTE SELECTOR AIMBOT ======
local aimbotSelectorPanel = Instance.new("Frame", gui)
aimbotSelectorPanel.Name = "AimbotSelectorPanel"
aimbotSelectorPanel.Size = UDim2.new(0, 140, 0, 90)
aimbotSelectorPanel.Position = UDim2.new(0, 400, 0, 200)
aimbotSelectorPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimbotSelectorPanel.BorderSizePixel = 0
aimbotSelectorPanel.Visible = false
aimbotSelectorPanel.ZIndex = 20

local selectorCorner = Instance.new("UICorner", aimbotSelectorPanel)
selectorCorner.CornerRadius = UDim.new(0, 6)

local selectorLayout = Instance.new("UIListLayout", aimbotSelectorPanel)
selectorLayout.Padding = UDim.new(0, 3)
selectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
selectorLayout.VerticalAlignment = Enum.VerticalAlignment.Top
selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
selectorLayout.FillDirection = Enum.FillDirection.Vertical

local selectorPadding = Instance.new("UIPadding", aimbotSelectorPanel)
selectorPadding.PaddingLeft = UDim.new(0, 4)
selectorPadding.PaddingRight = UDim.new(0, 4)
selectorPadding.PaddingTop = UDim.new(0, 4)
selectorPadding.PaddingBottom = UDim.new(0, 4)

local opcionesAimbot = {
    {nombre = lang.cabeza, valor = "cabeza"},
    {nombre = lang.cuello, valor = "cuello"},
    {nombre = lang.pecho, valor = "pecho"}
}

for _, opt in pairs(opcionesAimbot) do
    local optBtn = Instance.new("TextButton", aimbotSelectorPanel)
    optBtn.Size = UDim2.new(1, -8, 0, 24)
    optBtn.BackgroundColor3 = aimbotTarget == opt.valor and colorTema or Color3.fromRGB(60, 60, 60)
    optBtn.BorderSizePixel = 0
    optBtn.Text = opt.nombre
    optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    optBtn.Font = Enum.Font.GothamBold
    optBtn.TextSize = 10
    optBtn.AutoButtonColor = false
    optBtn.ZIndex = 21

    local optCorner = Instance.new("UICorner", optBtn)
    optCorner.CornerRadius = UDim.new(0, 12)

    optBtn.MouseButton1Click:Connect(function()
        aimbotTarget = opt.valor
        for _, child in pairs(aimbotSelectorPanel:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
        end
        optBtn.BackgroundColor3 = colorTema
    end)
end

-- ====== FUNCIONES ESP ======
local function drawESPBox(plr)
    if not plr.Character then return end
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    local head = plr.Character:FindFirstChild("Head")
    if not root or not head then return end

    local rootPos, onScreen = camera:WorldToViewportPoint(root.Position)
    local headPos, _ = camera:WorldToViewportPoint(head.Position)

    if not onScreen then
        if espBoxes[plr] then
            for _, line in pairs(espBoxes[plr]) do line.Visible = false end
        end
        return
    end

    local height = math.abs(headPos.Y - rootPos.Y) * 2.8
    local width = height * 0.75

    if not espBoxes[plr] then
        local box = {}
        for i = 1, 4 do
            local line = Drawing.new("Line")
            line.Thickness = 1
            line.Color = colorTema
            line.Visible = espBoxEnabled
            table.insert(box, line)
        end
        espBoxes[plr] = box
    end

    local box = espBoxes[plr]
    local centerX = rootPos.X
    local centerY = rootPos.Y - height / 2

    box[1].From = Vector2.new(centerX - width/2, centerY)
    box[1].To   = Vector2.new(centerX + width/2, centerY)
    box[2].From = Vector2.new(centerX + width/2, centerY)
    box[2].To   = Vector2.new(centerX + width/2, centerY + height)
    box[3].From = Vector2.new(centerX + width/2, centerY + height)
    box[3].To   = Vector2.new(centerX - width/2, centerY + height)
    box[4].From = Vector2.new(centerX - width/2, centerY + height)
    box[4].To   = Vector2.new(centerX - width/2, centerY)

    for _, line in pairs(box) do
        line.Color = colorTema
        line.Visible = espBoxEnabled
    end
end

local function drawESPLine(plr)
    if not plr.Character then return end
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local rootPos, onScreen = camera:WorldToViewportPoint(root.Position)

    if not espLines[plr] then
        local line = Drawing.new("Line")
        line.Thickness = 1
        line.Color = colorTema
        line.Visible = espLineEnabled and onScreen
        espLines[plr] = line
    end

    local line = espLines[plr]
    line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    line.To = Vector2.new(rootPos.X, rootPos.Y)
    line.Color = colorTema
    line.Visible = espLineEnabled and onScreen
end

local function drawESPName(plr)
    if not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    if not head then return end

    local headPos, onScreen = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))

    if not espNameLabels[plr] then
        local lbl = Drawing.new("Text")
        lbl.Size = 14
        lbl.Font = Drawing.Fonts.UI
        lbl.Color = Color3.fromRGB(255, 255, 255)
        lbl.Outline = true
        lbl.OutlineColor = Color3.fromRGB(0, 0, 0)
        lbl.Center = true
        lbl.Visible = false
        espNameLabels[plr] = lbl
    end

    local lbl = espNameLabels[plr]
    lbl.Text = plr.Name
    lbl.Position = Vector2.new(headPos.X, headPos.Y - 25)
    lbl.Color = colorTema
    lbl.Visible = espNameEnabled and onScreen
end

local function drawESPHealth(plr)
    if not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    local humanoid = plr.Character:FindFirstChild("Humanoid")
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not head or not humanoid or not root then return end

    local headPos, onScreen = camera:WorldToViewportPoint(head.Position)
    local rootPos, _ = camera:WorldToViewportPoint(root.Position)

    if not onScreen then
        if espHealthBars[plr] then
            for _, line in pairs(espHealthBars[plr]) do line.Visible = false end
        end
        return
    end

    local height = math.abs(headPos.Y - rootPos.Y) * 2.8
    local barX = rootPos.X + height * 0.4
    local barY = rootPos.Y - height / 2
    local healthPercent = humanoid.Health / humanoid.MaxHealth
    local barHeight = height * healthPercent

    if not espHealthBars[plr] then
        local bars = {}
        local outline = Drawing.new("Line")
        outline.Thickness = 2
        outline.Color = Color3.fromRGB(0, 0, 0)
        outline.Visible = false
        bars.outline = outline
        
        local fill = Drawing.new("Line")
        fill.Thickness = 1
        fill.Color = Color3.fromRGB(0, 255, 0)
        fill.Visible = false
        bars.fill = fill
        
        espHealthBars[plr] = bars
    end

    local bars = espHealthBars[plr]
    
    -- Outline
    bars.outline.From = Vector2.new(barX, barY)
    bars.outline.To = Vector2.new(barX, barY + height)
    bars.outline.Visible = espHealthEnabled and onScreen
    
    -- Fill
    bars.fill.From = Vector2.new(barX, barY + (height - barHeight))
    bars.fill.To = Vector2.new(barX, barY + height)
    bars.fill.Color = Color3.new(1 - healthPercent, healthPercent, 0)
    bars.fill.Visible = espHealthEnabled and onScreen
end

local skeletonR15 = {
    {"Head",       "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso",    "LeftUpperArm"},
    {"LeftUpperArm",  "LeftLowerArm"},
    {"LeftLowerArm",  "LeftHand"},
    {"UpperTorso",     "RightUpperArm"},
    {"RightUpperArm",  "RightLowerArm"},
    {"RightLowerArm",  "RightHand"},
    {"LowerTorso",    "LeftUpperLeg"},
    {"LeftUpperLeg",  "LeftLowerLeg"},
    {"LeftLowerLeg",  "LeftFoot"},
    {"LowerTorso",     "RightUpperLeg"},
    {"RightUpperLeg",  "RightLowerLeg"},
    {"RightLowerLeg",  "RightFoot"},
}

local skeletonR6 = {
    {"Head",    "Torso"},
    {"Torso",   "Left Arm"},
    {"Torso",   "Right Arm"},
    {"Torso",   "Left Leg"},
    {"Torso",   "Right Leg"},
}

local function getSkeletonConnections(character)
    if character:FindFirstChild("UpperTorso") then
        return skeletonR15
    else
        return skeletonR6
    end
end

local function drawESPSkeleton(plr)
    if not plr.Character then return end
    if not espSkeletonLines[plr] then espSkeletonLines[plr] = {} end

    local connections = getSkeletonConnections(plr.Character)
    local lineIndex = 1

    for _, pair in ipairs(connections) do
        local partA = plr.Character:FindFirstChild(pair[1])
        local partB = plr.Character:FindFirstChild(pair[2])

        if partA and partB then
            local posA, onA = camera:WorldToViewportPoint(partA.Position)
            local posB, onB = camera:WorldToViewportPoint(partB.Position)
            local visible = espSkeletonEnabled and onA and onB and posA.Z > 0 and posB.Z > 0

            if not espSkeletonLines[plr][lineIndex] then
                local line = Drawing.new("Line")
                line.Thickness = 2
                line.Transparency = 1
                line.Visible = false
                espSkeletonLines[plr][lineIndex] = line
            end

            local line = espSkeletonLines[plr][lineIndex]
            line.From  = Vector2.new(posA.X, posA.Y)
            line.To    = Vector2.new(posB.X, posB.Y)
            line.Color = colorTema
            line.Visible = visible
            lineIndex = lineIndex + 1
        end
    end

    for i = lineIndex, #espSkeletonLines[plr] do
        if espSkeletonLines[plr][i] then
            espSkeletonLines[plr][i].Visible = false
        end
    end
end

-- HITBOX
local function aplicarHitboxACharacter(character)
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not hrp:FindFirstChild("EMZ_HitboxRestore") then
        local tag = Instance.new("Configuration")
        tag.Name = "EMZ_HitboxRestore"
        tag:SetAttribute("X", hrp.Size.X)
        tag:SetAttribute("Y", hrp.Size.Y)
        tag:SetAttribute("Z", hrp.Size.Z)
        tag.Parent = hrp
    end

    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
    hrp.Color = Color3.fromRGB(0, 0, 0)
    hrp.Material = Enum.Material.Neon
    hrp.Transparency = hitboxTransparency
    hrp.CastShadow = false
    hrp.CanCollide = false
end

local function restaurarHitboxDeCharacter(character)
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local orig = hrp:FindFirstChild("EMZ_HitboxRestore")
    if orig then
        hrp.Size = Vector3.new(orig:GetAttribute("X"), orig:GetAttribute("Y"), orig:GetAttribute("Z"))
        orig:Destroy()
    end
    hrp.Transparency = 1
    hrp.Material = Enum.Material.Plastic
    hrp.CanCollide = false
end

local hitboxRespawnConnections = {}

local function conectarRespawnHitbox(plr)
    if hitboxRespawnConnections[plr] then
        hitboxRespawnConnections[plr]:Disconnect()
        hitboxRespawnConnections[plr] = nil
    end

    hitboxRespawnConnections[plr] = plr.CharacterAdded:Connect(function(newCharacter)
        if not hitboxEnabled then return end
        newCharacter:WaitForChild("HumanoidRootPart", 5)
        task.wait(0.2)
        aplicarHitboxACharacter(newCharacter)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= player then
        conectarRespawnHitbox(plr)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if hitboxRespawnConnections[plr] then
        hitboxRespawnConnections[plr]:Disconnect()
        hitboxRespawnConnections[plr] = nil
    end
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        conectarRespawnHitbox(plr)
    end
end

local function limpiarESPObsoleto()
    local jugadoresValidos = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            jugadoresValidos[plr] = true
        end
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and not jugadoresValidos[plr] then
            if plr.Character:FindFirstChild("EMZ_ESP") then plr.Character.EMZ_ESP:Destroy() end
            if plr.Character:FindFirstChild("EMZ_ESP_ENEMY") then plr.Character.EMZ_ESP_ENEMY:Destroy() end
        end
    end

    for plr, box in pairs(espBoxes) do
        if not jugadoresValidos[plr] then
            for _, line in pairs(box) do line:Remove() end
            espBoxes[plr] = nil
        end
    end
    for plr, line in pairs(espLines) do
        if not jugadoresValidos[plr] then line:Remove(); espLines[plr] = nil end
    end
    for plr, lbl in pairs(espNameLabels) do
        if not jugadoresValidos[plr] then lbl:Remove(); espNameLabels[plr] = nil end
    end
    for plr, bars in pairs(espHealthBars) do
        if not jugadoresValidos[plr] then
            bars.outline:Remove()
            bars.fill:Remove()
            espHealthBars[plr] = nil
        end
    end
    for plr, lines in pairs(espSkeletonLines) do
        if not jugadoresValidos[plr] then
            for _, line in pairs(lines) do line:Remove() end
            espSkeletonLines[plr] = nil
        end
    end
end

-- ====== FUNCIONES AIMBOT ======
local function isTargetVisible(cameraPosition, targetPosition)
    local direction = targetPosition - cameraPosition
    local distance = direction.Magnitude
    if distance == 0 then return false end
    local ray = Ray.new(cameraPosition, direction.Unit * distance)
    local hitPart, _ = workspace:FindPartOnRay(ray, player.Character)
    if hitPart == nil then return true end
    if hitPart:IsDescendantOf(player.Character) then return true end
    if hitPart.Parent and hitPart.Parent:FindFirstChild("Humanoid") then return true end
    return false
end

local function isInFOV(playerPos, targetPos, fovAngle)
    local cameraDirection = camera.CFrame.LookVector
    local toTarget = (targetPos - playerPos).Unit
    local dotProduct = cameraDirection:Dot(toTarget)
    local fovCosine = math.cos(math.rad(fovAngle / 2))
    return dotProduct >= fovCosine
end

local function getAimbotTargetPart(character)
    if aimbotTarget == "cabeza" then
        return character:FindFirstChild("Head")
    elseif aimbotTarget == "cuello" then
        local head = character:FindFirstChild("Head")
        local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
        if head and torso then
            return nil, (head.Position + torso.Position) / 2
        end
        return head
    elseif aimbotTarget == "pecho" then
        return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
    end
    return character:FindFirstChild("Head")
end

local function updateFOVCircle()
    if aimbotEnabled then
        if not fovCircle then
            fovCircle = Drawing.new("Circle")
            fovCircle.Thickness = 2
            fovCircle.NumSides = 60
            fovCircle.Radius = aimbotFOV * 2
            fovCircle.Filled = false
            fovCircle.Color = colorTema
            fovCircle.Visible = true
            fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
        else
            fovCircle.Radius = aimbotFOV * 2
            fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            fovCircle.Color = colorTema
            fovCircle.Visible = true
        end
    else
        if fovCircle then
            fovCircle.Visible = false
            fovCircle:Remove()
            fovCircle = nil
        end
    end
end

local function getClosestAimbotTarget()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil, nil end
    local closestPlayer = nil
    local closestTargetPos = nil
    local closestDistance = math.huge
    local myPos = player.Character.HumanoidRootPart.Position

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local targetPart, targetPos = getAimbotTargetPart(plr.Character)
            
            local finalTargetPos = targetPos or (targetPart and targetPart.Position)
            
            if finalTargetPos then
                local distance = (finalTargetPos - myPos).Magnitude
                if isInFOV(camera.CFrame.Position, finalTargetPos, aimbotFOV) then
                    local visibleCheck = true
                    if aimbotVisible then
                        visibleCheck = isTargetVisible(camera.CFrame.Position, finalTargetPos)
                    end
                    
                    if visibleCheck then
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = plr
                            closestTargetPos = finalTargetPos
                        end
                    end
                end
            end
        end
    end
    return closestPlayer, closestTargetPos
end

local aimbotTargetPlayer = nil
local aimbotTargetPosition = nil

RunService.Heartbeat:Connect(function()
    if aimbotEnabled then
        aimbotTargetPlayer, aimbotTargetPosition = getClosestAimbotTarget()
    else
        aimbotTargetPlayer = nil
        aimbotTargetPosition = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    
    if aimbotTargetPlayer and aimbotTargetPosition then
        local cameraPos = camera.CFrame.Position
        
        if aimbotSmooth <= 1 then
            camera.CFrame = CFrame.new(cameraPos, aimbotTargetPosition)
        else
            local currentLook = camera.CFrame.LookVector
            local targetLook = (aimbotTargetPosition - cameraPos).Unit
            local t = 1 / aimbotSmooth
            local smoothedLook = currentLook:Lerp(targetLook, t).Unit
            camera.CFrame = CFrame.new(cameraPos, cameraPos + smoothedLook)
        end
    end
end)

-- ====== FUNCIONES DE CARGA DE PESTAÑAS ======

-- CARGA PESTAÑA AIMBOT
local function loadAimbotTab()
    local aimbotFrame, aimbotStateBox, _ = createToggleButton(lang.aimbot_toggle, function() return aimbotEnabled end)
    aimbotFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        updateToggleState(aimbotStateBox, aimbotEnabled)
    end)

    local selectorBtn = Instance.new("TextButton", scroll)
    selectorBtn.Size = UDim2.new(1, 0, 0, 32)
    selectorBtn.BackgroundColor3 = colorTema
    selectorBtn.BorderSizePixel = 0
    selectorBtn.Text = lang.selector
    selectorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectorBtn.Font = Enum.Font.GothamBold
    selectorBtn.TextSize = 12
    selectorBtn.AutoButtonColor = false
    selectorBtn.ZIndex = 8
    Instance.new("UICorner", selectorBtn).CornerRadius = UDim.new(0, 5)

    local aimbotSelectorOpen = false
    selectorBtn.MouseButton1Click:Connect(function()
        aimbotSelectorOpen = not aimbotSelectorOpen
        aimbotSelectorPanel.Visible = aimbotSelectorOpen
        selectorBtn.Text = aimbotSelectorOpen and "Selector ▲" or lang.selector
        local absPos = panel.AbsolutePosition
        local absSize = panel.AbsoluteSize
        aimbotSelectorPanel.Position = UDim2.new(0, absPos.X + absSize.X + 5, 0, absPos.Y + 100)
    end)

    createSlider(lang.suavizado, aimbotSmooth, 1, 20, function(val)
        aimbotSmooth = val
    end)

    local aimbotTypeFrame = Instance.new("Frame")
    aimbotTypeFrame.Size = UDim2.new(1, 0, 0, 35)
    aimbotTypeFrame.BackgroundTransparency = 1
    aimbotTypeFrame.Parent = scroll
    aimbotTypeFrame.ZIndex = 8

    local aimbotVisibleBtn = Instance.new("TextButton", aimbotTypeFrame)
    aimbotVisibleBtn.Size = UDim2.new(0.45, 0, 0, 25)
    aimbotVisibleBtn.Position = UDim2.new(0, 0, 0, 0)
    aimbotVisibleBtn.BackgroundColor3 = aimbotVisible and colorTema or Color3.fromRGB(60, 60, 60)
    aimbotVisibleBtn.Text = lang.visible
    aimbotVisibleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimbotVisibleBtn.BorderSizePixel = 0
    aimbotVisibleBtn.Font = Enum.Font.GothamBold
    aimbotVisibleBtn.TextSize = 11
    aimbotVisibleBtn.AutoButtonColor = false
    aimbotVisibleBtn.ZIndex = 9
    Instance.new("UICorner", aimbotVisibleBtn).CornerRadius = UDim.new(0, 5)

    local aimbotNormalBtn = Instance.new("TextButton", aimbotTypeFrame)
    aimbotNormalBtn.Size = UDim2.new(0.45, 0, 0, 25)
    aimbotNormalBtn.Position = UDim2.new(0.55, 0, 0, 0)
    aimbotNormalBtn.BackgroundColor3 = not aimbotVisible and colorTema or Color3.fromRGB(60, 60, 60)
    aimbotNormalBtn.Text = lang.normal
    aimbotNormalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimbotNormalBtn.BorderSizePixel = 0
    aimbotNormalBtn.Font = Enum.Font.GothamBold
    aimbotNormalBtn.TextSize = 11
    aimbotNormalBtn.AutoButtonColor = false
    aimbotNormalBtn.ZIndex = 9
    Instance.new("UICorner", aimbotNormalBtn).CornerRadius = UDim.new(0, 5)

    aimbotVisibleBtn.MouseButton1Click:Connect(function()
        aimbotVisible = true
        aimbotVisibleBtn.BackgroundColor3 = colorTema
        aimbotNormalBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    aimbotNormalBtn.MouseButton1Click:Connect(function()
        aimbotVisible = false
        aimbotNormalBtn.BackgroundColor3 = colorTema
        aimbotVisibleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    createSlider(lang.aim_fov, aimbotFOV, minFOV, maxFOV, function(val)
        aimbotFOV = val
    end)
end

-- CARGA PESTAÑA PLAYER
local function loadPlayerTab()
    local flyToggleFrame, flyStateBox, _ = createToggleButton(lang.fly, function() return flying end)
    flyToggleFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        flying = not flying
        updateToggleState(flyStateBox, flying)
        if not flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.zero
        end
    end)

    createSlider(lang.fly_speed, flySpeed, minValue, maxValue, function(val) flySpeed = val end)

    local speedToggleFrame, speedStateBox, _ = createToggleButton(lang.speed, function() return speedEnabled end)
    speedToggleFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        updateToggleState(speedStateBox, speedEnabled)
        if not speedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end)

    createSlider(lang.walk_speed, walkSpeed, minValue, maxValue, function(val) walkSpeed = val end)

    local noclipFrame, noclipStateBox, _ = createToggleButton(lang.noclip, function() return noclipEnabled end)
    noclipFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        noclipEnabled = not noclipEnabled
        updateToggleState(noclipStateBox, noclipEnabled)
        if not noclipEnabled and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end)

    local jumpFrame, jumpStateBox, _ = createToggleButton(lang.infinite_jump, function() return infiniteJumpEnabled end)
    jumpFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        infiniteJumpEnabled = not infiniteJumpEnabled
        updateToggleState(jumpStateBox, infiniteJumpEnabled)
    end)
end

-- CARGA PESTAÑA VISUALES
local function loadVisualesTab()
    local espBodyFrame, espBodyStateBox, _ = createToggleButton(lang.esp_cuerpo, function() return espBodyEnabled end)
    espBodyFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espBodyEnabled = not espBodyEnabled
        updateToggleState(espBodyStateBox, espBodyEnabled)
        if not espBodyEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("EMZ_ESP") then
                    plr.Character.EMZ_ESP:Destroy()
                end
            end
        end
    end)

    local espEnemyFrame, espEnemyStateBox, _ = createToggleButton(lang.esp_enemigos, function() return espEnemyEnabled end)
    espEnemyFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espEnemyEnabled = not espEnemyEnabled
        updateToggleState(espEnemyStateBox, espEnemyEnabled)
        enemyCountDisplay.Visible = espEnemyEnabled
        if not espEnemyEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("EMZ_ESP_ENEMY") then
                    plr.Character.EMZ_ESP_ENEMY:Destroy()
                end
            end
            enemyCountDisplay.Visible = false
        end
    end)

    local espNameFrame, espNameStateBox, _ = createToggleButton(lang.esp_nombre, function() return espNameEnabled end)
    espNameFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espNameEnabled = not espNameEnabled
        updateToggleState(espNameStateBox, espNameEnabled)
        if not espNameEnabled then
            for _, lbl in pairs(espNameLabels) do lbl.Visible = false end
        end
    end)

    local espSkelFrame, espSkelStateBox, _ = createToggleButton(lang.esp_skeleton, function() return espSkeletonEnabled end)
    espSkelFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espSkeletonEnabled = not espSkeletonEnabled
        updateToggleState(espSkelStateBox, espSkeletonEnabled)
        if not espSkeletonEnabled then
            for _, lines in pairs(espSkeletonLines) do
                for _, line in pairs(lines) do line.Visible = false end
            end
        end
    end)

    local espBoxFrame, espBoxStateBox, _ = createToggleButton(lang.esp_box, function() return espBoxEnabled end)
    espBoxFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espBoxEnabled = not espBoxEnabled
        updateToggleState(espBoxStateBox, espBoxEnabled)
        if not espBoxEnabled then
            for _, box in pairs(espBoxes) do
                for _, line in pairs(box) do line.Visible = false; line:Remove() end
            end
            espBoxes = {}
        end
    end)

    local espLineFrame, espLineStateBox, _ = createToggleButton(lang.esp_linea, function() return espLineEnabled end)
    espLineFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espLineEnabled = not espLineEnabled
        updateToggleState(espLineStateBox, espLineEnabled)
        if not espLineEnabled then
            for _, line in pairs(espLines) do line.Visible = false; line:Remove() end
            espLines = {}
        end
    end)

    local espHealthFrame, espHealthStateBox, _ = createToggleButton(lang.esp_health, function() return espHealthEnabled end)
    espHealthFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        espHealthEnabled = not espHealthEnabled
        updateToggleState(espHealthStateBox, espHealthEnabled)
        if not espHealthEnabled then
            for _, bars in pairs(espHealthBars) do
                bars.outline.Visible = false
                bars.fill.Visible = false
            end
        end
    end)
end

-- CARGA PESTAÑA MUNDO
local function loadMundoTab()
    local fbFrame, fbStateBox, _ = createToggleButton(lang.fullbright, function() return fullbrightEnabled end)
    fbFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        fullbrightEnabled = not fullbrightEnabled
        updateToggleState(fbStateBox, fullbrightEnabled)
        if fullbrightEnabled then
            originalBrightness = Lighting.Brightness
            originalAmbient = Lighting.Ambient
            Lighting.Brightness = 10
            Lighting.Ambient = Color3.fromRGB(178, 178, 178)
            Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
            Lighting.FogEnd = 100000
            Lighting.FogStart = 99999
        else
            if originalBrightness then Lighting.Brightness = originalBrightness end
            if originalAmbient then
                Lighting.Ambient = originalAmbient
                Lighting.OutdoorAmbient = originalAmbient
            end
        end
    end)

    local fogFrame, fogStateBox, _ = createToggleButton(lang.remove_fog, function() return removeFogEnabled end)
    fogFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        removeFogEnabled = not removeFogEnabled
        updateToggleState(fogStateBox, removeFogEnabled)
        if removeFogEnabled then
            originalFog = {Lighting.FogEnd, Lighting.FogStart}
            Lighting.FogEnd = 100000
            Lighting.FogStart = 99999
        else
            if originalFog then
                Lighting.FogEnd = originalFog[1]
                Lighting.FogStart = originalFog[2]
            end
        end
    end)

    local lagFrame, lagStateBox, _ = createToggleButton(lang.anti_lag, function() return antiLagEnabled end)
    lagFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        antiLagEnabled = not antiLagEnabled
        updateToggleState(lagStateBox, antiLagEnabled)
        if antiLagEnabled then
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    end
                    if obj:IsA("BasePart") then obj.CastShadow = false end
                end)
            end
            pcall(function()
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("DepthOfFieldEffect") then
                        effect.Enabled = false
                    end
                end
            end)
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj.Enabled = true
                    end
                    if obj:IsA("BasePart") then obj.CastShadow = true end
                end)
            end
            pcall(function()
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("DepthOfFieldEffect") then
                        effect.Enabled = true
                    end
                end
            end)
        end
    end)

    local hitboxFrame, hitboxStateBox, _ = createToggleButton(lang.hitbox, function() return hitboxEnabled end)
    hitboxFrame:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function()
        hitboxEnabled = not hitboxEnabled
        updateToggleState(hitboxStateBox, hitboxEnabled)
        if hitboxEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    aplicarHitboxACharacter(plr.Character)
                end
            end
        else
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    restaurarHitboxDeCharacter(plr.Character)
                end
            end
        end
    end)

    createSlider(lang.tamaño, hitboxSize, 1, 50, function(val)
        hitboxSize = val
        if hitboxEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize) end
                end
            end
        end
    end)

    createSlider(lang.transparencia, hitboxTransparency * 100, 0, 100, function(val)
        hitboxTransparency = val / 100
        if hitboxEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Transparency = hitboxTransparency end
                end
            end
        end
    end)
end

-- CARGA PESTAÑA CONFIGURACIÓN
local function loadConfigTab()
    -- SELECTOR DE COLOR DEL TEMA
    local colorFrame = Instance.new("Frame", scroll)
    colorFrame.Size = UDim2.new(1, 0, 0, 50)
    colorFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    colorFrame.ZIndex = 8
    Instance.new("UICorner", colorFrame).CornerRadius = UDim.new(0, 5)

    local colorLabel = Instance.new("TextLabel", colorFrame)
    colorLabel.Size = UDim2.new(1, -12, 0, 16)
    colorLabel.Position = UDim2.new(0, 6, 0, 6)
    colorLabel.Text = lang.color_tema
    colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorLabel.BackgroundTransparency = 1
    colorLabel.Font = Enum.Font.Gotham
    colorLabel.TextSize = 11
    colorLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorLabel.ZIndex = 9

    local colorContainer = Instance.new("Frame", colorFrame)
    colorContainer.Size = UDim2.new(1, -12, 0, 25)
    colorContainer.Position = UDim2.new(0, 6, 0, 25)
    colorContainer.BackgroundTransparency = 1
    colorContainer.ZIndex = 9

    local colorLayout = Instance.new("UIListLayout", colorContainer)
    colorLayout.Padding = UDim.new(0, 4)
    colorLayout.FillDirection = Enum.FillDirection.Horizontal
    colorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    colorLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    colorLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, colorData in ipairs(coloresDisponibles) do
        local colorBtn = Instance.new("TextButton", colorContainer)
        colorBtn.Size = UDim2.new(0, 30, 0, 20)
        colorBtn.BackgroundColor3 = colorData.color
        colorBtn.BorderSizePixel = 0
        colorBtn.Text = ""
        colorBtn.AutoButtonColor = false
        colorBtn.ZIndex = 10

        local btnCorner = Instance.new("UICorner", colorBtn)
        btnCorner.CornerRadius = UDim.new(0, 4)

        colorBtn.MouseButton1Click:Connect(function()
            colorTema = colorData.color
            barraSuperior.BackgroundColor3 = colorTema
            enemyCountDisplay.TextColor3 = colorTema
            scroll.ScrollBarImageColor3 = colorTema
            
            -- Actualizar todos los elementos con el nuevo color
            for _, btn in pairs(scroll:GetDescendants()) do
                if btn:IsA("TextButton") and btn.BackgroundColor3 ~= Color3.fromRGB(60, 60, 60) then
                    if btn.Parent ~= colorContainer then
                        btn.BackgroundColor3 = colorTema
                    end
                end
            end
            
            -- Actualizar indicadores de pestañas
            aimbotIndicator.BackgroundColor3 = colorTema
            playerIndicator.BackgroundColor3 = colorTema
            visualesIndicator.BackgroundColor3 = colorTema
            mundoIndicator.BackgroundColor3 = colorTema
            configIndicator.BackgroundColor3 = colorTema
        end)
    end

    -- SELECTOR DE TAMAÑO DEL PANEL
    createSlider(lang.ancho, panelWidth, 200, 500, function(val)
        panelWidth = val
        panel.Size = UDim2.new(0, panelWidth, 0, panelHeight)
        barraSuperior.Size = UDim2.new(0, panelWidth, 0, BARRA_ALTO)
        barraSuperior.Position = UDim2.new(0.5, -panelWidth/2, 0.5, -panelHeight/2 - BARRA_ALTO)
        actualizarPosiciones()
    end)

    createSlider(lang.alto, panelHeight, 150, 400, function(val)
        panelHeight = val
        panel.Size = UDim2.new(0, panelWidth, 0, panelHeight)
        barraSuperior.Position = UDim2.new(0.5, -panelWidth/2, 0.5, -panelHeight/2 - BARRA_ALTO)
        actualizarPosiciones()
    end)

    -- SELECTOR DE IDIOMA
    local langFrame = Instance.new("Frame", scroll)
    langFrame.Size = UDim2.new(1, 0, 0, 40)
    langFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    langFrame.ZIndex = 8
    Instance.new("UICorner", langFrame).CornerRadius = UDim.new(0, 5)

    local langLabel = Instance.new("TextLabel", langFrame)
    langLabel.Size = UDim2.new(1, -12, 0, 16)
    langLabel.Position = UDim2.new(0, 6, 0, 2)
    langLabel.Text = lang.idioma
    langLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    langLabel.BackgroundTransparency = 1
    langLabel.Font = Enum.Font.Gotham
    langLabel.TextSize = 11
    langLabel.TextXAlignment = Enum.TextXAlignment.Left
    langLabel.ZIndex = 9

    local langContainer = Instance.new("Frame", langFrame)
    langContainer.Size = UDim2.new(1, -12, 0, 20)
    langContainer.Position = UDim2.new(0, 6, 0, 18)
    langContainer.BackgroundTransparency = 1
    langContainer.ZIndex = 9

    local langLayout = Instance.new("UIListLayout", langContainer)
    langLayout.Padding = UDim.new(0, 4)
    langLayout.FillDirection = Enum.FillDirection.Horizontal
    langLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    langLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    langLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local idiomasLista = {"español", "inglés", "portugués"}
    for _, idioma in ipairs(idiomasLista) do
        local langBtn = Instance.new("TextButton", langContainer)
        langBtn.Size = UDim2.new(0, 60, 0, 20)
        langBtn.BackgroundColor3 = colorTema
        langBtn.BorderSizePixel = 0
        langBtn.Text = idioma
        langBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        langBtn.Font = Enum.Font.GothamBold
        langBtn.TextSize = 9
        langBtn.AutoButtonColor = false
        langBtn.ZIndex = 10

        local btnCorner = Instance.new("UICorner", langBtn)
        btnCorner.CornerRadius = UDim.new(0, 4)

        langBtn.MouseButton1Click:Connect(function()
            actualizarIdioma(idioma)
        end)
    end

    local resetButton = createButton(lang.reset_all)
    resetButton.MouseButton1Click:Connect(function()
        flying = false; speedEnabled = false; noclipEnabled = false
        infiniteJumpEnabled = false; espBodyEnabled = false; espEnemyEnabled = false
        espBoxEnabled = false; espLineEnabled = false; espNameEnabled = false
        espSkeletonEnabled = false; espHealthEnabled = false
        aimbotEnabled = false; aimbotVisible = false
        aimbotFOV = 50; aimbotTarget = "cabeza"
        aimbotSmooth = 1
        fullbrightEnabled = false; removeFogEnabled = false
        antiLagEnabled = false; hitboxEnabled = false
        hitboxSize = 5; hitboxTransparency = 0.4
        enemyCountDisplay.Visible = false

        if player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 16 end
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end

        pcall(function()
            if originalBrightness then Lighting.Brightness = originalBrightness end
            if originalAmbient then Lighting.Ambient = originalAmbient; Lighting.OutdoorAmbient = originalAmbient end
            if originalFog then Lighting.FogEnd = originalFog[1]; Lighting.FogStart = originalFog[2] end
            for _, effect in pairs(Lighting:GetChildren()) do
                if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("DepthOfFieldEffect") then
                    effect.Enabled = true
                end
            end
        end)

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                if plr.Character:FindFirstChild("EMZ_ESP") then plr.Character.EMZ_ESP:Destroy() end
                if plr.Character:FindFirstChild("EMZ_ESP_ENEMY") then plr.Character.EMZ_ESP_ENEMY:Destroy() end
                restaurarHitboxDeCharacter(plr.Character)
            end
        end

        for _, box in pairs(espBoxes) do
            for _, line in pairs(box) do line:Remove() end
        end
        espBoxes = {}
        for _, line in pairs(espLines) do line:Remove() end
        espLines = {}
        for _, lbl in pairs(espNameLabels) do lbl:Remove() end
        espNameLabels = {}
        for _, bars in pairs(espHealthBars) do
            bars.outline:Remove()
            bars.fill:Remove()
        end
        espHealthBars = {}
        for _, lines in pairs(espSkeletonLines) do
            for _, line in pairs(lines) do line:Remove() end
        end
        espSkeletonLines = {}

        switchTab(lastTab)
    end)
end

-- switchTab
local function switchTab(tabName)
    activeTab = tabName
    
    -- Limpiar scroll
    for _, child in pairs(scroll:GetChildren()) do
        if child:IsA("GuiObject") then child:Destroy() end
    end

    -- Ocultar todos los indicadores
    aimbotIndicator.Visible = false
    playerIndicator.Visible = false
    visualesIndicator.Visible = false
    mundoIndicator.Visible = false
    configIndicator.Visible = false

    if tabName == "AIM" then
        loadAimbotTab()
        aimbotIndicator.Visible = true
    elseif tabName == "PLAYER" then
        loadPlayerTab()
        playerIndicator.Visible = true
    elseif tabName == "ESP" then
        loadVisualesTab()
        visualesIndicator.Visible = true
    elseif tabName == "WORLD" then
        loadMundoTab()
        mundoIndicator.Visible = true
    elseif tabName == "CONFIG" then
        loadConfigTab()
        configIndicator.Visible = true
    end
end

-- CONEXIONES DE PESTAÑAS
aimbotTabButton.MouseButton1Click:Connect(function()
    lastTab = "AIM"; switchTab("AIM")
end)
playerTabButton.MouseButton1Click:Connect(function()
    lastTab = "PLAYER"; switchTab("PLAYER")
end)
visualesTabButton.MouseButton1Click:Connect(function()
    lastTab = "ESP"; switchTab("ESP")
end)
mundoTabButton.MouseButton1Click:Connect(function()
    lastTab = "WORLD"; switchTab("WORLD")
end)
configTabButton.MouseButton1Click:Connect(function()
    lastTab = "CONFIG"; switchTab("CONFIG")
end)

-- TOGGLE PANEL
local isOpen = true
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    panel.Visible = isOpen
    toggleButton.Text = isOpen and "◀" or "▶"
    if isOpen then 
        switchTab(lastTab)
        actualizarPosiciones()
    end
end)

-- FLY + SPEED
RunService.RenderStepped:Connect(function()
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = camera.CFrame.LookVector * flySpeed
    end
    if speedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)

-- INFINITE JUMP
UIS.JumpRequest:Connect(function()
    if infiniteJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- FOV CIRCLE
RunService.RenderStepped:Connect(function()
    updateFOVCircle()
end)

-- AUTO UPDATE ESP
RunService.Heartbeat:Connect(function()
    limpiarESPObsoleto()

    if espEnemyEnabled then
        local enemyCount = 0
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                enemyCount = enemyCount + 1
            end
        end
        enemyCountDisplay.Text = lang.enemigos .. " " .. enemyCount
        enemyCountDisplay.Visible = true
    else
        enemyCountDisplay.Visible = false
    end

    if espBodyEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local highlight = plr.Character:FindFirstChild("EMZ_ESP")
                if highlight then
                    highlight.FillColor = colorTema
                    highlight.OutlineColor = colorTema
                else
                    local h = Instance.new("Highlight")
                    h.Name = "EMZ_ESP"
                    h.FillColor = colorTema
                    h.OutlineColor = colorTema
                    h.FillTransparency = 0.3
                    h.OutlineTransparency = 0
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent = plr.Character
                end
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("EMZ_ESP") then
                plr.Character.EMZ_ESP:Destroy()
            end
        end
    end

    if espBoxEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                drawESPBox(plr)
            end
        end
    else
        for _, box in pairs(espBoxes) do
            for _, line in pairs(box) do line.Visible = false end
        end
    end

    if espLineEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                drawESPLine(plr)
            end
        end
    else
        for _, line in pairs(espLines) do line.Visible = false end
    end

    if espNameEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                drawESPName(plr)
            end
        end
    else
        for _, lbl in pairs(espNameLabels) do lbl.Visible = false end
    end

    if espHealthEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                drawESPHealth(plr)
            end
        end
    else
        for _, bars in pairs(espHealthBars) do
            bars.outline.Visible = false
            bars.fill.Visible = false
        end
    end

    if espSkeletonEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                drawESPSkeleton(plr)
            end
        end
    else
        for _, lines in pairs(espSkeletonLines) do
            for _, line in pairs(lines) do line.Visible = false end
        end
    end
end)

-- HITBOX LOOP
RunService.Heartbeat:Connect(function()
    if not hitboxEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                hrp.Color = Color3.fromRGB(0, 0, 0)
                hrp.Material = Enum.Material.Neon
                hrp.Transparency = hitboxTransparency
                hrp.CanCollide = false
            end
        end
    end
end)

-- Actualizar posiciones iniciales
task.wait(0.1)
actualizarPosiciones()

-- Cargar pestaña inicial
switchTab("AIM")
