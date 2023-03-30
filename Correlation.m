clear; close all; clc;
a=load('dane_corr2.txt');

x=a(:,1)';

Fs=50;
t1=length(x)/Fs;
t=0.001:(1/Fs):t1;


tg=0:(1/Fs):14;
gauss=1.1*exp(-(tg-7).^2/(2*3));

tc=-98:(1/Fs):98;

xc=xcorr(x.^0.5,gauss.^0.5)+xcorr(1-x,1-gauss);
nr=find(xc==max(xc(:)),1,'first');
przes=tc(nr);

tt=0:(1/Fs):8;
troj=1.2*(1-abs(tt-4)/4).*(abs(tt-4)<=4);
xc1=xcorr(x.^0.5,troj.^0.5)+xcorr(1-x,1-troj);
nr1=find(xc1==max(xc1(:)),2,'first');
przes1=tc(nr1);

subplot(211), plot(t,x,tg+przes(1),gauss,'r');
subplot(212), plot(t,x,tt+przes1(1),troj,'r',tt+przes1(2),troj,'g');
przes()
przes1()

%%
clear; close all; clc;

a=load('dane_corr1.txt');
t=a(:,1)';
x=a(:,2)';

dt=t(2)-t(1);

ttroj=0:dt:6;
troj=0.8*(1-abs(ttroj-3)/3).*(abs(ttroj-3)<=3);

tc=-75:dt:75;

xct=xcorr(x.^0.5,troj.^0.5)+xcorr(1-x,1-troj);
nr=find(xct==max(xct(:)),3,'first');
przes=tc(nr);
subplot(211), plot(t,x,ttroj+przes(1),troj,'r',ttroj+przes(2),troj,'g',ttroj+przes(3),troj,'m');

tpila=0:dt:5;
pila=1.0.*(mod(tpila,5)/5);
%plot(t,x,tpila,pila,'r');

xcp=xcorr(x.^0.5,pila.^0.5)+xcorr(1-x,1-pila);
nr=find(xcp>=0.99999*max(xcp(:)),3,'first');
przes1=tc(nr);
subplot(212), plot(t,x,tpila+przes1(1),pila,'r',tpila+przes1(2),pila,'g',tpila+przes1(3),pila,'m');