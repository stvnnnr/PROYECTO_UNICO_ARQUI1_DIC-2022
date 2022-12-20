print MACRO entrada;macro para imprimir en consola algun texto
    mov ax,@data
    mov ds,ax
    mov ah,09h
    mov dx, offset entrada
    int 21h;interrupcion para consola
ENDM

leerchar MACRO;macro para leer algun caracter desde el teclado
    mov ah, 01h
    int 21h;interrupcion para consola
ENDM

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
        jmp menuPrincipal
    opcionDos:
        trabajoDos
        print backMenu
        leerchar
        jmp menuPrincipal
    opcionTres:
        trabajoTres
        print backMenu
        leerchar
        jmp menuPrincipal
    opcionCuatro:
        trabajoCuatro
        print backMenu
        leerchar
        jmp menuPrincipal
    opcionCinco:
        trabajoCinco
        print backMenu
        leerchar
        jmp menuPrincipal
    opcionSeis:
        trabajoSeis
        print backMenu
        leerchar
        jmp menuPrincipal
    opcionSiete:
        trabajoSiete
        print backMenu
        leerchar
        jmp menuPrincipal
    salir:;Todo lo que va en salir es para finalizar el programa
        print despedida
        mov ah, 4ch
        xor aL, aL
        int 21h
ENDM



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

trabajoUno MACRO;macro de ingresar ecuacion
    print cadenaCoCinco
    leerTexto coeCinco;almacena cada coeficiente en su variable

    print cadenaCoCuatro
    leerTexto coeCuatro

    print cadenaCoTres
    leerTexto coeTres

    print cadenaCoDos
    leerTexto coeDos

    print cadenaCoUno
    leerTexto coeUno

    print cadenaCoCero
    leerTexto coeCero

    print aceptado
ENDM

trabajoDos MACRO
    comparaCero coeCinco, coeCuatro, coeTres, coeDos, coeUno, coeCero
ENDM

trabajoTres MACRO
    print cadenaExtra
ENDM

trabajoCuatro MACRO
    print cadenaExtra
ENDM

trabajoCinco MACRO
    print cadenaExtra
ENDM

trabajoSeis MACRO
    print cadenaExtra
ENDM

trabajoSiete MACRO
    print cadenaExtra
ENDM

comparaCero MACRO numeroUno, numeroDos, numeroTres, numeroCuatro, numeroCinco, numeroSeis
    LOCAL printUno, printDos, printTres, printCuatro, printCinco, printSeis, salirMacro, bandera, banderaDos, banderaTres, banderaCuatro, banderaCinco
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