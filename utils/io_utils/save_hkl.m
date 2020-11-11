function save_hkl(params,hkl,intensity,translated_points,refined_trans_points,outer_means)
% [file,path,~] = uiputfile('hkl.txt');
fileID = fopen([get_file_name(params),'\hkl_full.txt'],'w');
fprintf(fileID,'%6s %6s %6s %16s %16s %6s %6s %6s %6s %12s\n','h','k','l','int','mean','x_orig','y_orig','x_ref','y_ref','tilt');
fprintf(fileID,'%6i %6i %6i %16f %16f %6i %6i %6i %6i %12f\n',[single(hkl),single(intensity),outer_means,translated_points(:,1:2),refined_trans_points(:,1:2),params.tilt(translated_points(:,3))']');
fclose(fileID);
valid = find_hkl_doubles(hkl,intensity);
fileID = fopen([get_file_name(params),'\hkl_reduced.txt'],'w');
fprintf(fileID,'%6s %6s %6s %12s %12s %12s\n','h','k','l','int','sqrt(int)','tilt');
fprintf(fileID,'%6i %6i %6i %12f %12f %12f\n',[single(hkl(valid,:)),single(intensity(valid)),sqrt(single(intensity(valid))),params.tilt(translated_points(valid,3))']');
fclose(fileID);
end