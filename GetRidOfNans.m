function [dataWithoutNans,nan_indices]  = GetRidOfNans(data)
%Function finds NaN value entries in data and removes them

[n,m]=size(data);

if n<m
    data=data';
end



% Find indices of NaN values
nan_indices = isnan(data);

% Number of NaN values
count=0;
for i=1:length(nan_indices)
    if nan_indices(i,1)==1
        count=count+1;
    end
end

% Exclude NaN values from the vector
dataWithoutNans = data(~nan_indices);

end
