function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	for i=1, 7 do

		local fire = pemit:Add( "sprites/flamelet"..tostring( math.random( 1, 5 ) ), pos + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) )
		fire:SetDieTime( 0.5 )
		fire:SetStartSize( 1 )
		fire:SetEndSize( 3 )
		fire:SetColor( Color( 50, 50, 255, 255 ) )

	end

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end