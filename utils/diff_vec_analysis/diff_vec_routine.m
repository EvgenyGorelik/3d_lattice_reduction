function diff_vec_routine(~,~,params)
params.base_vectors = zeros(0,3);
vector_names = ['a','b','c'];
diff_mat = calc_diff_mat(params.cluster);
diff_norm = vecnorm(diff_mat');
disp_rad = max(diff_norm)*0.7;
show_diff_mat = diff_mat(diff_norm < disp_rad,:);
fig = figure('Position', [800 100 800 800], 'Name','DVS, select three non-coplanar vectors','NumberTitle','off'); 
ax = axes(fig);
scatter3(ax, show_diff_mat(:,1) , show_diff_mat(:,2) , show_diff_mat(:,3),'.');
text(0,0,0,'o');
uicontrol('Style','text','position',[0 10 100 15],'String','Display Radius');
uicontrol('style','slider','position',[100 10 300 15],...
    'min', min(diff_norm), 'max', max(diff_norm),'val', disp_rad,...
    'Callback',@sliderChanged_02);
rad_labl = uicontrol('Style','text','position',[400 10 100 15],'String',disp_rad);
    function sliderChanged_02(src,~)
        view_param = ax.View;
        disp_rad = src.Value;
        rad_labl.String = disp_rad;
        cla(ax)
        show_diff_mat = diff_mat(diff_norm < disp_rad,:);
        scatter3(ax, show_diff_mat(:,1) , show_diff_mat(:,2) , show_diff_mat(:,3),'.');
        text(0,0,0,'o');
        hold on
        for i = 1:size(params.base_vectors,1)
            text(params.base_vectors(i,1),params.base_vectors(i,2),params.base_vectors(i,3),vector_names(i));
            it_max = floor(disp_rad/norm(params.base_vectors(i,:)));
            range_vec = -it_max:it_max;
            scatter3(params.base_vectors(i,1)*range_vec,params.base_vectors(i,2)*range_vec,params.base_vectors(i,3)*range_vec)
        end
        daspect([1,1,1])
        view(view_param);
    end
disp('Select 3 Basis Vector Clusters with the brush')
h=brush(fig);
set(h,'ActionPostCallback',{@(u,v)brush_data_selected(u,v,params,diff_mat,diff_norm,fig)});
end

