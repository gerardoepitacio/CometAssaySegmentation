% Script principal que lleva a cabo el proceso de segmentacion de imagenes 
% del ensayo cometa con los algoritmos K-Means y Fuzzy C-Means.
clear
clc
clear all
close all
% Quitamos advertencia: Image is too big to fit on screen
warning('off', 'Images:initSize:adjustingMag');

global NombresArchivo RutaPrincipal RutaResultados;
global Fila FilaFCM FilaKMeans CometasProcesados ;
global Excel ExcelKMeans ExcelFCM;

[NombresArchivo, RutaPrincipal] = ReadFile();
if RutaPrincipal == 0
    return;
end

InicializarEntorno();

for File = 1 : length(NombresArchivo)
    %% Preprocesamiento
    [Ruta, Archivo] = ObtenerArchivo(File);
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
        [RegionesKMeans, Areas] = ObtenerKRegiones(ctrs, cidx, m, n);
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
        [RegionesFCM, Areas]= ObtenerRegiones(U, centers, m, n);
        %% Guarda Resultados FCM
        Excel(Fila, 2) = {p};
        Excel(Fila, 3) = {CometasProcesados};
        Excel(Fila, 4:9) = Areas;
        Excel(Fila, 10) = {Tiempo};
        ExcelFCM(FilaFCM, 2:10) = Excel(Fila, 2:10); 
        Fila = Fila + 1;
        FilaFCM = FilaFCM + 1;
        %% Mostrar y guardar resultados 
        hold on
        rectangle('Position', box(p,:), 'EdgeColor', 'green');
        text(box(p,1)+7, box(p,2)+20, sprintf('%d', CometasProcesados), ...
            'Color', 'green', 'FontSize', 14);
        hold off
        set(gca,'position',[0 0 1 1],'units','normalized');
        print([RutaResultados Archivo], '-dbmp');
        
        ExportarImagen(RutaResultados, ['KMeans' ...
            num2str(CometasProcesados)], RegionesKMeans);
        ExportarImagen(RutaResultados, ['FCM' ...
            num2str(CometasProcesados)], RegionesFCM);
        %% exportar patrones del cometa.
        ExportarPatrones(RutaResultados, ['Patrones' ...
            num2str(CometasProcesados)], Patrones);
    end
    if ischar(NombresArchivo) == 1
        break;
    end
end
[pFondo, pNucleo, pHalo, pCola, pTiempo] = AnalisisAnova()
ExportarDatos();


