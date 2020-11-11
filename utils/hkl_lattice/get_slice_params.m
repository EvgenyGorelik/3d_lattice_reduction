function [translated_points,hkl,inner_reg_sq,outer_reg_sq,save_images,with_text] = get_slice_params(params,img)
thres = 5;
[hkl,translated_points] = get_hkl_slices(params,thres);
fig = figure;
uicontrol(fig,'Style','text','position',[0 70 100 15],'String','Slice Width');
uicontrol(fig,'Style','edit','position',[0 55 100 15],'String',thres,'Callback',@threshVal);
uicontrol(fig,'Style','text','position',[0 20 100 15],'String','Inner Bound');
in_sld = uicontrol(fig,'style','slider','position',[100 20 300 15],...
    'min', 1, 'max', 99,'val',5,'Callback',@sld_changed);
in_labl = uicontrol('Style','text','position',[400 20 100 15],'String',in_sld.Value);
uicontrol(fig,'Style','text','position',[0 35 100 15],'String','Outer Bound');
out_sld = uicontrol(fig,'style','slider','position',[100 35 300 15],...
    'min', 2, 'max', 100,'val',8,'Callback',@sld_changed);
out_labl = uicontrol('Style','text','position',[400 35 100 15],'String',out_sld.Value);
uicontrol(fig,'style','pushbutton','position',[60 5 50 15],'String','Index hkl','Callback',@finished);
uicontrol(fig,'style','checkbox','position',[160 5 100 15],'String','With Text','Callback',@text_ctrl);
uicontrol(fig,'style','checkbox','position',[260 5 100 15],'String','Save Images','Callback',@save_ctrl);
[nx,ny] = size(img);
[x_grid,y_grid] = meshgrid(1:nx,1:ny);
x_grid = reshape(x_grid,[],1);
y_grid = reshape(y_grid,[],1);
inner_reg_sq = 5^2;
outer_reg_sq = 8^2;
with_text = false;
save_images = false;
vis_img = img;
ind = find(translated_points(:,3) == 1);
text_hkl = strings(length(ind),1);
text_pos = zeros(length(ind),2);
for i = 1:length(ind)
    % find original point
    outer_ind = find((x_grid-translated_points(ind(i),2)).^2 +...
        (y_grid-translated_points(ind(i),1)).^2 > inner_reg_sq & ...
        (x_grid-translated_points(ind(i),2)).^2 +...
        (y_grid-translated_points(ind(i),1)).^2 < outer_reg_sq);
    vis_img(outer_ind) = 500;
    tmp_text = num2str(hkl(ind(i),:),'%.0f,');
    text_hkl(i) = ['(',tmp_text(1:end-1),')'];
    text_pos(i,:) = translated_points(ind(i),1:2)+[0,sqrt(outer_reg_sq)];
end
imshow(vis_img,[min(min(vis_img)),2000]);
colormap 'jet'
    function sld_changed(~,~)
        cla(fig);
        if(out_sld.Value <= in_sld.Value)
            in_sld.Value = out_sld.Value - 1;
        elseif(in_sld.Value >= out_sld.Value)
            out_sld.Value = in_sld.Value + 1;
        end
        in_labl.String = in_sld.Value;
        out_labl.String = out_sld.Value;
        inner_reg_sq = in_sld.Value^2;
        outer_reg_sq = out_sld.Value^2;
        vis_img = img;
        ind = find(translated_points(:,3) == 1);
        text_hkl = strings(length(ind),1);
        text_pos = zeros(length(ind),2);
        for j = 1:length(ind)
            % find original point
            outer_ind = find((x_grid-translated_points(ind(j),2)).^2 +...
                (y_grid-translated_points(ind(j),1)).^2>inner_reg_sq & ...
                (x_grid-translated_points(ind(j),2)).^2 +...
                (y_grid-translated_points(ind(j),1)).^2<outer_reg_sq);
            vis_img(outer_ind) = 500;
            tmp_text = num2str(hkl(ind(j),:),'%.0f,');
            text_hkl(j) = ['(',tmp_text(1:end-1),')'];
            text_pos(j,:) = translated_points(ind(j),1:2)+[0,sqrt(outer_reg_sq)];
        end
        imshow(vis_img,[min(min(vis_img)),2000]);
        colormap 'jet'
        if(with_text)
            text(text_pos(:,2),text_pos(:,1),text_hkl,'FontSize',5);
        end
    end
    function finished(~,~)
        exit = true;
        close(fig);
    end
    function text_ctrl(src,~)
        with_text = src.Value;
        cla(fig);
        imshow(vis_img,[min(min(vis_img)),2000]);
        colormap 'jet'
        if(with_text)
            text(text_pos(:,2),text_pos(:,1),text_hkl,'FontSize',5);
        end
    end
    function save_ctrl(src,~)
        save_images = src.Value;
    end
    function threshVal(src,~)
        [hkl,translated_points] = get_hkl_slices(params,str2double(src.String));
        sld_changed();
    end
exit = false;
while(~exit)
    pause(.1);
end
end