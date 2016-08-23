function [FileName, FilePath] = ReadFile()
Filter={'*.jpg;*.jpeg;*.png;*.tif;*.bmp'};
Title='Selecciona una imagen';
[FileName, FilePath] = uigetfile(Filter, Title, 'MultiSelect', 'on');
pause(0.01);

