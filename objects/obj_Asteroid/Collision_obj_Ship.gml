/// Collision

Size -= max((abs(other.HSP) + abs(other.VSP)), other.MoveSpeed) / 24;

var dir = point_direction(x, y, other.x, other.y);
HSP = -dcos(dir) * max((abs(other.HSP) + abs(other.VSP)) / 6, other.MoveSpeed / 6);
VSP = dsin(dir) * max((abs(other.HSP) + abs(other.VSP)) / 6, other.MoveSpeed / 6);