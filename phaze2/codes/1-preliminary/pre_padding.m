function I_pre = pre_padding(rgbImage)
%%pad the rgbImage to a 3500*3500 square
[r,c,d] = size(rgbImage);  %# Get the image dimensions
nPad_r= abs(3500-r)/2;
nPad_c = abs(3500-c)/2;
%# The padding size
padColor = [242 242 242];        %# RGB triple for pad color (white)
padColor = reshape(padColor,1,1,3);  %# Reshape pad color to 1-by-1-by-3
if 3500 > r                   %# Pad rows
  newImage = cat(1,repmat(padColor,floor(nPad_r),c),...  %# Top padding
                   rgbImage,...                        %# Image
                   repmat(padColor,ceil(nPad_r),c));     %# Bottom padding
elseif 3500 > c               %# Pad columns
  newImage = cat(2,repmat(padColor,r,floor(nPad_c)),...  %# Left padding
                   rgbImage,...                        %# Image
                   repmat(padColor,r,ceil(nPad_c)));     %# Right padding
end
I_pre = newImage;

end
