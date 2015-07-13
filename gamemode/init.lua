AddCSLuaFile( "cl_player.lua" )
AddCSLuaFile( "cl_net.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "vgui/cl_scoreboard.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

resource.AddFile( "materials/botondtextures/ConcreteWornPaint004.vtf" ) 
resource.AddFile( "materials/botondtextures/ConcreteWornPaint004_slip.vmt" ) 
resource.AddFile( "sound/warlocks/justdoit_countdown.wav" ) 

include( "shared.lua" )
include( "player.lua" )
include( "net.lua" )

util.AddNetworkString( "PlayerGotKill" )
util.AddNetworkString( "PlayerDied" )
util.AddNetworkString( "UpdateRoundState" )
util.AddNetworkString( "RoundTimeLeft" )
util.AddNetworkString( "AnnounceWinner" )

local minply = 2
local layers = {}
local roundstart_time = CurTime()
local nextdrop = roundstart_time + 10
local currentdrop = 1
local warndropcolor = false
local leaderboard = {}

local function StartRound()

	SetRoundState( ROUND_INPROGRESS )

end

local function StartRoundPreparation()

	SetRoundState( ROUND_READY )

end

function GM:Initialize()

	SetRoundState( ROUND_WAITING )

	if not timer.Start( "checkplayersalive" ) then
	    timer.Create( "checkplayersalive", 2, 0, function()

	    	print("checking if round is still valid")
	    	if GetRoundState() != ROUND_INPROGRESS then return end

	    	local alive = 0
	    	for k, v in pairs( player.GetAll() ) do
	    		if v:Alive() then 
	    			alive = alive + 1
	    		end
	    	end

	    	if alive == 0 || alive == 1 then
	    		CheckRoundOver()
	    	end

	    end )
	end

	GAMEMODE.currentround = 0

end

function GM:KeyPress( ply, key)

	--spectators bomb the living
	if IsValid( ply ) && !ply:Alive() && ply:KeyDown( IN_ATTACK ) && GetRoundState() == ROUND_INPROGRESS then
		
		print( "dead player clicked LMB" )

	end

	--double jump
	if key != IN_JUMP then return end

	if ply:IsOnGround() || ply.doublejumped == nil then
		
		ply.doublejumped = false

	elseif IsValid( ply ) && !ply:IsOnGround() && !ply.doublejumped then

		local ang, forward, right = ply:GetAngles(), ply:GetForward(), ply:GetRight()
		local vel = ply:GetVelocity() * -1
		vel = vel + Vector( 0, 0, 400 )
	
		if ply:KeyDown(IN_FORWARD) then
			vel = vel + forward * ply:GetMaxSpeed()
		elseif ply:KeyDown(IN_BACK) then
			vel = vel - forward * ply:GetMaxSpeed()
		end
		
		if ply:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * ply:GetMaxSpeed()
		elseif ply:KeyDown(IN_MOVELEFT) then
			vel = vel - right * ply:GetMaxSpeed()
		end
		
		ply:SetVelocity(vel)
		ply.doublejumped = true

	end

	ply.jumping = true

end

function GM:Think()

	for k, v in pairs( player.GetAll() ) do

		if v.jumping == nil then v.jumping = true end

		if v.jumping && v:IsOnGround() && v:Alive() then

			local effectdata = EffectData()
			effectdata:SetOrigin( v:GetPos() )
			effectdata:SetScale( 100 )
		    util.Effect( "ThumperDust", effectdata )
		    v.jumping = false

		elseif !v:IsOnGround() && !v.jumping && v:Alive() then

			v.jumping = true

		end
	end

	if GetRoundState() == ROUND_INPROGRESS && #player.GetAll() > 1 then

		if nextdrop <= CurTime() then

			nextdrop = CurTime() + 10
			warndropcolor = false

			if currentdrop > #layers then return end
			layers[ currentdrop ]:Fire( "break", 0 )
			currentdrop = currentdrop + 1

		elseif (nextdrop - 2) <= CurTime() && !warndropcolor then
			
			warndropcolor = true
			if currentdrop > #layers then return end
			layers[ currentdrop ]:SetColor( Color( 255, 0, 0, 255 ) )

		end

	end

end

function EndRound( ply )

	if ply != nil then
		ply:AddFrags( 1 )
		print( ply:Nick() .. " has won the game" )
		AnnounceWinner( ply )
	end

	SetRoundState( ROUND_OVER )

	timer.Simple( 5, function()
		StartRoundPreparation()
	end)

end

function CheckRoundOver()

	if GetRoundState() != ROUND_INPROGRESS then return end

	local alive = 0
	local winner

	for k, v in pairs( player.GetAll() ) do
		if v:Alive() && IsValid( v ) then
			alive = alive + 1
			winner = v
		end
	end

	if alive == 1 then
		EndRound( winner )
	elseif alive == 0 then
		EndRound()
	end

end

local function CheckForPlayers()

	if GetRoundState() == ROUND_INPROGRESS || GetRoundState() == ROUND_OVER || GetRoundState() == ROUND_READY then return end

	local playersready = 0

	for k,v in pairs( player.GetAll() ) do

		if IsValid( v ) then
			playersready = playersready + 1
		end

	end

	if playersready >= minply then
		StartRoundPreparation()
	end

	if playersready == 0 && GetRoundState() != ROUND_WAITING then
		SetRoundState( ROUND_WAITING )
	end

	print( "checked players, " .. playersready .. " ready (rs: " .. GetRoundState() .. ")" )

end

function GetRoundState()

	return GAMEMODE.roundstate

end

function GetCurrentRound()

	return GAMEMODE.currentround

end

function SetRoundState( state )

	GAMEMODE.roundstate = state

	if state == ROUND_WAITING then

		if not timer.Start( "waitforplayers" ) then
	    	timer.Create( "waitforplayers", 2, 0, CheckForPlayers )
		end

		print( "waiting for players (rs: " .. GetRoundState() .. ")" )

	elseif state == ROUND_READY then

		if #player.GetAll() >= 2 then

			layers = {}
			currentdrop = 1
			warndropcolor = false
			
			game.CleanUpMap( false, {} ) 

			print( "round preparing (rs: " .. GetRoundState() .. ")" )

			for k,v in pairs( player.GetAll() ) do

				v:Spawn()
				v:StripWeapons()
				v:Give( "weapon_wl_unarmed" )

			end

			timer.Simple( 10, function()
				StartRound()
			end )

			UpdateTimeLeft( 10 )

		else

			if not timer.Start( "waitforplayers" ) then
	     		timer.Create( "waitforplayers", 2, 0, CheckForPlayers )
			end

		end

	elseif state == ROUND_INPROGRESS then
		
		print( "round started (rs: " .. GetRoundState() .. ")" )

		for k,v in pairs( player.GetAll() ) do

			if !v:Alive() then
				v:Spawn()
			end

			v:StripWeapons()
			v:Give( "weapon_wl_magic" )

		end

		roundstart_time = CurTime()
		nextdrop = roundstart_time + 10
		GAMEMODE.currentround = GAMEMODE.currentround + 1
		print( GetCurrentRound() )

	end

	UpdateRoundState()

end

function GM:EntityKeyValue( ent, key, value ) 

	if key == "arenalayer" then
		
		table.insert( layers, ent )

	end

	return true

end