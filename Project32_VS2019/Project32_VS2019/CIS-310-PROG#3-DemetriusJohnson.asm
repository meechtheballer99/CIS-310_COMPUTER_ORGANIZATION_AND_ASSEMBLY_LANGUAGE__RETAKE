;Program#3 - CIS-310
;Demetrius Johnson
;Creation date: June 26, 2021
;Mod date: June 28, 2021
;Purpose: read an exam score from keyboard input, translate it to a grade based on score, output score and grade

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data												
	
	str1 BYTE "Welcome to the exam score grade output Program#3 - CIS-310, By Demetrius Johnson", 0
	str2 BYTE "Please input an exam score (0-100%): ", 0
	userInput_str BYTE 5 dup(0)
	strSCORE BYTE "Score = ", 0
	strGRADE BYTE "Grade = ",0
	grade_Num BYTE ?
	grade_Letter BYTE ?
INCLUDE Irvine32.inc		
.code
main proc
	
	mov edx, OFFSET str1
	call WriteString					;output string 1
	call Crlf

	mov edx, OFFSET str2
	call WriteString					;output string 2

	mov edx, OFFSET userInput_str
	mov ecx, SIZEOF userInput_str - 1	
	call ReadString						;Input a string from the user. EDX points to the string and ECX specifies 
											;the maximum number of characters the user is permitted to enter (in this case, I make max 3 + 1: "0" - "100"). +1 for the null char
											;A null byte is automatically appended to the string (which is why we needed +1 for the null char to be stored in/appended)
	mov ebx, SIZEOF userInput_str
	mov edx, OFFSET userInput_str
	mov ecx, SIZEOF userInput_str - 1
	call ParseDecimal32					;special note: for some reason this function or the read string function did not function properly/as expected; 
											;had to add an extra couple of bytes so that user can input up to 3 char without part of it being ignored
											;my comments above are in accordance with how it is supposed to work according to irvine slides and other sources.
	mov grade_Num, al					;ParseDecimal32 function stores the converted unsigned string number into an unsigned int from the EAX register; I only need lower 8 bits (AL).

	mov eax, 0							;need to zero the eax register for the following comparisons (just to make sure!)
	mov al, grade_Num					;now move grade percent value back into eax register for comparisons

	cmp al, 90d							;compare instruction will set the EFLAG bits accordingly (particularly the zero and carry flags ) so I can use conditionals in the next lines
	jae L1_A							;jae --> jump if above or equal to (left >= right operand) (based on cmp instruction results above in the flag registers)

	cmp al, 80d							;compare instruction will set the EFLAG bits accordingly (particularly the zero and carry flags ) so I can use conditionals in the next lines
	jae L1_B							;jae --> jump if above or equal to (left >= right operand) (based on cmp instruction results above in the flag registers)

	cmp al, 70d							;compare instruction will set the EFLAG bits accordingly (particularly the zero and carry flags ) so I can use conditionals in the next lines
	jae L1_C							;jae --> jump if above or equal to (left >= right operand) (based on cmp instruction results above in the flag registers)

	cmp al, 60d							;compare instruction will set the EFLAG bits accordingly (particularly the zero and carry flags ) so I can use conditionals in the next lines
	jae L1_D							;jae --> jump if above or equal to (left >= right operand) (based on cmp instruction results above in the flag registers)

	cmp al, 60d							;compare instruction will set the EFLAG bits accordingly (particularly the zero and carry flags ) so I can use conditionals in the next lines
	jb L1_E								;jb --> jump if below (left operand < right operand)  (based on cmp instruction results above in the flag registers)


	L1_A:
		mov al, 41h							;41h == ASCII 'A'
		jmp next

	L1_B:
		mov al, 42h							;42h == ASCII 'B'
		jmp next

	L1_C:
		mov al, 43h							;43h == ASCII 'C'
		jmp next

	L1_D:
		mov al, 44h							;44h == ASCII 'D'
		jmp next

	L1_E:
		mov al, 45h							;45h == ASCII 'E'

	next:
	
	mov grade_Letter, al		;store the grade in eax register (al = lower 8 bits of eax)
	mov al, grade_Num			;re input score into eax register for WriteDec function to output score

	mov edx, OFFSET strSCORE	;point to "score = " string for output
	call WriteString			;irvine 32 string output function based on string pointed to in edx index register
	call WriteDec				;writes the value stored in EAX register as a decimal integer to std output
	call Crlf					;newline sequence

	mov eax, 0					;zero the ecx register for next output
	mov al, grade_Letter		;mov letter grade integer into eax register
	mov edx, OFFSET strGRADE	;point to "grade = " string for output
	call WriteString
	call writeChar				;writes ascii character equivalent to stdout
	call Crlf					;newline sequence

	call waitMsg				;equivalent to system("pause") in c++; simple wait/pause message at end of program
	;end of program, score and letter grade outoput.
	;call dumpRegs


	invoke ExitProcess, 0
main endp
end main