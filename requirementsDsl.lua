require "std"

function section(text)
	return function(contents)
		contents.text = text
		return contents
	end
end

function requirement(comment, pred)
	return {
		["isRequirement"] = true,
		["predicate"] = pred,
		["comment"] = comment
	}
end

