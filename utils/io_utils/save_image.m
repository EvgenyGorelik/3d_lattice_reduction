function save_image(file_name,j)
F = getframe(gcf);
    [X, ~] = frame2im(F);
    imwrite(X,[file_name,'\slice_',num2str(j,'%03.f'),'.jpg']);
end