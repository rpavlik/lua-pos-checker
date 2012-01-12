module(..., package.seeall)

function test_okpos()
	require "posDsl"
	assert_table(
		POS{
			entry "COMS 511" {
				credits = 3,
				grade = "A",
				semester = "Fall 2011"
			}
		}
	, "Should get a table containing a POS"
	)
end

function test_creditsbad()
	require "posDsl"
	assert_error(function()
		POS{
			entry "COMS 511" {
				grade = "A",
				semester = "Fall 2011"
			}
		}
	end
	, "Should reject when credits missing"
	)
	assert_error(function()
		POS{
			entry "COMS 511" {
				grade = "A",
				credits = "a",
				semester = "Fall 2011"
			}
		}
	end
	, "Should reject when credits are a string"
	)
	assert_error(function()
		POS{
			entry "COMS 511" {
				grade = "A",
				credits = -1,
				semester = "Fall 2011"
			}
		}
	end
	, "Should reject when credits are -1"
	)
	assert_error(function()
		POS{
			entry "COMS 511" {
				grade = "A",
				credits = 2.5,
				semester = "Fall 2011"
			}
		}
	end
	, "Should reject when credits are noninteger"
	)
end
