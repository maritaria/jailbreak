local readonlySetting = newClass("ReadonlySetting", "Setting");

function readonlySetting:canCommit()
	return false;
end