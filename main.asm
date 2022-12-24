include macros.asm;copia lo del archivo de macros
;---------------------------------------------------------------------------------------------------------------------
.model small;Encargado de establecer el tamaño de memoria que usaremos, en este caso small.

.stack;Proporciona al procesador el tamaño de la pila.

.data;Segmento donde estableces los espacios de memoria y las variables a utilizar.
;variables auxiliares para las multiplicaciones y divisiones
numerrr dw 2, '$'
numerro dw 0010h, '$'
numer2 dw 2, '$'
numer3 dw ?, '$','$','$','$','$','$'
expo6 db 0006h,'$'
expo5 db 0005h,'$'
expo4 db 0004h,'$'
expo3 db 0003h,'$'
expo2 db 0002h,'$'
;Cadenas que me sirven para el menu
menuTexto db 0ah,0dh,'-----------------Menu Proyecto Unico-----------------:','$'
cadena db 0ah,0dh,'Escoje una opcion:','$'
cadenaDos db 0ah,0dh,'1) Ingresa tu funcion','$'
cadenaTres db 0ah,0dh,'2) Imprimir funcion almacenada','$'
cadenaCuatro db 0ah,0dh,'3) Imprimir la derivada de la funcion almacenada','$'
cadenaCinco db 0ah,0dh,'4) Imprimir la integral de la funcion almacenada','$'
cadenaSeis db 0ah,0dh,'5) Graficar','$'
cadenaSiete db 0ah,0dh,'6) Metodo de Newton','$'
cadenaOcho db 0ah,0dh,'7) Metodo de Steffensen','$'
cadenaNueve db 0ah,0dh,'8) Salir de la aplicacion','$'
cadenaExtra db 0ah,0dh,'Introduce tu numero deseado','$'

cadenaCoCinco db 0ah,0dh,'Introduce tu coeficiente para el exponente 5: ','$'
cadenaCoCuatro db 0ah,0dh,'Introduce tu coeficiente para el exponente 4: ','$'
cadenaCoTres db 0ah,0dh,'Introduce tu coeficiente para el exponente 3: ','$'
cadenaCoDos db 0ah,0dh,'Introduce tu coeficiente para el exponente 2: ','$'
cadenaCoUno db 0ah,0dh,'Introduce tu coeficiente para el exponente 1: ','$'
cadenaCoCero db 0ah,0dh,'Introduce tu coeficiente para el termino constante: ','$'

backMenu db 0ah,0dh,'Presiona cualquier tecla para volver al Menu','$'
despedida db 0ah,0dh,'Gracias por usar mi programa!!','$'
aceptado db 0ah,0dh,'Tu ecuacion fue almacenada',10,13,'$'
respuesta db 0ah,0dh,'Esta es tu ecuacion almacenada: ',10,13,'$'
respuesta2 db 0ah,0dh,'La derivada de tu ecuacion es: ',10,13,'$'
respuesta3 db 0ah,0dh,'La integral de tu ecuacion es: ',10,13,'$'

xSeis db 'x^6 ','$'
xCinco db 'x^5 ','$'
xCuatro db 'x^4 ','$'
xTres db 'x^3 ','$'
xDos db 'x^2 ','$'
xUno db 'x ','$'
sigMas db '+','$'


;Variables donde almacenare los coeficientes de la ecuacion
coeCinco db 2 dup(0),'$'
coeCuatro db 2 dup(0),'$'
coeTres db 2 dup(0),'$'
coeDos db 2 dup(0),'$'
coeUno db 2 dup(0),'$'
coeCero db 2 dup(0),'$'



.code;Segmento de todo el codigo o bien el conocido main.
main PROC;Inicio de mi clase main.
    mov dx, @DATA
    mov ds, dx
    menu;Mi metodo menu principal
main ENDP;Fin de mi clase main.

;procedimiento que convierete ascii en hexadecimales
;en resumen revisa si son negativos o positivos y les add los 48 para que llegue  a hexa, divide en 10 y separa los numeros
pImprimirEnteroSigno proc
    xor cx, cx
    xor di, di
    cmp bx, 0
    je lUnsigned_IntWrite
    cmp bx, 0
    jl lPrint_Minus
    mov byte ptr[si], 43  
    inc si
    neg bx
    jmp lUnsigned_IntWrite
    
    lPrint_Minus:
    mov byte ptr[si], 45
    inc si
    jmp lUnsigned_IntWrite

    lUnsigned_IntWrite:
        neg bx
        mov ax, bx
        mov di, 10
        lLoopWrite:
            xor dx, dx
            div di
            push dx
            inc cx
            cmp ax, 0
            jne lLoopWrite
        
        ConvDesdePila:
            pop dx
            add dx, 48
            mov byte ptr[si], dl
            dec cx
            cmp cx, 00
            je lSalirImprimir
            inc si
            jmp ConvDesdePila

    lSalirImprimir:
    ret
pImprimirEnteroSigno endp
end main;marca el final del archivo y donde debe iniciar, en nuestro caso en main.
