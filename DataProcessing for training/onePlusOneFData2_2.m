    % A simple random optimization algorithm. It tries new locations until it
% runs out of time. Delay serves as a way of slowing FunctionPlot.
% It requires a function for optimization (any function from folder
% "FunctionsForOptimization"
 
clear
load('data.mat')
% %% 
% [x,Ta,y,t]=modelData2Example();
% x0=y(1);
%% 
clear
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

X_all=[ZawrOdszraniania,Kompresor1,WentylatorParownika,Rozmraanie,...
    TemperaturaOtoczenia,Skraplacz,Wlot,Parownik1]';
[X,~]  = GetRidOfNans(X_all);
day=24*60*60*fs
t=T*(2*day:3*day);
X=X';
X=X(:,2*day:3*day);
size(X)
n=length(t);
X_toFilter=X(5:8,:);
threshold=[0,5;0,5;-5,5;-5,5];
for i = 1:4
X_filtered(i,:) = InterpolateData(X_toFilter(i,:),threshold(i,:),t);
end
previous_sample=0;
count=1;
clear locs
for i = 1:n
    current_sample=X(2,i);
    if previous_sample == 0 && current_sample ==1
    locs(count)=i;
    count=count+1;
    end
    previous_sample=current_sample;
end
x = FeatureExtract(X_filtered(4,:),locs);
x_wlot = FeatureExtract(X_filtered(3,:),locs);
x_parownik = FeatureExtract(X_filtered(4,:),locs);
locs=locs(2:end);
fridge_air_temp_p2p=x_wlot(1,:)-x_wlot(2,:);
TF = isoutlier(fridge_air_temp_p2p);
figure
TF = isoutlier(fridge_air_temp_p2p);
plot(locs(1),(X_filtered(4,locs(1))),'Marker','o',"Color",'green');hold on
count=1;
clear data
clear x
for i=2:length(x_wlot)
    if (TF(i)==0)
        plot(locs(i-1):locs(i),(X_filtered(4,locs(i-1):locs(i))),"Color",'blue');
        plot(locs(i),(X_filtered(4,locs(i))),'Marker','o',"Color",'green');
    end
end
% plot(locs,(X_filtered(4,locs)),'Marker','o',"Color",'green');
hold off
title('Detection of peaks on evaporator temperature')
xlabel('Samples')
ylabel('Temperature [C]')

% from plot:
x=X(2,locs(29):locs(54));
y=X_filtered(3,locs(29):locs(54));
Ta=X_filtered(1,locs(29):locs(54));
x0=y(1);
% t=t(locs(29):locs(54));
t=T*(0:locs(54)-locs(29));
%note: for simulation purpouses, time should start from 0
%% 
N=length(x);
R=400;
C=10;
%% Adjustable parameters:
MaxRangeR = [-200 200];  % Range of parameters for optimization
MaxRangeC = [-200 200];
MaxRangeG = [-100 100];

MaxSteps = 5000;         % How many iterations do we perform?
FunctionPlot = 0;       % change to 0 If you want to get rid of the underlying function plot 
PointPlot = 0;          % Change to 0 if you want to get rid of the visualization
ConvergenceColor = 'r'; % Change color of the convergence curve here
%close all              % Comment this out if you want to have many convergence curves plotted
 
ViewVect = [0,90];             % Initial viewpoint
Delay = 0.001;                 % Inter-loop delay  - to slow down the visualization
FunctionPlotQuality = 0.05;    % Quality of function interpolation. Lower for a quicker run
 
%% Map initialization
InitialRangeR = MaxRangeR;      % This is the range from which we can draw points.
InitialRangeC = MaxRangeC;
InitialRangeG = MaxRangeG;
%% Storing of a best solution
    CurrentMin = 50000;
    ResultR = 1;
    ResultC = 1;
    ResultG = 1;
%% The main optimization loop
    EndingCondition = 0;
    iter = 0;
    tic;
 
    
    InitialStep = 100; % Exploration/exploitation balance parameters:
    P1 = 2;
    P2 = 300;

    % lr_values = expDecay_of_learningRate(300, 1, MaxSteps*2);
% Random selection of a candidate for optimum:
    NewR = InitialRangeR(1) +  rand()*(InitialRangeR(2) - InitialRangeR(1));
    NewC = InitialRangeC(1) +  rand()*(InitialRangeC(2) - InitialRangeC(1));
    NewG = InitialRangeG(1) +  rand()*(InitialRangeG(2) - InitialRangeG(1));

    for repetition = 1:1
    
        CurrentMin = 50000;
ResultR = 1;
ResultC = 1;
ResultG = 1;
EndingCondition = 0;
iter = 0;

    while(EndingCondition == 0)
        iter = iter + 1;
        Step(iter) = InitialStep * (1/(1+exp((iter-(MaxSteps/P1))/P2)));
        % Step(iter)=lr_values(iter);
        NewR = ResultR+Step(iter)*randn();
        NewC = ResultC+Step(iter)*randn();
        NewG = ResultG+Step(iter)*randn();
        % Check for constraints (they could be different than the range
        % from which we draw our solutions)
        NewR = min(MaxRangeR(2),max(NewR,MaxRangeR(1)));
        NewC = min(MaxRangeC(2),max(NewC,MaxRangeC(1)));
        NewG = min(MaxRangeC(2),max(NewG,MaxRangeC(1)));
        if NewR == 0 
            NewR=1;
        end
        if NewC == 0
            NewC=1;
        end
        if NewG == 0 
            NewG=1;
        end
 
% If you'd like to provide function as a 2D image or use here any other objective function, 
% following line needs to be modified. The 0 passed to the function denotes the fact,
% that the function is constant in time.

        y1=ModelFunction(-x',Ta',NewG,NewR,NewC,t,x0)';
        CurrentValue = rmse(y,y1);
               
        
        if(CurrentValue < CurrentMin)
            CurrentMin = CurrentValue;  % Storing of a historically best result
            ResultR = NewR;
            ResultC = NewC;
            ResultG = NewG;
            
        
        
        % Command-window stuff for monitoring of algorithm's progress:
        SimTime = toc;
        clc
        fprintf('\nCurrent best:  %f',CurrentMin);
        fprintf('\nCurrent:       %f',CurrentValue);
        fprintf('\n\n\n');
        fprintf('\nIteration:     %d',iter);
        fprintf('\nTime:          %d',SimTime);
        
        BestHistory(iter) = CurrentMin;         % Here we store our historically best result
        CurrentHistory(iter) = CurrentValue;    % Here we store our currently investigated result
        
    if(iter >= MaxSteps)
        EndingCondition = 1;    % To stop the while loop from running
    else 
        
    end
        % If we'd like to slow down the simulation - this line is where it
        % is done:
        pause(Delay);
        Results(repetition) = BestHistory(end);
    end
    end
    end
    figure(2);
    plot(BestHistory,'Color',ConvergenceColor); hold on      
    plot(CurrentHistory,'Color',ConvergenceColor,'LineStyle',':'); hold on
    xlabel('Iteration number');
    ylabel('Objective function value');
    figure(4);
plot(Step);
xlabel('iteration');
ylabel('step value');
meanjpjvs=mean(Results);
stdjpjvs=std(Results);
disp(meanjpjvs);
disp(stdjpjvs);

y1=ModelFunction(-x',Ta',ResultG,ResultR,ResultC,t,x0);
figure
plot(t/(60*60),y);hold on
plot(t/(60*60),y1);hold off
legend('Measurement','Model')