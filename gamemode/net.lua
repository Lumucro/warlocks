local GotKillSounds = {
	"vo/ravenholm/monk_kill01.wav",
	"vo/ravenholm/monk_mourn03.wav",
	"vo/ravenholm/monk_mourn04.wav",
	"vo/ravenholm/monk_mourn05.wav",
	"vo/ravenholm/monk_kill11.wav"
}

local DiedSounds = {
	"vo/ravenholm/madlaugh01.wav",
	"vo/ravenholm/madlaugh02.wav"
}

function PlayGotKillSound( ply )

	if !IsValid( ply ) || !ply:IsPlayer() then return end

	net.Start( "PlayerGotKill" )
		net.WriteString( table.Random( GotKillSounds ) )
	net.Send( ply )

end

function PlayDiedSound( ply )

	if !IsValid( ply ) || !ply:IsPlayer() then return end
	
	net.Start( "PlayerDied" )
		net.WriteString( table.Random( GotKillSounds ) )
	net.Send( ply )

end

function UpdateRoundState()

	net.Start( "UpdateRoundState" )
		net.WriteInt( GetRoundState(), 8 )
	net.Broadcast()

end

function UpdateTimeLeft( time )

	net.Start( "RoundTimeLeft" )
		net.WriteInt( time, 8 )
	net.Broadcast()

end

function AnnounceWinner( p )

	net.Start( "AnnounceRoundWinner" )
		net.WriteString( p )
	net.Broadcast()

end