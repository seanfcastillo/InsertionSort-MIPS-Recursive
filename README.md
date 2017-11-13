# InsertionSort-MIPS-Recursive
Three insertion sort subroutines written in MIPS assembly: iterative, recursive, and limited-register.

Insertion Sort
--------------
Iterative insertion sort: basic sorting algorithm.
Recursive insertion sort: sorting algorithm using recursion.
Limited-register sort: sort using registers $a0, $sp, $t0, $s0, and $ra only.


To test each subroutine, go to the main routine and uncomment one subroutine call, and leave the others commented.
Example:

	jal insertionSort

	#jal insertionRecurs

	sw $t0, 16($sp)
	#jal insertionRecursHard
  
  Will run the iterative insertion sort. Uncomment one of the others to try them.
