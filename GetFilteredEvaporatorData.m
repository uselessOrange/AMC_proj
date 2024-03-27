function [x_filtered] = GetFilteredEvaporatorData(data)
% Function returns Evaporator Temperature after lowpass filtering


% Data filtering
% Find indices of NaN values
nan_indices = isnan(data.parownik);

% Number of NaN values
count=0;
for i=1:length(nan_indices)
    if nan_indices(i,1)==1
        count=count+1;
    end
end

% Exclude NaN values from the vector
parownik = data.parownik(~nan_indices);


% Filter desigend in Matlab FilterDesigner and exported into filterF.m script
Hd=filterF;

% Filtering
x_filtered=Hd.filter(parownik);

% Adjusting the delay and signal gain from filter 
group_delay = floor((length(Hd.Numerator) - 1)/2);
x_filtered = x_filtered(group_delay+1:end);

scale_factor = max(parownik) / max(x_filtered);
x_filtered = x_filtered * scale_factor;

end