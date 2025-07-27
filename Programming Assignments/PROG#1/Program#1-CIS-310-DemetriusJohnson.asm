;CIS-350 SUMMER 2021 WITH PROFESSOR DAVID YOON
;Name: Demetrius Johnson
;Date: 5-30-21 
;Program Description: Introduction to MASM; define variables and use registers to complete addition and subtraction operations


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.DATA

A	DWORD 30d
B	DWORD 20d
C1	DWORD 10d
D	DWORD 5d
FinalResult DWORD ?	; store the final result of my operation in this location (variable)

.CODE
main proc 

mov eax, A
mov ebx, B
mov ecx, C1
mov edx, D

;below, we need to perform the operation: A = (A + B) - (C1 + D)

add eax, B				; eax = A + B
add ecx, D				; ecx = C1 + D
sub eax, ecx			; eax = eax - ecx == (A + B) - (C1 + D)
mov FinalResult, eax	; store final result in a variable

	invoke ExitProcess,0
main endp
end main