function ta_mrc_write_header(fid_mrc, Header)
% disp('function ta_mrc_write_header');
% if nargin<1
%     error(['Data not specified (e.g. tom_mrcwrite(out)']);
% elseif nargin==1
%     error(['File not specified (e.g. tom_mrcwrite(out)']);
% elseif nargin==2
%     fid=varargin{1};
%     Header=varargin{2};
% end;
% 


fwrite(fid_mrc, Header.Basic.nx, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.ny, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.nz, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.mode, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.nxstart, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.nystart, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.nzstart, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.mx, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.my, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.mz, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.xlen, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.ylen, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.zlen, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.alpha, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.beta, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.gamma, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.mapc, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.mapr, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.maps, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.amin, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.amax, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.amean, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.ispg, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.nsymbt, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.next, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.dvid, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.extra, 'char');   % extra 30 bytes data (not used)
fwrite(fid_mrc, Header.Basic.numintegers, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.numfloats, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.sub, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.zfac, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.min2, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.max2, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.min3, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.max3, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.min4, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.max4, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.idtype, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.lens, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.nd1, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.nd2, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.vd1, 'short');   % integer 2-byte 
fwrite(fid_mrc, Header.Basic.vd2, 'short');   % integer 2-byte 
for i=1:9                               
    fwrite(fid_mrc, Header.Basic.tiltangles(i), 'float');   %float 4-byte
end
fwrite(fid_mrc, Header.Basic.zorg, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.xorg, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.yorg, 'float');   % float 4-byte 
fwrite(fid_mrc, Header.Basic.nlabl, 'int');   % integer 4-byte 
fwrite(fid_mrc, Header.Basic.labl, 'char');   % 10 text labels with 80 characters



% fwrite(fid,Header.MRC.nx,'int');           %integer: 4 bytes
% fwrite(fid,Header.MRC.ny,'int');            %integer: 4 bytes
% fwrite(fid,Header.MRC.nz,'int');            %integer: 4 bytes
% fwrite(fid,Header.MRC.mode,'int');         %integer: 4 bytes
% fwrite(fid,Header.MRC.nxstart,'int');      %integer: 4 bytes
% fwrite(fid,Header.MRC.nystart,'int');      %integer: 4 bytes
% fwrite(fid,Header.MRC.nzstart,'int');      %integer: 4 bytes
% fwrite(fid,Header.MRC.mx,'int');           %integer: 4 bytes
% fwrite(fid,Header.MRC.my,'int');           %integer: 4 bytes
% fwrite(fid,Header.MRC.mz,'int');           %integer: 4 bytes
% fwrite(fid,Header.MRC.xlen,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.ylen,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.zlen,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.alpha,'float');      %float: 4 bytes
% fwrite(fid,Header.MRC.beta,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.gamma,'float');      %float: 4 bytes
% fwrite(fid,Header.MRC.mapc,'int');         %integer: 4 bytes
% fwrite(fid,Header.MRC.mapr,'int');         %integer: 4 bytes
% fwrite(fid,Header.MRC.maps,'int');         %integer: 4 bytes
% fwrite(fid,Header.MRC.amin,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.amax,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.amean,'float');      %float: 4 bytes
% fwrite(fid,Header.MRC.ispg,'short');       %integer: 2 bytes
% fwrite(fid,Header.MRC.nsymbt,'short');     %integer: 2 bytes
% fwrite(fid,Header.MRC.next,'int');         %integer: 4 bytes
% fwrite(fid,Header.MRC.creatid,'short');    %integer: 2 bytes
% fwrite(fid,'..............................');                   %not used: 30 bytes
% fwrite(fid,Header.MRC.nint,'short');       %integer: 2 bytes
% fwrite(fid,Header.MRC.nreal,'short');      %integer: 2 bytes
% fwrite(fid,'............................'); %not used: 28 bytes
% fwrite(fid,Header.MRC.idtype,'short');     %integer: 2 bytes
% fwrite(fid,Header.MRC.lens,'short');       %integer: 2 bytes
% fwrite(fid,Header.MRC.nd1,'short');        %integer: 2 bytes
% fwrite(fid,Header.MRC.nd2,'short');        %integer: 2 bytes
% fwrite(fid,Header.MRC.vd1,'short');        %integer: 2 bytes
% fwrite(fid,Header.MRC.vd2,'short'); %integer: 2 bytes
% for i=1:6                               %24 bytes in total
%     fwrite(fid,Header.MRC.tiltangles(i),'float');%float: 4 bytes
% end
% fwrite(fid,Header.MRC.xorg,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.yorg,'float');       %float: 4 bytes
% fwrite(fid,Header.MRC.zorg,'float');       %float: 4 bytes
% fwrite(fid,'cmap');        %Character: 4 bytes
% fwrite(fid,'....');       %Character: 4 bytes
% % fwrite(fid,Header.MRC.rms,'float');        %float: 4 bytes
% fwrite(fid,Header.MRC.nlabl,'int');        %integer: 4 bytes
% fwrite(fid,Header.MRC.labl,'char');        %Character: 800 bytes
% comment=char(zeros(76,1));
% if Header.MRC.next>0
%     fwrite(fid, Header.Extended.buff);
% %     for i=1:(Header.MRC.nz)
% %         fwrite(fid, Header.Extended.a_tilt(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.b_tilt(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.x_stage(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.y_stage(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.z_stage(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.x_shift(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.y_shift(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.defocus(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.exp_time(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.mean_int(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.tiltaxis(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.pixelsize(i),'float');%float: 4 bytes
% %         fwrite(fid, Header.Extended.magnification(i),'float'); %float: 4 bytes
% %         fwrite(fid, comment, 'char');   %Character: 76 bytes
% %         
% %     end
% end
comment=char(zeros((1024-Header.Basic.nz)*Header.Basic.numfloats*4,1));    
if Header.Basic.next>0
    fwrite(fid_mrc, comment, 'char');
    disp('writing extended header')
    %%%%%%% WRITING EXTENDED HEADER
    for i=1:Header.Basic.nz
        status = fseek(fid_mrc, 1024+Header.Basic.numfloats*4*(i-1), 'bof');
        fwrite(fid_mrc, Header.Extended.a_tilt(i), 'float');   % float 4-byte 
        fwrite(fid_mrc, Header.Extended.b_tilt(i), 'float');   % float 4-byte 
        fwrite(fid_mrc, Header.Extended.x_stage(i), 'float');   % float 4-byte 
        fwrite(fid_mrc, Header.Extended.y_stage(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.z_stage(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.x_shift(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.y_shift(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.defocus(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.exposure(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.mean_intensity(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.tilt_axis(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.pixel_size(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.magnification(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Microscope_type(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Gun_type(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Lens_type(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.D_number_of_microscope(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.High_tension(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Diffraction_lens_value_in_percent(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.MTF(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Starting_Df(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Focus_step(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.DAC_setting(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Spherical_aberration(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Semi_convergence(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Info_limit(i), 'float');   % float 4-byte 
    fwrite(fid_mrc, Header.Extended.Number_of_images(i), 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Image_number_in_series(i), 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Coma_3_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Coma_3_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_2_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_2_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_3_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_3_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Camera_type_number, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Camera_position, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Spherical_Aberration_4, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Star_Aberration_4_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Star_Aberration_4_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_4_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_4_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Coma_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Coma_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Three_Lobe_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Three_Lobe_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_5_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_5_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Spherical_Aberration_6, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Star_Aberration_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Star_Aberration_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Rosette_Aberration_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Rosette_Aberration_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_6_X, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.Astigmatism_6_Y, 'float');   % float 4-byte 
%     fwrite(fid_mrc, Header.Extended.SI_Units, 'float');   % float 4-byte 

end
    
else
    disp('writing short header')
    fseek(fid_mrc, 1024, 'bof');
end     

pos=ftell(fid_mrc);
if pos< 156672
    comment=char(zeros(156672-pos, 1));    
    fwrite(fid_mrc, comment, 'char');
end
% disp('out of ta_mrc_write_header')


