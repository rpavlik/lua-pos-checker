gradeLookup = {
	["A"] = 4,
	["A-"] = 3.67,
	["B+"] = 3.33,
	["B"] = 3,
	["B-"] = 2.67,
	["C+"] = 2.33,
	["C"] = 2,
	["C-"] = 1.67,
	["D+"] = 1.33,
	["D"] = 1,
	["D-"] = 0.67,
	["F"] = 0
}

function isResearchCredit(entry)
	return entry.num == 699
end
