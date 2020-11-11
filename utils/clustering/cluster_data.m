function [cluster,cluster_values] = cluster_data(data,values,radius)
cluster_count = 1;
cluster_ind = zeros(size(data,1),1,'int16');
for i = 1:size(data,1)
        if(cluster_ind(i)==0)
            cluster_ind(vecnorm((data(i,:)-data)') < radius) = cluster_count;
            cluster_count = cluster_count+1;
        end
end
% actual number of clusters
cluster_count = cluster_count - 1;
cluster = zeros(cluster_count,3);
cluster_values = zeros(cluster_count,3);
for i = 1:cluster_count
    cluster(i,:) = mean(data(cluster_ind == i,:),1);
    cluster_values(i) = sum(values(cluster_ind == i));
end
end