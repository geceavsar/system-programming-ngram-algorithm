segment .bss
num resd 1
counter resd 1

segment .data
msg db "hello, world",10


segment .text
global ngram

ngram:
	
	push ebp
    	mov  ebp,esp

	mov dword [num], [ebp+20] ;num stores str2 len
	mov dword [counter], 0 ;init counter
	
	mov  ecx,[ebp+16] ;str2
    	mov  edx,[ebp+24] ;n
    	sub [num], edx ;subtract param n from num
    	inc dword [num] ;num holds how many ngrams a string holds
    
    
loop:
	inc dword [counter] ;increment counter
	mov eax,4 ;print by the n count
    	mov ebx,1
    	int 80h
    	inc ecx ;shift ecx by 1 location
    	cmp counter,[num]
    	jz finished
    	jmp loop
    
    
    
finished:  
    	pop  ebp
    	ret
