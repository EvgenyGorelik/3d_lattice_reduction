function main()
disp('Algorithm for Determining Grid Basis Vectors and Intensity Distribution');
close all
clear all

addpath('.\utils');
addpath('.\utils\base_vec_refinement');
addpath('.\utils\clustering');
addpath('.\utils\diff_vec_analysis');
addpath('.\utils\hkl_lattice');
addpath('.\utils\io_utils');
addpath('.\utils\math_utils');

% % find .mrc file
[filename, pathname] = uigetfile({'*.mrc';'*.*'}, 'Pick an MRC-file');
if isequal(filename,0) || isequal(pathname,0)
    disp('No data loaded.'); return;
end
params = global_variables;
params.fname_in = [pathname filename];
% fname_in = 'res/232_CM12_CL180.mrc_sh_ro_-6.85_nc.mrc';

fid_in = fopen(params.fname_in,'r');

% Read Header file and store in Header_in
Header_in=ta_mrc_read_header(fid_in);
Header_in.MRC.next=0;


% get image dimensions
params.nx = Header_in.MRC.nx;
params.ny = Header_in.MRC.ny;
params.nz = Header_in.MRC.nz;
params.tilt = Header_in.Extended.a_tilt;

disp ("tilting from "+num2str(params.tilt(1))+" to "+num2str(params.tilt(params.nz)))
 
% the data with value greater or equal to thresh will be stored
% in the following format
% data(:,1) data(:,2) data(:,3) int_val(:)
% x_1       y_1       z_1       I_1
% x_2       y_2       z_2       I_2
% x_3       y_3       z_3       I_3
% ..        ..        ..        ..


init_param = inputdlg({'Intensity Threshold','Cutting Sphere Radius'},'Parameters for .mrc Reading',[1,35],{'1000','-8000'});

% set threshold for minimal intensity value of included data
thresh = str2double(init_param{1});
% set radius of sphere for displacement, sign determines the direction of
% the sphere center along z
sphere_rad = str2double(init_param{2});

[x_grid,y_grid] = meshgrid(1:params.nx,1:params.ny);
x_grid = reshape(x_grid,[],1);
y_grid = reshape(y_grid,[],1);

% maximal number of included points
total_num = params.nx*params.ny*params.nz;
params.data = zeros(total_num,3,'single');
params.int_val = zeros(total_num,1,'int16');
data_counter = 1;

start_time=clock;
for j=1:params.nz
    % read data slice-wise
    disp(['reading slice ',num2str(j),'/',num2str(params.nz)]);
    img = fread(fid_in,[params.nx,params.ny],'int16');
    % rotate matrix by 90deg
    img = rot90(img);
    % create rotational matrix dependend on tilt(j)
    trans_img = img';
    ind = find(trans_img > thresh);
    sphere_cen = (sphere_rad*[0,0,1])*rotx(params.tilt(j));
    img_coor = [params.nx/2 - x_grid(ind), params.ny/2 - y_grid(ind), zeros(length(ind),1)]*rotx(params.tilt(j));
    img_coor_diff = img_coor - sphere_cen;
    img_coor_norm = vecnorm((img_coor_diff)');
    img_coor_trans = abs(sphere_rad)./img_coor_norm' .* img_coor_diff + sphere_cen;
    params.data(data_counter:data_counter + length(ind) - 1,:) = img_coor_trans;
    params.int_val(data_counter:data_counter + length(ind) - 1) = trans_img(ind);
    data_counter = data_counter + length(ind);
end
data_counter = data_counter - 1;
params.data = params.data(1:data_counter,:);
params.int_val = params.int_val(1:data_counter);
fclose(fid_in);
disp(strcat('finished reading slices(', num2str(etime(clock,start_time)),' sec)'));

% set maximal intensity for visualisation
show_thresh = (max(params.int_val)-min(params.int_val))*0.7;
[ind]=find(params.int_val>=show_thresh);
show_data = params.data(ind,:);
show_val = single(params.int_val(ind));
% plot data
fig = figure('Position', [400 100 800 800], 'Name','3D data (tilt axis along X): select threshhold for plotting...','NumberTitle','off'); 
ax = axes(fig);
scatter3(ax, show_data(:,1) , show_data(:,2) , show_data(:,3), show_val*100/max(show_val), show_val*100/max(show_val), 'filled');
thresh_labl = uicontrol('Style','text','position',[400 10 100 15],'String',show_thresh);
uicontrol('Style','text','position',[0 10 100 15],'String','Intensity Threshold');
sld = uicontrol('style','slider','position',[100 10 300 15],...
    'min', min(params.int_val), 'max', max(params.int_val),'val',show_thresh,...
    'Callback',{@(u,v)intensity_threshold_changed(u,v,params,ax,thresh_labl)});
c = uicontrol(fig,'style','pushbutton','position',[10 30 150 20],...
    'String','Cluster Data',...
    'Callback',{@(u,v)cluster_data_routine(u,v,params,sld)});
daspect([1 1 1])
xlabel('x')
ylabel('y')
zlabel('z')
end

