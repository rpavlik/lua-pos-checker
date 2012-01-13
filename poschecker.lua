#!/usr/bin/env lua

if #arg == 0 then
	print("ERROR: Must pass a filename containing POS data to check.")
	os.exit(1)
end

require "std"

require "posPredicates"
require "requirementsDsl"
require "posDsl"

local indent = "  "

local tryRequirement = function(pos, requirement, id)
	requirement.id = id
	local result = requirement.predicate(pos)
	if result == true then
		print(id, requirement.comment, "passed")
		table.insert(pos.requirements.passed, requirement)
	elseif result == false then
		print(id, requirement.comment, "FAILED")
		table.insert(pos.requirements.failed, requirement)
	else
		print(id, requirement.comment, "UNKNOWN")
		table.insert(pos.requirements.unknown, requirement)
	end
end

local recursiveRequirements

recursiveRequirements = function(pos, t, level, id)
	local display = function(...)
		print(indent:rep(level), ...)
	end

	display(t.text)
	for i, v in ipairs(t) do
		if v.isRequirement then
			tryRequirement(pos, v, id .. "." .. tostring(i))
		else
			recursiveRequirements(pos, v, level + 1, id .. "." .. tostring(i))
		end
	end
end

local checkRequirements = function(pos, reqs)
	local reqtable = {}
	for _, reqname in ipairs(reqs) do
		local req = require(reqname)
		req.text = "Requirement Module: " .. reqname
		req.name = reqname
		table.insert(reqtable, req)
	end

	pos.requirements = {
		passed = {},
		failed = {},
		unknown = {}
	}
	for _, reqmod in ipairs(reqtable) do
		recursiveRequirements(pos, reqmod, 0, reqmod.name)
	end
	return pos
end

posmethods = {
	["POS"] = function(t) getmetatable(POS(t)).__index["checkRequirements"]=checkRequirements return t end,
	["entry"] = entry
}

theposfile = loadfile(arg[1])
setfenv(theposfile, posmethods)

output = theposfile()
print()
print("ALL DONE:")
print("Passed:", #(output.requirements.passed))
print("Failed:", #(output.requirements.failed))
print("Unknown:", #(output.requirements.unknown))
