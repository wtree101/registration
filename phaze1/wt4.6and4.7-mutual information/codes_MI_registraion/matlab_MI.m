
global I J

%input
name1 = '525';
name2 = '530';

%using the figures downsampled, smoothed, and...
%
name = [name2,'on',name1,'jump'];
I = imread(['D:\WORKPLACE\image_process\resized\resized\phaze2\images_1\',name1,'_filter.jpg']);
J = imread(['D:\WORKPLACE\image_process\resized\resized\phaze2\images_1\',name2,'_filter.jpg']);
%s=0; y_list = [];

%preset for matlab registration function
optimizer = registration.optimizer.OnePlusOneEvolutionary; %don't know what optimizer
metric = registration.metric.MattesMutualInformation; %mutial information
optimizer.InitialRadius = 0.009; 
optimizer.Epsilon = 1.5e-5; % the smaller, the more accurate
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 1000;

% registration
movingRegistered = imregister(J,I,'affine',optimizer,metric);
imshowpair(I, movingRegistered,'Scaling','joint');
saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome1\',name1,'_compare_matlab.jpg'],'jpg')
