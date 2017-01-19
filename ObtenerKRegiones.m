function [Img, Areas] = ObtenerKRegiones(ctrs, cidx, m, n)
% ObtenerKRegiones: Devuelve las regiones de una imagen a partir del vector
% de indices generado por el algoritmo de clustering K-Means.
%
% [Img, Areas] = ObtenerKRegiones(ctrs, cidx, m, n)
% Donde: 
% Img:      Imagen RGB con las regiones segmentada
% Areas:    El conteo total de pixeles, Total en la region, Total en el
%           fondo, Nucleo, Halo y Cola.
%
% ctrs:     Es la matriz de centroides de cada clase.
% cidx:     Es el vector que contiene los indices de clase a los que
% pertenece cada patron.
% m:        Numero de filas de la subimagen.
% n:        Numero de columnas en la subimagen.
%
% La columna de brillo de cada vector centroide es obtenida y ordenada para
% poder corresponder un indice de clase a un valor de brillo y en
% consecuencia a una region.
    VectorBrillo = ctrs(:, 1);
    VectorBrilloOrd = sortrows(VectorBrillo, 1);
    Img = uint8(zeros(m, n, 3));
    k = 1;
    
    Total = m*n;
    BG = 0;
    Nucleo = 0;
    Halo = 0;
    Cola = 0;
    for i = 1 : m
        for j = 1 : n
           KIdx = cidx(k,1);
           Clase = ObtenerKClase(KIdx, VectorBrillo, VectorBrilloOrd);
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
    Areas = {'K-Means', Total, BG, Nucleo, Halo, Cola};
end

