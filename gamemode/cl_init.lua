include( "shared.lua" )
include( "cl_player.lua" )
include( "cl_net.lua" )
include( "vgui/cl_scoreboard.lua" )
include( "cl_hud.lua" )

local roundtime = 0
local lasttick = CurTime()
local showplayertime = 0
local winnerpanel = nil

local function ShowPlayerWon()

	winnerpanel = vgui.Create( "DPanel" )
	winnerpanel:SetPos( ScrW() / 2 - 150, ScrH() / 2 - 150 )
	winnerpanel:SetSize( 300, 180 )

	local avatar = vgui.Create( "AvatarImage", winnerpanel )
	avatar:SetPlayer( GAMEMODE.winner )
	avatar:SetSize( 100, 100 )
	avatar:Dock( TOP )
	avatar:DockMargin( 100, 4, 100, 4 )

	local winner = vgui.Create( "DLabel", winnerpanel )
	winner:SetText( "ROUND WON BY" )
	winner:Dock( TOP )
	winner:DockMargin( 0, 4, 0, 0 )
	winner:SetFont( "ScoreboardDefault" )
	winner:SizeToContents()
	winner:SetContentAlignment( 5 )

	local name = vgui.Create( "DLabel", winnerpanel )
	name:SetText( GAMEMODE.winner:Nick() )
	name:Dock( TOP )
	name:DockMargin( 0, 8, 0, 4 )
	name:SetSize( 300, 30 )
	name:SetFont( "ScoreboardDefaultTitle" )
	name:SetContentAlignment( 5 )

	winnerpanel:SetBackgroundColor( Color( 100, 100, 100, 0 ) )

end

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

function SetRoundWinner( p )

	if !IsValid( p ) || !p:IsPlayer() then return end
	GAMEMODE.winner = p
	
	showplayertime = CurTime() + 5
	ShowPlayerWon()
	if winnerpanel != nil then
		winnerpanel:Show()
	end

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

	if showplayertime <= CurTime() then
		if winnerpanel != nil then
			winnerpanel:Hide()
		end
	end

end

function GM:HUDShouldDraw( name ) 

	if name == "CHudHealth" || name == "CHudDamageIndicator" || name == "CHudDeathNotice" || name == "CHudWeapon" || name == "CHudWeaponSelection" then return false end
	return true
	
end
