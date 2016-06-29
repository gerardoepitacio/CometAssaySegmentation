function [paterns,Img] = ObtenerPatrones(GrayImage)
    [h, w] = size(GrayImage);
    GrayImage = im2double(GrayImage);
    GrayImage = imadjust(GrayImage, [min(GrayImage(:)), max(GrayImage(:))], [0 1]);
    tam = h*w;
    Img = double(zeros(h, w));
    Respuesta = padarray(GrayImage,[5 5], 0);
    [h, w] = size(Respuesta);
    paterns = zeros(tam, 3);
    k = 1;
    for i = 1 : h-10, 
        for j = 1 : w-10,  
            SumM = Respuesta(i:i+10,j:j+10);
            paterns(k, 3) = mean(SumM(:));
            paterns(k, 2) = std2(SumM);
            paterns(k, 1) = Respuesta(i+5,j+5);
            Img(i, j) = Respuesta(i+5,j+5);
            k = k+1;
        end
    end
end