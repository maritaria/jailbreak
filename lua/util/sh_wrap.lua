function wrap(func, tbl)
	return function(...) return func(tbl, ...) end;
end