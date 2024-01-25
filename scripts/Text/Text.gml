/// Text

function ally_blue_text(type)
{
	if (type == 0) // Seeing the player for the first time
	{
		var text = [
		"Hey!\nStick with us, will you?",
		"It's not safe to travel alone.\nCome with us.",
		"Oi, friend!\nCome join us!",
		"Oi, mate! Follow us, will ya?",
		"Hey you! Come with us!\nWe could use some more ships.",
		"This sector is pretty dangerous.\nYou better stick with us."
		];
		return text[irandom_range(0, array_length(text) - 1)];
	}
	
	else if (type >= 1) // Seeing the player again
	{
		var text = [
		"Hey, it's you!\nGlad to have you back.",
		"Oi, mate!\nKeep up, will ya?",
		"Oi, friend!\nYou shouldn't wander off alone!",
		"Keep up, will you?\nYou don't want to get left behind."
		];
		return text[irandom_range(0, array_length(text) - 1)];
	}
}

function enemy_red_text(type)
{
	if (type == 0) // Seeing the player for the first time
	{
		var text = [
		"Ship of the Galactic Fleet!\nPrepare to die!",
		"Disappear, scum!",
		"No ship of the Fleet will escape us!",
		"You picked the wrong side, fool!\nDeath awaits you!",
		"Any ship with the symbol of the Fleet\nis an enemy of mine!",
		"Cur! Prepare to meet your end!"
		];
		return text[irandom_range(0, array_length(text) - 1)];
	}
	
	else if (type >= 1) // Seeing the player again
	{
		var text = [
		"We meet again!\nYou won't escape this time!",
		"There you are!\nDie!",
		"Found you!\nTake this!",
		"You can't run from us!\nTake this!",
		"You can't hide from us!\nDie!",
		"Got nowhere to run, do you?"
		];
		return text[irandom_range(0, array_length(text) - 1)];
	}
}