;segment .bss
;size1 resd 1
;size2 resd 1
;n resd 1
segment .data
msg db "hello, world",10
len equ 14

segment .text
global ngram

ngram:
    push ebp
    mov  ebp,esp

	;mov dword [n], [ebp+8]
	;mov dword [size2], [ebp+12]
	;mov dword [size1], [ebp+20]
    ;mov eax,4
    ;mov ebx,1
    ;mov  ecx,[ebp+16] ;str2
    mov ecx,msg
    
    ;mov  edx,[ebp+24] ;str1
    ;xor  eax,eax
    ;mov edx,[ebp+12] 
    mov edx,len
    int 80
    
    mov eax,1 
    mov ebx,0
    int 80h
	
	
	
	
	
    pop  ebp
    ret
