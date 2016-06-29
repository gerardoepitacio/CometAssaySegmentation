%  
% Perfil = CreaPatrones(Imagen)
% Retorna un vector que contiene el perfil de la imagen.
% los valores en cada elemento del vector representa el valor promedio de
% las columnas en y.
% Autor: Gerardo
% 

function [Profile] = ObtenerPerfil(img)   
[subM subN capas] = size(img);
Profile = double(zeros(subM,1));
 for j=1:subN
     Profile(j) = sum(img(:,j))/subN;
 end
end