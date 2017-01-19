function [FileName, FilePath] = ReadFile()
% Funcion ReadFile: Muestra una ventana para seleccionar la o las imagenes
% que van a ser procesadas.
Filter={'*.jpg;*.jpeg;*.png;*.tif;*.bmp'};
Title='Selecciona una imagen';
[FileName, FilePath] = uigetfile(Filter, Title, 'MultiSelect', 'on');
pause(0.01);