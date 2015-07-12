AddCSLuaFile()

if CLIENT then

   SWEP.PrintName = "Warlock Powers Experimental"
   SWEP.Slot = 1

   SWEP.ViewModelFlip = false
   SWEP.ViewModelFOV = 60

end

SWEP.HoldType = "magic"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.Primary.Ammo = "none"
SWEP.Primary.FireSound = "ambient/fire/ignite.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultCli = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.25
SWEP.Primary.Ammo = "none"
SWEP.Primary.Cone = 0.005
SWEP.Secondary.FireSound = "weapons/physcannon/energy_disintegrate5.wav"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.5

SWEP.AutoSpawnable = false
SWEP.NoSights = true
SWEP.Charging = false
SWEP.Charged = 0
SWEP.PulsePreview = nil

function SWEP:DrawWorldModel()

end

function SWEP:Initialize()

	self:SetWeaponHoldType( self.HoldType )

end

function SWEP:Think()

	if self.Owner:KeyDown( IN_ATTACK2 ) then
		
		self.Charging = true
		self.Charged = self.Charged + CurTime()

		if SERVER then

			if self.PulseReview == nil then
				
				self.PulseReview = ents.Create( "prop_physics" )
				self.PulseReview:SetModel( "models/hunter/misc/shell2x2a.mdl" )
				self.PulseReview:SetMaterial( "Models/effects/comball_sphere" )
				self.PulseReview:PhysicsInit( 1 )
				self.PulseReview:SetCollisionGroup( 0 )
				self.PulseReview:SetModelScale( 0.4 )

				local phys = self.PulseReview:GetPhysicsObject()

				if IsValid( phys ) then
					phys:Wake()
				end

				phys:EnableGravity( false )
				phys:EnableDrag( false )

				self.PulseReview:SetOwner( self.Owner )

				local magicangle = self.Owner:GetAngles()
				magicangle.x = magicangle.x + 90

				local magicpos = self.Owner:GetShootPos()

				self.PulseReview:SetAngles( magicangle )
				self.PulseReview:SetPos( magicpos )

				self.PulseReview:SetParent( self ) 

			end

		end

	elseif self.Charging then

		if SERVER then

			local magicpush = ents.Create( "wl_magic_push" )
			magicpush:SetOwner( self.Owner )
			magicpush:SetPos( self.Owner:GetPos() )

			local magicangle = self.Owner:EyeAngles()
			magicangle.x = magicangle.x + 90

			local magicpos = self.Owner:EyePos()
			magicpos = magicpos + ( self.Owner:GetForward() * 100 )

			magicpush:SetAngles( magicangle )
			magicpush:SetPos( magicpos )
			magicpush:Spawn()

			self.Owner:SetVelocity( self.Owner:GetForward() * -500 )

			self.PulseReview:Remove()
			self.PulseReview = nil

		end
		
		self:EmitSound( self.Secondary.FireSound, 75, 100, 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

		self.Charging = false
		self.Charged = 0

	end

end

function SWEP:PrimaryAttack()

	if SERVER then

		local magicpush = ents.Create( "wl_magic_melonshot" )
		magicpush:SetOwner( self.Owner )
		magicpush:SetPos( self.Owner:GetPos() )

		local magicangle = self.Owner:EyeAngles()
		magicangle.x = magicangle.x + 90

		local magicpos = self.Owner:EyePos()
		magicpos = magicpos + ( self.Owner:GetForward() * 100 )

		magicpush:SetAngles( magicangle )
		magicpush:SetPos( magicpos )
		magicpush:Spawn()

		self.Owner:SetVelocity( self.Owner:GetForward() * -10 )

	end

	self:EmitSound( self.Primary.FireSound, 75, 100, 0.5 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

end

function SWEP:SecondaryAttack()


end