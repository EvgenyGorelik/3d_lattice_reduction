function deg = ang_btw_vec(a,b)
deg = rad2deg(atan2(norm(cross(a,b)), dot(a,b)));
end
