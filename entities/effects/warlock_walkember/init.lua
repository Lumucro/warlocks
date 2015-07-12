function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	for i=1, 2 do

		local fire = pemit:Add( "sprites/flamelet"..tostring( math.random( 1, 5 ) ), pos + Vector( math.random( -20, 20 ), math.random( -20, 20 ), math.random( -20, 20 ) ) )
		fire:SetDieTime( 1 )
		fire:SetStartSize( 5 )
		fire:SetEndSize( 7 )

		local smoke = pemit:Add( "particles/smokey", fire:GetPos() + Vector( 0, 0, 10 ) )
		smoke:SetDieTime( 1 )
		smoke:SetStartSize( 5 )
		smoke:SetEndSize( 7 )
		smoke:SetColor( 70, 70, 70, 220 )
		smoke:SetGravity( Vector( 0, 0, 60 ) )

	end

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end