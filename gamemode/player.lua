local playermodelchoices = {
	"models/player/Group01/male_01.mdl",
	"models/player/Group01/male_05.mdl",
	"models/player/Group01/male_07.mdl"
}

function GM:PlayerDeathThink( ply )

	/*if GAMEMODE.roundstate >= 2 then

		GAMEMODE:PlayerSpawnAsSpectator( ply )*/

	if ( GAMEMODE.roundstate < 2 && ( ply:IsBot() || ply:KeyPressed( IN_ATTACK ) ) ) then
	
		ply:Spawn()
	
	end
end

function GM:PlayerInitialSpawn( ply ) 

	if GAMEMODE.roundstate >= ROUND_INPROGRESS then

		ply:KillSilent()

	end

	ply.doublejumped = false
	ply.jumping = false

	UpdateRoundStateSingle( ply )
	UpdateTimeLeftSingle( ply, 10 )

end

function GM:PlayerSpawn( ply ) 

	ply:SetJumpPower( 500 )
	ply:SetModel( table.Random( playermodelchoices ) )

	ply:StripWeapons()
	ply:Give( "weapon_wl_unarmed" )

	ply.lastattacker = nil

end

function GM:GetFallDamage( ply, speed )

	return 0

end

function GM:PlayerShouldTakeDamage( ply, ent )

	if ent:GetClass() == "wl_magic_push" || ent:GetClass() == "wl_magic_melonshot" then
		return false
	end

	return true

end

function GM:PostPlayerDeath( victim, inflictor, attacker )

	CheckRoundOver()

	if victim != victim.lastattacker then
		PlayGotKillSound( victim.lastattacker )
	end

	PlayDiedSound( victim )

end

function GM:PlayerDisconnected( ply )

	PrintMessage( HUD_PRINTCENTER, ply:Nick() .. " has resigned from their warlock duties, much like Ellen Pao from hers." )	
	CheckRoundOver()

	local playersleft = 0

	for k, v in pairs( player.GetAll() ) do
		if v != ply then
			playersleft = playersleft + 1
		end
	end

	if playersleft < 2 then

		SetRoundState( ROUND_WAITING )
		
	end

end

function GM:CanPlayerSuicide( ply )

	ply:ChatPrint( "There shall be no escape, mortal!" )
	return false

end