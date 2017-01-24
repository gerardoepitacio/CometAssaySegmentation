function ExportarImagen(FolderDestino, NombreArchivo, MatrizRGB)
% Funcion ExportarImagen: Guarda la imagen recibida en la MatrizRGB en el
% subfolder "Cometas" del folder destino. El archivo es guardado en 
% formato png con el nombre recibido en el segundo parametro.
FolderDestino = [FolderDestino 'Cometas\'];
if exist(FolderDestino, 'dir') ~= 7
    mkdir(FolderDestino);
end
if exist([FolderDestino NombreArchivo '.png'], 'file') == 2
    delete([FolderDestino NombreArchivo '.png']); 
end
imwrite(MatrizRGB, [FolderDestino NombreArchivo '.png']);
end