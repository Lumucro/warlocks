include( "shared.lua" )
include( "cl_player.lua" )
include( "cl_net.lua" )
include( "vgui/cl_scoreboard.lua" )
include( "cl_hud.lua" )

local roundtime = 0
local lasttick = CurTime()

function GetRoundState()

	return GAMEMODE.roundstate

end

function SetRoundState( state )

	GAMEMODE.roundstate = state

	if state == ROUND_READY then
		lasttick = CurTime()
	end

end

function SetRoundTime( time )

	if !isnumber( tonumber(time) ) then return end
	roundtime = time

end

function GetRoundTime()

	return roundtime

end

function GM:Initialize()

	GAMEMODE.roundstate = ROUND_WAITING

end

function GM:Think()

	if (lasttick + 1) <= CurTime() && GetRoundState() == ROUND_READY then

		lasttick = CurTime()
		if (roundtime - 1) <= 0 then return end
		roundtime = roundtime - 1

	end

end

function GM:HUDShouldDraw( name ) 

	if name == "CHudHealth" || name == "CHudDamageIndicator" || name == "CHudDeathNotice" || name == "CHudWeapon" || name == "CHudWeaponSelection" then return false end
	return true
	
end
