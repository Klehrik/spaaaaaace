/// Step

image_xscale = Size;
image_yscale = Size;

if (HSP != 0) HSP -= sign(HSP) * 0.02;
if (VSP != 0) VSP -= sign(VSP) * 0.02;
if (abs(HSP) <= 0.02) HSP = 0;
if (abs(VSP) <= 0.02) VSP = 0;

x += HSP;
y += VSP;

if (Size <= 0.7)
{
	part_particles_create(global.PartSys, x, y, global.Part2, 1);
	instance_destroy();
}