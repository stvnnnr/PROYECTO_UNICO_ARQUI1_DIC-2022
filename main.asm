include macros.asm;copia lo del archivo de macros
;---------------------------------------------------------------------------------------------------------------------
.model small;Encargado de establecer el tamaño de memoria que usaremos, en este caso small.

.stack;Proporciona al procesador el tamaño de la pila.

.data;Segmento donde estableces los espacios de memoria y las variables a utilizar.

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
respuesta db 0ah,0dh,'Esta es tu ecuacion almacenada: ','$'

xCinco db 'x^5 ','$'
xCuatro db 'x^4 ','$'
xTres db 'x^3 ','$'
xDos db 'x^2 ','$'
xUno db 'x ','$'
sigMas db '+','$'


;Variables donde almacenare los coeficientes de la ecuacion
coeCinco db 2 dup('$'),'$'
coeCuatro db 2 dup('$'),'$'
coeTres db 2 dup('$'),'$'
coeDos db 2 dup('$'),'$'
coeUno db 2 dup('$'),'$'
coeCero db 2 dup('$'),'$'


.code;Segmento de todo el codigo o bien el conocido main.

main PROC;Inicio de mi clase main.
    menu;Mi metodo menu principal
main ENDP;Fin de mi clase main.

end main;marca el final del archivo y donde debe iniciar, en nuestro caso en main.