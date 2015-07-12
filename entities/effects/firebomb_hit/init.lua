function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	local smoke = pemit:Add( "particles/smokey", pos + Vector( 0, 0, 20 ) )
	smoke:SetDieTime( 2 )
	smoke:SetStartSize( 20 )
	smoke:SetEndSize( 20 )
	smoke:SetColor( 70, 70, 180, 220 )

	for i=1, 2 do
		
		local smoke = pemit:Add( "particles/smokey", pos + Vector( 0, 0, 20 ) )
		smoke:SetDieTime( 1 )
		smoke:SetStartSize( 10 )
		smoke:SetEndSize( 14 )
		smoke:SetColor( 120, 120, 200, 220 )
		smoke:SetGravity( Vector( 0, 0, 60 ) )

	end

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end