clear
clc
clear all
close all
%% Select Image and thresholding.
[FileNames, FilePath] = ReadFile();
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
end
bw = im2bw(f1);
%% Image regions and comets segmentation.
s = regionprops(bw, 'all')

box = cat(1, s.BoundingBox);
[boxLen col] = size(box);    
for p = 1 : boxLen
    Roi = s(p);
    %figure,imshow(Roi.Image);
    [height, width] = size(Roi.Image);
    YFrontCentroid = GetYFrontCentroid(Roi.Image)
    YFrontCentroid = round(YFrontCentroid)
    RegionImage = Roi.Image;
    
    [rows cols] = size(RegionImage)
    
     ResultImage=zeros(rows,cols,3); %initialize
     ResultImage(:,:,1)  = RegionImage;
     ResultImage(:,:,2)  = RegionImage;
     ResultImage(:,:,3)  = RegionImage;
     whos ResultImage
     ResultImage=im2uint8(ResultImage);
     whos ResultImage
     %contador=0;
    for i = 1 : (cols*0.3)
        %contador = contador + 1
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
    
end
    
% box = cat(1, s.BoundingBox);
% [boxLen col] = size(box);
% centroids = cat(1, s.Centroid);
% 
% BW2 = bwperim(bw,8);
% imshowpair(bw,BW2,'montage')

%% Labeling.
% figure,imshow(bw);

%CONVEX HULL
% [y, x] = find(bw);
% k = convhull(x, y);
% hold on
% plot(x, y, 'white')
% plot(x(k), y(k), 'r', 'LineWidth', 4)
% hold off

% hold on
% plot(centroids(:,1), centroids(:,2), 'b*')
% [boxLen col] = size(box);
% for i = 1 : boxLen
% rectangle('Position', box(i,:), 'EdgeColor', 'red');
% end
% hold off


% figure,imshow(bw);
% hold on
% [boxLen col] = size(box);
% for i = 1 : boxLen
% rectangle('Position', box(i,:), 'EdgeColor', 'red');
% end
% hold off
