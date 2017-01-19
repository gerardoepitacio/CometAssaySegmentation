function  Img = ObtenerImagen(Patrones, Descriptor, m, n)
% Funcion ObtenerImagen: Extrae una imagen en escala de grises del arreglo
% de patrones, del descriptor solicitado.
%
% Img = ObtenerImagen(Patrones, Descriptor, m, n)
% Donde:
% Patrones: Es el arreglo de patrones que se utiliza en los algoritmos de
% agrupamiento
% Descriptor: Es un entero [1 3] que indica el descriptor que va a formar
% la imagen en escala de grises.
%             1: Representa el descriptor de brillo del patron.
%             2: Desviacion estandar.
%             3: Promedio
% m: Indica el numero de filas.
% n: Indica el numero de columnas.
Img = double(zeros(m,n));
k=1;
    for i = 1:m
        for j= 1:n  
            Img(i, j) = Patrones(k, Descriptor);
            k = k + 1;
        end
    end
    Img = imadjust(Img, [min(Img(:)), max(Img(:))], [0 1]);
end