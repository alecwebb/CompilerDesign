Alec Webb
CS540

Chose to complete project 1 using the C Language.

To compile the project:
	- Use the make file included. //unmodified from Professor White's implementation

For my own testing purposes I included:
	- driver.c 		//runs one.c two.c three.c and mult.c
	- batchconvert.sh	//generates one.c two.c three.c mult.c by piping the xml transformation
	- batchdelete.sh	//deletes one.c two.c three.c mult.c and driver
	- compiler_driver.sh	//generates the driver executable

	to use these:
		1.) sh batchconvert.sh
		2.) sh compile_driver.sh
		3.) ./driver
		4.) sh batchdelete.sh  // to clean up