function [Header] = ta_mrc_read_header(fid)
narginchk(1, 2)
if fid==-1
    error('Cannot open:  mrc file'); 
end



Header.MRC.nx = fread(fid,[1],'int');        %integer: 4 bytes
Header.MRC.ny = fread(fid,[1],'int');        %integer: 4 bytes
Header.MRC.nz = fread(fid,[1],'int');        %integer: 4 bytes
Header.MRC.mode = fread(fid,[1],'int');      %integer: 4 bytes
Header.MRC.nxstart= fread(fid,[1],'int');    %integer: 4 bytes
Header.MRC.nystart= fread(fid,[1],'int');    %integer: 4 bytes
Header.MRC.nzstart= fread(fid,[1],'int');    %integer: 4 bytes
Header.MRC.mx= fread(fid,[1],'int');         %integer: 4 bytes
Header.MRC.my= fread(fid,[1],'int');         %integer: 4 bytes
Header.MRC.mz= fread(fid,[1],'int');         %integer: 4 bytes
Header.MRC.xlen= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.ylen= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.zlen= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.alpha= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.beta= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.gamma= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.mapc= fread(fid,[1],'int');       %integer: 4 bytes
Header.MRC.mapr= fread(fid,[1],'int');       %integer: 4 bytes
Header.MRC.maps= fread(fid,[1],'int');       %integer: 4 bytes
Header.MRC.amin= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.amax= fread(fid,[1],'float');     %float: 4 bytes
Header.MRC.amean= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.ispg= fread(fid,[1],'short');     %integer: 2 bytes
Header.MRC.nsymbt = fread(fid,[1],'short');  %integer: 2 bytes
Header.MRC.next = fread(fid,[1],'int');      %integer: 4 bytes
Header.MRC.dvid = fread(fid,[1],'short');  %integer: 2 bytes
Header.MRC.extra = fread(fid,[30]);        %not used: 30 bytes
Header.MRC.numintegers = fread(fid,[1],'short');    %integer: 2 bytes
Header.MRC.numfloats = fread(fid,[1],'short');   %integer: 2 bytes
Header.MRC.sub = fread(fid,[1],'short');    %integer: 2 bytes
Header.MRC.zfac = fread(fid,[1],'short');    %integer: 2 bytes
Header.MRC.min2= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.max2= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.min3= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.max3= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.min4= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.max4= fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.idtype= fread(fid,[1],'short');   %integer: 2 bytes
Header.MRC.lens=fread(fid,[1],'short');      %integer: 2 bytes
Header.MRC.nd1=fread(fid,[1],'short');       %integer: 2 bytes
Header.MRC.nd2 = fread(fid,[1],'short');     %integer: 2 bytes
Header.MRC.vd1 = fread(fid,[1],'short');     %integer: 2 bytes
Header.MRC.vd2 = fread(fid,[1],'short');     %integer: 2 bytes
for i=1:9                               %24 bytes in total
    Header.MRC.tiltangles(i)=fread(fid,[1],'float');%float: 4 bytes
end
Header.MRC.zorg = fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.xorg = fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.yorg = fread(fid,[1],'float');    %float: 4 bytes
Header.MRC.nlabl = fread(fid,[1],'int');     %integer: 4 bytes
Header.MRC.labl = fread(fid,[800],'char');   %Character: 800 bytes
if Header.MRC.nz>1
    Data_read=zeros(Header.MRC.nx,Header.MRC.ny,1);
else
    Data_read=zeros(Header.MRC.nx,Header.MRC.ny,1);
end
fseek(fid, 1024, 'bof');


if Header.MRC.next>0
    for i=1:Header.MRC.nz
        Header.Extended.a_tilt(i)= fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.b_tilt(i)= fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.x_stage(i)= fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.y_stage(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.z_stage(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.x_shift(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.y_shift(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.defocus(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.exposure(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.mean_intensity(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.tilt_axis(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.pixel_size(i)=fread(fid,[1],'float');%float: 4 bytes
        Header.Extended.magnification(i)=fread(fid,[1],'float'); %float: 4 bytes
        Header.Extended.Microscope_type(i)=fread(fid,[1],'float');
        Header.Extended.Gun_type(i)=fread(fid,[1],'float');
        Header.Extended.Lens_type(i)=fread(fid,[1],'float');
        Header.Extended.D_number_of_microscope(i)=fread(fid,[1],'float');
        Header.Extended.High_tension(i)=fread(fid,[1],'float');
        Header.Extended.Diffraction_lens_value_in_percent(i)=fread(fid,[1],'float');
        Header.Extended.MTF(i)=fread(fid,[1],'float');
        Header.Extended.Starting_Df(i)=fread(fid,[1],'float');
        Header.Extended.Focus_step(i)=fread(fid,[1],'float');
        Header.Extended.DAC_setting(i)=fread(fid,[1],'float');
        Header.Extended.Spherical_aberration(i)=fread(fid,[1],'float');
        Header.Extended.Semi_convergence(i)=fread(fid,[1],'float');
        Header.Extended.Info_limit(i)=fread(fid,[1],'float');
        Header.Extended.Number_of_images(i)=fread(fid,[1],'float');
        
        fseek(fid, 1024+i*Header.MRC.numfloats*4, 'bof');
        
        
    end
end




%     fwrite(fid_mrc, Extended.Image_number_in_series(i), 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Coma_3_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Coma_3_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_2_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_2_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_3_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_3_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Camera_type_number, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Camera_position, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Spherical_Aberration_4, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Star_Aberration_4_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Star_Aberration_4_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_4_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_4_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Coma_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Coma_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Three_Lobe_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Three_Lobe_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Spherical_Aberration_6, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Star_Aberration_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Star_Aberration_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Rosette_Aberration_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Rosette_Aberration_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.Astigmatism_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Extended.SI_Units, 'float');   % float 4-byte 






if Header.MRC.next>0
    fseek(fid,0,'bof');
    Header.buff= fread(fid, (Header.MRC.numfloats*4+1)*1024);        
    
    fseek(fid,1024,'bof');
    Header.Extended.buff= fread(fid,Header.MRC.numfloats*4*1024);
    
    fseek(fid,(Header.MRC.numfloats*4+1)*1024,'bof'); 
else 
    fseek(fid, 0, 'bof');
    Header.buff= fread(fid, 1024); 
    fseek(fid, 1024, 'bof');
end
% disp('out of ta_mrc_read_header')
