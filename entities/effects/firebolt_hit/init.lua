function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	local smoke = pemit:Add( "particles/smokey", pos )
	smoke:SetDieTime( 1 )
	smoke:SetStartSize( 8 )
	smoke:SetEndSize( 10 )
	smoke:SetColor( 220, 120, 120, 200 )

	local smokeup = pemit:Add( "particles/smokey", pos )
	smokeup:SetDieTime( 1 )
	smokeup:SetStartSize( 5 )
	smokeup:SetEndSize( 8 )
	smokeup:SetColor( 200, 120, 120, 200 )
	smokeup:SetGravity( Vector( 0, 0, 100 ) )

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end