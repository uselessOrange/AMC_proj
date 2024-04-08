clear
load("data.mat")

figure;hold on;
plot(data.SondaSterujca)
plot(data.parownik)
plot(data.wirtualna)
plot(data.skraplacz)
plot(data.compressor)
hold off

legend('SondaSterujca','parownik','wirtualna',...
'skraplacz','compressor')
parownik = data.parownik(~nan_indices);