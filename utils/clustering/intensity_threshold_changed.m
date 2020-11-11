function intensity_threshold_changed(source,~,params,ax,thresh_labl)
params.data = params.data;
thresh_labl.String = source.Value; 
[ind]=find(params.int_val>=source.Value);
show_data = params.data(ind,:);
show_val = single(params.int_val(ind));
view_param = ax.View;
scatter3(ax, show_data(:,1) , show_data(:,2) , show_data(:,3), show_val*100/max(show_val), show_val*100/max(show_val), 'filled');
view(view_param);
xlabel('x')
ylabel('y')
zlabel('z')
disp(['plotting ',num2str(length(ind)),' points with treshold ', num2str(source.Value)]);
end

