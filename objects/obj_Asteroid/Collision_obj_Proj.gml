/// Take Damage

Size -= other.Damage * (other.Type + 1) / 16;

var dir = point_direction(x, y, other.x, other.y);
HSP = -dcos(dir) * other.Spd / 16;
VSP = dsin(dir) * other.Spd / 16;

part_particles_create(global.PartSys, other.x, other.y, global.Part1, 1);
instance_destroy(other);