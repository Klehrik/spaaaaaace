/// Take Damage

if (Appear <= -9 and other.Team != Team)
{
	if (other.SB == 1)
	{
		if (Shield > 0) Shield = clamp(Shield - MaxShield * 0.4, 0, MaxShield);
		else Hull -= 1;
	}
	else
	{
		if (Shield > 0) Shield = clamp(Shield - other.Damage, 0, MaxShield);
		else Hull -= other.Damage;
	}
	
	ShieldRegen = regen;
	
	part_particles_create(global.PartSys, other.x, other.y, global.Part1, 1);
	instance_destroy(other);
}