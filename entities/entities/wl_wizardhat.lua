AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Warlock Hat"
ENT.Author = "Lumucro"
ENT.Information = "Woosh"
ENT.Category = "Warlocks"

ENT.Editable = false
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

	local bone
	local pos, ang

	self:SetModel( "models/props_junk/TrafficCone001a.mdl" )

	bone = self:GetOwner():LookupBone( "ValveBiped.Bip01_Head1" )
	pos, ang = self:GetOwner():GetBonePosition( bone )

	pos.z = pos.z + 15 
	self:SetPos( pos )
	self:SetAngles( ang )
	self:SetLocalAngles( Angle( 0, 0, 0 ) )

	self:SetParent( self:GetOwner() )
 
end