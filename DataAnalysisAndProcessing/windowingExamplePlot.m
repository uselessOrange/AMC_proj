clear
load('data.mat')

%Data filtering

% Find indices of NaN values
nan_indices = isnan(data.parownik);

% Exclude NaN values from the vector
parownik = data.parownik(~nan_indices);
%% Ploting the windowing
figure
window=8800:9600;
plot(window,parownik(window));hold on;

windowLength = 100;
overlap = round(0.25*windowLength);

cycle = 0;
while windowLength*(cycle+1)-overlap*cycle<length(window)
    a=windowLength*cycle+1-overlap*cycle;
    b=windowLength*(cycle+1)-overlap*cycle;
    c=mean(parownik(a:b));
    plotRectAngle(window(a),window(b),c);
    cycle=cycle+1;
end
hold off

%% Window feature extraction (f2 not finished)

n=length(parownik);

windowLength = 100;
overlap = round(0.25*windowLength);

[f1,f2]=featureExtract(n, windowLength, overlap, parownik);

cycle = round(-(n - windowLength)/(overlap - windowLength)+1);

disp(size(f1))
disp(cycle)

x=linspace(1,length(parownik),length(f1));

figure
plot(x,f1);hold on;

plot(parownik);


function [f1,f2]=featureExtract(n, windowLength, overlap, data_scaled)

cycle_number=-(n - windowLength)/(overlap - windowLength);
cycle_number=floor(cycle_number);

f1=zeros(cycle_number,3);
f2=f1;

for cycle = 0:cycle_number
    a=windowLength*cycle+1-overlap*cycle;
    b=windowLength*(cycle+1)-overlap*cycle;
    f1(cycle+1,:)=mean(data_scaled(a:b,:));
    f2(cycle+1,:)=max(data_scaled(a:b,:))-min(data_scaled(a:b,:));

end
end