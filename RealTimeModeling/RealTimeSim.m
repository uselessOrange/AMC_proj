function [stopTime,startTime,dt,fs,Tas,A,B,C,D,x0,th,th2] = RealTimeSim(Ta,G,R,c,t,x0)
% Y = RealTimeSim(Ta,G,R,c,t,x0)


A=-1/(R*c);
B=[1/(R),G];
C=1/c;
D=[0,0];

th=-22;
th2=-20;


stopTime=t(end);
startTime=t(1);
dt=t(2)-t(1);
fs=1/dt;

Tas=timeseries(Ta,t);




