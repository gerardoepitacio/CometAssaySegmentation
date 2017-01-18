%% Muestra algunos descriptores de una imagen de prueba.
clear
clc
clear all
close all
%% Select Image and thresholding.
FileNames = {'shape2Binary.png'};
FilePath = 'img/other/';
%[FileNames, FilePath] = ReadFile() %Descomentar para seleccionar una imagen
if FilePath == 0
    return;
end
for File=1 : length(FileNames)
    if ischar(FileNames) == 0
        FileName = FileNames{File};
        FullFileName=[FilePath FileNames{File}];
    else
        FileName = FileNames;
        FullFileName=[FilePath FileNames];
    end
    f1 = imread(FullFileName);
    bw = im2bw(f1);
    bw = bwareaopen(bw, 3000);

    %% Image regions and comets segmentation.
    s = regionprops(bw, 'all')
    box = cat(1, s.BoundingBox);
    [boxLen col] = size(box);    
    for p = 1 : boxLen
    Roi = s(p);
    [height, width] = size(Roi.Image);
    YFrontCentroid = GetYFrontCentroid(Roi.Image);
    YFrontCentroid = round(YFrontCentroid);
    RegionImage = Roi.Image;
    [rows cols] = size(RegionImage)
    ResultImage=zeros(rows,cols,3);
    ResultImage(:,:,1)  = RegionImage;
    ResultImage(:,:,2)  = RegionImage;
    ResultImage(:,:,3)  = RegionImage;
    ResultImage=im2uint8(ResultImage);
    for i = 1 : (cols*0.3)
        for j = 1 : rows
            if RegionImage(j, i) ~= 0
                    ResultImage(j, i , 1) = 204;
                    ResultImage(j, i , 2) = 230;
                    ResultImage(j, i , 3) = 255;
                if j == round(YFrontCentroid)
                    ResultImage(j, i , 1) = 255;
                    ResultImage(j, i , 2) = 0;
                    ResultImage(j, i , 3) = 0;
                end
            end
        end
    end
    figure,imshow(ResultImage);
    %% CONVEX HULL
    figure,imshow(bw);
    [y, x] = find(bw);
    k = convhull(x, y);
    hold on
    plot(x, y, 'white')
    plot(x(k), y(k), 'r', 'LineWidth', 4)
    hold off
    end  
    if ischar(FileNames) == 1
break;
    end
end

