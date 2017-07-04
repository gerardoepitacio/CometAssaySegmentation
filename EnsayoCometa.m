clear
clc
clear all
close all
% Off Warning: Image is too big to fit on screen
warning('off', 'Images:initSize:adjustingMag');
%% Select Image and thresholding.
tic
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
    g = rgb2gray(f1);
    filtro = 'average';
    f = imfilter(g,fspecial(filtro, 11));
    tsd = localthresh(f, ones(3),1,1.1,'global');
    bwW = bwareaopen(tsd,5000);
    bw = imclearborder(bwW);
    %% Image regions and comets segmentation.
    s = regionprops(bw, 'all');
    s = GetComets(s, FileName);
    box = cat(1, s.BoundingBox);
    [boxLen col] = size(box);
    centroids = cat(1, s.Centroid);
    for i = 1 : boxLen
        subImage = imcrop(g, (box(i,:)-1));
        %subImage(~s(i).Image) = 0;     %crop with binary image shape
        [m, n, c] = size(subImage);
        Patrones = ObtenerPatrones(subImage, m, n);
        opts = [nan;nan;nan;0];
        [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
        Regiones = ObtenerRegiones(U, centers, m, n);
        figure,imshow(Regiones);
         
    %% plotting
        figure,plot(Patrones(:,1),Patrones(:,2),'o');
                 xlabel('Pixel Value')
                 ylabel('std')
                 B=U;
        B(:,m*n+1)= centers(:,1);
        B = sortrows(B,m*n+1);
        centers = sortrows(centers,1);
    
        B(:,m*n+1) = [];
        U = B;
        
        maxU = max(U);
        index1 = find(U(1,:)== maxU);
        index2 = find(U(2,:)== maxU);
        index3 = find(U(3,:)== maxU);
        index4 = find(U(4,:)== maxU);
        line(Patrones(index1,1),Patrones(index1,2),'linestyle','-',...
             'marker','*','color','k');
        line(Patrones(index2,1),Patrones(index2,2),'linestyle','-',...
             'marker', '*','color','g');
         line(Patrones(index3,1),Patrones(index3,2),'linestyle','-',...
             'marker', '*','color','b');
         line(Patrones(index4,1),Patrones(index4,2),'linestyle','-',...
             'marker', '*','color','r');
        hold on
        plot(centers(1,1),centers(1,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(2,1),centers(2,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(3,1),centers(3,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(4,1),centers(4,2),'xk','MarkerSize',15,'LineWidth',3);
        hold off
        
        
        %% pixel value, mean
        figure,plot(Patrones(:,1),Patrones(:,3),'o');
                 xlabel('Pixel Value')
                 ylabel('std')
                 B=U;
        B(:,m*n+1)= centers(:,1);
        B = sortrows(B,m*n+1);
        centers = sortrows(centers,1);
    
        B(:,m*n+1) = [];
        U = B;
        
        maxU = max(U);
        index1 = find(U(1,:)== maxU);
        index2 = find(U(2,:)== maxU);
        index3 = find(U(3,:)== maxU);
        index4 = find(U(4,:)== maxU);
        line(Patrones(index1,1),Patrones(index1,2),'linestyle','-',...
             'marker','*','color','k');
        line(Patrones(index2,1),Patrones(index2,2),'linestyle','-',...
             'marker', '*','color','g');
         line(Patrones(index3,1),Patrones(index3,2),'linestyle','-',...
             'marker', '*','color','b');
         line(Patrones(index4,1),Patrones(index4,2),'linestyle','-',...
             'marker', '*','color','r');
        hold on
        plot(centers(1,1),centers(1,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(2,1),centers(2,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(3,1),centers(3,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(4,1),centers(4,2),'xk','MarkerSize',15,'LineWidth',3);
        hold off
        
        %% std vs prom
        figure,plot(Patrones(:,2),Patrones(:,3),'o');
                 xlabel('Pixel Value')
                 ylabel('std')
                 B=U;
        B(:,m*n+1)= centers(:,1);
        B = sortrows(B,m*n+1);
        centers = sortrows(centers,1);
    
        B(:,m*n+1) = [];
        U = B;
        
        maxU = max(U);
        index1 = find(U(1,:)== maxU);
        index2 = find(U(2,:)== maxU);
        index3 = find(U(3,:)== maxU);
        index4 = find(U(4,:)== maxU);
        line(Patrones(index1,1),Patrones(index1,2),'linestyle','-',...
             'marker','*','color','k');
        line(Patrones(index2,1),Patrones(index2,2),'linestyle','-',...
             'marker', '*','color','g');
         line(Patrones(index3,1),Patrones(index3,2),'linestyle','-',...
             'marker', '*','color','b');
         line(Patrones(index4,1),Patrones(index4,2),'linestyle','-',...
             'marker', '*','color','r');
        hold on
        plot(centers(1,1),centers(1,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(2,1),centers(2,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(3,1),centers(3,2),'xk','MarkerSize',15,'LineWidth',3);
        plot(centers(4,1),centers(4,2),'xk','MarkerSize',15,'LineWidth',3);
        hold off
        

    end
    
%% Labeling.
% % % figure,imshow(f1);
% % % hold on
% % %        % X               Y
% % % plot(centroids(:,1), centroids(:,2), 'b*')
% % % for i = 1 : boxLen
% % % rectangle('Position', box(i,:), 'EdgeColor', 'red');
% % % end
% % % 
% % %             %X               Y
% % % plot(centroids(:,1), centroids(:,2), 'b*')
% % % [boxLen col] = size(box);
% % % for i = 1 : boxLen
% % % rectangle('Position', box(i,:), 'EdgeColor', 'red');
% % % end
% % % hold off
        if ischar(FileNames) == 1
            break;
        end
end
toc