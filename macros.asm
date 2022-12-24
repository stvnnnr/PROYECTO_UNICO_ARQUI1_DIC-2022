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
        trabajoCinco
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
trabajoDos MACRO
    limpiar
    comparaCero coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoTres MACRO
    limpiar
    comparaUno coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoCuatro MACRO
    limpiar
    comparaDos coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM
;
trabajoCinco MACRO
ENDM
;
trabajoSeis MACRO
ENDM
;
trabajoSiete MACRO
ENDM
;
comparaCero MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco,  unoPositivo, unoNegativo, dosPositivo, dosNegativo,tresPositivo, tresNegativo, cuatroPositivo, cuatroNegativo, cincoPositivo, cincoNegativo, seisPositivo, seisNegativo, seisPositivo, seisNegativo, salirUno, salirDos, salirTres, salirCuatro, salirCinco, salirSeis, salirMacro
    print respuesta
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
        print sigMas
        print numeroUno
        print xCinco
        jmp salirUno
    unoNegativo:
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

multiplicacion MACRO var1, var2
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

    FMUL
    FISTP numerrr
    ; xor ax,ax
    ; mov ax, numerrr
    ; mov bx, numerro
    ; div bx
    ; add al,48
    ; mov coco, aL
    ; print coco
    ; add ah,48
    ; mov cucu, ah
    ; print cucu

    mov si, offset numerrr
    mov bx, word ptr[si]
    mov si, offset numer2
    call pImprimirEnteroSigno
    print numer2

    ; ----------------------
    
    mov numerrr, '$'
    mov numer2,'$'
ENDM

comparaUno MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis
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

comparaDos MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis
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

division MACRO var1, var2
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
