local extension = newClass("SettingExtension");

function extension:ctor()
	getDefinition("Base").ctor(self);
end