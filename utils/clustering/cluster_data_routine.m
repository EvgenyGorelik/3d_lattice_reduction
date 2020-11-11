function cluster_data_routine(~,~,params,sld)
ind=find(params.int_val>=sld.Value);
show_data = single(params.data(ind,:));
show_val = single(params.int_val(ind));
radius = 5;
[params.cluster,~] = cluster_data(show_data,show_val,radius);

fig = figure('Position', [600 100 800 800], 'Name','3D data filtered','NumberTitle','off'); 
ax = axes(fig);
scatter3(ax, params.cluster(:,1) , params.cluster(:,2) , params.cluster(:,3),'.');
uicontrol('Style','text','position',[0 10 100 15],'String','Cluster Radius');
uicontrol('style','slider','position',[100 10 300 15],...
    'min', 10^-3, 'max', 10^2,'val', 10,...
    'Callback',@sliderChanged_01);
rad_labl = uicontrol('Style','text','position',[400 10 100 15],'String',radius);
uicontrol(fig,'style','pushbutton','position',[10 30 150 20],...
    'String','Calculate Difference Vectors',...
    'Callback',{@(u,v)diff_vec_routine(u,v,params)});
    function sliderChanged_01(src,~)
        radius = src.Value;
        rad_labl.String = radius;
        disp(['clustering values with radius ',num2str(radius)])
        [params.cluster,~] = cluster_data(show_data,show_val,radius);
        disp(['calulated ',num2str(size(params.cluster,1)),' clusters'])
        scatter3(ax, params.cluster(:,1) , params.cluster(:,2) , params.cluster(:,3),'.');
        axis tight
        daspect([1,1,1])
    end
end

