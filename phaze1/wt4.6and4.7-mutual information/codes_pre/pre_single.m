function I_pre = pre_single(I)
%input image I before preprocessing
%output image I after preprocessing

%%medfilt2 
downs = imresize(I, [512 512], 'bilinear'); %downsample get smaller
%figure
Hs = adapthisteq(downs); %enlarge contrast
%imshow(Hs);
%imshowpair(Hs,fixed,'montage');

Hs_f = medfilt2(Hs,[3 3]);
% for i = 1:2
% Hs_f = medfilt2(Hs_f,[3 3]); 
% end
Hs_g = imgaussfilt(Hs_f,0.5); %smoother
%imshowpair(Hs_f,Hs_g,'montage');
%title(num2str(input_num))
I_pre = Hs_g;
%saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\pre\',num2str(input_num),'_compare_gau.jpg'],'jpg')
%Hs_f= adapthisteq(ss3);
end
