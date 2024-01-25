/// Collision

if (Appear <= -9)
{
	var dir = point_direction(x, y, other.x, other.y);
	HSP = -dcos(dir) * max((abs(HSP) + abs(VSP)) / 1.5, MoveSpeed / 4);
	VSP = dsin(dir) * max((abs(HSP) + abs(VSP)) / 1.5, MoveSpeed / 4);

	if (Shield > 0) Shield = clamp(Shield - 1, 0, MaxShield);
	else Hull -= 1;

	ShieldRegen = regen;

	part_particles_create(global.PartSys, x, y, global.Part1, 1);
}