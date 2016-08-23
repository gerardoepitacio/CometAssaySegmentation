function Img = ObtenerKRegiones(ctrs, cidx, m, n)
% ObtenerKRegiones, devuelve las regiones de una imagen a partir del vector
% de indices generado por el algoritmo de clustering K-Means.

% Img = ObtenerKRegiones(ctrs, cidx, m, n)
% Donde: 
% ctrs:   Es la matriz de centroides de cada clase.
% cidx:   Es el vector que contiene los indices de clase a los que
% pertenece cada patron.
% m:      Numero de filas de la subimagen.
% n:      Numero de columnas en la subimagen.
% la columna de brillo de cada vector centroide es obtenida y ordenada para
% poder corresponder un indice de clase a un valor de brillo y en
% consecuencia a una region.
    VectorBrillo = ctrs(:, 1);
    VectorBrilloOrd = sortrows(VectorBrillo, 1);
    Img = uint8(zeros(m, n, 3));
    k = 1;
    for i = 1 : m
        for j = 1 : n
           KIdx = cidx(k,1);
           Clase = ObtenerKClase(KIdx, VectorBrillo, VectorBrilloOrd);
          switch Clase
              case 1
                  Img(i,j,:) = [0 0 0];
              case 2
                  Img(i,j,:) = [0 255 0];
              case 3
                  Img(i,j,:) = [0 0 255];
              case 4
                  Img(i,j,:) = [255 0 0];
          end
            k=k+1;
        end
    end
end

