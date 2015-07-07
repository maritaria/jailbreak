function math.isNan(value)
	return value != value;
end

function math.isInf(value)
	return value == math.huge;
end