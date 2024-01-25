/// Collision

var dir = point_direction(x, y, other.x, other.y);
HSP = -dcos(dir) * (HSP + VSP);
VSP = dsin(dir) * (HSP + VSP);