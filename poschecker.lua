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

local tryRequirement = function(pos, requirement)
	local result = requirement.predicate(pos)
	if result == true then
		print(requirement.comment, "passed")
		table.insert(pos.requirements.passed, requirement)
	elseif result == false then
		print(requirement.comment, "FAILED")
		table.insert(pos.requirements.failed, requirement)
	else
		print(requirement.comment, "UNKNOWN")
		table.insert(pos.requirements.other, requirement)
	end
end

local recursiveRequirements

recursiveRequirements = function(pos, t, level)
	local display = function(...)
		print(indent:rep(level), ...)
	end

	display(t.text)
	for _, v in ipairs(t) do
		if v.isRequirement then
			tryRequirement(pos, v)
		else
			recursiveRequirements(pos, v, level + 1)
		end
	end
end

local checkRequirements = function(pos, reqs)
	local reqtable = {}
	for _, reqname in ipairs(reqs) do
		local req = require(reqname)
		req.text = "Requirement Module: " .. reqname
		table.insert(reqtable, req)
	end

	pos.requirements = {
		passed = {},
		failed = {},
		other = {}
	}
	recursiveRequirements(pos, reqtable, 0)
	return pos
end

posmethods = {
	["POS"] = function(t) return setmetatable(POS(t), {__index={["checkRequirements"]=checkRequirements}}) end,
	["entry"] = entry
}

theposfile = loadfile(arg[1])
setfenv(theposfile, posmethods)

output = theposfile()

print("ALL DONE")
print(output)
