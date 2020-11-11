function [hkl,translated_points] = get_hkl_slices(params,thres)
disp(['calculating hkl with slice-width: ',num2str(thres)])
start_time=clock;
a = params.base_vectors(1,:);
b = params.base_vectors(2,:);
c = params.base_vectors(3,:);
max_range = max(norm(single(min(params.data))),norm(single(max(params.data))));
it_max = round(max_range/min(vecnorm([a;b;c]')));
[a_grid,b_grid,c_grid] = meshgrid(-it_max:it_max,-it_max:it_max,-it_max:it_max);
a_grid = reshape(a_grid,[],1);
b_grid = reshape(b_grid,[],1);
c_grid = reshape(c_grid,[],1);
points = a_grid.*a + b_grid.*b + c_grid.*c;
translated_points = zeros(size(points));
hkl = zeros(size(points),'int8');
data_counter = 1;
%rotate around x axis
for i = 1:length(params.tilt)
    norm_vec = [0,0,1]*rotx(params.tilt(i));
    ns = [0,1,0]*rotx(params.tilt(i));
    [p_dist, p_project] = point_to_plane_distance(points,norm_vec,ns);
    ind = find(p_dist < thres);
    rot_project = p_project(ind,:)*rotx(-params.tilt(i));
    translated_points(data_counter:data_counter+length(ind)-1,1:2) = rot_project(:,1:2);
    translated_points(data_counter:data_counter+length(ind)-1,3) = ones(length(ind),1)*i;
    hkl(data_counter:data_counter+length(ind)-1,:) = [a_grid(ind),b_grid(ind),c_grid(ind)];
    data_counter = data_counter + length(ind);
end
translated_points = translated_points(1:data_counter-1,:);
hkl = hkl(1:data_counter-1,:);
translated_points(:,1:2) = round([params.nx,params.ny]/2 - translated_points(:,1:2));
hkl = hkl(translated_points(:,1)>0,:);
translated_points = translated_points(translated_points(:,1)>0,:);
hkl = hkl(translated_points(:,2)>0,:);
translated_points = translated_points(translated_points(:,2)>0,:);
hkl = hkl(translated_points(:,1)<params.nx,:);
translated_points = translated_points(translated_points(:,1)<params.nx,:);
hkl = hkl(translated_points(:,2)<params.ny,:);
translated_points = translated_points(translated_points(:,2)<params.ny,:);
disp(['finished hkl calculation(', num2str(etime(clock,start_time)),' sec)']);
end



