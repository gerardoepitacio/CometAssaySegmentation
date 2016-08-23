function [Profile] = ObtenerPerfil(img)   
[subM subN capas] = size(img);
Profile = double(zeros(subM,1));
 for j=1:subN
     Profile(j) = sum(img(:,j))/subN;
 end
end