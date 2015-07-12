AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Warlock Melonshot"
ENT.Author = "Lumucro"
ENT.Information = "Pow"
ENT.Category = "Warlocks"

ENT.Editable = false
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.enemynear = false

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/props_junk/watermelon01.mdl" )
		self.DeathTime = CurTime() + 25

		timer.Simple( 30, function() 
			if IsValid( self ) then self:Remove() end
		end	)

		local trace = util.TraceLine( {
			start = self:GetPos(),
			endpos = self:GetPos() + Vector( 0, 0, -100 ),
			filter = function( ent ) if ent:GetClass() == "wl_magic_melonmine" then return false end return true end
		} )

		if trace.Hit then
			self:SetPos( trace.HitPos )
		else
			self:Remove()
		end

	end

end

function ENT:Think()

	if SERVER then

		if !self.enemynear then
			local ents = ents.FindInSphere( self:GetPos(), 50 ) 
			for k,v in pairs( ents ) do
				if v:IsPlayer() and v:Alive() then
					self:Explode()
					self:Remove()
				end
			end
		end
		if self:WaterLevel() > 0 then self:Explode() end

	end

end

function ENT:Explode( hitpos, hitnormal )

	if SERVER then

		if self.Died then return end

		self.Died = true
		self.PhysicsData = nil

		self:NextThink( CurTime() )

		hitpos = hitpos or self:GetPos()
		hitnormal = hitnormal or Vector(0, 0, 1)

		for k,v in pairs( ents.FindInSphere( hitpos, 150 ) ) do
			if v:IsPlayer() and v:Alive() then
				v:SetVelocity( 1200 * (v:LocalToWorld(v:OBBCenter()) - hitpos):GetNormalized() )
				v.lastattacker = self:GetOwner()
			end
		end

		util.ScreenShake( hitpos, 500, 0.5, 1, 300 )

	end

	local effectdata = EffectData()
	effectdata:SetOrigin( hitpos )
	util.Effect( "fireball_hit", effectdata )

	self:EmitSound( "ambient/fire/ignite.wav", 75, 100, 0.5 )

end