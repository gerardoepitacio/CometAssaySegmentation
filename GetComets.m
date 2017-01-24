function Comets = GetComets(Stats, FileName)
% Funcion GetComets: Devuelve los cometas que son validos para ser
% procesados como cometas.
%
% Donde: 
% Stats:    Son las estadisticas generadas por la funcion regionprops
% FileName: Es el nombre del archivo de donde se obtuvieron las
%           estadisticas recibidas.
[Elements, cols] = size(Stats);
Invalid = false(Elements, 1);
disp(['Archivo: ', FileName])
str = sprintf('%5s%10s%10s%10s%10s%10s%10s','#', 'Solidity', ...
    'Asymmetry', 'Hratio', 'CLD', 'Area', 'Valid');
disp(str);
for i = 1 : Elements
    Roi = Stats(i);
    [height, width] = size(Roi.Image);
    Log = sprintf('%5d',i);
    Valid = ' ';
     if Roi.Solidity < 0.5
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', Roi.Solidity, Valid)];
   
    Valid = ' ';
    Asymmetry = GetAsymmetry(Roi);
     if Asymmetry > 0.7
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', Asymmetry, Valid)];
    
    Valid = ' ';
    if (height / width) > 1.1    %Hratio
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', (height / width), Valid)];
    
    Valid = ' ';
    CLD = abs(GetXFrontCentroid(Roi.Image) - height/2)/height;
    if CLD > 0.1
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', CLD, Valid)];
    Log = [Log sprintf('%10.2f%', Roi.Area)];
    if Invalid(i) == true
        Log = [Log sprintf('%10s', 'Invalid')];
    else 
        Log = [Log sprintf('%10s', 'Valid')];
    end
    disp(Log);
end

Stats(Invalid) = [];
Comets = Stats;