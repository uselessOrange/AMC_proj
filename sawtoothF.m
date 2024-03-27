clear 
close all
T = 1;

fs = 200;
t = 0:1/fs:T;

x = sawtooth(2*pi*t);
n=length(x);
x=[x(1:n-1),-x(1:n-1)];

figure
% Plot the triangular wave
plot(x);
title('Triangular Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

figure
% Define two signals
h = data.SondaSterujca; % Signal 2

% Perform convolution
y = conv(x, h);

% Plot the original signals
subplot(3, 1, 1);
plot(x);
title('Signal x');
xlabel('Index');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(h);
title('Signal h');
xlabel('Index');
ylabel('Amplitude');

% Plot the convolution result
subplot(3, 1, 3);
plot(y);
title('Convolution of x and h');
xlabel('Index');
ylabel('Amplitude');
