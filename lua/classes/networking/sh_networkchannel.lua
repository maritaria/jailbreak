local channel = newClass("NetworkChannel");

function channel:ctor(channelName)
	assertArgument(2, "string");
	self._channelName = channelName;
	self._transmissionReceivedEvent = newInstance("Event");
	channelhub.add(self);
end

function channel:getChannelName()
	return self._channelName;
end

function channel:getTransmissionReceivedEvent()
	return self._transmissionReceivedEvent;
end

function channel:transmit(data, players)
	self:writePacket(data);
	self:sendData(players);
end

function channel:writePacket(data)
	net.Start(channelhub.NETWORK_STRING);
	local packet = {
		channel = self:getChannelName(),
		data = data
	};
	local message = channelhub.encode(packet);
	local length = #message;
	net.WriteUInt(length, 32);
	net.WriteData(message, length);
end

function channel:sendData(players)
	if SERVER then
		assertArgument(2, "Player", "table", "nil");
		if (type(players) == "Player") then
			players = { players };
		else
			players = players or player.GetAll();
		end
		net.Send(players);
	else
		net.SendToServer();
	end
end

function channel:receive(data, ply)
	self:getTransmissionReceivedEvent():fire(self, data, ply);
end