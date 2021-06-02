%preset for matlab registration function
optimizer = registration.optimizer.OnePlusOneEvolutionary; %don't know what optimizer
metric = registration.metric.MattesMutualInformation; %mutial information
optimizer.InitialRadius = 0.006; %should be small to avoid warning
optimizer.Epsilon = 1.5e-5; % the smaller, the more accurate
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 1000;

pos_in = 'D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs_filter\';
pos_out = 'D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome6\';

fixed = imread('D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs_filter\001_filter.jpg');
fix_num = 1;


tic
for i = 6:5:496
    disp(i)
    disp('fix')
    disp(fix_num)
    
    name_fl_input = [num2str(i,'%03d'),'_filter.jpg'];
    name_out = [num2str(i,'%03d'),'reg'];
    floated = imread([pos_in,name_fl_input]); % read float fig
    
    tform = imregtform(floated,fixed,'similarity',optimizer,metric); 
	%%similarity is the best. rigid will fail; and affine will introduce deformation
    
    J_t = imwarp(floated,tform,'FillValue',242,'OutputView', imref2d( size(fixed) ));
    imshowpair(fixed, J_t,'Scaling','joint');
    title(name_out);
    saveas(gcf,[pos_out,name_out,'_compare_matlab.jpg'],'jpg')
    
    o = struct();
    o.fixed = fixed;
    o.floated = floated;
    o.J_t = J_t; %image transformed
    o.tform = tform; %transform data
    
    save([pos_out,'data\',name_out,'.mat'],'o')
    
   
    fixed = floated; %register neiborhooding slices! 
    fix_num = i;
    
end
toc
