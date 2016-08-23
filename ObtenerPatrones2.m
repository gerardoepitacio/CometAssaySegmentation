function [paterns,Img] = ObtenerPatrones2(GrayImage, h, w)
% ObtenerPatrones2 Version optimizada para obtener patrones.
% Patrones = ObtenerPatrones(GrayImage, h, w);
% Donde:
% GrayImage Es una imagen en escala de grises.
% h         Es la altura o la cantidad de filas de la imagen.
% w         Es el ancho de la imagen o la cantidad de columnas.
%
% Patrones  Es una matriz (h*w)x3 de la siguiente forma
%
% [ValorDeBrillo     11x11std     11x11]
%               .
%               .
%               .

    GrayImage = im2double(GrayImage);
    GrayImage = imadjust(GrayImage, [min(GrayImage(:)), max(GrayImage(:))], [0 1]);
    stdImg = stdfilt(GrayImage, ones(11, 11));
    medImg = medfilt2(GrayImage, [11 11]);
    figure('Name', 'medfilt2'),imshow(medImg);
    tam = h*w;
    Img = [];
    paterns = zeros(tam, 3);
    k = 1;
    for i = 1 : h, 
        for j = 1 : w,  
            paterns(k, 1) = GrayImage(i,j);
            paterns(k, 2) = stdImg(i,j);
            paterns(k, 3) = medImg(i,j);
            k = k+1;
        end
    end
end