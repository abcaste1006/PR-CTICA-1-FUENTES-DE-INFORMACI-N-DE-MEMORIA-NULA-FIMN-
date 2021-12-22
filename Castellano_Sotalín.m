clc;
clearvars;
close all;

fprintf("FIMN\n");
q=input("Ingrese el número de símbolos de la fuente: ");
fprintf("Ingrese los símbolos del alfabeto\n");
%%preasigno/inicio el array alfabeto y lo leo con un for
%La lectura de datos se realiza con enter, uno por línea
alfabeto=strings(10);
for i=1:q
    alfabeto(i)=input("",'s');
end
%inicio el arrays de probabilidades, uno para los símbolos y otro para los
%valores, luego leo el de símbolos y mediante str2sym lo paso a valor
suma_probabilidades=0;
while suma_probabilidades~=1
    suma_probabilidades=0;
    fprintf("Ingrese probabilidades\n");
    probabilidadstring=strings(10);
    probabilidadvalor=zeros(10);
    for i=1:q
        probabilidadstring(i)=input("",'s');
        probabilidadvalor(i)=str2sym(probabilidadstring(i));
        suma_probabilidades=suma_probabilidades+probabilidadvalor(i);
    end
    if(suma_probabilidades~=1)
        fprintf("Las probabilidades no suman 1\n");
    end
end   
%declaro un valor flag para saber cuando terminar el bucle del menú
%Limpio la pantalla e imprimo el menu
%es importante que el valor de prueba del switch sea un char
% tambíen se debe tener cuidado de poner pause() para q espere antes de
% volver al menú
flag=11;
while flag~=0
    clc
    fprintf("\t\t\t\t\t\tMenú\n\n");
    fprintf("a.- Cantidad de información de cualquier símbolo del alfabeto fuente\n");
    fprintf("b.- Cantidad de información de un grupo de símbolos del alfabeto\n");
    fprintf("c.- Entropía de la FIMN\n");
    fprintf("d.- Máxima entropía de la FIMN\n");
    fprintf("e.- Entropía de la extensión de orden n de la fuente original\n");
    fprintf("f.- Alfabeto fuente extendido del literal anterior\n");
    fprintf("g.- Entropía máxima de la fuente extendida\n");
    fprintf("s.- Salir\n");
    opcion=input("\nElija una opción del menu\n",'s');
    switch opcion
        case 'a'
            var1=input("Ingrese el número del símbolo del que desea conocer información, o 0 para mostrar la de todos los símbolos\n",'s');
            switch var1
                case {'1','2','3','4','5'}
                    cantidad_infoB=cantidaddeinformacion('2',probabilidadvalor(str2sym(var1)));
                    fprintf("El símbolo %s tiene %.2f[bits], %.2f[nats], %.2f[Hartleys]\n",var1,cantidad_infoB,cantidad_infoB/1.44,cantidad_infoB/3.32);
                    fprintf("Presione ENTER para continuar");
                    pause();
                case '0'
                    
                    fprintf("\t\t\t\t\t\tTabla de resumen de cantidad de información\n")
                    fprintf("Símbolo N:\t\tProbabilidad\t\tbits\t\tnats\t\tHartleys\n");
                    for i=1:q
                        cantidad_infoB=cantidaddeinformacion('2',probabilidadvalor(i));
                        fprintf('%s\t\t\t\t%s\t\t\t\t%.2f\t\t%.2f\t\t%.2f\n',alfabeto(i),probabilidadstring(i),cantidad_infoB,cantidad_infoB/1.44,cantidad_infoB/3.32);
                    end
                    fprintf("Presione ENTER para continuar");
                    pause();
                    
            end
            
        case 'b'
            fprintf("Ingrese la secuencia del grupo de símbolos a operar en formato de número y usando ENTER, pulse 0 para terminar la secuencia\n");
            flag2=1;
            grupo_simbolos=zeros(20);
            i=1;
            while flag2~=0
                grupo_simbolos(i)=input("");
                flag2=grupo_simbolos(i);
                i=i+1;
            end
            i=i-2;
            fprintf("La secuencia de símbolos ingresada es: ");
            for k=1:i
                fprintf("%s, ",alfabeto(grupo_simbolos(k)));
            end
            Cantidad_info_grupo=0;
            for j=1:i
                Cantidad_info_grupo=Cantidad_info_grupo+cantidaddeinformacion('2',probabilidadvalor(grupo_simbolos(j)));
            end
            fprintf("\nLa cantidad de información para el grupo ingresado es: %.2f[bits], %.2f[nats], %.2f[Hartleys]\n",Cantidad_info_grupo,Cantidad_info_grupo/1.44,Cantidad_info_grupo/3.32);
            fprintf("Presione ENTER para continuar");
            pause();
        case 'c'
            entropia_fimn=0;
            for i=1:q
                entropia_fimn=entropia_fimn+probabilidadvalor(i)*log2(1/probabilidadvalor(i));
            end
            fprintf("La entropía de la FIMN es: %.2f[bits/símbolo], %.2f[nats/símbolo], %.2f[Hartleys/símbolo]\n",entropia_fimn,entropia_fimn/1.44,entropia_fimn/3.32);
            fprintf("Presione ENTER para continuar");
            pause();
        case 'd'
            entropia_max=log2(q);
            fprintf("La máxima entropía de la FIMN es: %.2f[bits/símbolo], %.2f[nats/símbolo], %.2f[Hartleys/símbolo]\n",entropia_max,entropia_max/1.44,entropia_max/3.32);
            fprintf("Presione ENTER para continuar");
            pause();
        case 'e'
            n=input("Ingrese el valor n, es decir el orden de la extensión:\n");
            entropia_fimn=0;
            for i=1:q
                entropia_fimn=entropia_fimn+probabilidadvalor(i)*log2(1/probabilidadvalor(i));
            end
            entropia_ext=n*entropia_fimn;
            fprintf("La entropía de la extensión de orden %d de la FIMN es: %.2f[bits/símbolo]\n",n,entropia_ext);
            fprintf("Presione ENTER para continuar");
            pause();
        case 'f'
            clc
            total_ext=q^n;
            combinacion_probabilidades=zeros(total_ext);
            switch n
                case 1
                    for t=1:total_ext
                        combinacion_probabilidades(t)=probabilidadvalor(t);
                    end
                case 2
                    for t=1:total_ext
                        combinacion_probabilidades(t)=probabilidadvalor(t);
                    end
                case 3
            end
            
            if total_ext>16
                %casos donde la fuente extendida tiene q>16
                %casos donde la fuente extendida tiene q múltiplo de 3
                if mod(total_ext/3,1)==0
                    for m=1:floor(total_ext/3)
                        fprintf("%d s1s1s1 %.2f\t\t\t\t%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\n",m,1,m+floor(total_ext/3),m+2*floor(total_ext/3));
                    end
                else
                    %casos donde la fuente extendida tiene q no múltiplo de
                    %3 y se tendría que imprimir un caso más
                    if mod(total_ext/3,1)<0.5
                        for m=1:floor(total_ext/3)
                            fprintf("%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\n",m,m+floor(total_ext/3),m+2*floor(total_ext/3));
                        end
                        fprintf("%d s1 000 s1s1s1 1/14\n",total_ext);
                        %casos donde la fuente extendida tiene q no múltiplo de
                        %3 y se tendría que imprimir dos casos más
                    else
                        for m=1:floor(total_ext/3)
                            fprintf("%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\n",m,m+floor(total_ext/3),m+2*floor(total_ext/3));
                        end
                        fprintf("%d s1 000 s1s1s1 1/14\t\t\t\t%d s1 000 s1s1s1 1/14\n",total_ext-1,total_ext);
                    end
                end
            else
                %casos donde la fuente extendida tiene q<16
                for m=1:total_ext
                    fprintf("%d s1 000 s1s1s1 1/14\n",m);
                end
            end
            fprintf("Presione ENTER para continuar");
            pause();
        case 'g'
            %%es importante que primero se realice el literal "e"
            entropia_max_ext=log2(q^n);
            fprintf("La máxima entropía de la extensión de orden %d de la FIMN es: %.2f[bits/símbolo]\n",n,entropia_max_ext);
            fprintf("Presione ENTER para continuar");
            pause();
        case 's'
            flag=0;
    end
end
fprintf("Terminado\n");
return
















function resultado=cantidaddeinformacion(base,probabilidad)
%funcion que permite calcular la cantidad de informacion del símbolo,
%permite insertar la base deseada
if nargout>0
    switch base
        case '2'
            resultado=log2(1/probabilidad);
        case 'e'
            resultado=log(1/probabilidad);
        case '10'
            resultado=log10(1/probabilidad);
    end
    
end
end

















