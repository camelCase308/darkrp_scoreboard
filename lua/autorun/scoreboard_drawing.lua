if not CLIENT then return end

ScoreboardDrawing = ScoreboardDrawing or {}

function ScoreboardDrawing.DrawRect(x,y,w,h,color)
    surface.SetDrawColor(color)
    surface.DrawRect(x,y,w,h)
end

function ScoreboardDrawing.DrawText(str,font,x,y,color)
    surface.SetFont(font)
    surface.SetTextPos(x,y)
    surface.SetTextColor(color)
    surface.DrawText(str)
end

function ScoreboardDrawing.DrawOutlinedRect(x,y,w,h,thick,color)
    surface.SetDrawColor(color)
    for i = 0, thick - 1 do
        surface.DrawOutlinedRect(x+i,y+i,w-i*2,h-i*2)
    end
end

local blur = Material('pp/blurscreen')
function ScoreboardDrawing.Blurred(panel,layers,density,alpha)

    local x,y = panel:LocalToScreen(0,0)

    surface.SetDrawColor(255,255,255,alpha)
    surface.SetMaterial(blur)

    for i=1, 3 do
        blur:SetFloat('$blur', (i/layers)*density)
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(-x,-y,ScrW(),ScrH())
    end
end