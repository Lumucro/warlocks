net.Receive( "PlayerGotKill", function()

	surface.PlaySound(  net.ReadString()  )

end )

net.Receive( "PlayerDied", function()

	surface.PlaySound(  net.ReadString()  )

end )

net.Receive( "UpdateRoundState", function()

	SetRoundState( net.ReadInt( 8 ) )

	if GetRoundState() == ROUND_READY then
		surface.PlaySound( "warlocks/justdoit_countdown.wav" )
	end

end )

net.Receive( "RoundTimeLeft", function()

	SetRoundTime( net.ReadInt( 8 ) )

end )