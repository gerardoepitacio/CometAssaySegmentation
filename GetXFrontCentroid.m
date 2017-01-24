function xCentroid = GetXFrontCentroid(ImgRoi)
% Funcion GetXFrontCentroid: Devuelve el centroide frontal de la imagen 
% del ROI.
%
% Donde: 
% ImgRoi: Es la imagen binaria del ROI, ImgRoi = Roi.Image
xFrontCentroid = 0.0;
cnt = 0;
[rows cols] = size(ImgRoi);
for i = 1 : (cols*0.3)
    for j = 1 : rows
        if ImgRoi(j, i) ~= 0
            xFrontCentroid = xFrontCentroid + j;
            cnt = cnt + 1;
        end
    end
end
xCentroid = xFrontCentroid / cnt;