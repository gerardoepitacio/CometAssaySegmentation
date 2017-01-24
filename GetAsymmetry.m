function Asymmetry = GetAsymmetry(Roi)
% Funcion GetAsymmetry: Devuelve el valor asimetrico de la region.
%
% Donde: 
% Roi: Es es el arreglo de descriptores generadas por, Roi = Stats(i).
ImgRoi = Roi.Image;
[rows cols] = size(ImgRoi);
absdy = 0.0;
xFrontCentroid = GetXFrontCentroid(ImgRoi);
for i = 1 : cols
    Sum1 = 0.0;
    Sum2 = 0.0;
    cnt1 = 0;
    for j = 1 : rows
        if ImgRoi(j,i) ~= 0
            if j > xFrontCentroid
                Sum1 = Sum1 + 1;
            else
                Sum2 = Sum2 + 1;
            end
            cnt1 = cnt1 + 1;
        end
    end
    absdy = absdy + (abs(Sum2 - Sum1) / cnt1);
end
Asymmetry = absdy / cols;