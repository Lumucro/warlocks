function EFFECT:Init( data )

	local pos = data:GetOrigin() 
	local pemit = ParticleEmitter( pos )

	local smoke = pemit:Add( "particles/smokey", pos + Vector( 0, 0, 20 ) )
	smoke:SetDieTime( 1 )
	smoke:SetStartSize( 30 )
	smoke:SetEndSize( 35 )
	smoke:SetColor( 120, 70, 180, 120 )
	smoke:SetGravity( Vector( 0, 0, 100 ) )

	for i=1, 25 do
		
		local smoke = pemit:Add( "particles/smokey", pos + Vector( math.random(-50, 50), math.random(-50, 50), 50 ) )
		smoke:SetDieTime( 1 )
		smoke:SetStartSize( 15 )
		smoke:SetEndSize( 20 )
		smoke:SetColor( 100, 60, 165, 220 )
		smoke:SetGravity( Vector( 0, 0, -150 ) )

	end

end

function EFFECT:Think( )

	return false
		
end


function EFFECT:Render()

end