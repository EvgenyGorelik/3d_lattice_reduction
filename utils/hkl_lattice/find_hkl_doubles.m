function valid = find_hkl_doubles(hkl,intensity)
valid = true(size(hkl,1),1);
for i = 1:length(valid)
    if(valid(i))
        ind = find(hkl(:,1) == hkl(i,1) & hkl(:,2) == hkl(i,2) & hkl(:,3) == hkl(i,3));
        if(length(ind)>1)
            [~,max_ind] = max(intensity(ind));
            valid(ind(ind ~= ind(max_ind))) = 0;
        end
    end
end
end