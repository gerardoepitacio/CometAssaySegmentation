function [Img, Areas] = ObtenerRegiones(Clases, Centro,m, n)
% Funcion ObtenerRegiones: Devuelve las regiones de una imagen a partir de 
% la matriz de pertenencia y la matriz de centroides devueltos del
% algoritmo de clustering Fuzzy C-Means.
%
% [Img, Areas] = ObtenerRegiones(Clases, Centro,m, n)
% Donde: 
% Img:      Imagen RGB con las regiones segmentada
% Areas:    El conteo total de pixeles, Total en la region, Total en el
%           fondo, Nucleo, Halo y Cola.
%
% Clases: Es la matriz de grados de pertenencia.
% Centro: Es la matriz que contiene los patrones centroides.
% m:      Numero de filas de la imagen.
% n:      Numero de columnas en la imagen.
%
% La matriz de clases es ordenada respecto al valor de brillo de la matriz
% de centroides, para asegurarse que las clases devueltas se obtienen
% en funcion del brillo, es decir a menor clase, menor brillo tiene la
% imagen. 
    Img = uint8(zeros(m,n,3));
    k = 1;
    Clases(:,m*n+1)= Centro(:,1);
    B = sortrows(Clases,m*n+1);
    B(:,m*n+1) = [];
    
    Total = m*n;
    BG = 0;
    Nucleo = 0;
    Halo = 0;
    Cola = 0;
    for i = 1 : m
        for j = 1 : n
           Clase =  ObtenerClase(B(:,k));
          switch Clase
           case 1
              Img(i,j,:) = [0 0 0];
              BG = BG + 1;
           case 2
            Img(i,j,:) = [0 255 0];
            Cola = Cola + 1;
          case 3
             Img(i,j,:) = [0 0 255];
             Halo = Halo + 1;
          case 4
             Img(i,j,:) = [255 0 0];
             Nucleo = Nucleo + 1;
          end
            k=k+1;
        end
    end
    Areas = {'FCM', Total, BG, Nucleo, Halo, Cola};
end

