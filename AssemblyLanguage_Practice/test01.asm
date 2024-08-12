datarea segment
    fname db 'test.txt',0
    string db 'input the file name:$'
    filename db 14,0,14 dup(?)
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
	stars db '*********************************************************************',0ah,0dh,'$'
	beginning db '**************Welcome to the Counting Characters System**************',0ah,0dh,'$'
	starting db 'Do you want to count characters in the file?(Y/N)','$'
    ending db 'Thank you for using the counting characters system',0ah,0dh,'$'
    success db 'Counting success!$',0ah,0dh,'$'
    error1 db 'Error opening file!',07h,0
    error2 db 'Error reading file!',07h,0
    string1 db 'number of $'
    string2 db ':$'
    array db 26 dup(0)
    others db 0
    buffer db ?
    eof db 032h
datarea ends

codes segment
    assume cs:codes,ds:datarea
    start:
        mov ax,datarea;初始化数据段寄存器
        mov ds,ax
        
        lea dx,stars
        mov ah,09h
        int 21h

        lea dx,beginning;显示欢迎信息
        mov ah,09h
        int 21h
        
        lea dx,stars
        mov ah,09h
        int 21h
        
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
        mov ax,datarea
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
		mov ax,datarea
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
    	   	

    ;输入是否统计字符
    request:
        lea dx,starting;显示提示信息
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
		
		mov dl,0ah;回车换行
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h

        jmp request;输入错误，重新输入
		
	finish:;结束程序
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
		
        lea dx,string;显示提示信息
        mov ah,09h
        int 21h


        ;输入文件名
        lea dx,filename
        mov ah,0ah
        int 21h

        mov bl,filename+1;获取文件名长度
        mov bh,0
        mov [bx+filename+2],0;文件名后加0
        lea dx,filename+2
        mov ax,3d00h;打开文件
        int 21h

        ; mov dx,offset fname;打开文件
        ; mov ah,3dh
        ; mov al,0
        ; int 21h
        
		
		jnc open
        mov si,offset error1;打开文件失败
        call dmess
        jmp continue

    open:		
        mov bx,ax
    go:
        call readchar;读取一个字符
        jc readerror;读取失败
        cmp al,eof;判断是否到文件尾
        jz typeok;到文件尾，显示结果
        call punch;统计字符
        jmp go;继续读取

    readerror:
        mov si,offset error2
        call dmess
    
    
    typeok:
        mov ah,3eh;关闭文件
        int 21h
        mov dl,0ah
        mov ah,2
        int 21h
        call show


    ;回车换行
        mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h

        lea dx,success;显示成功信息
        mov ah,09h
        int 21h
		
		mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h

        jmp request;重新输入

    
    over:
        lea dx,ending;显示结束信息
        mov ah,09h
        int 21h

        mov ah,07h 
        int 21h
        mov ax,4c00h
        int 21h


    ;子程序段
    ;读取一个字符
    readchar proc
        mov cx,1
        mov dx,offset buffer
        mov ah,3fh
        int 21h
        jc r1
        cmp ax,cx
        mov al,eof
        jb r2
        mov al,buffer

    r2:
        clc
    r1:
        ret
    readchar endp

    ;显示错误信息
    dmess proc
    dmess1:
        mov dl,[si]
        inc si
        or dl,dl
        jz dmess2
        mov ah,02h
        int 21h
        jmp dmess1
    dmess2:
        ret
    dmess endp

    ;统计字符
    punch proc
        push dx
        mov dl,al
        mov ah,02h
        int 21h
        pop dx
        mov cl,41h
        lea di,array
        mov ch,al
        cmp ch,cl
        jb other
        cmp ch,5ah
        ja higher2

    ;统计小写字母
    h1:
        je char
        ja loop1
    
    loop1:
        inc cl
        add di,1
        jmp h1

    ;统计大写字母
    higher2:
        mov cl,61h
        lea di,array
        mov ch,al
        cmp ch,cl
        jb other
        cmp ch,7ah
        ja other

    h2:
        cmp ch,cl
        je char
        ja loop2

    loop2:
        inc cl
        add di,1
        jmp h2

    char:
        sub ch,ch
        mov ch,[di]
        inc ch
        mov [di],ch

    other:
        inc others

        ret
    punch endp


    ;显示统计结果
    show proc
        lea si,array
        mov di,41h
    loop3:
        lea dx,string1
        mov ah,09h
        int 21h
        mov dx,di
        mov ah,02h
        int 21h
        lea dx,string2
        mov ah,09h
        int 21h
        sub ax,ax
        mov al,[si]
        add si,1
        call display
        call endline
        inc di
        cmp di,5bh
        jb loop3
        ret
    show endp

    endline proc near
		mov dl,20h
        mov ah,02h
        int 21h
        mov dl,20h
        mov ah,02h
        int 21h
        mov dl,20h
        mov ah,02h
        int 21h
        mov dl,20h
        mov ah,02h
        int 21h
        mov dl,20h
        mov ah,02h
        int 21h
        ret
    endline endp

    ;显示一个字节
    display proc near
        mov bl,10
        div bl
        push ax
        mov dl,al
        add dl,30h
        mov ah,02h
        int 21h
        pop ax
        mov dl,ah
        add dl,30h
        mov ah,02h
        int 21h
        mov dl,20h
        mov ah,02h
        int 21h
        ret
    display endp
    
    ;显示字符串
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
    
codes ends
end start


