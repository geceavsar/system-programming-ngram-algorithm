segment .bss ;declares variables



segment .data ;declare initialized data or constants, 
count dd 0
i dd 0
u dd 0
nMinusOne dd 0
j dd 0

;;str1 ebp+8
;;size1 ebp+12
;;str2 ebp+16
;;size2 ebp+20
;;n ebp+24

segment .text
global ngram

ngram:
	
	push ebp
    mov  ebp,esp

	
	mov dword [i],0
	
	

l1:
	mov eax, [ebp+8] ;;str1
	mov ebx, [ebp+12] ;;len of str1
	;mov ecx, [ebp+16] ;;str2
	;mov edx, [ebp+20] ;;len of str2
	mov esi, [ebp+24] ;;n
	
	push esi ;;esi holds n
	sub ebx, esi
	mov edi, esi ;;edi holds #ngram
	pop esi
	inc edi
	mov dword [nMinusOne], esi
	sub dword [nMinusOne], 1
		
	mov ecx, eax ;;set the offset address
	jmp loop1
incEax:
	inc eax ;;goto next ngram
	mov ecx, eax ;;set the offset address
	mov dword [i], 0  ;;clear counters
	mov dword [j], 0
loop1:
	push ecx ;;push letter to stack
	inc ecx ;;increase iterator
	add dword [i], 1 ;;increase counters
	add dword [j], 1
	cmp [j], esi ;;end of inner loop
	jl loop1
	cmp [i], edi ;;end of outer loop
	jl incEax ;;;;err
	
	mov eax, edi ;;#ngram
	mul esi ;;#of letters
	mul 4 ;;1 letter for each 4 bytes, esp should be increased to
	;;go to the bottom of the stack
	
    pop ebp 
    ret
