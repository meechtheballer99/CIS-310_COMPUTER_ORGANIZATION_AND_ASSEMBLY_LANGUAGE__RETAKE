; Program#2 - CIS-310
;Demetrius Johnson
;Creation date: June 20, 2021
;Mod date: June 26, 2021
;Purpose: Find the mean and variance of an array of numbers

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data														;NOTE: I Make lots of notes to myself in this program so I can refer back to it for my later programs
	; declare variables here (1 WORD = 2 BYTES)				;another note: you can only move constants, constant expr or const labels, or same-size reg or mem location into a given reg or mem location

	str1	BYTE "Welcome to the Mean and Variance Assmebly Language Program#2-CIS-310, By Demetrius Johnson", 0
	str2	BYTE "MEAN: ", 0
	str3	BYTE "VARIANCE: ", 0
	MEAN_32	DWORD ?														;need this 32-bit unsigned int in order to use IRVINE32 WriteDec function
	VARI_32	DWORD ?														;need this 32-bit unsigned int in order to use IRVINE32 WriteDec function
	VARI	WORD ?														;use this to store the results of variance
	MEAN	WORD ?														;use this to store the results of the average												
	DIFF	SWORD 15 Dup(?)												;use this array to store the use this to store the (element_value - average) (need SWORD for negative values)
	SQUARE	WORD  15 Dup(?)												;use this array to store the square of the element_value and average difference (variance)
	RAW		WORD  10, 12, 8, 17, 9, 22, 18, 11, 23, 7, 30, 22, 19, 6, 7	;declare array of raw data to find statistics for
	arrayLength = ($ - RAW)/2											;use this symbolic constant to store the size of the RAW array 
																			;(evaluated at runtime; can be changed to store another constant/constant expression 
																			;but cannot be used as a storage variable --> can only mov integer const/const expressions to it during runtime) 
																	;also: $ symbol is the current location counter (in bytes), 
																	;so after declaring RAW array, doing ($ - RAW)/2 does current address - address of Raw to give size of RAW (/2-->in WORDS = 2bytes))
																	;do: $ - RAW of the RAW array to get the size of the array in BYTES
																	;Alternatively, I could do : mov ecx, LENGTHOF RAW --> the LENGTHOF directive will return number of elements in RAW
																	;note: using operator[] with register operands returns the value pointed to by the register if it is storing an address
																	;otherwise, [] has no effect and simply always returns the value stored by a given variable
																	;HOWEVER: if you use a variable name + an index register, you will get a byte(s) offset by the value stored in an index register
																		;from the start address of the variable, and then the data stored at that byte offset is returned (see slide 60 from ch_04)
																		;for example: [label + reg], or label[reg] ---> label refers to a label/variable name, reg refers to an INDEX register
																		;(this is called using Indexed Operands; setting index register to a an address is called using Indirect Operands)
	
INCLUDE Irvine32.inc		;CPU type and memory model used already included in the irvine32 library, So I techinically don't need the above .directives I made
.code
main proc
	; write your code here

	mov edx, OFFSET str1	;print out a welcome message using write string function from irvine 32 library
	call WriteString
	call Crlf				;newline sequence function from irvine32

	mov edi, OFFSET RAW		;move address of RAW into edi 32-bit index register using the OFFSET operator (returns an address of a variable/array); note that OFFSET refers to the offset from the start address of the data segment
	mov ecx, arrayLength	;ECX is a loop counter register used by the LOOP directive --> set it equal to array length
	mov ax, 0				;zero the accumulator register (AX = Lower 16 bits of the EAX register)

SUM_LABEL:					;use the SUM label in order to create a loop to sum up all the integers in the array
	add ax, [edi]			;go to the memory location stored by edi, and get the value stored at the memory location, and add it to the ax accumulator register
	add edi, TYPE RAW		;TYPE directive returns the size of elements in RAW (variable type length), thus add this to the edi index register to move to next position in the RAW array
	LOOP SUM_LABEL			;call the loop directive, which will first decrement ecx counter register, then if ecx!=0 go to SUM label (set EPI instruction pointer to SUM)
	
	mov dx, 0				;DX register contains high part of the dividend (dividend = DX:AX) so it must be cleared since I will only need the low part (AX register)
	mov cx, arrayLength		;need to move arrayLength into cx register location to perform division (divisor for 16-bit division must be a 16-bit reg or mem location)
	div cx					;this will do  = sum/numElements = average --> DX:AX / CX --> quotient stored in AX, remainder stored in DX
	mov MEAN, ax			;move the average (only the quotient portion; remainder is ignored) into a storage variable (should read AX = 000E, DX = 000B)
	

	mov esi, OFFSET DIFF	;move start address of DIFF array into esi 32-bit index register
	mov edi, OFFSET RAW		;mov start address of RAW back into edi index register
	mov ecx, arrayLength	;move length of array into ecx counter register for next loop statement
	
DIFF_LABEL:
	mov ax, [edi]			;move the RAW element (original data element) into the ax register
	sub ax, MEAN			;get difference of each element from the mean
	mov [esi], ax			;move the calculated difference into the DIFF array corresponding element location
	add esi, TYPE DIFF		;go to next element in DIFF array (remember TYPE operator returns the variable type/byte size of a defined variable (and its elements))
	add edi, TYPE RAW		;go to next element in RAW array (current element address of RAW + 2 bytes since raw array is an array of words; same applies to DIFF array)
	LOOP DIFF_LABEL			;calculate all differences and store them in the DIFF array

	mov esi, OFFSET DIFF	;move DIFF address into esi index reg for the next loop
	mov edi, OFFSET SQUARE	;move SQUARE address into edi index reg for the next loop
	mov ecx, arrayLength	;need to reset ecx to size of the arrays (15) for the next loop statements 

SQUARE_LABEL:
	mov ax, [esi]			;move the current difference element into ax
	imul ax, [esi]			;imul (signed multiplication) using two 16-bit operands multiplies the two operands and store the result in the first operand (in this case, store result in ax, preserving sign +/-)
	mov [edi], ax			;move the multiplication result into the corresponding SQUARE array element location
	add esi, TYPE DIFF		;move to next element location/address in DIFF array
	add edi, TYPE SQUARE	;move to next element location in SQUARE array (remember diff and square arrays contain 2-byte elements, so we use TYPE command to return element size)
	LOOP SQUARE_LABEL

	mov esi, OFFSET SQUARE	;mov square array into esi index register
	mov ax, 0				;zero the ax register for the summation of squared differences from mean
	mov ecx, arrayLength	;set ecx register to array length; which is used by the LOOP function

VARI_LABEL:
	add ax, [esi]			;add elements from the SQUARE rray to the ax register; we must sum them all up into this accumulator register
	add esi, TYPE SQUARE	;size of SQUARE array elements is 2 bytes; use TYPE function to return size type of SQAURE and move to the next element in the array (similar to doing esi+2)
	LOOP VARI_LABEL			; call loop function; decrements ecx register first, checks if it is 0, if not 0 then mov to address of label argument given (VARI_LABEL)

	mov dx, 0				;DX register contains high part of the dividend (dividend = DX:AX) so it must be cleared since I will only need the low part (AX register)
	mov cx, arrayLength		;need to move arrayLength into cx register location to perform division (divisor for 16-bit division must be a 16-bit reg or mem location)
	div cx					;this will do  = sumOfSquareDiff/numElements = variance --> DX:AX / CX --> quotient stored in AX, remainder stored in DX
	mov VARI, ax			;move the average (only the quotient portion; remainder is ignored) into a storage variable (should read AX = 0033 , DX = 0002 )
	
	;below, we need to reset 32-bit registers in order to move the values of MEAN and VARIANCE into their lower half, then move those values into 32-bit unsigned ints
		;and then use WriteDec function from IRIVIN32 library, which prints the decimal value of a 32-bit unsigned int memory location

	mov eax, 0				;zero the eax 32-bit reg
	mov ax, MEAN			;mov MEAN into lower half of the 32-bit eax reg (ax = 16-bit lower half)
	mov ebx, 0				;zero the ebx 32-bit reg
	mov bx, VARI			;mov MEAN into lower half of the 32-bit ebx reg (bx = 16-bit lower half)

	mov MEAN_32, eax		;move 32-bit values into 32-bit mem location
	mov	VARI_32, ebx		;move 32-bit values into 32-bit mem location

	mov eax, MEAN_32		;mov MEAN into eax, eax will be used to print by the WriteDec function
	mov edx, OFFSET str2	;move string2 address location into edx in order to use the WriteString function from irvine32
	call WriteString		;will write the contents of the string at the memory location stored by edx index register
	call WriteDec			;irvine32 library, writes 32-bit unsigned int to standard output in decimal format
	call Crlf				;irivine32 library, writes a end of line sequence to standard output
		
	mov eax, VARI_32		;mov VARIANCE into eax, eax will be used to print by the WriteDec function
	mov edx, OFFSET str3
	call WriteString
	call WriteDec			;irvine32 library, writes 32-bit unsigned int from the eax register
	call Crlf				;irivine32 library, writes a end of line sequence to standard output





	;call dumpRegs


	invoke ExitProcess, 0
main endp
end main