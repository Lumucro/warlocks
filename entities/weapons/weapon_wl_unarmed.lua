AddCSLuaFile()

if CLIENT then

   SWEP.PrintName = "Warlock Powers"
   SWEP.Slot = 1

   SWEP.ViewModelFlip = false
   SWEP.ViewModelFOV = 60

end

SWEP.HoldType = "normal"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultCli = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.25
SWEP.Primary.Ammo = "none"
SWEP.Primary.Cone = 0.005
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
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

end

function SWEP:SecondaryAttack()

end