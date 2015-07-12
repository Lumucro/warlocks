AddCSLuaFile()

if CLIENT then

   SWEP.PrintName = "Warlock Powers"
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

function SWEP:DrawWorldModel()

end

function SWEP:Initialize()

	self:SetWeaponHoldType( self.HoldType )

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

	local effectdata = EffectData()
	effectdata:SetEntity( self )
	effectdata:SetOrigin( self.Owner:GetShootPos() + (self.Owner:GetRight() * 6) + (self.Owner:GetForward() * 30) + (self.Owner:GetUp() * -5) )
	util.Effect( "warlock_shootfire", effectdata )

end

function SWEP:SecondaryAttack()

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

	end
	
	self:EmitSound( self.Secondary.FireSound, 75, 100, 0.5 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

	local effectdata = EffectData()
	effectdata:SetEntity( self )
	effectdata:SetOrigin( self.Owner:GetShootPos() + (self.Owner:GetRight() * 6) + (self.Owner:GetForward() * 30) + (self.Owner:GetUp() * -5) )
	util.Effect( "warlock_shootpulse", effectdata )

end