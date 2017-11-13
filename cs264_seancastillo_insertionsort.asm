# sean castillo, cs264, 11/11/17


# pseudocode used:

# ITERATIVE
#for i = 1 to n - 1
#	j = i
#	while j > 0 and A[j] < A[j - 1]
#		swap(A[j],A[j-1])
#		j = j - 1

# RECURSIVE
#void insertionSort(int a[], unsigned int length)
#{
#	if (length>1) {
#		insertionSort(a, length-1);
#		int key = a[length-1];
#		int i=length-2;
#		while (i>=0 && a[i] > key) {
#			a[i+1] = a[i];
#			i--;
#		}
#		a[i+1] = key;
#	}
#}

.data
commaspace: .asciiz ", "

.text

main:

	# allocate new spot for array in memory
	#syscall: sbrk
	addi $a0, $0, 40			# allocate n*4 = 40 bytes (n=10)  (CHANGE THIS IF YOU CHANGE SIZE OF ARRAY)
	addi $v0, $0, 9
	syscall						# syscall to allocate
	addi $s0, $v0, 0			# $s0 = new empty memory

	# manually initialize dynamic array {2,5,-2,11,6,12,10,4,-9,1}
	# (THESE ARE 10 VALUES BUT YOU CAN ADD AS MANY AS YOU WANT)
	addi $t0, $0, 2
	sw $t0, 0($s0)
	addi $t0, $0, 5
	sw $t0, 4($s0)
	addi $t0, $0, -2
	sw $t0, 8($s0)
	addi $t0, $0, 11
	sw $t0, 12($s0)
	addi $t0, $0, 6
	sw $t0, 16($s0)
	addi $t0, $0, 12
	sw $t0, 20($s0)
	addi $t0, $0, 10
	sw $t0, 24($s0)
	addi $t0, $0, 4
	sw $t0, 28($s0)
	addi $t0, $0, -9
	sw $t0, 32($s0)
	addi $t0, $0, 1
	sw $t0, 36($s0)
							# s0 = array
	addi $a0, $s0, 0 		# a0 = array
	addi $s4, $s0, 0        # (some of these lines are redundant and not used)
	addi $s1, $0, 10		# s1 = n = 10 (CHANGE THIS NUMBER IF YOU USE A DIFF SIZE ARRAY)
	addi $t0, $s1, 0
	addi $a1, $s1, 0 		# a1 = size n

	addi $sp, $sp, -32
	



#*************************************************************************
####################################################################################################
##																			#
## THESE ARE THE SUBROUTINES, UNCOMMENT ONE AT A TIME TO TEST THEM        	#
##																			#
###########################################################################
###########################################################################


	jal insertionSort

	#jal insertionRecurs

	sw $t0, 16($sp)
	#jal insertionRecursHard
	

#########################################################################################
#######################################################################################



	addi $sp, $sp, 32
	addi $t0, $0, 0     	# t0 = i 
LOOP3:

	# syscall: print int
	ori $v0, $0, 1			
	mul $a0, $t0, 4		
	add $a0, $a0, $s4
	lw $a0, 0($a0)	
	syscall

	# syscall: print string
	ori $v0, $0, 4	
	lui $a0, 0x1001				
	syscall

	addi $t0, $t0, 1   # i++

	slt $t7, $t0, $a1
	bne $t7, $0, LOOP3

	addi $v0, $0, 10
	syscall
	


#subroutines
########################################################
insertionSort:
	addi $sp, $sp -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	addi $t0, $0, 1 		# $t0 = i = 1
	addi $t1, $a1, -1 		# $t1 = n - 1

LOOP:
	add $t2, $t0, $0 		# $t2 = j = i

	LOOP2:
		mul $t6, $t2, 4     # [j]
		add $t6, $t6, $a0   # A[j]
		lw $t3, 0($t6)     	# t3 = A[j]

		addi $t6, $t2, -1   # j - 1
		mul $t6, $t6, 4     # [j-1]
		add $t6, $t6, $a0   # A[j-1]
		lw $t4, 0($t6)      # t4 = A[j-1]

		slt $t6, $t3, $t4   #  if(t3 < t4) t6 = 1
		beq $t6, $0, SKIP

		add $t6, $t4, $0
		add $t4, $t3, $0
		add $t3, $t6, $0    # swap (A[j], A[j-1])

		# now the registers are swapped, store each one back in memory in the right spot
		mul $t6, $t2, 4     # [j]
		add $t6, $t6, $a0   # A[j]
		sw $t3, 0($t6)     	# t3 = A[j]

		addi $t6, $t2, -1   # j - 1
		mul $t6, $t6, 4     # [j-1]
		add $t6, $t6, $a0   # A[j-1]
		sw $t4, 0($t6)      # t4 = A[j-1]

		addi $t2, $t2, -1 	# j--

		slti $t7, $t2, 1    #  if( j == 0) t7 = 1
		bne $t7, $0, SKIP

		j LOOP2
SKIP:



	addi $t0, $t0, 1 		# i++
	slt $t7, $t0, $a1       # while (i < n), LOOP
	bne $t7, $0, LOOP

exitRestore:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra

###################################################################
insertionRecurs:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	sw $a0, 12($sp)
	sw $a1, 16($sp)

	slti $t0, $a1, 2 		#if (n > 1), t0 = 0;
	bne $t0, $0, exitRestore2

	addi $s0, $a0, 0  		# s0 = array
	addi $s1, $a1, 0 		# s1 = n

	addi $a1, $a1, -1    	# a1 = n - 1
	jal insertionRecurs

	sll $t0, $a1, 2 		# [n-1]
	add $t0, $s0, $t0      	# arr[n-1]
	lw $s2, 0($t0)  		# s2 = key = arr[n-1]
	addi $t1, $s1, -2 		# t1 = i = n - 2

LOOPR:
	slti $t0, $t1, 0        # while (i >= 0)
	bne $t0, $0, skipR

	sll $t0, $t1, 2 		# [i] 
	add $t0, $t0, $s0  		# arr[i]
	lw $s3, 0($t0) 			# s3 = arr[i]

	slt $t0, $s2, $s3 		# if (key < arr[i]) $t0 = 1 and stay
	beq $t0, $0, skipR

	add $t0, $t1, 1
	sll $t0, $t0, 2 		# [i+1] 
	add $t0, $t0, $s0  		# arr[i+1]
	#lw $s4, 0($t0) 		# s4 = arr[i+1]

	sw $s3, 0($t0) 			# a[i+1] = a[i]

	addi $t1, $t1, -1      # i--

	j LOOPR

skipR:

	add $t0, $t1, 1
	sll $t0, $t0, 2 		# [i+1] 
	add $t0, $t0, $s0  		# arr[i+1]

	sw $s2, 0($t0)

	


exitRestore2:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $ra, 8($sp)
	lw $a0, 12($sp)
	lw $a1, 16($sp)

	addi $sp, $sp, 20
	jr $ra


######################################################
# hard one
# using only 5 registers - a0, sp, t0, s0, ra
###################################################################
insertionRecursHard:
	

	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $t0, 4($sp)
	sw $ra, 8($sp)
	sw $a0, 12($sp)

	lw $s0, 52($sp) 		# s0 = get n from prev subroutine was (16 + 32 = 52)

	slti $t0, $s0, 2 		#if (n > 1), t0 = 0;
	bne $t0, $0, exitRestore3

							# a0 = array
							# s0 = n
	sw $s0, 28($sp) 		# 28($sp) = n (dont know if will need later)
	addi $t0, $s0, -1    	# t0 = n - 1
	sw $t0, 16($sp)

	jal insertionRecursHard

	sll $t0, $t0, 2 		# [n-1]
	add $t0, $a0, $t0      	# arr[n-1]
	lw $t0, 0($t0)  		# s2 = key = arr[n-1]
	sw $t0, 20($sp)			# 20($sp) = key
	addi $t0, $s0, -2 		# t0 = i = n - 2
	sw $t0, 24($sp)			# 24($sp) = i = n-2

LOOPR3:
	slti $t0, $t0, 0        # while (i >= 0)
	bne $t0, $0, skipR3

	lw $t0, 24($sp) 		# t0 = i
	sll $t0, $t0, 2 		# [i] 
	add $t0, $t0, $a0  		# arr[i]
	lw $t0, 0($t0) 			# t0 = arr[i]
	sw $t0, 32($sp) 		# 32($sp) = arr[i]

	lw $s0, 20($sp) 		# s0 = key
	slt $t0, $s0, $t0 		# if (key < arr[i]) $t0 = 1 and stay
	beq $t0, $0, skipR3

	lw $t0, 24($sp) 		# t0 = i
	add $t0, $t0, 1
	sll $t0, $t0, 2 		# [i+1] 
	add $t0, $t0, $a0  		# address of arr[i+1]

	lw $s0, 32($sp) 		# s0 = arr[i]
	sw $s0, 0($t0) 			# a[i+1] = a[i]

	lw $t0, 24($sp)
	addi $t0, $t0, -1      # i--
	sw $t0, 24($sp)

	j LOOPR3


skipR3:

	lw $t0, 24($sp)
	add $t0, $t0, 1
	sll $t0, $t0, 2 		# [i+1] 
	add $t0, $t0, $a0  		# arr[i+1]

	lw $s0, 20($sp) 		# s0 = key
	sw $s0, 0($t0) 			# arr[i+1] = key

	


exitRestore3:
	lw $s0, 0($sp)
	lw $t0, 4($sp)
	lw $ra, 8($sp)
	lw $a0, 12($sp)


	addi $sp, $sp, 36
	jr $ra