function mat = rot_mat(angle)
% rotational matrix dependent on angle
mat = ...
    [cosd(angle),-sind(angle);
    sind(angle),cosd(angle)];
end