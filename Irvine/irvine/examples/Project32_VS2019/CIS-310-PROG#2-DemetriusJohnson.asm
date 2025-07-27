; Program template

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	; declare variables here

	RAW WORD 10, 12, 8, 17, 9, 22, 18, 23, 7, 30, 22, 19, 6, 7 

.code
main proc
	; write your code here

	invoke ExitProcess,0
main endp
end main