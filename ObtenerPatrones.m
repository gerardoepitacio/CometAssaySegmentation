function Patrones = ObtenerPatrones(Imagen, h, w)
% Funcion ObtenerPatrones: Devuelve los patrones de la imagen en escala 
% de grises.
%
% Donde:
% Imagen    Es una imagen en escala de grises.
% h         Es la altura o la cantidad de filas de la imagen.
% w         Es el ancho de la imagen o la cantidad de columnas.
%
% Patrones  Es una matriz (h*w)x3 de la siguiente forma
%
% [ValorDeBrillo     11x11std     11x11mean]
%               .
%               .
%               .
    Imagen = im2double(Imagen);
    Imagen = imadjust(Imagen, [min(Imagen(:)), max(Imagen(:))], [0 1]);
    stdImg = stdfilt(Imagen, ones(11, 11));
    tam = h*w;
    Img = double(zeros(h, w));
    Respuesta = padarray(Imagen,[5 5], 0);
    [h, w] = size(Respuesta);
    Patrones = zeros(tam, 3);
    k = 1;
    
    for i = 1 : h-10, 
        for j = 1 : w-10,  
            SumM = Respuesta(i:i+10,j:j+10);
            Patrones(k, 1) = Respuesta(i+5,j+5);
            Patrones(k, 2) = stdImg(i,j);
            Patrones(k, 3) = mean2(SumM);
            Img(i, j) = Patrones(k, 1);
            k = k+1;
        end
    end
end