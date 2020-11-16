

 segment .bss ;declares variables


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
	
	;get params 
	
	;mov eax, [ebp+16]
	;mov edx, [eax] ;edx = str2
	;mov eax, [ebp+8]
	;mov ecx, [eax] ;ecx = str1
	
	mov edx, [ebp+16]
	mov ecx, [ebp+8]

	
	mov ebx, [ebp+24] ;ebx = n 
	
l1:
	mov dword [counter], 0
	push ecx
	mov dword [index2],0
	
l4: 
	mov dh, byte[edx]
	mov ch, byte[ecx]
	cmp dh,ch
	;mov edx,[edx]
	;mov edx,[ecx]
	;cmp ecx,edx
	je match 
	
l3:	inc edx
	add dword [index2],1 ;increment index 2
	
	;;;;eax in burda str2 de ilerlemesi lazım
	mov eax,[ebp+20]; eax = size 2
	sub eax,ebx ;eax = size2 - n
	inc eax 
	cmp [index2],eax
	;;;
	
	je l2
	jmp l4 

l2: pop ecx
	inc ecx
	add dword [index1],1 ;increment index 1
	
	;;;;eax in burda str1 de ilerlemesi lazım
	mov eax,[ebp+12] ;eax = size1
	sub eax,ebx ;eax = size1 - n
	inc eax 
	cmp [index1],eax
	;;check for if str1 reached end
	je fin
	mov edx,[ebp+16]
	jmp l1
	
match:
	add dword [counter],1 ;increment counter
	cmp [counter], ebx
	je addHit
	inc ecx
	inc edx
	;mov edx,[edx]
	;mov edx,[ecx]
	;cmp ecx, edx
	mov dh, byte[edx]
	mov ch, byte[ecx]
	cmp dh, ch
	je match
	jmp l2 
	
addHit: 
	add dword [hit],1 ;increment hit count
	jmp l2
	
fin:
	mov eax,[hit]
    
    pop ebp 
    ret
    
