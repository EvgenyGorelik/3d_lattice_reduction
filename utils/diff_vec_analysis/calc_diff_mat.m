function diff_mat = calc_diff_mat(data)
% returns difference vector of every vector with every other vector in data
n = size(data,1);
diff_mat = zeros(n^2,3);
for i = 1:n
    diff_mat(1+(i-1)*n:i*n,:) = data - data(i,:);
end
end
