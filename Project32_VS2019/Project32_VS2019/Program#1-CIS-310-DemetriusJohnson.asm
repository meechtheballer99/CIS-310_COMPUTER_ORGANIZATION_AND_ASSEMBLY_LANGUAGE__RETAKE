;CIS-350 SUMMER 2021 WITH PROFESSOR DAVID YOON
;Name: Demetrius Johnson
;Date: 6-06-21 
;Program Description: EXAM I Question 4: write a program that mulitplies 5*4


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.DATA

.CODE
main proc 

mov al, 5d	;move 5 into al 8-bit register (05)
mov bl, 4d	;move 4 into bl 8-bit register (04)
mul bl		;multiply al * bl --> it will be stored in the 16-bit AX register 0014h = 20d



	invoke ExitProcess,0
main endp
end main