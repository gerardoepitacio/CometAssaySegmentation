function [Filtrada, Gris] = PreprocesarImagen(ImagenRGB)
% Funcion PreprocesarImagen: Realiza el proceso de filtrado a la imagen
% RGB recibida.
Gris = rgb2gray(ImagenRGB);
% R = double(ImagenRGB(:, :, 1));
% G = double(ImagenRGB(:, :, 2));
% B = double(ImagenRGB(:, :, 3));
% Gris = uint8((R + G + B ) / 3.0);
Filtrada = imfilter(Gris,fspecial('average', 11));
end

