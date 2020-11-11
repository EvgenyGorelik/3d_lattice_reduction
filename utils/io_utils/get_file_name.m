function name = get_file_name(params)
dotLocations = find(params.fname_in == '.');
if isempty(dotLocations)
% No dots at all found so just take entire name.
name = params.fname_in;
else
% Take up to , but not including, the first dot.
name = params.fname_in(1:dotLocations(end)-1);
end
end