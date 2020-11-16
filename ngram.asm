
    
    segment .bss ;declares variables
temp1 resd 1
temp2 resd 1

segment .data ;declare initialized data or constants, 
hit dd 0 ;how many matching ngram
counter dd 0 ;to check if n letters are matched
index2 dd 0 ; holds str2 index
index1 dd 0 ;holds str1 index

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

	;xor eax,eax
	
	;init counters
	mov dword [hit],0
	mov dword [index1],0

	mov edx, [ebp+16]
	mov ecx, [ebp+8]
	
	mov esi,0 ; esi = 0
	mov edi,0 ; edi = 0
	
	mov ebx, [ebp+24] ;ebx = n 
	
l1:
	mov dword [counter], 0
	push esi
	mov dword [index2],0
	
l4: 	
	mov byte dl, [edx+edi]
	mov byte cl, [ecx+esi]
	cmp dl,cl
	
	je match 
	
l3:	;inc edx
	inc edi ;increment offset instead of register
	add dword [index2],1 ;increment index 2
	
	;;;;eax in burda str2 de ilerlemesi lazım
	mov eax,[ebp+20]; eax = size 2
	sub eax,ebx ;eax = size2 - n
	inc eax 
	cmp [index2],eax
	;;;
	
	je l2
	jmp l4 

l2: ;pop ecx
	pop esi ;pop esi back 
	;inc ecx
	inc esi
	add dword [index1],1 ;increment index 1
	
	;;;;eax in burda str1 de ilerlemesi lazım
	mov eax,[ebp+12] ;eax = size1
	sub eax,ebx ;eax = size1 - n
	inc eax 
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
	
	mov byte dl, [edx+edi]
	mov byte cl, [ecx+esi]
	cmp dl,cl
	
	je match
	
	jmp l2 
	
addHit: 
	add dword [hit],1 ;increment hit count
	jmp l2
	
fin:
	mov eax,[hit]
    
    pop ebp 
    ret
    
