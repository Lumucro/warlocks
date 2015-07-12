function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	for i=1, 15 do

		local fire = pemit:Add( "sprites/flamelet"..tostring( math.random( 1, 5 ) ), pos + Vector( math.random( -20, 20 ), math.random( -20, 20 ), math.random( -20, 20 ) ) )
		fire:SetDieTime( math.random( 1, 2 ) )
		fire:SetStartSize( 15 )
		fire:SetEndSize( 20 )

		local smoke = pemit:Add( "particles/smokey", fire:GetPos() + Vector( 0, 0, 20 ) )
		smoke:SetDieTime( math.random( 1, 2 ) )
		smoke:SetStartSize( 15 )
		smoke:SetEndSize( 25 )
		smoke:SetColor( 70, 70, 70, 220 )
		smoke:SetGravity( Vector( 0, 0, 60 ) )

	end

	local smoke = pemit:Add( "particle/particle_smokegrenade", pos )
	smoke:SetDieTime( 3 )
	smoke:SetStartSize( 30 )
	smoke:SetEndSize( 40 )
	smoke:SetColor( 100, 100, 100, 255 )

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end