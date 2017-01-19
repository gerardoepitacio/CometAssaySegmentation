clear
clc
clear all
close all
% Quitamos advertencia: Image is too big to fit on screen
warning('off', 'Images:initSize:adjustingMag');
%% Select Image and thresholding.
[NombresArchivo, RutaPrincipal] = ReadFile();
if RutaPrincipal == 0
    return;
end

Fila = 2;
FilaFCM = 3;
FilaKMeans = 3;
CometasProcesados = 0;
Excel = {'Imagen','#', '#Img', 'Algoritmo', 'Pixeles', 'Fondo', ...
    'N�cleo', 'Halo', 'Cola', 'Tiempo'};
ExcelFCM(2, 1:10) = {'RESULTADOS FCM','#', '#', 'Algoritmo', 'FCM', ...
    'FCM', 'FCM', 'FCM', 'FCM', 'FCM'};
ExcelKMeans(2, 1:10) = {'RESULTADOS K-Means','#', '#', 'Algoritmo', ...
    'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means'};

for File = 1 : length(NombresArchivo)
    %% Preprocesamiento
    [Ruta, Archivo] = ObtenerArchivo(RutaPrincipal, NombresArchivo, File);
    ImagenActual = imread(Ruta);
    [Filtrada, Gris] = PreprocesarImagen(ImagenActual);
    
    %% Binarizado y remocion.
    tsd = localthresh(Filtrada, ones(3), 1, 1.1, 'global');
    bwW = bwareaopen(tsd, 3000);
    bw = imclearborder(bwW);
    
    %% Descripcion y descarte
    s = DescartarCometas(ImagenActual, bw, Archivo);
    
    %% Subimagen y Patrones
    box = cat(1, s.BoundingBox);
    [CantidadCometas, col] = size(box);
    Excel(Fila, 1) = {Archivo};
    ExcelFCM(FilaFCM, 1) = {Archivo};
    ExcelKMeans(FilaKMeans, 1) = {Archivo};
    for p = 1 : CantidadCometas
        CometasProcesados = CometasProcesados + 1;
        Excel(Fila, 2) = {p};
        Excel(Fila, 3) = {CometasProcesados};
        %% Obtener Patrones
        subImagen = imcrop(Gris, (box(p,:)-1));
        [m, n, c] = size(subImagen);
        Patrones = ObtenerPatrones(subImagen, m, n);
        %% K-MEANS
        tic
        [cidx, ctrs] = kmeans(Patrones, 4);
        Tiempo = toc;
        [img, Areas] = ObtenerKRegiones(ctrs, cidx, m, n);
        %% Guarda Resultados K-MEANS
        Excel(Fila, 4:9) = Areas;
        Excel(Fila, 10) = {Tiempo};
        ExcelKMeans(FilaKMeans, 2:10) = Excel(Fila, 2:10); 
        Fila = Fila + 1;
        FilaKMeans = FilaKMeans + 1;
        %% FUZZY C-MEANS
        opts = [nan;nan;nan;0];
        tic
        [centers, U, obj_fcn] = fcm(Patrones, 4, opts);
        Tiempo = toc;
        [Regiones, Areas]= ObtenerRegiones(U, centers, m, n);
        %% Guarda Resultados FCM
        Excel(Fila, 2) = {p};
        Excel(Fila, 3) = {CometasProcesados};
        Excel(Fila, 4:9) = Areas;
        Excel(Fila, 10) = {Tiempo};
        ExcelFCM(FilaFCM, 2:10) = Excel(Fila, 2:10); 
        Fila = Fila + 1;
        FilaFCM = FilaFCM + 1;
        %% Mostrando resultados 
        hold on
        rectangle('Position', box(p,:), 'EdgeColor', 'green');
        text(box(p,1)+7, box(p,2)+20, sprintf('%d', CometasProcesados), 'Color', 'green', 'FontSize', 14);
        hold off
        %% Regiones FCM y K-means.
%         figure('NumberTitle', 'off', 'Name',[num2str(File) '-' num2str(p) ' K-Means & FCM'])
%         hold on
%         subplot(1,2,1), subimage(img)
%         title('K-Means')
%         subplot(1,2,2), subimage(Regiones)
%         title('FCM')
%         hold off
    end
    
    if ischar(NombresArchivo) == 1
        break;
    end
end
FilaFin = CometasProcesados + 2;
ExportarDatos(Patrones, Excel, ExcelKMeans, ExcelFCM, FilaFin);
