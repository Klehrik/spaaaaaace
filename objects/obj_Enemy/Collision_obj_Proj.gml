/// Take Damage

if (other.image_blend != c_red)
{
	if (Shield > 0) Shield = clamp(Shield - other.Damage, 0, MaxShield);
	else Hull -= other.Damage;
	
	var e = instance_create_depth(other.x, other.y, 0, obj_Effect);
	instance_destroy(other);
}