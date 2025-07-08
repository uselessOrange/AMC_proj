function X = hysteresis(Y, th, th2)
%#codegen

persistent state
if isempty(state)
    state = 0;
end

if Y > th2
    state = 1;
elseif Y < th
    state = 0;
end

X = state;
