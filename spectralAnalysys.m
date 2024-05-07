clear
load data2.mat
n=length(data.CzasLokalnyUTC0000)

T=5; %[s]
fs=1/T; %[Hz]
t_all=T*(0:n-1);

Skraplacz=0.1*data.Skraplacz;
Kompresor1=data.Kompresor1;
Parownik1=0.1*data.Parownik1;
Wlot=0.1*data.Wlot;
TemperaturaOtoczenia=0.1*data.TemperaturaOtoczenia;
Rozmraanie=data.Rozmraanie;
WentylatorParownika=data.WentylatorParownika;
ZawrOdszraniania=data.ZawrOdszraniania;

X_all=[ZawrOdszraniania,Kompresor1,WentylatorParownika,Rozmraanie,...
    TemperaturaOtoczenia,Skraplacz,Wlot,Parownik1]';

[X,~]  = GetRidOfNans(X_all);

h10th=10*60*60*fs;
h15th=15*60*60*fs;
t=T*(h10th:h15th);
X=X';
X=X(:,h10th:h15th);
size(X)

X_toFilter=X(5:8,:);
threshold=[0,5;0,5;-5,0;-5,0];
for i = 1:4
X_filtered(i,:) = InterpolateData(X_toFilter(i,:),threshold(i,:),t);
end

x=X(2,:);
y=X_filtered(3,:);
Ta=X_filtered(1,:);

R=-99;
C=-98;
G=-1.07;
x0=y(1);
y1=ModelFunction(-x',Ta',G,R,C,t,x0);
magaxis = 0:fs/length(y):fs-fs/length(y);
Y=fft(y);
mag=abs(Y);
stem(magaxis,mag)

% ph=angle(Y);
% % Frequency axis
% f_axis = linspace(0, fs, length(ph));
% 
% % Plot phase of the signal
% plot(f_axis, ph);
% xlabel('Frequency (Hz)');
% ylabel('Phase (radians)');
% title('Phase of the Signal');
% grid on;
