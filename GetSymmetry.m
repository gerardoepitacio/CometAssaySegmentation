function [Symmetry] = GetSymmetry(Roi)
ImgRoi = Roi.Image;
[rows cols] = size(ImgRoi);
absdy = 0.0;
YFrontCentroid = GetYFrontCentroid(ImgRoi);
for i = 1 : cols
    Sum1 = 0.0;
    Sum2 = 0.0;
    cnt1 = 0;
    for j = 1 : rows
        if ImgRoi(j,i) ~= 0
            if j > YFrontCentroid
                Sum1 = Sum1 + 1;
            else
                Sum2 = Sum2 + 1;
            end
            cnt1 = cnt1 + 1;
        end
    end
    absdy = absdy + (abs(Sum2 - Sum1) / cnt1);
end

Symmetry = absdy / rows;


% % % % //int counter = 0;
% % % %         Rectangle roi = ip.getRoi();
% % % %         byte[] mask = ip.getMaskArray();
% % % %         Rectangle br = roi.getBounds();
% % % %         //double pix;
% % % %         int sum1, sum2;
% % % %         double absdy = 0.0;
% % % %         int cnt1 = 0;
% % % %         int maskidx;
% % % % 
% % % %         int yFrontCentroid = getFrontCentroid(ip);
% % % % 
% % % %         for (int x = br.x; x < (br.x + br.width); x++) {
% % % %             sum1 = 0;
% % % %             sum2 = 0;
% % % %             cnt1 = 0;
% % % %             for (int y = br.y; y < (br.y + br.height); y++) {
% % % %                 maskidx = ((y - br.y) * br.width) + (x - br.x);
% % % %                 if (mask[maskidx] != 0) {
% % % %                     //if(y < (br.y+ (br.height/2))){
% % % %                     if (y < yFrontCentroid) {
% % % %                         sum1++;
% % % %                     } else {
% % % %                         sum2++;
% % % %                     }
% % % %                     cnt1++;
% % % %                 }
% % % % 
% % % %             }
% % % %             absdy += Math.abs(sum2 - sum1) / (double) cnt1;
% % % %         }
% % % %         absdy = absdy / br.width;
% % % %         return absdy;