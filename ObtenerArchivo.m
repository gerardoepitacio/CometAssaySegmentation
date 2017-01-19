function [Ruta, Nombre] = ObtenerArchivo(RutaBase, NombresArchivo, Indice)
% Funcion ObtenerArchivo: Lee el archivo segun el indice recibido, si
% NombresArchivo no es un arreglo, solo se concatena la ruta base al nombre
% del archvo.
% 
% Donde:
% RutaBase:         Es el folder de donde se obtienen de donde se leen las
%                   imagenes
% NombresArchivos:  Arreglo con los nombres de los archivos.
% Indice de donde se obtiene el archivo.
    if ischar(NombresArchivo) == 0
        Nombre = NombresArchivo{Indice};
        Ruta=[RutaBase Nombre];
    else
        Nombre = NombresArchivo;
        Ruta = [RutaBase NombresArchivo];
    end
end

