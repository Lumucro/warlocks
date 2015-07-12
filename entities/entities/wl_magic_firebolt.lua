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

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/Gibs/wood_gib01e.mdl" )

		self:PhysicsInit( 1 )
		self:SetCollisionGroup( 0 )

		self.DeathTime = CurTime() + 3

		local phys = self:GetPhysicsObject()

		if IsValid( phys ) then
			phys:Wake()
		end

		self.phys = phys

		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:SetVelocity( self:GetForward() * 1500 )

		self:SetColor( 255, 0, 0, 255 )
		self:Ignite( 10, 1 )

		timer.Simple( 10, function() 
			if IsValid( self ) then self:Remove() end
		end	)

	end

end

function ENT:Think()

	if SERVER then

		if self.Died || self.DeathTime <= CurTime() then

			self:Remove()

		elseif self.PhysicsData then

			self:Explode( self.PhysicsData.HitPos, self.PhysicsData.HitNormal )
			self:Remove()

		elseif self.HitEnemy then

			if IsValid( self.HitEnemy ) then self.HitEnemy = nil end

			self:Explode()
			self:Remove()

		end

		if self:WaterLevel() > 0 then self:Explode() end

	end

end

function ENT:StartTouch( ent )

	if SERVER then

		if ent:IsPlayer() && ent:Alive() then
			self.HitEnemy = ent
		end

	end

end

function ENT:PhysicsCollide( data, phys )

	if SERVER then
		
		self.PhysicsData = data
		self:NextThink( CurTime() )

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

		for k,v in pairs( ents.FindInSphere( hitpos, 100 ) ) do
			if v:IsPlayer() and v:Alive() then
				v:SetVelocity( 250 * (v:LocalToWorld(v:OBBCenter()) - hitpos):GetNormalized() )
				v.lastattacker = self:GetOwner()
			end
		end

		util.ScreenShake( hitpos, 200, 0.5, 1, 300 )

	end

	local effectdata = EffectData()
	effectdata:SetOrigin( hitpos )
	util.Effect( "firebolt_hit", effectdata )

	self:EmitSound( "ambient/fire/ignite.wav", 75, 100, 0.5 )

end