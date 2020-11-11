function d = point_to_line(pt, v1, v2)
% function for determining distance point to line
a = v1 - v2;
b = pt - v2;
d = norm(cross(a,b)) / norm(a);
end