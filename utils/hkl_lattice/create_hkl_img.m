function create_hkl_img(params)
fid_in = fopen(params.fname_in,'r');
ta_mrc_read_header(fid_in);
[x_grid,y_grid] = meshgrid(1:params.nx,1:params.ny);
x_grid = reshape(x_grid,[],1);
y_grid = reshape(y_grid,[],1);

save_images = false;
with_text = false;
file_name = get_file_name(params);
iptsetpref('ImshowBorder','tight');
disp('starting indexing')
start_time=clock;
for j=1:params.nz
    % read data slice-wise
    disp(['indexing slice ',num2str(j),'/',num2str(params.nz)]);
    img = fread(fid_in,[params.nx,params.ny],'int16');
    % rotate matrix by 90deg
    img = rot90(img);
    vis_img = img;
    if(j==1)
       [translated_points,hkl,inner_reg_sq,outer_reg_sq,save_images,with_text] = ...
           get_slice_params(params,vis_img);
       intensities = zeros(size(translated_points,1),1);
       outer_means = zeros(size(translated_points,1),1);
       refined_trans_points = translated_points;
       figure;
    end
    ind = find(translated_points(:,3) == j);
    if(with_text)
        text_hkl = strings(length(ind),1);
        text_pos = zeros(length(ind),2);
    end
    for i = 1:length(ind)
        % find original point
        outer_ind = find((x_grid-translated_points(ind(i),2)).^2 +...
        (y_grid-translated_points(ind(i),1)).^2>inner_reg_sq & ...
            (x_grid-translated_points(ind(i),2)).^2 +...
        (y_grid-translated_points(ind(i),1)).^2<outer_reg_sq);
        inner_ind = find((x_grid-translated_points(ind(i),2)).^2 +...
        (y_grid-translated_points(ind(i),1)).^2<inner_reg_sq);
        %check if consistent of maximum in region
        [~,max_index] = max(img(inner_ind));
        [refined_trans_points(ind(i),1),refined_trans_points(ind(i),2)] = ind2sub([params.nx,params.ny],inner_ind(max_index));
        % calculate intensity - average of surrounding
        ref_outer_ind = find((x_grid-refined_trans_points(ind(i),2)).^2 +...
        (y_grid-refined_trans_points(ind(i),1)).^2>inner_reg_sq & ...
            (x_grid-refined_trans_points(ind(i),2)).^2 +...
        (y_grid-refined_trans_points(ind(i),1)).^2<outer_reg_sq);
        outer_means(ind(i)) = mean(mean(img(ref_outer_ind)));
        ref_inner_ind = find((x_grid-refined_trans_points(ind(i),2)).^2 +...
        (y_grid-refined_trans_points(ind(i),1)).^2<inner_reg_sq);
        intensities(ind(i)) = sum(sum(img(ref_inner_ind)-outer_means(ind(i))));
            vis_img(outer_ind) = 500;
            vis_img(ref_outer_ind) = 2000;
            if(with_text)
                tmp_text = num2str(hkl(ind(i),:),'%.0f,');
                text_hkl(i) = ['(',tmp_text(1:end-1),')'];
                text_pos(i,:) = refined_trans_points(ind(i),1:2)+[0,sqrt(outer_reg_sq)];
            end
        if(intensities(ind(i))<0)
            intensities(ind(i)) = 0;
        end
    end
    imshow(vis_img,[min(min(vis_img)),2000]);
    colormap 'jet'
    if(with_text)
        text(text_pos(:,2),text_pos(:,1),text_hkl,'FontSize',5, 'Color', 'yellow');
    end
    if(save_images)
        save_image(file_name,j)
    end
end
fclose(fid_in);
disp(['finished indexing(', num2str(etime(clock,start_time)),' sec)']);
save_hkl(params,hkl,intensities,translated_points,refined_trans_points,outer_means);
end