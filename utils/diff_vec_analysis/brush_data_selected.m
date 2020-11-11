function brush_data_selected(~,~,params,diff_mat,diff_norm,fig)
global base_vectors
% get coordinates of selected points
% h=findobj(gca,'type','scatter');
h = fig.Children(end).Children(end);
idx=get(h,'BrushData');
idx=logical(idx);
x=get(h,'XData');
x=x(idx);
y=get(h,'YData');
y=y(idx);
z=get(h,'ZData');
z=z(idx);

vector_names = ['a','b','c'];
% draw line through points by regression
mat=[transpose(x),transpose(y),transpose(z)];
X_ave=mean(mat,1);
base_vectors(end+1,:) = X_ave;
max_range = str2double(fig.Children(1).String);
hold on
for i = 1:size(base_vectors,1)
    text(base_vectors(i,1),base_vectors(i,2),base_vectors(i,3),vector_names(i));
    it_max = floor(max_range/norm(base_vectors(i,:)));
    range_vec = -it_max:it_max;
    scatter3(base_vectors(i,1)*range_vec,base_vectors(i,2)*range_vec,base_vectors(i,3)*range_vec)
end
disp(['vector ',vector_names(size(base_vectors,1)),' is ',num2str(X_ave)])
if(size(base_vectors,1) == 3)
    params.base_vectors = base_vectors;
    base_vectors = zeros(0,3);
    refine_vectors_routine(params,diff_mat,diff_norm,str2double(fig.Children(1).String));
end
end

