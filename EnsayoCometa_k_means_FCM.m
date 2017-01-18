clear
clc
clear all
close all
% Off Warning: Image is too big to fit on screen
warning('off', 'Images:initSize:adjustingMag');
%% Select Image and thresholding.
[FileNames, FilePath] = ReadFile();
if FilePath == 0
    return;
end

Row = 2;
RowFCM = 3;
RowKMeans = 3;
CometsProcessed = 0;
Excel={'Imagen','#', '#Img', 'Algoritmo', 'Pixeles', 'Fondo', 'Núcleo', 'Halo', 'Cola', 'Tiempo'};
%ExcelFCM=[{''}, {'RESULTADOS FCM'}];
ExcelFCM(2, 1:10) = {'RESULTADOS FCM','#', '#', 'Algoritmo', 'FCM', 'FCM', 'FCM', 'FCM', 'FCM', 'FCM'};
%ExcelKMeans=[{''}, {'RESULTADOS KMEANS'}];
ExcelKMeans(2, 1:10) = {'RESULTADOS K-Means','#', '#', 'Algoritmo', 'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means'};

for File=1 : length(FileNames)
    if ischar(FileNames) == 0
        FileName = FileNames{File};
        FullFileName=[FilePath FileNames{File}];
    else
        FileName = FileNames;
        FullFileName=[FilePath FileNames];
    end
    f1 = imread(FullFileName);
    %% Preprocessing
    g = rgb2gray(f1);
    filtro = 'average';
    f = imfilter(g,fspecial(filtro, 11));
    %% thresholding
    tsd = localthresh(f, ones(3), 1, 1.1, 'global');
    %bwW = bwareaopen(tsd, 400);
    %bwW = bwareaopen(tsd, 5000);
    bwW = bwareaopen(tsd, 3000);
    bw = imclearborder(bwW);
    %% Image regions and comets segmentation.
    s = regionprops(bw,  'Area', 'BoundingBox', 'Image', 'Solidity');
    fprintf('\n');
    
    %% ROIs found and image log
    figure('NumberTitle', 'off', 'Name', FileName),imshow(f1);
    
    hold on
    box = cat(1, s.BoundingBox);
    ROIs = size(box);
    for i = 1 : ROIs
        rectangle('Position', box(i,:), 'EdgeColor', 'red');
    end
    
    s = GetComets(s, FileName);
    %% Region Segmentation
    box = cat(1, s.BoundingBox);
    [Comets col] = size(box);
    Excel(Row, 1) = {FileName};
    ExcelFCM(RowFCM, 1) = {FileName};
    ExcelKMeans(RowKMeans, 1) = {FileName};
    for p = 1 : Comets
        CometsProcessed = CometsProcessed + 1;
        Excel(Row, 2) = {p};
        Excel(Row, 3) = {CometsProcessed};
        subImage = imcrop(g, (box(p,:)-1));
        [m, n, c] = size(subImage);
        [Patrones, Img] = ObtenerPatrones(subImage, m, n);
        %% K-MEANS
        tic
        [cidx, ctrs] = kmeans(Patrones, 4);
        Tiempo = toc;
        [img, Areas] = ObtenerKRegiones(ctrs, cidx, m, n);
        
        Excel(Row, 4:9) = Areas;
        Excel(Row, 10) = {Tiempo};
        ExcelKMeans(RowKMeans, 2:10) = Excel(Row, 2:10); 
        Row = Row + 1;
        RowKMeans = RowKMeans + 1;
        %% FUZZY C-MEANS
        opts = [nan;nan;nan;0];
        tic
        [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
        Tiempo = toc;
        [Regiones, Areas]= ObtenerRegiones(U, centers, m, n);
        
        Excel(Row, 2) = {p};
        Excel(Row, 3) = {CometsProcessed};
        Excel(Row, 4:9) = Areas;
        Excel(Row, 10) = {Tiempo};
        ExcelFCM(RowFCM, 2:10) = Excel(Row, 2:10); 
        Row = Row + 1;
        RowFCM = RowFCM + 1;
        %% Mostrando resultados
        % Rectangulo sobre la imagen actual.
        rectangle('Position', box(p,:), 'EdgeColor', 'green');
        text(box(p,1)+7, box(p,2)+20, sprintf('%d', CometsProcessed), 'Color', 'green', 'FontSize', 14);
        
        %Regiones FCM y K-means.
% %         figure('NumberTitle', 'off', 'Name',[num2str(File) '-' num2str(p) ' K-Means & FCM'])
% %         subplot(1,2,1), subimage(img)
% %         title('K-Means')
% %         subplot(1,2,2), subimage(Regiones)
% %         title('FCM')

    end
    hold off
    if ischar(FileNames) == 1
        break;
    end
end
Comets= CometsProcessed+2;
Validacion(1,1:10) = {'Background', '', 'Nucleo', '', 'Halo', '', 'Cola', '', 'Tiempo', ''};
Validacion(2:Comets,1:10) = [...
    ExcelKMeans(2:Comets,6) ExcelFCM(2:Comets,6) ...
    ExcelKMeans(2:Comets,7) ExcelFCM(2:Comets,7) ...
    ExcelKMeans(2:Comets,8) ExcelFCM(2:Comets,8) ...
    ExcelKMeans(2:Comets,9) ExcelFCM(2:Comets,9) ...
    ExcelKMeans(2:Comets,10) ExcelFCM(2:Comets,10)];
Resultados = [Excel ; ExcelKMeans ; ExcelFCM ; Validacion];
if exist('Resultados.xls', 'file')==2
  delete('Resultados.xls');
end
if exist('Patrones.xls', 'file')==2
  delete('Patrones.xls');
end
xlswrite('Resultados', Resultados);
csvwrite('Patrones', Patrones)