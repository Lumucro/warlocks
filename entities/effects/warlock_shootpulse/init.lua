function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	local fire = pemit:Add( "sprites/flamelet"..tostring( math.random( 1, 5 ) ), pos )
	fire:SetDieTime( 0.5 )
	fire:SetStartSize( 10 )
	fire:SetEndSize( 10 )
	fire:SetColor( 50, 0, 150, 255 )

	for i=1, 3 do

		local fire = pemit:Add( "sprites/flamelet"..tostring( math.random( 1, 5 ) ), pos + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) )
		fire:SetDieTime( 0.5 )
		fire:SetStartSize( 3 )
		fire:SetEndSize( 5 )
		fire:SetColor( 50, 0, 150, 255 )

	end

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end