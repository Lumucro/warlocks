GM.Name = "Warlocks"
GM.Author = "Lumucro"
GM.Email = ""
GM.Website = ""

ROUND_WAITING = 1
ROUND_READY = 2
ROUND_INPROGRESS = 3
ROUND_OVER = 4

team.SetUp( 1, "Warlock", Color( 125, 125, 125, 255 ) )
team.SetUp( 2, "Spectator", Color( 125, 125, 125, 255 ) )

PrecacheParticleSystem( "ThumperDust" )
PrecacheParticleSystem( "cball_explode" )
PrecacheParticleSystem( "StunstickImpact" )
PrecacheParticleSystem( "fireball_hit" )
PrecacheParticleSystem( "warlock_walkember" )

function GM:PlayerFootstep( ply, pos, foot, sound, volume, filter ) 

	local effectdata = EffectData()
	effectdata:SetOrigin( pos )
	util.Effect( "warlock_walkember", effectdata )

	return false

end