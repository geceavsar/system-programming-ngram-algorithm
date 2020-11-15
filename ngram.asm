segment .bss ;declares variables



segment .data ;declare initialized data or constants, 
count dd 0
i dd 0

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
	mov edx, [ebp+24] ;get param n 
	mov ecx, [ebp+16] ;get adress of str2
	
	mov ebx,[ebp+20] ;ebx holds len str2 
	sub ebx,edx
	inc ebx ;ebx now holds #ngram
	
	
loop:	
	
	push ebx
	mov eax,4 ;print by the n count
    mov ebx,1
    int 80h
    pop ebx 
    
    inc ecx
    add dword [i],1 ; increment i
    cmp ebx, [i]
    jne loop
    
    pop ebp 
    ret
    