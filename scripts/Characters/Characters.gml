/// Characters

function char_name()
{
	var names = ["Carl", "Matthew", "Marcus", "Eric", "Mark", "Jeff", "Jones",
				"Jasper", "Chris", "Lee", "Ross", "Albert", "Travis", "Harold",
				"Henry", "Hank", "Rufus", "Scott", "Dominic", "Nathan", "John",
				"Hugh", "Robin", "Michael", "Noah", "Curtis", "Thomas", "Andy",
				"Robert", "Will", "Neil", "Joseph", "Caesar", "Jake", "Bobert"];
	return names[irandom_range(0, array_length(names) - 1)];
}