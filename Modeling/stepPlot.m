clear    
InitialStep = 100; % Exploration/exploitation balance parameters:
    P1 = 2;
    P2 = 60;
    MaxSteps=1000;
    for iter = 1:MaxSteps
    Step(iter) = InitialStep * (1/(1+exp((iter-(MaxSteps/P1))/P2)));
    end
    plot(Step)