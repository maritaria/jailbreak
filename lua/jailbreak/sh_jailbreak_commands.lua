local commands = {};
concommand.Add("jb", function(ply, com, args)
	local subCommand = args[1];
	table.remove(args, 1);
	commands[subCommand](args);
end);

function commands.teams(ply, args)
	for _, ply in pairs(player.GetAll()) do
		print(ply, ply:Alive() and "alive" or "dead", ply:getTeam():getName());
	end
end

function commands.reload(ply, args)
	print("Reloading jailbreak...");
	GAMEMODE:getGamemode():reload();
end