function ref_vec = refine_vector(vec,diff_mat,radius,max_range)
range_vec = -max_range:max_range;
[p_dist,p_project] = point_to_plane_distance(diff_mat, vec, vec*range_vec(1));
p_dist = p_dist - norm(vec*range_vec(1));
p_project = p_project - vec*range_vec(1);
norm_vec = [0,0,1];
ang = ang_btw_vec(vec,norm_vec);
if(ang > 90)
    ang = -ang;
end
rot_vec = null([vec;norm_vec]);
rot_project = rot_around_vec(p_project,rot_vec,ang);
vec_ind = find(abs(rot_project(:,1)) < radius & abs(rot_project(:,2)) < radius);
sd_mat = diff_mat(vec_ind,:);
index_vector = zeros(size(sd_mat,1),1,'int16');
vec_norm = norm(vec);
for i = 1:length(range_vec)
    ind = find(abs(p_dist(vec_ind) - vec_norm*range_vec(i)) < vec_norm/2);
    index_vector(ind) = ones(length(ind),1)*i;
end
    function result = evaluate(p)
        result = 0;
        for j = 1:length(range_vec)
            result = result + sum(vecnorm((p*range_vec(j) - sd_mat(index_vector == j,:))'));
        end
    end
ref_vec = fminsearch(@evaluate,vec);
end