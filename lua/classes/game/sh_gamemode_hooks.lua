local gamemode = newClass("Gamemode");
gamemode.__eventFactoryQueue = {};
print("Possible alternative: build hook system into gamemode class :{");
function gamemode:addGamemodeEvent(name)
	assert(type(self.__eventFactoryQueue) == "table", "This function can only be called before an instance has been made");
	local funcName = "on" .. name;
	local eventName = name .. "Event";
	
	local eventStorage = "_" .. eventName;
	table.insert(self.__eventFactoryQueue, eventStorage);
	
	local eventGetter = "get" .. eventName;
	gamemode[eventGetter] = function(self)
		return self[eventStorage];
	end
	gamemode[funcName] = function(self, ...)
		local event = gamemode[eventGetter](self);
		event:fire(...);
	end
end

function gamemode:initEvents()
	for _, eventName in pairs(self.__eventFactoryQueue) do
		local eventStorage = eventName;
		self[eventStorage] = newInstance("Event");
	end
	self.__eventFactoryQueue = false;
end

local function redirectHook(hookName)
	gamemode:addGamemodeEvent(fixHookName(hookName));
end

--Some of the hooks, add more later on
if SERVER then
	redirectHook("AcceptInput");
	redirectHook("AllowPlayerPickup");
	redirectHook("CanExitVehicle");
	redirectHook("CanPlayerSuicide");
	redirectHook("CheckPassword");
	redirectHook("CreateEntityRagdoll");
	redirectHook("DoPlayerDeath");
	redirectHook("EntityTakeDamage");
	redirectHook("GetFallDamage");
	redirectHook("GetGameDescription");
	redirectHook("PlayerAuthed");
	redirectHook("PlayerCanHearPlayersVoice");
	redirectHook("PlayerCanPickupItem");
	redirectHook("PlayerCanPickupWeapon");
	redirectHook("PlayerCanSeePlayersChat");
	redirectHook("PlayerDeath");
	redirectHook("PlayerDeathSound");
	redirectHook("PlayerDeathThink");
	redirectHook("PlayerDisconnected");
	redirectHook("PlayerInitialSpawn");
	redirectHook("PlayerLeaveVehicle");
	redirectHook("PlayerSay");
	redirectHook("PlayerSelectSpawn");
	redirectHook("PlayerSilentDeath");
	redirectHook("PlayerSpawn");
	redirectHook("PlayerSpray");
	redirectHook("PlayerStartTaunt");
	redirectHook("PlayerSwitchFlashlight");
	redirectHook("PlayerUse");
	redirectHook("PostCleanupMap");
	redirectHook("PostPlayerDeath");
	redirectHook("ScaleNPCDamage");
	redirectHook("WeaponEquip");
else
	redirectHook("AddDeathNotice");
	redirectHook("CanPlayerEnterVehicle");
	redirectHook("CreateClientsideRagdoll");
	redirectHook("DrawOverlay");
	redirectHook("HUDAmmoPickedUp");
	redirectHook("HUDItemPickedUp");
	redirectHook("HUDPaint");
	redirectHook("HUDShouldDraw");
	redirectHook("HUDWeaponPickedUp");
end
redirectHook("EndEntityDriving");
redirectHook("EntityRemoved");
redirectHook("Initialize");
redirectHook("InitPostEntity");
redirectHook("PlayerConnect");
redirectHook("PlayerEnteredVehicle");
redirectHook("PlayerHurt");
redirectHook("PlayerNoClip");
redirectHook("PlayerShouldTakeDamage");
redirectHook("PropBreak");
redirectHook("ScalePlayerDamage");
redirectHook("ShouldCollide");
redirectHook("ShutDown");
redirectHook("Think");
redirectHook("Tick");