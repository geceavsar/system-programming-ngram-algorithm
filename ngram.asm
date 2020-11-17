
    segment .bss ;declares variables
temp1 resd 1
temp2 resd 1

segment .data ;declare initialized data or constants, 
hit dd 0 ;how many matching ngram
counter dd 0 ;to check if n letters are matched
index2 dd 0 ; holds str2 index
index1 dd 0 ;holds str1 index
ngram1 dd 0 ;#of ngram in str1
ngram2 dd 0 ;#of ngram in str2

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

	;init counters
	mov dword [hit],0
	mov dword [index1],0

	mov edx, [ebp+16]
	mov ecx, [ebp+8]
	
	mov esi,0 ; esi = 0
	mov edi,0 ; edi = 0
	mov ebx, [ebp+24] ;ebx = n 
	
	;;calculate #of ngrams for str1
	mov eax, [ebp+12]
	sub eax, ebx
	add eax, 1
	mov dword [ngram1], eax
	
	;;calculate #of ngrams for str2
	xor eax, eax
	mov eax, [ebp+20]
	sub eax, ebx
	add eax, 1
	mov dword [ngram2], eax
	
l1:
	mov dword [counter], 0
	push esi
	mov dword [index2],0
	
l4: 	
	push eax
	push ebx
	mov byte al, [edx+edi]
	mov byte bl, [ecx+esi]
	cmp al,bl
	pop ebx
	pop eax
	je match 
	
l3:	
	inc edi ;increment offset instead of register
	add dword [index2],1 ;increment index 2
		
	mov eax, [ngram2]
	cmp [index2],eax
	;;check for if str2 reached end	
	je l2
	jmp l4 

l2: 
	pop esi ;pop esi back 
	inc esi
	add dword [index1],1 ;increment index 1
	
	mov eax, [ngram1]	
	cmp [index1],eax
	;;check for if str1 reached end
	je fin
	mov edi, 0
	jmp l1
	
match:
	add dword [counter],1 ;increment counter
	cmp [counter], ebx
	je addHit

	inc esi
	inc edi
	
	push eax
	push ebx
	mov byte al, [edx+edi]
	mov byte bl, [ecx+esi]
	cmp al,bl
	pop ebx
	pop eax
	je match
	
	jmp l2 
	
addHit: 
	add dword [hit],1 ;increment hit count
	jmp l2
	
fin:
	mov edi, [ngram1]
	mov esi, [ngram2]
b1:
	add edi, esi
	mov esi, 100
	mov eax,[hit] ;;eax is intersection
	xor edx, edx ;;clear edx
    sub edi, eax ;;edi is union
    cmp edi, 0
    je noCalc
    
	mul esi
	div edi
noCalc:	
    pop ebp 
    ret
    
