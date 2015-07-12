local xcenter = ScrW() / 2
local ycenter = ScrH() / 2

local function GetRoundStateHUD()

	if GetRoundState() == ROUND_WAITING then
		return "Waiting for more souls"
	elseif GetRoundState() == ROUND_READY then
		return "Preparing harvest"
	elseif GetRoundState() == ROUND_INPROGRESS then
		return "Soul harvest in progress"
	elseif GetRoundState() == ROUND_OVER then
		return "Retrieving warlocks from hell"
	end

end

function GM:HUDPaint()

	draw.DrawText( GetRoundStateHUD(), "ScoreboardDefault", xcenter, 10, Color( 200, 0, 0, 255 ), TEXT_ALIGN_CENTER ) 
	
	if GetRoundState() != ROUND_READY then return end
	draw.DrawText( GetRoundTime(), "ScoreboardDefaultTitle", xcenter, 40, Color( 180, 0, 0, 255 ), TEXT_ALIGN_CENTER ) 

end