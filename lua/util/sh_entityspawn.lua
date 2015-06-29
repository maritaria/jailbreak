local allowed = false;

function isEntitySpawnAllowed()
	return allowed;
end

hook.Add("PostEntityInit", "assertPostEntityInit", function()
	allowed = true;
end);