if SERVER then AddCSLuaFile('scoreboard_config.lua') end
include('scoreboard_config.lua')

if not CLIENT then return end

local Surface_CreateFont = surface.CreateFont
local Color = Color

Surface_CreateFont('ScoreboardFont',{font='Trebuchet24',size=35,weight=800,antialias=true,bold=true,outline=true,shadow=true})
Surface_CreateFont('ScoreboardFontSmall',{font='Trebuchet24',size=25,weight=700,antialias=true,bold=true})
Surface_CreateFont('ScoreboardFontWebsite',{font='Trebuchet24',size=15,weight=700,antialias=true,underline=true,bold=true})

local function Scoreboard()
    local w,h = ScrW(),ScrH() 
    Frame = vgui.Create('DFrame')
    Frame:SetSize(w-300,h-100)
    Frame:SetTitle('')
    Frame:SetDraggable(false)
    Frame:SetVisible(true)
    Frame:ShowCloseButton(false)
    Frame:Center()
    gui.EnableScreenClicker(true)
    Frame.Paint = function(me,w,h)
        ScoreboardDrawing.Blurred(me,13,20,200)
        ScoreboardDrawing.DrawRect(0,0,w,h,Color(78,78,168,250))
        ScoreboardDrawing.DrawRect(0,50,w,h-100,Color(14,14,14,100))
        ScoreboardDrawing.DrawRect( 10, 73, w - 20, 30, Color( 34, 34, 34, 150 ) )
        //Draw job names later      
        ScoreboardDrawing.DrawText(Scoreboard_Config.ServerName,'ScoreboardFont',w/60,h/150,Color(255,255,255,122))
        ScoreboardDrawing.DrawText('Players: '..#player.GetAll(),'ScoreboardFontSmall',w-150,h/100,Color(255,255,255,122))
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

    Frame.PlayerTabs = vgui.Create('DPanelList',Frame)
    Frame.PlayerTabs:SetPos()
    Frame.PlayerTabs:SetSize()
    Frame.PlayerTabs:SetSpacing()
    Frame.PlayerTabs:EnableVerticalScrollbar(true )


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

