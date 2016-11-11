function [paterns,Img] = ObtenerPatrones(GrayImage, h, w)
    GrayImage = im2double(GrayImage);
    GrayImage = imadjust(GrayImage, [min(GrayImage(:)), max(GrayImage(:))], [0 1]);
    stdImg = stdfilt(GrayImage, ones(11, 11));
    %meanImg = medfilt2(GrayImage, [11 11]);
    tam = h*w;
    Img = double(zeros(h, w));
    %Img = [];
    Respuesta = padarray(GrayImage,[5 5], 0);
    [h, w] = size(Respuesta);
    paterns = zeros(tam, 3);
    k = 1;
    
% %     %%  Parametros de los patrones obtenidos de matrices.
% %     for i = 1 : h, 
% %         for j = 1 : w,  
% %             paterns(k, 3) = meanImg(i,j);
% %             paterns(k, 2) = stdImg(i,j);
% %             paterns(k, 1) = GrayImage(i,j);
% %             k = k+1;
% %         end
% %     end

% % disp(sprintf('%-20s%-20s%-20s', 'ValorBrillo', 'DesvStd', 'Promedio'));

    for i = 1 : h-10, 
        for j = 1 : w-10,  
            SumM = Respuesta(i:i+10,j:j+10);
            paterns(k, 3) = mean2(SumM);
            %paterns(k, 2) = std2(SumM);
            paterns(k, 2) = stdImg(i,j);
            paterns(k, 1) = Respuesta(i+5,j+5);
            %Img(i, j) = Respuesta(i+5,j+5);
            Img(i, j) = paterns(k, 3);
            
% %             Log = sprintf('%-20d', paterns(k, 1));
% %             Log = [Log sprintf('%-20d', paterns(k, 2))];
% %             Log = [Log sprintf('%-20d', paterns(k, 3))];
% %             
            k = k+1;
% %             disp(Log);
        end
    end
    %figure('Name', 'filtrado'),imshow(Img);
end