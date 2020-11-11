function rotated_points = rot_around_vec(points,vector,angle)
a = angle;
vector = vector/norm(vector);
n1 = vector(1);
n2 = vector(2);
n3 = vector(3);
rotation_matrix = [n1^2*(1-cosd(a))+cosd(a), n1*n2*(1-cosd(a))-n3*sind(a), n1*n3*(1-cosd(a))+n2*sind(a);...
    n2*n1*(1-cosd(a))+n3*sind(a), n2^2*(1-cosd(a))+cosd(a), n2*n3*(1-cosd(a))-n1*sind(a);...
    n3*n1*(1-cosd(a))-n2*sind(a), n3*n2*(1-cosd(a))+n1*sind(a), n3^2*(1-cosd(a))+cosd(a)];
rotated_points = points*rotation_matrix;
end