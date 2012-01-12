require "std"
require "list"

local isPositiveInteger = function(v) return type(v) == "number" and math.floor(v) == v and v > 0 end
local isNonEmptyString = function(v) return type(v) == "string" and #v > 0 end
local validations = {
	["dept must be a non-empty string"] =
		function(e) return isNonEmptyString(e.dept) end;
	["num must be a positive integer"] =
		function(e) return isPositiveInteger(e.num) end;
	["suffix must be nil or a non-empty string"] =
		function(e) return e.suffix == nil or isNonEmptyString(e.suffix) end;
		
	["credits must be a positive integer"] =
		function(e) return isPositiveInteger(e.credits) end;
--[[	"semester", "year"]]

}

local validate = function(poslist)
	local fail = false
	for _, e in ipairs(poslist) do
		for errmsg, test in pairs(validations) do
			if not test(e) then
				print("\nError when validating entry", e)
				print(errmsg)
				fail = true
			end
		end
	end
	if fail then
		error("One or more validation errors in POS entries")
	end
end

local splitCourseNum = function(t)
	if t.coursenum ~= nil and t.dept == nil and t.num == nil then
		_, _, dept, num, suffix = t.coursenum:find("^(%a+)[^%a%d]*(%d+)[^%a%d]*(%a*)")
		t.dept = dept
		t.num = tonumber(num)
		if #suffix > 0 then
			t.suffix = suffix
		end
	end
end

local entryconstructor = function(t)
	splitCourseNum(t)
	return t
end

POS = function(input)
	local poslist = list.new(input)
	validate(poslist)
	return poslist
end

entry = function(coursenumOrT)
	if type(coursenumOrT) == "table" then
		return entryconstructor(coursenumOrT)
	elseif type(coursenumOrT) == "string" then
		return function(t)
			t.coursenum = coursenumOrT
			return entryconstructor(t)
		end
	else
		error("Invalid 'entry'!", 2)
	end
end		

