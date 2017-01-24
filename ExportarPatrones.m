function ExportarPatrones(FolderDestino, NombreArchivo, Patrones)
% Funcion ExportarPatrones: Exporta a un archivo CSV los patrones 
% generados por cada cometa con el llamado a la funcion ObtenerPatrones.
FolderDestino = [FolderDestino 'Patrones\'];
if exist(FolderDestino, 'dir') ~= 7
    mkdir(FolderDestino);
end

if exist([FolderDestino NombreArchivo '.csv'], 'file') == 2
    delete([FolderDestino NombreArchivo '.csv']); 
end

csvwrite([FolderDestino NombreArchivo '.csv'], Patrones);
end