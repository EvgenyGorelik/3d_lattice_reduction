function [p_project,theta1,theta2] = rotate_projection(projection,c)
[theta1,~,~] = cart2pol(c(1),c(2),c(3));
c_rot1 = c*rotz(rad2deg(theta1));
[theta2,~,~] = cart2pol(c_rot1(3),c_rot1(1),c_rot1(2));
rot_mat1 = rotz(rad2deg(theta1));
rot_mat2 = roty(rad2deg(theta2));
p_project = projection*rot_mat1*rot_mat2;
end