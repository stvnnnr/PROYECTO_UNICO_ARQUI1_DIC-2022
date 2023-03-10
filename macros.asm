print MACRO entrada;macro para imprimir en consola algun texto
    mov ah,09h
    mov dx, offset entrada
    int 21h;interrupcion para consola
ENDM
;
limpiar MACRO
    mov ah, 0Fh;se carga en la parte alta el servicio 0Fh, lee el modo actual de video.
    int 10h;se utiliza la interrupcion 10h, esta maneja los servicios de la pantalla
    mov ah, 0;activa modo de video
    int 10h
ENDM
;
leerchar MACRO;macro para leer algun caracter desde el teclado
    mov ah, 01h
    int 21h;interrupcion para consola
ENDM
;
leerTexto MACRO entrada;macro para leer una cadena de texto
    LOCAL obtenerChar, termino;definimos variables locales para que no haya problemas entre macros
    xor si, si;limpiar el registro si , 0 
    obtenerChar:
        leerchar;lee caracter por caracter 
        cmp aL, 0dh;compara si es igual a salto de linea
        je termino;si es igual al salto de linea pone "$" en el resto de caracteres para llenar el arreglo
        mov entrada[si], aL;si es diferente al salto de linea lo concatena
        inc si;aumenta uno en el contador 
        jmp obtenerChar;recursividad hasta leer todos los caracteres
    termino:
    mov aL, 24h;si es igual al salto de linea pone "$" en el resto de caracteres para llenar el arreglo
    mov entrada[si], aL
ENDM
;
menu MACRO;macro que mantiene el menu y lo repite en loop
    menuPrincipal:;imprimo todas las opciones del menu
        textos
        leerchar;leo el caracter que introducen
        cmp aL, 31h;compruebo si el caracter es igual a 31h que es el codigo hexadecimal del numero 1 en ascii
        je opcionUno;uso el jmp equals para ver si es igual y sí si, pues entro en la etiqueta
        cmp aL, 32h
        je opcionDos
        cmp aL, 33h
        je opcionTres
        cmp aL, 34h
        je opcionCuatro
        cmp aL, 35h
        je opcionCinco
        cmp aL, 36h
        je opcionSeis
        cmp aL, 37h
        je opcionSiete
        cmp aL, 38h;Si eligen 8, salgo del programa
        je salir
        jmp menuPrincipal;vuelvo a poner el menu principal si ponen algun caracter que no es los que considere
    opcionUno:;etiquetas de las opciones, me manda a su macro especial
        trabajoUno
        print backMenu
        leerchar;al terminar el trabajo de la macro debo dar alguna tecla para volver al menu
        limpiar
        jmp menuPrincipal
    opcionDos:
        trabajoDos
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    opcionTres:
        trabajoTres
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    opcionCuatro:
        trabajoCuatro
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    opcionCinco:
        menusSecundario
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    opcionSeis:
        trabajoSeis
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    opcionSiete:
        trabajoSiete
        print backMenu
        leerchar
        limpiar
        jmp menuPrincipal
    salir:;Todo lo que va en salir es para finalizar el programa
        limpiar
        print despedida
        mov ah, 4ch
        xor aL, aL
        int 21h
ENDM
;
textos MACRO;aca tengo todos los textos que imprimo en el menu
    print menuTexto
    print cadenaDos
    print cadenaTres
    print cadenaCuatro
    print cadenaCinco
    print cadenaSeis
    print cadenaSiete
    print cadenaOcho
    print cadenaNueve
    print cadena
ENDM
textos2 MACRO;aca tengo todos los textos que imprimo en el menu
    print menusito
    print menusito2
    print menusito3
    print menusito4
    print menusito5
    print menusito6
ENDM
;
trabajoUno MACRO;macro de ingresar ecuacion
    limpiar
    print cadenaCoCinco
    leerTexto coeCinco;almacena cada coeficiente en su variable

    limpiar
    print cadenaCoCuatro
    leerTexto coeCuatro

    limpiar
    print cadenaCoTres
    leerTexto coeTres

    limpiar
    print cadenaCoDos
    leerTexto coeDos

    limpiar
    print cadenaCoUno
    leerTexto coeUno

    limpiar
    print cadenaCoCero
    leerTexto coeCero

    limpiar
    print aceptado
ENDM
;
trabajoDos MACRO;Esta macro imprime la ecuacion almacenada, solo si son una variable, si son cero no los imprime
    limpiar
    comparaCero coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoTres MACRO;Esta macro imprime la derivada de la ecuacion almacenada, solo si son una variable, si son cero no los imprime
    limpiar
    comparaUno coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoCuatro MACRO;Esta macro imprime la integral de la ecuacion almacenada, solo si son una variable, si son cero no los imprime
    limpiar
    comparaDos coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoCinco MACRO
    LOCAL ciclo, SALIR
    onVideo;prendo modo video
    ejes;pinto mis ejes
    impFuncion coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero;pinto mis puntos
    ciclo:;lo mantengo en ciclo hasta que precione esc para salir
        MOV AH, 10H
        INT 16h
        CMP AL,27
        JE SALIR
        jmp ciclo
    SALIR:
    offVideo;apago el modeo video
ENDM
;
trabajoSeis MACRO
ENDM
;
trabajoSiete MACRO
ENDM
;
comparaCero MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis;macro que recibe los 6 coeficientes e imprime la ecuacion almacenada
;Creo las banderas locales para no tener problemas con las demas macros 
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco,  unoPositivo, unoNegativo, dosPositivo, dosNegativo,tresPositivo, tresNegativo, cuatroPositivo, cuatroNegativo, cincoPositivo, cincoNegativo, seisPositivo, seisNegativo, seisPositivo, seisNegativo, salirUno, salirDos, salirTres, salirCuatro, salirCinco, salirSeis, salirMacro
    print respuesta
    cmp numeroUno, 30h;comparo si le numero es igual a cero
    jne printUno;si es igual a cero no voy a la bandera, si es diferente voy a la bandera 
    bandera:;Bandera para returns mas facil
    cmp numeroDos, 30h
    jne printDos
    banderaDos:
    cmp numeroTres, 30h
    jne printTres
    banderaTres:
    cmp numeroCuatro, 30h
    jne printCuatro
    banderaCuatro:
    cmp numeroCinco, 30h
    jne printCinco
    banderaCinco:
    cmp numeroSeis, 30h
    jne printSeis
    jmp salirMacro
    ;----------------------------------------
    printUno:
    cmp numeroUno, 30h;comparo si el coeficient con cero para imprimirlo con signo menos o mas
    jg unoPositivo;si es mayor que cero me voy a esta bandera
    jl unoNegativo;si es menor que cero se va a esta bandera
    unoPositivo:;si es mayor a cero, osea positivo imprimo el signo mas, el coeficiente y la x con su exponente
        print sigMas
        print numeroUno
        print xCinco
        jmp salirUno
    unoNegativo:;si es negativo se imprime el numero con su signo y su x con su exponente
        print numeroUno
        print xCinco
    salirUno:
    jmp bandera
    ;-------------------------
    printDos:
    cmp numeroDos, 30h
    jg dosPositivo
    jl dosNegativo
    dosPositivo:
        print sigMas
        print numeroDos
        print xCuatro
        jmp salirDos
    dosNegativo:
        print numeroDos
        print xCuatro
    salirDos:
    jmp banderaDos
    ;-----------------------------------
    printTres:
    cmp numeroTres, 30h
    jg tresPositivo
    jl tresNegativo
    tresPositivo:
        print sigMas
        print numeroTres
        print xTres
        jmp salirTres
    tresNegativo:
        print numeroTres
        print xTres
    salirTres:
    jmp banderaTres
    ;-------------------------
    printCuatro:
    cmp numeroCuatro, 30h
    jg cuatroPositivo
    jl cuatroNegativo
    cuatroPositivo:
        print sigMas
        print numeroCuatro
        print xDos
        jmp salirCuatro
    cuatroNegativo:
        print numeroCuatro
        print xDos
    salirCuatro:
    jmp banderaCuatro
    ;--------------------------------
    printCinco:
    cmp numeroCinco, 30h
    jg cincoPositivo
    jl cincoNegativo
    cincoPositivo:
        print sigMas
        print numeroCinco
        print xUno
        jmp salirCinco
    cincoNegativo:
        print numeroCinco
        print xUno
    salirCinco:
    jmp banderaCinco
    ;-----------------------------------
    printSeis:
    cmp numeroSeis, 30h
    jg seisPositivo
    jl seisNegativo
    seisPositivo:
        print sigMas
        print numeroSeis
        jmp salirSeis
    seisNegativo:
        print numeroSeis
    salirSeis:
    salirMacro: 
ENDM
;

multiplicacion MACRO var1, var2;esta macro es para realizar la multiplicacion de los coeficientes con los numeros para las deviadas
    FINIT;inicializo la fpu con su estado inicial
    xor dx, dx;limpio los registros dx que me serviran
    mov si, offset var1;paso la direccion de mi variable 1 que la tengo en unas variable db
    mov dl, byte ptr[si];paso los datos de mi variable 1 al dl
    mov si, offset numerrr;paso la direccion de mi var aux que es dw, ya que la fpu solo acepta dw
    sub dx, 48;como las ingreso en ascii debo sumarle 48 para hacerlo hexa
    mov word ptr[si], dx;le meto el dato ya corregido a la var dw
    FILD  numerrr;le damos push a nuestra primera variable al fpu

    xor dx, dx
    mov si, offset var2
    mov dl, byte ptr[si]
    mov si, offset numerrr
    mov word ptr[si], dx
    FILD numerrr;le damos push a nuestra segunda variable a la fpu

    FMUL;los multiplico
    FISTP numerrr;saco el resultado de la fpu y la mando a la variable de resultado
    
    mov si, offset numerrr;paso la direccion de mi resultado al si
    mov bx, word ptr[si];paso a bx mi contenido del resultado
    mov si, offset numer2;paso mi variable de respuesta donde imprimire mi contenido convertido en hexa
    call pImprimirEnteroSigno;llamo mi procedimiento para poder convertir mi variable ascii en hexa
    print numer2;imprimo mi variable ya en hexa
ENDM

multiplicacion2 MACRO var1, var2;esta macro es para realizar la multiplicacion de los coeficientes con los numeros para las deviadas
    FINIT;inicializo la fpu con su estado inicial
    xor dx, dx;limpio los registros dx que me serviran
    mov si, offset var1;paso la direccion de mi variable 1 que la tengo en unas variable db
    mov dl, byte ptr[si];paso los datos de mi variable 1 al dl
    mov si, offset numerrr;paso la direccion de mi var aux que es dw, ya que la fpu solo acepta dw
    sub dx, 48;como las ingreso en ascii debo sumarle 48 para hacerlo hexa
    mov word ptr[si], dx;le meto el dato ya corregido a la var dw
    FILD  numerrr;le damos push a nuestra primera variable al fpu

    xor dx, dx
    mov si, offset var2
    mov dl, byte ptr[si]
    mov si, offset numerrr
    mov word ptr[si], dx
    FILD numerrr;le damos push a nuestra segunda variable a la fpu

    FMUL;los multiplico
    FISTP numerrr;saco el resultado de la fpu y la mando a la variable de resultado
    
    mov si, offset numerrr;paso la direccion de mi resultado al si
    mov bx, word ptr[si];paso a bx mi contenido del resultado
    ; mov si, offset numer2;paso mi variable de respuesta donde imprimire mi contenido convertido en hexa
    ; call pImprimirEnteroSigno;llamo mi procedimiento para poder convertir mi variable ascii en hexa
ENDM


comparaUno MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis;macro que recibe los 5 coeficientes e imprime la derivada almacenada
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco, unoPositivo, unoNegativo, dosPositivo, dosNegativo,tresPositivo, tresNegativo, cuatroPositivo, cuatroNegativo, cincoPositivo, cincoNegativo, salirUno, salirDos, salirTres, salirCuatro, salirCinco, salirMacro
    print respuesta2
    cmp numeroUno, 30h
    jne printUno
    bandera:
    cmp numeroDos, 30h
    jne printDos
    banderaDos:
    cmp numeroTres, 30h
    jne printTres
    banderaTres:
    cmp numeroCuatro, 30h
    jne printCuatro
    banderaCuatro:
    cmp numeroCinco, 30h
    jne printCinco
    ;----------------------------------------
    printUno:
    cmp numeroUno, 30h
    jg unoPositivo
    jl unoNegativo
    unoPositivo:
        multiplicacion numeroUno, expo5
        print xCuatro
        jmp salirUno
    unoNegativo:
        multiplicacion numeroUno, expo5
        print xCuatro
    salirUno:
    jmp bandera
    ;-------------------------
    printDos:
    cmp numeroDos, 30h
    jg dosPositivo
    jl dosNegativo
    dosPositivo:
        multiplicacion numeroDos, expo4
        print xTres
        jmp salirDos
    dosNegativo:
        multiplicacion numeroDos, expo4
        print xTres
    salirDos:
    jmp banderaDos
    ;-----------------------------------
    printTres:
    cmp numeroTres, 30h
    jg tresPositivo
    jl tresNegativo
    tresPositivo:
        multiplicacion numeroTres, expo3
        print xDos
        jmp salirTres
    tresNegativo:
        multiplicacion numeroTres, expo3
        print xDos
    salirTres:
    jmp banderaTres
    ;-------------------------
    printCuatro:
    cmp numeroCuatro, 30h
    jg cuatroPositivo
    jl cuatroNegativo
    cuatroPositivo:
        multiplicacion numeroCuatro, expo2
        print xUno
        jmp salirCuatro
    cuatroNegativo:
        multiplicacion numeroCuatro, expo2
        print xUno
    salirCuatro:
    jmp banderaCuatro
    ;--------------------------------
    printCinco:
    cmp numeroCinco, 30h
    jg cincoPositivo
    jl cincoNegativo
    jmp salirMacro
    cincoPositivo:
        print sigMas
        print numeroCinco
        jmp salirCinco
    cincoNegativo:
        print numeroCinco
    salirCinco:
    salirMacro: 
ENDM

comparaDos MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis;macro que recibe los 5 coeficientes e imprime la integral almacenada
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco,  unoPositivo, unoNegativo, dosPositivo, dosNegativo,tresPositivo, tresNegativo, cuatroPositivo, cuatroNegativo, cincoPositivo, cincoNegativo, seisPositivo, seisNegativo, seisPositivo, seisNegativo, salirUno, salirDos, salirTres, salirCuatro, salirCinco, salirSeis, salirMacro
    print respuesta3
    cmp numeroUno, 30h
    jne printUno
    bandera:
    cmp numeroDos, 30h
    jne printDos
    banderaDos:
    cmp numeroTres, 30h
    jne printTres
    banderaTres:
    cmp numeroCuatro, 30h
    jne printCuatro
    banderaCuatro:
    cmp numeroCinco, 30h
    jne printCinco
    banderaCinco:
    cmp numeroSeis, 30h
    jne printSeis
    jmp salirMacro
    ;----------------------------------------
    printUno:
    cmp numeroUno, 30h
    jg unoPositivo
    jl unoNegativo
    unoPositivo:
        division numeroUno, expo6
        print xSeis
        jmp salirUno
    unoNegativo:
        division numeroUno, expo6
        print xSeis
    salirUno:
    jmp bandera
    ;-------------------------
    printDos:
    cmp numeroDos, 30h
    jg dosPositivo
    jl dosNegativo
    dosPositivo:
        division numeroDos, expo5
        print xCinco
        jmp salirDos
    dosNegativo:
        division numeroDos, expo5
        print xCinco
    salirDos:
    jmp banderaDos
    ;-----------------------------------
    printTres:
    cmp numeroTres, 30h
    jg tresPositivo
    jl tresNegativo
    tresPositivo:
        division numeroTres, expo4
        print xCuatro
        jmp salirTres
    tresNegativo:
        division numeroTres, expo4
        print xCuatro
    salirTres:
    jmp banderaTres
    ;-------------------------
    printCuatro:
    cmp numeroCuatro, 30h
    jg cuatroPositivo
    jl cuatroNegativo
    cuatroPositivo:
        division numeroCuatro, expo3
        print xTres
        jmp salirCuatro
    cuatroNegativo:
        division numeroCuatro, expo3
        print xTres
    salirCuatro:
    jmp banderaCuatro
    ;--------------------------------
    printCinco:
    cmp numeroCinco, 30h
    jg cincoPositivo
    jl cincoNegativo
    cincoPositivo:
        division numeroCinco, expo2
        print xDos
        jmp salirCinco
    cincoNegativo:
        division numeroCinco, expo2
        print xDos
    salirCinco:
    jmp banderaCinco
    ;-----------------------------------
    printSeis:
    cmp numeroSeis, 30h
    jg seisPositivo
    jl seisNegativo
    seisPositivo:
        print sigMas
        print numeroSeis
        print xUno
        jmp salirSeis
    seisNegativo:
        print numeroSeis
        print xUno
    salirSeis:
    salirMacro: 
ENDM

division MACRO var1, var2;macro que realiza la dividion, hace lo mismo que la de multiplicacion, pero con division
    FINIT
    xor dx, dx
    mov si, offset var1
    mov dl, byte ptr[si]
    mov si, offset numerrr
    sub dx, 48
    mov word ptr[si], dx
    FILD  numerrr

    xor dx, dx
    mov si, offset var2
    mov dl, byte ptr[si]
    mov si, offset numerrr
    mov word ptr[si], dx
    FILD numerrr

    FDIV
    FISTP numerrr

    mov si, offset numerrr
    mov bx, word ptr[si]
    mov si, offset numer2
    call pImprimirEnteroSigno
    print numer2
ENDM

impFuncion MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis;macro que recibe los 5 coeficientes e imprime la integral almacenada
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco,  unoPositivo, unoNegativo, dosPositivo, dosNegativo,tresPositivo, tresNegativo, cuatroPositivo, cuatroNegativo, cincoPositivo, cincoNegativo, seisPositivo, seisNegativo, seisPositivo, seisNegativo, salirUno, salirDos, salirTres, salirCuatro, salirCinco, salirSeis, salirMacro, banderin
    mov numedos,0
    banderin:;Recibo los numeros y comparo con 0 si son diferentes de cero, hago su funcion.
        mov numerrrou, '$'
        mov numerrrou, '$'
        mov numerrrou, '$'
        cmp numeroUno, 30h
        jne printUno
        bandera:
        cmp numeroDos, 30h
        jne printDos
        banderaDos:
        cmp numeroTres, 30h
        jne printTres
        banderaTres:
        cmp numeroCuatro, 30h
        jne printCuatro
        banderaCuatro:
        cmp numeroCinco, 30h
        jne printCinco
        banderaCinco:
        cmp numeroSeis, 30h
        jne printSeis
        jmp salirMacro
        ;----------------------------------------
        printUno:
        cmp numeroUno, 30h
        jg unoPositivo
        jl unoNegativo
        unoPositivo:;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            multiplicacion2 numeroUno, expo0
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirUno
        unoNegativo:
            
        salirUno:
        jmp bandera
        ;-------------------------
        printDos:
        cmp numeroDos, 30h
        jg dosPositivo
        jl dosNegativo
        dosPositivo:
            multiplicacion2 numeroDos, expo0;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirDos
        dosNegativo:
            
        salirDos:
        jmp banderaDos
        ;-----------------------------------
        printTres:
        cmp numeroTres, 30h
        jg tresPositivo
        jl tresNegativo
        tresPositivo:
            multiplicacion2 numeroTres, expo0;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirTres
        tresNegativo:
            
        salirTres:
        jmp banderaTres
        ;-------------------------
        printCuatro:
        cmp numeroCuatro, 30h
        jg cuatroPositivo
        jl cuatroNegativo
        cuatroPositivo:
            multiplicacion2 numeroCuatro, expo0;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirCuatro
        cuatroNegativo:
            
        salirCuatro:
        jmp banderaCuatro
        ;--------------------------------
        printCinco:
        cmp numeroCinco, 30h
        jg cincoPositivo
        jl cincoNegativo
        cincoPositivo:
            multiplicacion2 numeroCinco, expo0;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirCinco
        cincoNegativo:
            
        salirCinco:
        jmp banderaCinco
        ;-----------------------------------
        printSeis:
        cmp numeroSeis, 30h
        jg seisPositivo
        jl seisNegativo
        seisPositivo:
            multiplicacion2 numeroSeis, expo1;multiplico el numero por el contador que llevo y luego lo sumo a mi acomulador para sacar el punto final
            mov si, word ptr[numerrrou]
            mov ax, word ptr[si]
            add ax, bx
            mov word ptr[si], ax
            jmp salirSeis
        seisNegativo:
            
        salirSeis:
        ; print numedos
        ; print numerrrou
        ; print xCinco
        mov si, word ptr[numerrrou];recibo la suma de las multiplicaciones y le quito 36 no se porque le pone 36 pero se los quito
        mov ax, word ptr[si]
        sub ax, 36
        mov word ptr[si], ax

        ; mov si, offset numerrrou
        ; mov bx, word ptr[si]
        ; mov si, offset numedo
        ; call pImprimirEnteroSigno

        ; print numedo
        ; mov al,04h
        ; xor dx, dx
        ; xor ax, ax
        ; xor bx,bx
        ; xor cx, cx

        ; mov si, offset numedos
        ; mov bx, word ptr[si]
        ; mov si, offset numeTres
        ; call pImprimirEnteroSigno

        ; print numedo
        ; print numeTres
        ; print xSeis
        xor dx, dx
        xor ax, ax
        xor bx,bx
        xor cx, cx

        mov si, word ptr[numerrrou]
        mov ax, word ptr[si]
        add ax, 0160h
        mov word ptr[si], ax;le sumo 160 a la coordenada para hacerlo del centro en adelante

        xor ax, ax

        mov si, word ptr[numedos]
        mov ax, word ptr[si]
        add ax, 0100h;le sumo 100 a la coordenada para hacerlo del centro en adelante
        mov word ptr[si], ax
        ; -------------------------------
        ; mov si, offset numedo
        ; mov bx, word ptr[si]
        ; mov si, offset numedos
        ; call pImprimirEnteroSigno
        ; xor dx, dx
        ; xor ax, ax
        ; xor bx,bx
        ; xor cx, cx
        ; mov si, offset numerrrou
        ; mov bx, word ptr[si]
        ; mov si, offset numeTres
        ; call pImprimirEnteroSigno


        xor dx, dx
        xor ax, ax
        xor bx,bx
        xor cx, cx

        mov si, word ptr[numedos]
        mov ax, word ptr[si]
        mov cx, ax;muevo mi coordenada x

        xor ax, ax 

        mov si, word ptr[numerrrou]
        mov ax, word ptr[si]
        mov dx, ax;muevo mi coordenada y
        
        xor ax, ax
        
        mov ah, 0ch;pongo el modeo video
        mov al, 04h;pongo el color rojo para el punto
        int 10h;pinto el punto
        inc numedos
        inc expo0
        cmp expo0,0004h
        jne banderin
    salirMacro: 
    
ENDM

ejes MACRO
    LOCAL linea, linea2
    xor dx,dx
    xor cx,cx
    xor ax,ax
    xor bx,bx
    mov ah,0ch
    mov al,0fh
    mov cx, 160
    mov dx,0
    int 10h
    linea:
        inc dx
        int 10h
        cmp dx,200
        jne linea
    mov cx, 0
    mov dx,100
    int 10h
    linea2:
        inc cx
        int 10h
        cmp cx,320
        jne linea2
ENDM

onVideo MACRO
    xor ax,ax;limpiamos los registros
    xor bx,bx
    xor cx,cx
    xor dx,dx
    mov ah,0;para activar el modo video
    mov al,13h;que sea pantalla negra
    int 10h; activamos el modo video
    mov ax,0A000h;para acceder a los registros extra
    mov es,ax
ENDM

offVideo MACRO
    mov ax, 0003h
    int 10h
ENDM

menusSecundario MACRO;macro que mantiene el menu y lo repite en loop
    menuSecundario:;imprimo todas las opciones del menu
        textos2
        leerchar;leo el caracter que introducen
        cmp aL, 31h;compruebo si el caracter es igual a 31h que es el codigo hexadecimal del numero 1 en ascii
        je opcionUno2;uso el jmp equals para ver si es igual y sí si, pues entro en la etiqueta
        cmp aL, 32h
        je opcionDos2
        cmp aL, 33h
        je opcionTres2
        cmp aL, 38h;Si eligen 8, salgo del programa
        je salir2
        jmp menuSecundario;vuelvo a poner el menu principal si ponen algun caracter que no es los que considere
    opcionUno2:;etiquetas de las opciones, me manda a su macro especial
        trabajoCinco
        print backMenu
        leerchar;al terminar el trabajo de la macro debo dar alguna tecla para volver al menu
        limpiar
        jmp menuSecundario
    opcionDos2:
        trabajoCinco
        print backMenu
        leerchar
        limpiar
        jmp menuSecundario
    opcionTres2:
        trabajoCinco
        print backMenu
        leerchar
        limpiar
        jmp menuSecundario
    salir2:;Todo lo que va en salir es para finalizar el programa
        limpiar
ENDM