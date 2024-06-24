if SERVER then AddCSLuaFile('scoreboard_config.lua') end
include('scoreboard_config.lua')

if not CLIENT then return end

local Surface_CreateFont = surface.CreateFont

Surface_CreateFont('ScoreboardFont',{font='Trebuchet24',size=35,weight=800,antialias=true,bold=true,outline=true,shadow=true})
Surface_CreateFont('ScoreboardFontSmall',{font='Trebuchet24',size=25,weight=700,antialias=true,bold=true})
Surface_CreateFont('ScoreboardFontWebsite',{font='Trebuchet24',size=15,weight=700,antialias=true,underline=true,bold=true})

local text = {
    {tag='Name',spacing=Frame:GetWide()/60},
    {tag='Job',spacing=Frame:GetWide()/6.5},
    {tag='Money',spacing=Frame:GetWide()/3.5},
    {tag='Rank',spacing=Frame:GetWide()/2.3},
    {tag='Kills',spacing=Frame:GetWide()/1.7},
    {tag='Deaths',spacing=Frame:GetWide()/1.35},
    {tag='Ping',spacing=Frame:GetWide()-200}
}

local function DrawInfo()
    for k, v in pairs(text) do
        ScoreboardDrawing.DrawText(v.tag,'ScoreboardFont',v.spacing,Frame:GetTall()-1273,Color(255,255,255,122))
    end
end


local function Scoreboard()

    Frame = vgui.Create('DFrame')
    Frame:SetSize(ScrW()-300,ScrH()-100)
    Frame:SetTitle('')
    Frame:SetDraggable(false)
    Frame:SetVisible(true)
    Frame:ShowCloseButton(false)
    Frame:Center()
    gui.EnableScreenClicker(true)
    Frame.Paint = function(me,w,h)
        ScoreboardDrawing.DrawRect(0,0,Frame:GetWide(),Frame:GetTall(),Color(78,78,168))
        ScoreboardDrawing.DrawRect(0,50,Frame:GetWide(),Frame:GetTall()-100,Color(14,14,14))
        ScoreboardDrawing.DrawRect(10,73,Frame:GetWide() - 20,30,Color(34,34,34) )
        DrawInfo()
        ScoreboardDrawing.DrawText(Scoreboard_Config.ServerName,'ScoreboardFont',Frame:GetWide()/60,Frame:GetTall()/150,Color(255,255,255,122))
        ScoreboardDrawing.DrawText('Players: '..#player.GetAll(),'ScoreboardFontSmall',Frame:GetWide()-150,Frame:GetTall()/100,Color(255,255,255,122))
    end

   
    local webpage = vgui.Create('DLabel',Frame)
    webpage:SetPos(Frame:GetWide()-2222,Frame:GetTall()-1355)
    webpage:SetSize(200,150)
    webpage:SetFont('ScoreboardFontWebsite')
    webpage:SetTextColor(Color(86,108,134))
    webpage:SetText(Scoreboard_Config.Website)
    webpage:SetCursor('hand')
    webpage:SetMouseInputEnabled(true)
    webpage.OnMousePressed = function()
        gui.OpenURL('http://'..Scoreboard_Config.Website)
    end

    //local discord = vgui.Create('DImage', Frame)
    //discord:SetPos()
    //discord



end

local function ScoreboardHide()
    Frame:SetVisible(false)
    gui.EnableScreenClicker(false)
end

hook.Add('ScoreboardShow','Show_Scoreboard',function()
    Scoreboard()
    return true
end )

hook.Add('ScoreboardHide','Remove_Scoreboard',function()
    if IsValid( Frame ) then ScoreboardHide() end
    return true 
end)

