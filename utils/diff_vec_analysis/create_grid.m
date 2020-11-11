function create_grid(params)
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
thresh = max(params.int_val)*0.7;
[ind]=find(params.int_val>=thresh);
show_data = single(params.data(ind,:));
show_val = single(params.int_val(ind));
show_points = points(vecnorm(points') < max(vecnorm(show_data')),:);
fig = figure('Position', [600 100 800 800], 'Name','overlay of the data and the lattice grid','NumberTitle','off'); 
ax = axes(fig);
scatter3(ax, show_data(:,1) , show_data(:,2) , show_data(:,3), show_val*100/max(show_val), show_val*100/max(show_val), 'filled');
hold on
scatter3(ax, show_points(:,1) , show_points(:,2) , show_points(:,3),'.');
daspect([1,1,1]);
uicontrol('Style','text','position',[0 10 100 15],'String','Intensity Threshold');
uicontrol('style','slider','position',[100 10 300 15],...
    'min', min(params.int_val), 'max', max(params.int_val),'val', thresh,...
    'Callback',@sliderChanged_03);
thresh_labl = uicontrol('Style','text','position',[400 10 100 15],'String',thresh);
uicontrol(fig,'style','pushbutton','position',[10 30 150 20],...
    'String','Reduce Basis Vectors',...
    'Callback',@buttonPushed_02);
    function sliderChanged_03(src,~)
        thresh = src.Value;
        thresh_labl.String = thresh;
        view_param = ax.View;
        cla(ax);
        [ind]=find(params.int_val>=thresh);
        show_data = params.data(ind,:);
        show_val = single(params.int_val(ind));
        show_points = points(vecnorm(points') < max(vecnorm(show_data')),:);
        scatter3(ax, show_data(:,1) , show_data(:,2) , show_data(:,3), show_val*100/max(show_val), show_val*100/max(show_val), 'filled');
        hold on
        scatter3(ax, show_points(:,1) , show_points(:,2) , show_points(:,3),'.');
        view(view_param);
        daspect([1,1,1]);
    end
    function buttonPushed_02(~,~)
        reduce_base(params,points);
    end
end
