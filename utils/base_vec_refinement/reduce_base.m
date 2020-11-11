function reduce_base(params,points)
global base_vectors
p_norm = vecnorm(points');
ind = find(p_norm > 0);
points = points(ind, :);
p_norm = p_norm(ind);
[~,a_ind] = min(p_norm);
a = points(a_ind(1),:);
ns = null(a)';
p_dist = point_to_plane_distance(points,a,ns(1,:));
p_dist_ind = find(p_dist<norm(a)-0.01);
[~,b_ind] = min(p_norm(p_dist_ind));
b = points(p_dist_ind(b_ind(1)),:);
ns = null([a;b])';
distances = zeros(size(points,1),1);
v1 = -max(p_norm)*ns;
v2 = +max(p_norm)*ns;
for i = 1:length(distances)
distances(i) = point_to_line(points(i,:),v1,v2);
end
dist_ind = find(distances<min(norm(a),norm(b))-0.01);
[~,c_ind] = min(p_norm(dist_ind));
c = points(dist_ind(c_ind),:);
params.base_vectors = [a;b;c];
disp('reduced basis vectors:')
disp(['a = ',num2str(a)])
disp(['b = ',num2str(b)])
disp(['c = ',num2str(c)])
disp('with angles')
disp(['ang(a,b) = ',num2str(rad2deg(atan2(norm(cross(a,b)), dot(a,b))))])
disp(['ang(b,c) = ',num2str(rad2deg(atan2(norm(cross(b,c)), dot(b,c))))])
disp(['ang(a,c) = ',num2str(rad2deg(atan2(norm(cross(a,c)), dot(a,c))))])
disp('and lengths')
disp(['|a| = ',num2str(norm(a))])
disp(['|b| = ',num2str(norm(b))])
disp(['|c| = ',num2str(norm(c))])

% store base vector information
file_name = get_file_name(params);
if(~exist(file_name,'dir'))
mkdir(file_name);
end
fileID = fopen([file_name,'\basis_vectors.txt'],'w');
fprintf(fileID,'#Reduced Basis Vectors: a, b, c [pix]\n');
fprintf(fileID,[num2str(a),'\n']);
fprintf(fileID,[num2str(b),'\n']);
fprintf(fileID,[num2str(c),'\n']);
fprintf(fileID,'#Vectors lengths\n');
fprintf(fileID,['|a| = ',num2str(norm(a)),'\n']);
fprintf(fileID,['|b| = ',num2str(norm(b)),'\n']);
fprintf(fileID,['|c| = ',num2str(norm(c)),'\n']);
fprintf(fileID,'#Angles\n');
fprintf(fileID,['ang(a,b) = ',num2str(rad2deg(atan2(norm(cross(a,b)), dot(a,b)))),'\n']);
fprintf(fileID,['ang(b,c) = ',num2str(rad2deg(atan2(norm(cross(b,c)), dot(b,c)))),'\n']);
fprintf(fileID,['ang(a,c) = ',num2str(rad2deg(atan2(norm(cross(a,c)), dot(a,c)))),'\n']);

fclose(fileID);

create_hkl_img(params)
% assign_hkl();
end