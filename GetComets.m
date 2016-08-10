function [Comets] = GetComets(Stats)
[Elements, cols] = size(Stats);
Invalid = false(Elements, 1);
str = sprintf('%5s%10s%10s%10s%10s%10s%10s','#', 'Solidity', 'Symmetry', 'Hratio', 'CLD', 'Area', 'Valid');
disp(str);
for i = 1 : Elements
    Roi = Stats(i);
    figure('Name','Binary Image'), imshow(Roi.Image);
    [height, width] = size(Roi.Image);
    Log = sprintf('%5d',i);
    Valid = ' ';
    if Roi.Solidity < 0.6
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', Roi.Solidity, Valid)];
   
    Valid = ' ';
    Symmetry = GetSymmetry(Roi);
    if Symmetry > 0.7
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', Symmetry, Valid)];
    
    Valid = ' ';
    if (height / width) > 1.1    %Hratio
        Invalid(i) = true;
        Valid = '*';
    end
    Log = [Log sprintf('%9.4f%1s', (height / width), Valid)];
    
    Valid = ' ';
    CLD = abs(GetYFrontCentroid(Roi.Image) - height/2)/height;
    if CLD > 0.2
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