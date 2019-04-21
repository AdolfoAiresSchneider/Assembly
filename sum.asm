section .data

	ms1 db "A = "
	tam_ms1 equ $-ms1
	ms2 db "B = "
	tam_ms2 equ $-ms2
	ms3 db "A + B = "
	tam_ms3 equ $-ms3

section .bss

	numero1 resd 1
	numero2 resd 1
	
	aux resd 1
	soma resd 1
	qtdSaida resd 1
	
	
	Saida resb 100
	S1 resb 100
	S2 resb 100
	buf resb 100

section .text

global main

main :


	N1:; ---------------------------------------

	xor eax,eax ; zerar
	mov [numero1],eax ; zerar numero 1

	mov edx,tam_ms1 ; tamanho para imprimir
	mov ecx,ms1 ; ponteiro para imprimir
	call print_STR	
	call read_STR ;
	
	mov ah,0 ; flag
	call validarSOMAR
	cmp ah,1
	jz N1 ; se flag != 1
	mov [numero1],edx ; SALVA O NUMERO1

	N2:; ---------------------------------------

	xor eax,eax ; zerar eax
	mov [numero2] , eax
	
	mov edx,tam_ms2 ; tamanho da msg
	mov ecx,ms2 ; ponteiro do msg
	call print_STR
	call read_STR
	
	mov ah,0; flag
	call validarSOMAR
	cmp ah,1
	jz N2 ; se flag != 0
	mov [numero2] , edx ; SALVA O NUMERO2
	
	;-------------------------------------------
	
	call SOMA ; soma
	call FORMAT ; converter em string
	
	
	mov edx,tam_ms3
	mov ecx,ms3
	call print_STR
	
	mov edx,[qtdSaida]
	mov ecx,Saida
	call print_STR
	
	;-------------------------------------------
	
	END:
	jmp N1
	mov ebx, 0
	mov eax,1
	int 0x80 ;; Final


print_STR:

	mov ebx,1
	mov eax,4
	int 0x80
	ret

read_STR :

	mov edx,100
	mov ecx,buf
	mov ebx , 0 ;
	mov eax , 3 ; leitura
	int 0x80 ;
	ret


validarSOMAR :

	dec eax ; eax esta com o tamanho da string lida
	jz ERRO91; verifica se eax é zero

	mov ecx,eax ; salva o tamanho da string
	mov esi,0; zera o contador
	mov [aux],esi; zera a minha variavel auxiliar

	cmp eax,6 ; compara com 6
	jg ERRO91; se for maior que 6
	
	mov edx,0

	FOR:
	
		xor eax, eax

		mov edx, 0  ; edx:eax * ebx
		mov eax,10
		mov ebx,[aux]
		mul ebx
		mov ebx, eax
		
		mov eax, 0
		mov al, [buf+esi]
		sub al, 48
		cmp al , 9
		jg ERRO91 ; se for maior
		cmp al , 0
		jl ERRO91 ; se for menor
		
		add ebx , eax
		mov [aux] , ebx

		inc esi; incrementa o contador em 1
		cmp esi,ecx ; verifica se ainda tem caractere
		jne FOR ; se tiver ele executa o for
		
		mov edx,[aux]
		ret

ERRO91:

	mov ah,1
	ret
	
SOMA:

	mov eax,[numero1]
	mov ebx,[numero2]
	add eax,ebx
	mov [soma],eax
	ret

FORMAT :

	mov esi , 0 ; contador
	mov eax , [soma]
	mov ecx , 10 ; EAX/ECX --> EAX = EAX/ECX ---> EDX = EAX%ECX
	
	ini :

		mov edx, 0 ; CONCATENA COM EAX --> EDX:EAX / ECX ,P PROBLÇEMA DE PONTO FLUTUANTE
		div ecx  ; eax / ecx
		add edx, 48
		push rdx ; o resto vai para edx e  quociente apra eax
		inc esi
		cmp eax, 0
		jne ini ; se não for zero
	
	mov ecx,esi
	mov esi,0
	
	for2:
		
		pop rdx
		mov [Saida+esi],rdx
		inc esi
		cmp esi,ecx
		jne for2
	
	mov edx , 10
	mov [Saida+esi],edx
	inc esi
	mov [qtdSaida],esi
	ret
