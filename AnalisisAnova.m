function [pFondo, pNucleo, pHalo, pCola, pTiempo] = AnalisisAnova()
% Funcion AnalisisAnova: Realiza el analisis de datos a traves de ANOVA
% unidireccional. Los datos son tomados desde las variables globales
% despues de terminar la tarea de segmentacion.
%
% Donde:
% ExcelKMeans       Es una matriz nx10 que contiene todos los datos 
%                   resultantes de la segmentacion de regiones del cometa 
%                   con K-Means, donde n es la cantidad de cometas
%                   procesados.
% ExcelFCM          Es la matriz que guarda todos los datos obtenidos por
%                   Fuzzy C-Means.
global ExcelKMeans ExcelFCM CometasProcesados RutaResultados;
FilaFin = CometasProcesados + 2;

DatosFondo = [ExcelKMeans(3:FilaFin, 6) ExcelFCM(3:FilaFin, 6)];
DatosNucleo = [ExcelKMeans(3:FilaFin, 7) ExcelFCM(3:FilaFin, 7)];
DatosHalo = [ExcelKMeans(3:FilaFin, 8) ExcelFCM(3:FilaFin, 8)];
DatosCola = [ExcelKMeans(3:FilaFin, 9) ExcelFCM(3:FilaFin, 9)];
DatosTiempo = [ExcelKMeans(3:FilaFin, 10) ExcelFCM(3:FilaFin, 10)];

pFondo = anova1(cell2mat(DatosFondo(:, :)), {'K-MEANS', 'FCM' }, 'off');
pNucleo = anova1(cell2mat(DatosNucleo(:, :)), {'K-MEANS', 'FCM' }, 'off');
pHalo = anova1(cell2mat(DatosHalo(:, :)), {'K-MEANS', 'FCM' }, 'off');
pCola = anova1(cell2mat(DatosCola(:, :)), {'K-MEANS', 'FCM' }, 'off');
pTiempo = anova1(cell2mat(DatosTiempo(:, :)), {'K-MEANS', 'FCM' }, 'off');
Destino = [RutaResultados 'ResultadosAnova.xls'];
if exist(Destino, 'file') == 2
    delete(Destino); 
end
Validacion(1, 1:10) = {'pFondo', pFondo, 'pNucleo', pNucleo, ...
    'pHalo', pHalo, 'pCola', pCola, 'pTiempo', pTiempo};
Validacion(2, 1:10) = {'K-MEANS', 'FCM', 'K-MEANS', 'FCM', 'K-MEANS', ...
    'FCM', 'K-MEANS', 'FCM', 'K-MEANS', 'FCM'};
Validacion(3:(CometasProcesados+2), 1:10) = ...
    [DatosFondo(:, :) DatosNucleo(:, :) DatosHalo(:, :) ... 
    DatosCola(:, :) DatosTiempo(:, :)];
xlswrite(Destino, Validacion);
end 