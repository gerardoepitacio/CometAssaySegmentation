function Img = ObtenerRegiones(Clases, Centro,m, n)
% ObtenerRegiones, devuelve las regiones de una imagen a partir de la
% matriz de pertenencia y la matriz de centroides devueltos del algoritmo
% de clustering Fuzzy C-Means
% Img = ObtenerRegiones(Clases, Centro,m, n)
% Donde: 
% Clases: Es la matriz de grados de pertenencia.
% Centro: Es la matriz que contiene los patrones centroides.
% m:      Numero de filas de la imagen.
% n:      Numero de columnas en la imagen.
% La matriz de clases es ordenada respecto al valor de brillo de la matriz
% de centroides, para asegurarse que las clases devueltas se obtienen
% en funcion del brillo, es decir a menor clase, menor brillo tiene la
% imagen. 
    Img = uint8(zeros(m,n,3));
    k = 1;
    Clases(:,m*n+1)= Centro(:,1);
    B = sortrows(Clases,m*n+1);
    B(:,m*n+1) = [];
    for i = 1 : m
        for j = 1 : n
           Clase =  ObtenerClase(B(:,k));
          switch Clase
           case 1
             % img(i,j) = (Centro(1,1));
              Img(i,j,:) = [0 0 0];
           case 2
            %img(i,j) = (Centro(2,1));
            Img(i,j,:) = [0 255 0];
          case 3
             %img(i,j) = (Centro(3,1));
             Img(i,j,:) = [0 0 255];
          case 4
             %img(i,j) = (Centro(4,1));
             Img(i,j,:) = [255 0 0];
          end
            k=k+1;
        end
    end
end

