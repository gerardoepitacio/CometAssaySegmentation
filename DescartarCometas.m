function Propiedades = DescartarCometas(ImagenRGB, ImgBinaria, Archivo)
% Funcion DescartarCometas(): Obtiene los descriptores de la imagen binaria
% y descarta los cometas que no cumplen con los parametros establecidos.
%
% Donde:
% ImagenRGB:    Es la imagen original RGB
% ImgBinaria:   Es la imagen binaria del proceso anterior al descarte
% Archivo:      Es el nombre del archivo.
    Propiedades = regionprops(ImgBinaria,  'Area', 'BoundingBox', 'Image', ...
     'Solidity');
    figure('NumberTitle', 'off', 'Name', Archivo), imshow(ImagenRGB);
    box = cat(1, Propiedades.BoundingBox);
    ROIs = size(box);
    hold on
    for i = 1 : ROIs
        rectangle('Position', box(i,:), 'EdgeColor', 'red');
    end
    hold off
    fprintf('\n');
    Propiedades = GetComets(Propiedades, Archivo);
end