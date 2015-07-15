net.Receive( "PlayerGotKill", function()

	surface.PlaySound(  net.ReadString()  )

end )

net.Receive( "PlayerDied", function()

	surface.PlaySound(  net.ReadString()  )
	SetPlayerDied()

end )

net.Receive( "UpdateRoundState", function()

	local firsttimecheck = GAMEMODE.roundstate || nil
	SetRoundState( net.ReadInt( 8 ) )

	if firsttimecheck != nil && GetRoundState() == ROUND_READY then
		surface.PlaySound( "warlocks/justdoit_countdown.wav" )
		GAMEMODE.winner = nil
	elseif GetRoundState() == ROUND_READY then
		GAMEMODE.winner = nil
	end

end )

net.Receive( "RoundTimeLeft", function()

	SetRoundTime( net.ReadInt( 8 ) )

end )

net.Receive( "AnnounceWinner", function()

	local winner = net.ReadEntity()
	SetRoundWinner( winner )

end )