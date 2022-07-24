;*********MAIN PROG*******************
  DOSSEG 
  .186
  .model large
  .stack 200h
  
  ;********MAIN PROG DATA SEG*****************
   .data 
   Mssg1 db 'Please enter the number of disk:$'

   Mssg2 db 'Please enter the starting position:$'

   Mssg3 db 'Please enter the ending position:$'

   Echo1 db 'The  number of disks:$'

   Echo2 db 'The starting position:$'
    
   Echo3 db 'The ending position:$'

   Errormsg1 db 'Wrong input!The disk has to be within the range 3-7:$'

   Errormsg2 db 'The range of starting position is within 1-3:$'

   Errormsg3 db  'The range of ending  position is within 1-3 and endpos!=startpos:$'

   disks dw ?   ;number of disks

   startpos dw ?	;starting position

   endpos dw ?		;ending poisition 

   steps dw 0

   ;***********MAIN PROG CODE SEG ***************

   .code 
   extrn	PutStr: PROC, PutCrLf: PROC
   extrn	GetDec: PROC, PutDec: PROC

   ProgStart Proc near
   
   mov ax,@data  ;initialize the ds register to hold the adress of the data segment 
   mov ds,ax

   ;call greet proc
    call Greet

   ;print the first prompt asking user to ender the number of disks
   mov dx,OFFSET Mssg1
   mov ah,9
   int 21h 
  
   
   call GetDec
   cmp ax,3
   jl  INPUTVAL1    ;if disk input is less than 3 jump to input validation

   cmp ax,7
   jg  INPUTVAL1    ;if disk input is greater than 7 jump to input validation

   mov disks,ax ;if user input is correct initialize the number of disks

    ;call echo and print user intput
    mov dx,OFFSET Echo1
    mov ah,09H
    int 21h ;print string

    mov ax,disks
    call PutDec
    call PutCrLf
    call PutCrLf
 
  ; after the num of disks, the next input is stat position
  jmp INPUTSTARTPOS  ;if input is within the range of 3-7, jump to inputting the starting position

   ;INPUT VALIDATION 1
   INPUTVAL1:
   mov dx,OFFSET Errormsg1
   mov ah,09H
   int 21h ;print the first prompt asking user to ender the number of disks



   call GetDec 
    cmp ax,3
    jl  INPUTVAL1 ;jump back to input validation

	cmp ax,7
    jg  INPUTVAL1

    mov disks,ax               ;if input is correct , initialize and move on to input start pos
    mov dx,OFFSET Echo1
   mov ah,09H
    int 21h ;print string

    mov ax,disks
    call PutDec
    call PutCrLf
    call PutCrLf
   
   
   jmp INPUTSTARTPOS
	

  INPUTSTARTPOS:
  mov dx,OFFSET Mssg2
   mov ah,9
   int 21h ;print the first prompt asking user to ender the number of disks
  
    
	;same procedure as inputting disks, check for valid input, if not go to input validation or else conitnue to input last pos
    call GetDec 
    cmp ax,1
    jl  INPUTVAL2 

	cmp ax,3
    jg  INPUTVAL2

mov startpos,ax ;if input is valid initialize startpos

 mov dx,OFFSET Echo2
 mov ah,09H
 int 21h ;print string

 mov ax,startpos ;print the startpos
 call PutDec
 call PutCrLf
 call PutCrLf
   
jmp INPUTLASTPOS ;if input is within 1-3 jump to inputting the last position
  
  ;INPUT VALIDATION 2                                                                    
  INPUTVAL2:                                                                    
  mov dx,OFFSET Errormsg2                                                                    
   mov ah,09H                                                                    
   int 21h                                                                     
                                                
    call GetDec                                                                     
    cmp ax,1                                                                    
    jl  INPUTVAL2                                                                    
                                              
	cmp ax,3                                                                    
    jg  INPUTVAL2                                                                    
                                              
   mov startpos,ax                                                                    
   mov dx,OFFSET Echo2                                                                    
	mov ah,09H                                                                    
   int 21h ;print string                                                                    
                                              
 mov ax,startpos ;print the startpos                                                                    
 call PutDec                                                                    
 call PutCrLf                                                                    
  call PutCrLf                                                                    
                                              
;conitinue to input last pos                                                                    
jmp INPUTLASTPOS                                                                    
                                              
                                              
	INPUTLASTPOS:                                                                    
                                              
	mov dx, OFFSET Mssg3                                                                    
	mov ah,09H                                                                    
	int 21h                                                                    
	                                              
                                              
	call GetDec                                                                    
                                              
	cmp ax,1                                                                    
	jl INPUTVAL3                                                                    
                                              
	cmp ax,3                                                                    
	jg INPUTVAL3                                                                    
                                              
	
	cmp ax,startpos ; endpos cannot be equal to startpos, if so jump to input vaidation
	je INPUTVAL3

   mov endpos,ax            ;print the user input
   mov dx,OFFSET Echo3
   mov ah,09H
   int 21h
   mov ax,endpos
   call PutDec
   call PutCrLf
   call PutCrLf
  
   jmp hanoi ; if end position is valid, jump to function 

   ;INPUT VALIDATION 3
	INPUTVAL3:
	mov dx,OFFSET Errormsg3
    mov ah,09H
	int 21h


	call GetDec
	
    cmp ax,1
    jl  INPUTVAL3

	cmp ax,3
    jg  INPUTVAL3

	cmp ax,startpos
	je INPUTVAL3
 
	mov endpos,ax

  mov dx,OFFSET Echo3   ;echo the ending position to the user 
  mov ah,09H
   int 21h
   mov ax,endpos
   call PutDec
   call PutCrLf
    call PutCrLf


jmp hanoi ; if end positon is valid, initialize endpos and jmp to hanoi


	hanoi:
   push OFFSET steps   ;call hanoi(disks,startpos,endpos,steps)
   push endpos
  push startpos
  push disks
  call Hanoi
	
	;push the parameters in order and call procedure


	;end program 
	mov ah,4ch
	int 21h    
   ProgStart endp ;terminate dos fn 

     comment |
******* PROCEDURE HEADER **************************************
  PROCEDURE NAME : Greet
  PURPOSE :  To print initial greeting messages to the user
  INPUT PARAMETERS : None
  OUTPUT PARAMETERS or RETURN VALUE:  None
  NON-LOCAL VARIABLES REFERENCED: None
  NON-LOCAL VARIABLES MODIFIED :None
  PROCEDURES CALLED :
	FROM iofar.lib: PutCrLf
  CALLED FROM : main program
|
;****** SUBROUTINE DATA SEGMENT ********************************
	.data
Msgg1	 db  'Program: Towers of Hanoi puzzle  $'
Msgg2	 db  'Programmer:Nafis Mortuza $'
Msgg3	 db  'Date: March 30th, 2022 $'


;****** SUBROUTINE CODE SEGMENT ********************************
	.code
Greet	PROC    near

; Save registers on the stack
	pusha
	pushf

; Print name of program
	mov	dx,OFFSET Msgg1 ; set pointer to 1st greeting message
	mov ah,09H        ; DOS print string function #
	int	21h	            ; print string
	call	PutCrLf

; Print name of programmer
	mov	dx,OFFSET Msgg2    ; set pointer to 2nd greeting message
mov ah,09H	           ; DOS print string function #
	int	21h	               ; print string
	call	PutCrLf

; Print date
	mov	dx,OFFSET Msgg3    ; set pointer to 3rd greeting message
	mov ah,09H           ; DOS print string function #
	int	21h	               ; print string
	call	PutCrLf
	call	PutCrLf


; Restore registers from stack
	popf
	popa

; Return to caller module
	ret
Greet	ENDP

 ;Hanoi procedure
 .data
 print1 db '.move disk:$ '
print2 db '   from pole:$  '
print3 db '   to pole:$  ' 

.code
Hanoi	PROC	near

pusha
pushf
mov bp,sp

mov ax,[bp+20] ;ax now holds the num of disks

IFO1:
cmp ax,1   ;if n==1 continue to print the steps and exit proc , if n!=1 jump to else
jne ELSE01

THEN:
mov bx,[bp+26];bx now holds the OFFSET adress  of steps 
mov ax,[bx];ax now holds steps
inc ax
mov [bx],ax ;steps now holds steps+1
call PutDec ;print the step number

mov dx, OFFSET print1  
mov ah,09H
int 21h
mov bx,[bp+20 ];ax now holds n
mov ax,bx
call PutDec

mov dx, OFFSET print2
mov ah,09H
int 21h
mov bx,[bp+22]
mov ax,bx ;;ax now holds r
call PutDec

mov dx, OFFSET print3
mov ah,09H
int 21h
mov bx,[bp+24]
mov ax,bx ;;ax now holds s
call PutDec
call  PutCrLf

popf
popa
ret

ELSE01:
mov bx,[bp+26];bx now holds the num of steps
push bx ;push param steps onto stack


mov bx,[bp+24];bx now holds the s
mov ax,[bp+22];ax now holds the r
add ax,bx ;ax now r+s
mov bx,6
sub bx,ax ;bx now holds 6-(r+s)
push bx ;push 6-r+s onto stack

mov ax,[bp+22];ax now holds the r
push ax ;push r onto stack

mov ax,[bp+20];ax now holds n 
dec ax
push ax ;push n-1 onto stack

call Hanoi
pop ax
pop ax
pop ax
pop ax

PRINTSTEPS01:
mov bx,[bp+26];bx now holds the OFFSET adress  of steps 
mov ax,[bx];ax now holds steps
inc ax
mov [bx],ax ;steps now holds steps+1
call PutDec ;print the step number

mov dx, OFFSET print1  
mov ah,09H
int 21h
mov bx,[bp+20 ];ax now holds n
mov ax,bx
call PutDec

mov dx, OFFSET print2
mov ah,09H
int 21h
mov bx,[bp+22]
mov ax,bx ;;ax now holds r
call PutDec

mov dx, OFFSET print3
mov ah,09H
int 21h
mov bx,[bp+24]
mov ax,bx ;;ax now holds s
call PutDec
call  PutCrLf

PRINTSTEPS01END:

SECONDCALL:

mov bx,[bp+26]
push bx ;push  the parameter steps parameter onto stack

mov bx,[bp+24] 
push bx ;push the parameter s onto stack

mov bx,[bp+24];bx now holds the s
mov ax,[bp+22];ax now holds the r
add ax,bx ;ax now r+s
mov bx,6
sub bx,ax ;bx now holds 6-(r+s)
push bx ;push 6-r+s onto stack



mov bx,[bp+20]
mov ax,bx 
dec ax
push ax ;push n-1 onto stack

call Hanoi
pop ax
pop ax
pop ax
pop ax
popf
popa
ret

Hanoi endp
end ProgStart
