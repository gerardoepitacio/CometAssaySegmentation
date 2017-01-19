function ExportarDatos(Patrones, Excel, ExcelKMeans, ExcelFCM, FilaFin)
% Exporta los datos generados durante el proceso de segmentacion.
% 
% Donde:
% Patrones: Son los patrones del ultimo cometa procesado.
% Excel:    Contiene el detalle general del proceso
% ExcelKMeans:  Contiene solo los resultados de K-Means
% ExcelFCM: Contiene solo los resultados de FCM
% FilaFin:  La fila donde comenzada a sumarse los demas datos al archivo
% Excel
Validacion(1, 1:10) = {'Fondo', '', 'Nucleo', '', 'Halo', '', 'Cola', ...
    '', 'Tiempo', ''};
Validacion(2:FilaFin, 1:10) = [...
    ExcelKMeans(2:FilaFin, 6) ExcelFCM(2:FilaFin, 6) ...
    ExcelKMeans(2:FilaFin, 7) ExcelFCM(2:FilaFin, 7) ...
    ExcelKMeans(2:FilaFin, 8) ExcelFCM(2:FilaFin, 8) ...
    ExcelKMeans(2:FilaFin, 9) ExcelFCM(2:FilaFin, 9) ...
    ExcelKMeans(2:FilaFin, 10) ExcelFCM(2:FilaFin, 10)];

Resultados = [Excel ; ExcelKMeans ; ExcelFCM ; Validacion];
if exist('Resultados.xls', 'file') == 2
  delete('Resultados.xls');
end
if exist('Patrones.xls', 'file') == 2
  delete('Patrones.xls');
end
xlswrite('Resultados', Resultados);
csvwrite('Patrones', Patrones)
end