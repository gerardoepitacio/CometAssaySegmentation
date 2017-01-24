function ExportarDatos()
% Funcion ExportarDatos: Exporta los datos generados durante el proceso de 
% segmentacion a un archivo excel llamado Resultados.xls que contiene los 
% siguientes datos:
%
% 1.- El conjunto de datos donde por cada cometa la primer fila contiene 
% los resultados generados por el algorimo de clustering K-Means y la 
% segunda por el algoritmo Fuzzy C-Means.
% 2.- El mismo conjunto de datos anterior, solo que se separan los 
% resultados de K-Means y Fuzzy C-Means en dos apartados.
% 3.- El conjunto de datos formateados de tal manera que facilite el 
% analisis a traves del test de ANOVA.
global Excel ExcelKMeans ExcelFCM CometasProcesados RutaResultados;
FilaFin = CometasProcesados + 2;
Validacion(1, 1:10) = {'Fondo', '', 'Nucleo', '', 'Halo', '', 'Cola', ...
    '', 'Tiempo', ''};
Validacion(2:FilaFin, 1:10) = [...
    ExcelKMeans(2:FilaFin, 6) ExcelFCM(2:FilaFin, 6) ...
    ExcelKMeans(2:FilaFin, 7) ExcelFCM(2:FilaFin, 7) ...
    ExcelKMeans(2:FilaFin, 8) ExcelFCM(2:FilaFin, 8) ...
    ExcelKMeans(2:FilaFin, 9) ExcelFCM(2:FilaFin, 9) ...
    ExcelKMeans(2:FilaFin, 10) ExcelFCM(2:FilaFin, 10)];
Resultados = [Excel ; ExcelKMeans ; ExcelFCM ; Validacion];

if exist([RutaResultados 'Resultados.xls'], 'file') == 2
  delete([RutaResultados 'Resultados.xls']);
end
xlswrite([RutaResultados 'Resultados'], Resultados);
end