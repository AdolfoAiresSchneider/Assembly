section .bss

bufin resb 100
bufout resb 100

qtd resd 1

section .data
fraseUs db "Digite a frase : ",

tam equ $-fraseUs

section .txt

	global main
	main : 
	
		mov edx ,tam ;
		mov ecx , fraseUs ;
		mov ebx , 1 ; tela
		mov eax , 4 ; impressao
		int 0x80 ;
		
		mov edx , 100 ; defino o tamanho maximo da leitura
		mov ecx , bufin ;
		mov ebx , 0 ;
		mov eax , 3 ; leitura
		int 0x80 ; 
		
		mov [qtd] , eax ; ira pegar o qtd do buffer
		
		mov esi , 0
		mov edi , [qtd]
		
		iniloop : ; inicio loop
		
			dec edi
			mov al,[bufin + esi] ;
			mov [bufout + edi],al ;
			je saiLoop ;
			inc esi ;
			jmp iniloop ;
			
		saiLoop : 
		
		
		Loop2 :
			
			
		saiLoop2:
		
		mov edx,qtd
		mov ecx ,bufout
		mov ebx,1
		mov eax,4
		int 0x80
		
		mov eax,1;Saida
		int 0x80; Chama sistema
