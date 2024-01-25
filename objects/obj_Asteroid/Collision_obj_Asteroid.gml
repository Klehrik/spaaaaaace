/// Collision

Size -= 0.05;

var dir = point_direction(x, y, other.x, other.y);
HSP = -dcos(dir) * (abs(HSP) + abs(VSP));
VSP = dsin(dir) * (abs(HSP) + abs(VSP));