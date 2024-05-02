function [x,Ta,y,t]=modelData2Example()

load data2.mat
T=5; %[s]
fs=1/T; %[Hz]

Skraplacz=0.1*data.Skraplacz;
Kompresor1=data.Kompresor1;
Parownik1=0.1*data.Parownik1;
Wlot=0.1*data.Wlot;
TemperaturaOtoczenia=0.1*data.TemperaturaOtoczenia;
Rozmraanie=data.Rozmraanie;
WentylatorParownika=data.WentylatorParownika;
ZawrOdszraniania=data.ZawrOdszraniania;

X_all=[Kompresor1,TemperaturaOtoczenia,Wlot]';

[X,~]  = GetRidOfNans(X_all);

h10th=10*60*60*fs;
h15th=15*60*60*fs;

t=T*(h10th:h15th);
X=X';
X=X(:,h10th:h15th);
size(X)

X_toFilter=X(2:3,:);
threshold=[0,5;-5,0];
for i = 1:2
X_filtered(i,:) = InterpolateData(X_toFilter(i,:),threshold(i,:),t);
end

x=X(1,:);
y=X_filtered(2,:);
Ta=X_filtered(1,:);
end