require "std"

function section(text)
	return function(contents)
		contents.text = text
		return contents
	end
end

function requirement(comment)
	return function(pred)
		return {
			["predicate"] = pred,
			["comment"] = comment
		}
	end
end

