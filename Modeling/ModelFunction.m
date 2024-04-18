function y = ModelFunction(x,Ta,R,C,t)
% y = ModelFunction(x,Ta,R,C)
% x and Ta are vectors of the same lenght
% R - frige walls thermal resistance
% C - Heat capacity of the fridge content
A=-1/(R*C);
B=[1/C,1/(R*C)];
C=1;
D=0;

sys=ss(A,B,C,D);

[y] = lsim(sys, [x,Ta],t,Ta(1));

end