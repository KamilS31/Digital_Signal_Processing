clear; close all; clc;

Fs=100;
t=-3:(1/Fs):3;
 x=(t+3).*(t<-1 & t>=-3) + -2*(abs(t)<=1) + (3-t).*(t>1 & t<=3);

XT=zeros(size(t));
MSE=@(x,XT)1/length(t)*sqrt(sum(x-XT).^2);
k=1;
for n=1:1:50
    an=-8/(n*pi)*sin(n*pi/3)-6/(n*n*pi*pi)*(cos(n*pi)-cos(n*pi/3));
    XT=XT+an*cos(n*pi*t/3);
    wynik(k,1)=n;
    wynik(k,2)=MSE(x,XT);
    k=k+1;
end

subplot(211), plot(wynik(:,1), wynik(:,2))

XT1=zeros(size(t));
for n=1:25
    an=-8/(n*pi)*sin(n*pi/3)-6/(n*n*pi*pi)*(cos(n*pi)-cos(n*pi/3));
    XT1=XT1+an*cos(n*pi*t/3);
end

XT2=zeros(size(t));
for n=1:50
    an=-8/(n*pi)*sin(n*pi/3)-6/(n*n*pi*pi)*(cos(n*pi)-cos(n*pi/3));
    XT2=XT2+an*cos(n*pi*t/3);
end

subplot(212), plot(t,x,'-k',t,XT1,'r',t,XT2,'g')