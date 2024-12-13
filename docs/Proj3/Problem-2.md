2. Benchmarking. Now we are going to compare the performance of your three processor
designs in terms of execution time. Please generate a table for each of your final single-cycle,
software-scheduled pipeline, and hardware-schedule pipeline designs. The rows should
correspond to your synthetic benchmark (i.e., the one with all instructions), grendel (provided
with the testing framework), Bubblesort, and, for teams >4, Mergesort. The columns should
be # instructions (count using MARS), total cycles to execute (count using your Modelsim
simulations), CPI (using the previous two columns to calculate), maximum cycle time (from
your synthesis results), and total execution time (using the appropriate previous columns).
Note that the applications used to benchmark the single-cycle and hardware-scheduled
pipeline applications should be identical and thus the same number of instructions, while the
software-scheduled pipeline programs should be modified to work on the software-scheduled
processor and thus should have more instructions. Count software-inserted NOPS as
instructions. Make sure to include units and double-check that these results make sense from
your first principles!

Assembly File		# Instructions (MARS)	Total Cycles	CPI	Maximum Cycle Time	Total Execution Time (ns)
proj2_ci	sc	37	37	1	44.309	1639.433
	sw	44	48	1.090909091	21.935	1052.88
	hw	37	48	1.297297297	24.04	1153.92
bubblesort.s	sc	607	607	1	44.309	26895.563
	sw	2211	2352	1.063772049	21.935	51591.12
	hw	607	1245	2.05107084	24.04	29929.8
grendel.s	sc	2116	4373	2.066635161	44.309	193763.257
	sw	missing	1	#VALUE!	21.935	21.935
	hw	2138	1	0.0004677268475	24.04	24.04
mergesort.s	sc	missing	1	#VALUE!	44.309	44.309
	sw	61	1	0.01639344262	21.935	21.935
	hw	22	1	0.04545454545	24.04	24.04
	Count software-inserted NOPS as instructions.					
Gotten From:		MARS	Questasim	Auto-Calculated	Synthesis Timing	Auto-Calculated
