if SERVER then AddCSLuaFile('scoreboard_config.lua')
    resource.AddFile('materials/content/discord.png')
    resource.AddFile('materials/content/www.png')
    resource.AddFile('materials/content/steam.png') 
end

include('scoreboard_config.lua')

if not CLIENT then return end

local Surface_CreateFont = surface.CreateFont

Surface_CreateFont('ScoreboardFont',{font='Trebuchet24',size=35,weight=800,antialias=true,bold=true,outline=true,shadow=true})
Surface_CreateFont('ScoreboardFontSmall',{font='Trebuchet24',size=25,weight=700,antialias=true,bold=true})

local function Scoreboard()

    local discordicon = Material('content/discord.png')
    local www = Material('content/www.png')
    local steam = Material('content/steam.png')

    Frame = vgui.Create('DFrame')
    Frame:SetSize(ScrW()-300,ScrH()-100)
    Frame:SetTitle('')
    Frame:SetDraggable(false)
    Frame:SetVisible(true)
    Frame:ShowCloseButton(false)
    Frame:Center()
    gui.EnableScreenClicker(true)

    local text = {
        {tag='Name',spacing=Frame:GetWide()/60},
        {tag='Job',spacing=Frame:GetWide()/6.5},
        {tag='Money',spacing=Frame:GetWide()/3.5},
        {tag='Rank',spacing=Frame:GetWide()/2.3},
        {tag='Kills',spacing=Frame:GetWide()/1.7},
        {tag='Deaths',spacing=Frame:GetWide()/1.35},
        {tag='Ping',spacing=Frame:GetWide()/1.08}
    }

    Frame.Paint = function(me,w,h)

        ScoreboardDrawing.DrawRect(0,0,Frame:GetWide(),Frame:GetTall(),Color(108,110,105,26))
        ScoreboardDrawing.DrawRect(0,50,Frame:GetWide(),Frame:GetTall()-100,Color(14,14,14,155))
        ScoreboardDrawing.DrawRect(10,73,Frame:GetWide()-20,30,Color(34,34,34,230) )
        for k, v in pairs(text) do  
            ScoreboardDrawing.DrawText(v.tag,'ScoreboardFont',v.spacing,Frame:GetTall()/20,Color(255,255,255))
        end
        ScoreboardDrawing.DrawText(camelCaseScoreboardConfig.ServerName,'ScoreboardFont',Frame:GetWide()/60,Frame:GetTall()/150,Color(255,255,255))
        ScoreboardDrawing.DrawText('Players: '..#player.GetAll(),'ScoreboardFontSmall',Frame:GetWide()-150,Frame:GetTall()/100,Color(255,255,255))

    end

    local discord = vgui.Create('DImageButton',Frame)
    discord:SetPos(Frame:GetWide()-220,Frame:GetTall()-1345)
    discord:SetSize(55,55)
    discord:SetMaterial(discordicon)
    discord:SetCursor('hand')
    discord:SetMouseInputEnabled(true)
    discord.OnMousePressed = function()
        gui.OpenURL(camelCaseScoreboardConfig.Discord)
    end    

    local website = vgui.Create('DImageButton',Frame)
    website:SetPos(Frame:GetWide()-260,Frame:GetTall()/500)
    website:SetSize(44,44)
    website:SetMaterial(www)
    website:SetCursor('hand')
    website:SetMouseInputEnabled(true)
    website.OnMousePressed = function()
        gui.OpenURL(camelCaseScoreboardConfig.Website)
    end    

    local steamicon = vgui.Create('DImageButton',Frame)
    steamicon:SetPos(Frame:GetWide()-310,Frame:GetTall()/500)
    steamicon:SetSize(44,44)
    steamicon:SetMaterial(steam)
    steamicon:SetCursor('hand')
    steamicon:SetMouseInputEnabled(true)
    steamicon.OnMousePressed = function()
        gui.OpenURL(camelCaseScoreboardConfig.Steam)
    end
    
    offset1 = vgui.Create('Panel',Frame)
    offset1:SetSize(Frame:GetWide(),85)
    offset1:Dock(TOP)
    
    offset1.Paint = function(me,w,h)
        ScoreboardDrawing.DrawRect(0,0,w,h,Color(255,255,255,0))
    end

    offset2 = vgui.Create('Panel',Frame)
    offset2:SetSize(Frame:GetWide(),45)
    offset2:Dock(BOTTOM)

    offset2.Paint = function(me,w,h)
        ScoreboardDrawing.DrawRect(0,0,w,h,Color(255,255,255,0))
    end

    itemlist = vgui.Create('DScrollPanel',Frame)
    itemlist:Dock(FILL)

    itemlist.Paint = function(me,w,h)
        ScoreboardDrawing.DrawRect(0,0,w,h,Color(255,255,255,0))
    end

    for _, v in pairs(player.GetAll()) do
        item =  itemlist:Add('DPanel')
        item:SetSize(itemlist:GetWide(),30)
        item:Dock(TOP)
        item:DockMargin(0,0,0,5)

        item.Paint = function(me,w,h)
            if v == LocalPlayer() then
                ScoreboardDrawing.DrawRect(0,0,w,h,Color(172,91,91,200))
            else            
                ScoreboardDrawing.DrawRect(0,0,w,h,Color(46,45,45,200))
            end
            ScoreboardDrawing.DrawText(v:getDarkRPVar('rpname'),'ScoreboardFontSmall',text[1][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(string.upper(v:getDarkRPVar('job')),'ScoreboardFontSmall',text[2][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(v:getDarkRPVar('money'),'ScoreboardFontSmall',text[3][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(string.upper(v:GetUserGroup()),'ScoreboardFontSmall',text[4][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(v:Frags(),'ScoreboardFontSmall',text[5][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(v:Deaths(),'ScoreboardFontSmall',text[6][2],item:GetTall()/50,Color(255,255,255))
            ScoreboardDrawing.DrawText(v:Ping(),'ScoreboardFontSmall',text[7][2],item:GetTall()/50,Color(255,255,255)) 
        end

        if not IsValid(v) then item:Remove() return end
    end

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
