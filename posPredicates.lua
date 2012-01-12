
-- Returns a predicate that checks whether a course matches department and number
function isDeptAndNum(dept, num)
	return function(entry)
		return (entry.department == department) and (entry.num == num)
	end
end
