function refine_vectors_routine(params,diff_mat,diff_norm,disp_rad)
det_base_vectors = params.base_vectors;
ref_vectors = params.base_vectors;
vector_names = ['a','b','c'];
ref_rad = 5;
show_diff_mat = diff_mat(diff_norm < disp_rad,:);
fig1 = figure('Position', [800 100 800 800], 'Name','Refine Basis Vectors','NumberTitle','off'); 
ax = axes(fig1);
scatter3(ax, show_diff_mat(:,1) , show_diff_mat(:,2) , show_diff_mat(:,3),'.');
text(0,0,0,'o');
hold on
for j = 1:size(ref_vectors,1)
    text(ref_vectors(j,1),ref_vectors(j,2),ref_vectors(j,3),vector_names(j));
    it_max = floor(disp_rad/norm(ref_vectors(j,:)));
    range_vec = -it_max:it_max;
    scatter3(ref_vectors(j,1)*range_vec,ref_vectors(j,2)*range_vec,ref_vectors(j,3)*range_vec)
end
uicontrol(fig1,'Style','text','position',[0 10 100 15],'String','Display Radius');
uicontrol(fig1,'style','slider','position',[100 10 300 15],...
    'min', min(diff_norm), 'max', max(diff_norm),'val', disp_rad,...
    'Callback',@dispRadChanged_01);
disp_rad_labl = uicontrol('Style','text','position',[400 10 100 15],'String',disp_rad);
uicontrol(fig1,'Style','text','position',[0 25 100 15],'String','Refinement Radius');
uicontrol(fig1,'style','slider','position',[100 25 300 15],...
    'min', 0, 'max', 100,'val', 5,...
    'Callback',@refRadChanged);
ref_rad_labl = uicontrol('Style','text','position',[400 25 100 15],'String',ref_rad);
uicontrol(fig1,'style','pushbutton','position',[10 60 150 20],...
    'String','Finish Refinement',...
    'Callback',@refFinished);
uicontrol('Style','text','position',[0 40 100 15],'String','Refinement Muliplicity');
max_mult_edit = uicontrol(fig1,'Style','edit','position',[100 40 100 15],'String',5,'Callback',@max_mult);
    function dispRadChanged_01(src,~)
        disp_rad = src.Value;
        disp_rad_labl.String = disp_rad;
        replot();
    end
    function refRadChanged(src,~)
        ref_rad = src.Value;
        ref_rad_labl.String = ref_rad;
        disp('refining...')
        for i = 1:size(ref_vectors,1)
            ref_vectors(i,:) = refine_vector(det_base_vectors(i,:),diff_mat,ref_rad,str2double(max_mult_edit.String));
            disp(['refined vector ',vector_names(i),' is ',num2str(ref_vectors(i,:))])
        end
        replot();
    end
    function max_mult(~,~)
        disp('refining...')
        for i = 1:size(ref_vectors,1)
            ref_vectors(i,:) = refine_vector(det_base_vectors(i,:),diff_mat,ref_rad,str2double(max_mult_edit.String));
            disp(['refined vector ',vector_names(i),' is ',num2str(ref_vectors(i,:))])
        end
        replot();
    end
    function replot()
        view_param = ax.View;
        cla(ax)
        show_diff_mat = diff_mat(diff_norm < disp_rad,:);
        scatter3(ax, show_diff_mat(:,1) , show_diff_mat(:,2) , show_diff_mat(:,3),'.');
        text(0,0,0,'o');
        hold on
        for i = 1:size(ref_vectors,1)
            text(ref_vectors(i,1),ref_vectors(i,2),ref_vectors(i,3),vector_names(i));
            it_max = floor(disp_rad/norm(ref_vectors(i,:)));
            range_vec = -it_max:it_max;
            scatter3(ref_vectors(i,1)*range_vec,ref_vectors(i,2)*range_vec,ref_vectors(i,3)*range_vec)
        end
        daspect([1,1,1])
        view(view_param);
    end
    function refFinished(~,~)
        params.base_vectors = ref_vectors;
        create_grid(params);
    end
end
