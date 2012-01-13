require "edu.iastate.Common"

return {
	section [[E.3. REQUIREMENTS FOR A CO-MAJOR AT THE PH.D. LEVEL]]
	{
		section [[E.3.1. Course, Research, and Credit Requirements]]
		{
			section [[a. Core courses (6 credits): 511, 531; both with a grade of “B” or higher.]]
			{
				requirement("One entry for 511", function(pos) return #(pos:filter(isDeptAndNum("COMS", 511))) == 1 end),
				requirement("B or higher for 511",
					function(pos)
						local courselist = pos:filter(isDeptAndNum("COMS", 511))
						if #courselist ~= 1 then return nil end
						if courselist[1].grade == nil then return nil end
						return gradeLookup[courselist[1].grade] >= gradeLookup["B"]
					end),
				requirement("One entry for 531",
					function(pos) return #(pos:filter(isDeptAndNum("COMS", 531))) == 1 end);
				requirement("B or higher for 531",
					function(pos)
						local courselist = pos:filter(isDeptAndNum("COMS", 531))
						if #courselist ~= 1 then return nil end
						if courselist[1].grade == nil then return nil end
						return gradeLookup[courselist[1].grade] >= gradeLookup["B"]
					end);
			},
			
			section [[b. Elective courses]]
			{
				section [[Minimum of 21 credits.]]
				{
				},
				section [[This must include one (1) Computer Science graduate course from each of four (4) distinct areas listed in the Ph.D. breadth requirements.]]
				{
				},
			},
			section [[c. At least three (3) credits of Com S 610.]]
			{
			},
			section [[Subject to the following restrictions:]]
			{
				section [[At least 36 credits, including dissertation research credits, must be earned under the supervision of the POS committee.]]
   				{
   				},
   				section [[The course credits (excluding Com S 590, 610, 690, 699) must add up to at least 36 credits.]]
   				{
   				},
   				section [[The POS must include at least 6 credits of COM S 600-level courses (excluding 699 and including, at most, three (3) credits of 610)]]
   				{
   				},
   				section [[A maximum of 6 credits of Com S 590, 610 and 690 can appear on the POS.]]
   				{
   				}
   			},
   		},
   		section [[E.3.2. Grade requirements for the Ph.D.]]
   		{
   			section [[No more than two C's (C, C+) and no grade below a C on the POS.]]
   			{
   			
   			}
   		}
   	}
}

