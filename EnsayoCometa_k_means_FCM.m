clear
clc
clear all
close all
%% Select Image and thresholding.
[FileNames, FilePath] = ReadFile();
if FilePath == 0
    return;
end

Excel={0,9};
Row = 3;
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
    bwW = bwareaopen(tsd, 5000);
    bw = imclearborder(bwW);
    %% Image regions and comets segmentation.
    s = regionprops(bw,  'Area', 'BoundingBox', 'Image', 'Solidity');
    fprintf('\n');
    
    %% ROIs found
    figure('NumberTitle', 'off', 'Name', FileName),imshow(f1);
    
    hold on
    box = cat(1, s.BoundingBox);
    [boxLen col] = size(box);
    for i = 1 : boxLen
        rectangle('Position', box(i,:), 'EdgeColor', 'red');
    end
    
    s = GetComets(s);
    %% Region Segmentation
    box = cat(1, s.BoundingBox);
    [boxLen col] = size(box);
    %disp(sprintf('%5s%10s%10s%10s%10s%10s%10s', '', 'Area', 'Total', 'BG', 'Nucleo', 'Halo', 'Cola'));
    Excel(Row, 1) = {FileName};
    
    for p = 1 : boxLen
        Excel(Row, 2) = {p};
        
        subImage = imcrop(g, (box(p,:)-1));
        [m, n, c] = size(subImage);
        [Patrones, Img] = ObtenerPatrones(subImage, m, n);
        %% K-MEANS
        tic
        [cidx, ctrs] = kmeans(Patrones, 4);
        Tiempo = toc;
        [img, Areas] = ObtenerKRegiones(ctrs, cidx, m, n);
        
        Excel(Row, 3:8) = Areas;
        Excel(Row, 9) = {Tiempo};
        Row = Row + 1;
        
        %% FUZZY C-MEANS
        opts = [nan;nan;nan;0];
        tic
        [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
        Tiempo = toc;
        [Regiones, Areas]= ObtenerRegiones(U, centers, m, n);
        
        Excel(Row, 2) = {p};
        Excel(Row, 3:8) = Areas;
        Excel(Row, 9) = {Tiempo};
        Row = Row + 1;
        
        %% Showing results
        rectangle('Position', box(p,:), 'EdgeColor', 'green');
        
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
xlswrite('Resultados', Excel);
csvwrite('Patrones', Patrones)