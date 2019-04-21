section .bss
frase resb 60
section .data
msg db "Entre com uma frase:",Slin
mas2 db " Eu to certo -- > sdsdffsdf"
tam equ $-msg
Slin equ 10
section .text

	global main
	main: 
	
		mov edx,tam
		mov ecx,msg
		mov ebx,1
		mov eax,4
		int 0x80
		
		mov edx,59
		mov ecx,frase
		mov ebx,0
		mov eax,3
		int 0x80
		
		mov edx,59
		mov ecx ,frase
		mov ebx,1
		mov eax,4
		int 0x80
		
		
		
		mov eax,1;Saida
		int 0x80; Chama sistema
		 


