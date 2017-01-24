function InicializarEntorno()
% Funcion InicializarEntorno: Realiza la inicializacion de variables
% globales para ser utilizadas durante el proceso de segmentacion.
% Crea la carpeta Resultados donde se almacenaran los resultados.
global CometasProcesados Fila FilaFCM FilaKMeans;
global Excel ExcelKMeans ExcelFCM;
global RutaPrincipal RutaResultados;

CometasProcesados = 0;
Fila = 2;
FilaFCM = 3;
FilaKMeans = 3;

Excel = cell(0);
ExcelKMeans = cell(0);
ExcelFCM = cell(0);

Excel = {'Imagen','#', '#Img', 'Algoritmo', 'Pixeles', ...
    'Fondo', 'Núcleo', 'Halo', 'Cola', 'Tiempo'};
ExcelKMeans(2, 1:10) = {'RESULTADOS K-Means', '#', '#', 'Algoritmo', ...
     'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means', 'K-Means'};
ExcelFCM(2, 1:10) = {'RESULTADOS FCM','#', '#', 'Algoritmo', 'FCM', ...
     'FCM', 'FCM', 'FCM', 'FCM', 'FCM'};
 
format shortg
c = clock;
fecha = [num2str(c(1)) num2str(c(2)) num2str(c(3))];
RutaResultados = [RutaPrincipal 'Resultados' fecha '\'];
if exist(RutaResultados, 'dir') ~= 7
    mkdir(RutaResultados);
end
end