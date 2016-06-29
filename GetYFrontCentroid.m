function [YCentroid] = GetYFrontCentroid(ImgRoi)
yFrontCentroid = 0.0;
cnt = 0;
[rows cols] = size(ImgRoi);
for i = 1 : (cols*0.3)
    for j = 1 : rows
        if ImgRoi(j, i) ~= 0
            yFrontCentroid = yFrontCentroid + j;
            cnt = cnt + 1;
        end
    end
end
YCentroid = yFrontCentroid / cnt;