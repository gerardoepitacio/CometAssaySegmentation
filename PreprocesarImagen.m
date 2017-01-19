function [Filtrada, Gris] = PreprocesarImagen(ImagenRGB)
% Funcion PreprocesarImagen: Realiza el proceso de filtrado a la imagen
% rgb.
Gris = rgb2gray(ImagenRGB);
Filtrada = imfilter(Gris,fspecial('average', 11));
end

