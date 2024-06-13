function y = ModelFunction2(x,Ta,G,R,C,t,x0)
% y = ModelFunction(x,Ta,G,R,C,t,x0)
% x and Ta are vectors of the same lenght
% R - frige walls thermal resistance
% C - Heat capacity of the fridge content
A=-1/(R*C);
B=[G,1/R];
C=1/C;
D=0;

sys=ss(A,B,C,D);

[y] = lsim(sys, [x,Ta],t,x0);

end