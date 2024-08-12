DATAS	SEGMENT
STR1	DB	'n=', '$';定义提示字符
STR2	DB	'n!=', '$';定义字符，显示结果
MSG0    DB  '**************************************************************************',0AH,0DH,'$'
MSG1    DB  '**************Welcome to the Calculating N Factorial Program**************',0AH,0DH,'$'
MSG2    DB  'Do you want to Calculate N Factorial?(Y/N)','$'
ending db 'Thank you for using the Calculating N Factorial Program',0ah,0dh,'$'
username db 'username:',0ah,0dh,'$'
password db 'password:',0ah,0dh,'$'
user db 'JIANG'
pass db '123456'
tempname db 15,?,15 dup(?)
countname db $-tempname-02h,'$'
temppassword db 15,?,15 dup (?)
countpassword db $-temppassword-02h
wrong1 db 'wrong username!',0ah,0dh,'$'
wrong2 db 'wrong password!',0ah,0dh,'$'
login db 'Login Success!',0ah,0dh,'$'


ANS	DW	1,3000 DUP(-1)			;储存运算结果 存入一个1应对输入0的情况
ANSH	DW	3000 DUP(0)			;相对高位
ANSL	DW	3000 DUP(0)			;相对低位
DATAS	ENDS

CODES	SEGMENT
ASSUME	CS:CODES,DS:DATAS

;字符输出
OUTPUTCHAR MACRO AINCHAR	;将字符AINCHAR输出
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		
	MOV DL,AINCHAR
	MOV AH,02H					;输出字符
	INT 21H
		
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

;字符串输出
OUTPUTSTR MACRO AIMSTR		;将字符串AIMSTR输出
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		
	LEA DX,AIMSTR				;将AIMSTR的偏移地址送到DX寄存器
	MOV AH,09H					;09H字符串输出功能
	INT 21H
		
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

;以10进制输出AX中的数值
OUTPUTAX MACRO				;将AX中的数值以10进制形式输出
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX	
	CALL OUTPUTAXP			;调用进制输出过程	
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

OUTPUTAXP PROC
	MOV DX,0
	MOV CX,0						;用CX储存余数个数后续LOOP需要使用
	CMP AX,0						;判断AX中的值是否为0
	JNE	OUTPUTAXF1
	OUTPUTCHAR '0'
	JMP	OUTPUTAXPEXIT
		
OUTPUTAXF1:
	CMP AX,0						;判断AX中的值是否为0
	JE OUTPUTAXF2				;是则说明AX已经按位除完了
	MOV BX,10		   		 		;10进制
	DIV BX							;除10
	PUSH DX						;将余数入栈保存
	MOV DX,0
	INC CX							;计数循环取得的余数个数
	JMP OUTPUTAXF1
		
OUTPUTAXF2:						;循环输出取得的余数
	POP AX
	ADD AL,30H
	OUTPUTCHAR AL
    LOOP OUTPUTAXF2
OUTPUTAXPEXIT:  RET	
OUTPUTAXP	ENDP

;输出字符串AIMNUM所表示的数值
OUTPUTNUM MACRO AIMNUM
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
		
	LEA	BX,AIMNUM;用BX存储字符串AIMNUM在DS中的首地址	
	CALL OUTPUTNUMP	;调用字符串AIMNUM数值输出过程
		
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

OUTPUTNUMP	PROC
OUTPUTNUMF1:
	MOV SI,-2
OUTPUTNUMEND:					;使SI指向ANS的数值结尾处
	ADD SI,2
	MOV AX,[BX+SI]				;测试AX是否为-1
	CMP AX,-1
	JNE	OUTPUTNUMEND			;直到搜索到最后结尾-1
	
	SUB SI,2
	CMP SI,-2
	JE	OUTPUTNUMEXIT			;若为-2则说明ANS中不存在数据
	MOV AX,[BX+SI]				;取出ANS中的第一个数值到AX中 从低到高
	OUTPUTAX					;将AX中的数以10进制形式输出 是最高位不需要填0
	
OUTPUTNUMNEXT:	
	SUB SI,2
	CMP SI,-2
	JE	OUTPUTNUMEXIT
	MOV AX,[BX+SI]				;取出ANS中的数值到AX中 开始判断有多少0需要填充
	CMP AX,1000
	JAE	OUTPUTNUMF2			;AX中的数值大于等于1000时跳转
	OUTPUTCHAR '0'				;AX小于1000时先输出一个字符'0'
	CMP AX,100
	JAE	OUTPUTNUMF2
	OUTPUTCHAR '0'				;AX小于100时再输出一个字符'0'
	CMP AX,10
	JAE	OUTPUTNUMF2
	OUTPUTCHAR '0'				;AX小于10时再输出一个字符'0'

OUTPUTNUMF2:	
	OUTPUTAX					;将AX中的数以10进制形式输出
	JMP OUTPUTNUMNEXT		;跳转进行下一位数值的输出	
OUTPUTNUMEXIT:		
	RET	
OUTPUTNUMP	ENDP



START:	
	MOV AX,DATAS
	MOV DS,AX
	
	OUTPUTSTR MSG0
	OUTPUTSTR MSG1
	OUTPUTSTR MSG0
	
	input:        
        lea dx,username
        mov ah,09h
        int 21h
        
        lea dx,tempname
        mov ah,0ah
        int 21h
        
        cmp byte ptr tempname+1,05h
        jnz repeat1
        
        mov cx,5
        mov si,offset user
        mov di,offset tempname+2
        mov ax,DATAS
        mov es,ax
        cld
        repe cmpsb
        jnz repeat1
        
        mov dx,offset tempname+2   ;显示输入的字符串
		mov byte ptr tempname[7],'$'
		call dosshow
        
        lea dx,password
        mov ah,09h
        int 21h
        
        lea dx,temppassword
        mov ah,0ah
        int 21h
        
        cmp byte ptr temppassword+1,06h
        jnz repeat2
        
        mov cx,6
		mov si,offset pass
		mov di,offset temppassword+2
		mov ax,DATAS
		mov es,ax
		cld
		repe cmpsb
		jnz repeat2
		
		mov dx,offset temppassword+2
		mov byte ptr temppassword[8],'$'
		call dosshow
		
		jmp loginsuccess
        
    repeat1:
    	lea dx,wrong1
    	mov ah,09h
    	int 21h
    	jmp input
    	
    repeat2:
    	lea dx,wrong2
    	mov ah,09h
    	int 21h
    	jmp input
    	
    loginsuccess:
    	lea dx,login
    	mov ah,09h
    	int 21h
	
	request:
        lea dx,MSG2;显示提示信息
        mov ah,09h
        int 21h
		
		mov ah,01h;获取键盘输入
        int 21h

        cmp al,'N';判断是否统计字符
        je finish;不统计字符，结束程序
        cmp al,'n'
        je finish

        cmp al,'Y';统计字符
        je continue
        cmp al,'y'
        je continue
		
		mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h

        jmp request;输入错误，重新输入
		
	finish:
		mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h
		
		lea dx,ending;显示结束信息
        mov ah,09h
        int 21h

        mov ah,07h 
        int 21h
        mov ax,4c00h
        int 21h
    continue:
		mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h
	
	OUTPUTSTR STR1			;输出字符串STR1
	PUSH BX
	PUSH CX
	PUSH DX
		
	MOV	AX,	0
TYPEIN:  ;输入需要求解的n值
    PUSH AX
    MOV AH,01H
	INT 21H					    ;字符默认输入到AL中
	CMP AL,13
	JE	TYPEINEXIT			    ;检测到回车后跳转AX的输出
	SUB	AL,48				    ;将字符转化为对应的数值
	MOV BH,0
	MOV BL,AL
	POP	AX		
	CMP AX,0				;当AX中的数值为0时，跳过乘法操作
	JE	TYPEINADD
	MOV CX,10
	MUL CX					    ;乘以10
TYPEINADD:
    ADD AX,BX
	JMP TYPEIN		
TYPEINEXIT:	
    POP AX						;将计算得到的数值出栈到AX中		
	POP DX
	POP CX
	POP BX
	MOV CX,AX					;求阶乘的数转至CX中
;输入结束
	OUTPUTSTR STR2		    	;输出字符串STR2
	
;计算阶乘并保存到ANS		
	MOV BX,1						;BX逐步求阶的乘数
SAVENEXT:
	CMP CX,0
	JE	OUTPUTANS				;当CX中的值为0时，输出ANS中的数值
	PUSH CX					
	MOV SI,0						;SI指向ANS的起始位置
MULANS:					;对ANS中的所有数值进行乘BX操作，乘积大于等于10000的部分存储到ANSH中，小于10000的部分存储到ANSL中
	MOV AX,ANS[SI]		;取出ANS中的数值到AX中
	CMP AX,-1
	JE	TRANSFORM				;直到取得的数值为-1时，跳转
	MUL BX						;进行乘法操作
	
	PUSH CX	
	MOV CX,10000
	DIV CX							;除法操作 除以10000
	POP CX
		 
	MOV ANSL[SI],DX		    	;将余数存储到ANSL中			
	ADD SI,2
	MOV ANSH[SI],AX		    	;将商存储到ANSH中
	
	JMP	MULANS
	
TRANSFORM:						;对ANS乘以BX得到的数值字符串ANSL和ANSH，进行格式调整，并将调整后的结果存储到ANS中去
	PUSH BX						;BX中的乘数入栈保存	
	MOV BX,0
	MOV SI,2
	
TRANSFORMF1:
	MOV AX,ANS[BX]				;取出ANS中的数值到AX中
	CMP AX,-1
	JE	TRANSFORMF2			;当ANS中的数值取完时，跳转
	
	MOV AX,ANSH[BX]		    ;取商到AX中
	ADD AX,ANSL[BX]		   	;加上此时所在位置对应的余数
	
	CMP AX,10000					;判断AX中的数值是否大于10000
	JB SAVEINTOANS				;小于10000时直接将数值存储到ANS中
	MOV DX,0						;大于10000时，将大于等于10000的部分存到高位的进位中去，小于10000的部分存储到ANS中
	PUSH CX
	MOV CX,10000
	DIV CX
	POP	CX
	MOV ANS[BX],DX				;小于10000的余数部分存储到ANS中
	ADD ANSH[SI],AX				;大于10000的高位部分添加到高位的进位中去
	
	ADD BX,2						;指针后移指向下一个数值
	ADD SI,2
	JMP	TRANSFORMF1
	
SAVEINTOANS:	
	MOV ANS[BX],AX				;将数值存储到ANS中
	ADD BX,2						;指针后移指向下一个数值
	ADD SI,2
	JMP	TRANSFORMF1
	
TRANSFORMF2:
	MOV AX,ANSH[BX]			;取出上一个商到AX中
	CMP AX,0
	JE	TRANSFORMF3			;若AX中的数值为0时 跳过下一步
	MOV ANS[BX],AX				;将上一位的商添加到ANS中
TRANSFORMF3:
	POP	BX						;BX中的数值出栈
	INC BX
	POP CX
	LOOP SAVENEXT
	
OUTPUTANS:						;输出数值字符串所表示的数值
	OUTPUTNUM ANS
	
	mov dl,0ah
    mov ah,2
    int 21h
    mov dl,0dh
    mov ah,2
    int 21h
        
	jmp request

	MOV AH,4CH
	INT 21H	
	
	dosshow proc
		mov ah,09h
		int 21h

		mov dl,0dh
		mov ah,02h
		int 21h

		mov dl,0ah
		mov ah,02h
		int 21h

		ret
	dosshow endp
CODES	ENDS
END	START
