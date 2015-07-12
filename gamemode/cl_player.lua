function GM:CalcView( ply, pos, angles, fov )

	local view = {}
	view.origin = pos - ( angles:Forward() * 100 )
	view.origin = view.origin - ( angles:Right() * -10 )
	view.angles = angles
	view.fov = fov

	return view

end

function GM:ShouldDrawLocalPlayer( ply )

	return true

end