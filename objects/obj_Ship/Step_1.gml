/// Shield Regen

regen = 480;

if (ShieldRegen > 0) { ShieldRegen -= 1; Shield = floor(Shield); }
else { if (Shield < MaxShield) Shield += ShieldRegenRate / 60; }
//else { if (Shield < MaxShield and global.DT mod ShieldRegenRate == 0) Shield += 1; }