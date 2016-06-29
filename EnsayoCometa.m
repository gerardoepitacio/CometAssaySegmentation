clear
clc
clear all
close all
%% Select Image and thresholding.
tic
Filter={'*.jpg;*.jpeg;*.png;*.tif;*.bmp'};
[FileName, FilePath]=uigetfile(Filter);
pause(0.01);
if FileName==0
    return;
end
FullFileName = [FilePath FileName];
f1 = imread(FullFileName);
g = rgb2gray(f1);
filtro = 'average';
f = imfilter(g,fspecial(filtro, 10));
tsd = localthresh(f, ones(3),1,1.1,'global');
bwW = bwareaopen(tsd,5000);
bw = imclearborder(bwW);
%% Image regions and comets segmentation.
s = regionprops(bw, 'all');
s = GetComets(s);
box = cat(1, s.BoundingBox);
[boxLen col] = size(box);
centroids = cat(1, s.Centroid);
for i = 1 : boxLen
    subImage = imcrop(g, (box(i,:)-1));
    %subImage(~s(i).Image) = 0;
    [m, n, c] = size(subImage);
    [Patrones, Img] = ObtenerPatrones(subImage);
    opts = [nan;nan;nan;0];
    [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
    Regiones = ObtenerRegiones(U, centers, m, n);
    figure,imshow(Img);
    figure,imshow(Regiones);
%% plotting
% %     figure,plot(Patrones(:,1),Patrones(:,2),'o');
% %              xlabel('Pixel Value')
% %              ylabel('std')
% %              
% %                 B=U;
% % B(:,m*n+1)= centers(:,1);
% % B = sortrows(B,m*n+1);
% % centers = sortrows(centers,1);
% % 
% %     B(:,m*n+1) = [];
% % U = B;
% % 
% %              
% %     maxU = max(U);
% %     index1 = find(U(1,:)== maxU);
% %     index2 = find(U(2,:)== maxU);
% %     index3 = find(U(3,:)== maxU);
% %     index4 = find(U(4,:)== maxU);
% %     line(Patrones(index1,1),Patrones(index1,2),'linestyle','-',...
% %          'marker','*','color','k');
% %     line(Patrones(index2,1),Patrones(index2,2),'linestyle','-',...
% %          'marker', '*','color','g');
% %      line(Patrones(index3,1),Patrones(index3,2),'linestyle','-',...
% %          'marker', '*','color','b');
% %      line(Patrones(index4,1),Patrones(index4,2),'linestyle','-',...
% %          'marker', '*','color','r');
% %     hold on
% %     plot(centers(1,1),centers(1,2),'xk','MarkerSize',15,'LineWidth',3);
% %     plot(centers(2,1),centers(2,2),'xk','MarkerSize',15,'LineWidth',3);
% %     plot(centers(3,1),centers(3,2),'xk','MarkerSize',15,'LineWidth',3);
% %     plot(centers(4,1),centers(4,2),'xk','MarkerSize',15,'LineWidth',3);
% %     hold off
       
end

%% Labeling.
figure,imshow(f1);
hold on
       % X               Y
plot(centroids(:,1), centroids(:,2), 'b*')
for i = 1 : boxLen
rectangle('Position', box(i,:), 'EdgeColor', 'red');
end

            %X               Y
plot(centroids(:,1), centroids(:,2), 'b*')
[boxLen col] = size(box);
for i = 1 : boxLen
rectangle('Position', box(i,:), 'EdgeColor', 'red');
end
hold off

toc