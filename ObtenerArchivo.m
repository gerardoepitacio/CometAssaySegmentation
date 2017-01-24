function [Ruta, Nombre] = ObtenerArchivo(Indice)
% Funcion ObtenerArchivo: Lee el archivo segun el indice recibido, si
% NombresArchivo no es un arreglo, solo se concatena la ruta base al 
% nombre del archvo.
% 
% Donde:
% Indice:   De donde se obtiene el archivo indica el indice del archivo 
%           del arreglo de archivos leidos.
global NombresArchivo RutaPrincipal;
    if ischar(NombresArchivo) == 0
        Nombre = NombresArchivo{Indice};
        Ruta = [RutaPrincipal Nombre];
    else
        Nombre = NombresArchivo;
        Ruta = [RutaPrincipal NombresArchivo];
    end
end

