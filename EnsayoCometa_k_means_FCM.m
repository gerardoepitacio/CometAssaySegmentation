clear
clc
clear all
%close all
%% Select Image and thresholding.
[FileNames, FilePath] = ReadFile();
if FilePath == 0
    return;
end
for File=1 : length(FileNames)
FullFileName=[FilePath FileNames{File}];
f1 = imread(FullFileName);
%% Preprocessing
g = rgb2gray(f1);
filtro = 'average';
f = imfilter(g,fspecial(filtro, 11));
%% thresholding
tsd = localthresh(f, ones(3), 1, 1.1, 'global');
bwW = bwareaopen(tsd, 5000);
bw = imclearborder(bwW);
%% Image regions and comets segmentation.
s = regionprops(bw, 'all');
s = GetComets(s);
box = cat(1, s.BoundingBox);
[boxLen col] = size(box);
centroids = cat(1, s.Centroid);
for p = 1 : boxLen
    subImage = imcrop(g, (box(p,:)-1));
    %subImage(~s(i).Image) = 0;     %crop with binary image shape
    [m, n, c] = size(subImage);
    [Patrones, Img] = ObtenerPatrones(subImage, m, n);
    %% K-MEANS
    [cidx, ctrs] = kmeans(Patrones, 4);
    img = ObtenerKRegiones(ctrs, cidx, m, n);
    figure('Name','K-MEANS CLUSTERING'),imshow(img);
    %% FUZZY C-MEANS
     opts = [nan;nan;nan;0];
    [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
    Regiones = ObtenerRegiones(U, centers, m, n);
    figure('Name','FUZZY C-MEANS CLUSTERING'),imshow(Regiones);
end
end