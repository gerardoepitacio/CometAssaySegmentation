%% Prueba ANOVA al conjunto de datos generados con los algoritmos k-Means y FCM
clc
close all
c = clock;
disp([ 'Comenzando prueba ANOVA: ' datestr(datenum(c(1),c(2),c(3),c(4),c(5),c(6)))]);
Datos = csvread('Validacion/DatosValidacion.csv', 2,0);
pFondo = anova1(Datos(:, 1:2), {'K-MEANS', 'FCM' }, 'off');
pNucleo = anova1(Datos(:, 3:4), {'K-MEANS', 'FCM' }, 'off');
pHalo = anova1(Datos(:, 5:6), {'K-MEANS', 'FCM' }, 'off');
pCola = anova1(Datos(:, 7:8), {'K-MEANS', 'FCM' }, 'off');
pTiempo = anova1(Datos(:, 9:10), {'K-MEANS', 'FCM' }, 'off');
pFondo
pNucleo
pHalo
pCola
pTiempo

