clc; clear; close all;

% Usunąć składową harmoniczną o częstotliwości 13Hz

Fs=100;
t=0:1/Fs:10;
T=0.05;
x1=1*sin(2*pi*t/0.05);
x2=0.8*sin(2*pi*t*13);
x3=3*(1-abs(t-5)/1.5).*(abs(t-5)<1.5);
y=x1+x2+x3;

XT=fftshift(fft(y));
WA=abs(XT);

%f=10*(t-5);
f=linspace(-Fs/2, Fs/2, length(t));
plot(f,WA,'b','LineWidth',1); title('Widmo amplitudowe y = x1 + x2 + x3');
figure;

LP=1.0*(abs(f)>=16 | abs(f)<=9);
y_new=real(ifft(ifftshift(LP.*XT)));

subplot(211), plot(t,y,'r',t,y_new,'g'); legend('Przed filtracja','Po Filtracji');
subplot(212), plot(f,WA,'r',f,LP*400,'g','LineWidth',1); legend('Widmo','Filtr','Location','SW');

%%
clear; close all; clc;

% Usunąć składową harmoniczną o częstotliwości 3Hz

Fs=25;
t=0:(1/Fs):50;

x1=1*sin(2*pi*t*1);
x2=sin(2*pi*t*3)/3;
x3=sin(2*pi*t*5)/5;

x=x1+x2+x3;

XT=fftshift(fft(x));
WA=abs(XT);
f=linspace(-Fs/2,Fs/2,length(t));

BA=1./(1+(f./(f.*f-3*3)).^8);
XT_new=XT.*BA;
x_new=ifft(ifftshift(XT_new));

WA_new=abs(x_new);

subplot(211), plot(t,x,'r',t,x_new,'g'); legend('Przed filtracja','Po Filtracji');
subplot(212), plot(f,WA,'r',f,100*BA,'g');legend('Widmo','Filtr','Location','NW');

%%
clear; close all; clc;

Fs=80;
t=0:(1/Fs):12;

x1=0.9*sin(2*pi*t/0.15);
x2=0.8*(1-abs(t-6)/4).*(abs(t-6)<=4);
x3=0.4*rand(size(t))-0.2;

x=x1+x2+x3;

f=linspace(-Fs/2,Fs/2,length(t));
XT=fftshift(fft(x));
WA=abs(XT);
plot(f,WA);

BA=1.0./(1+((2*f)./(f.*f-400/9)).^8);

XT_new=XT.*BA;
x_new=real(ifft(ifftshift(XT_new)));

WA_new=abs(XT_new);

subplot(211), plot(t,x,'r',t,x_new,'g'); legend('Przed filtracja','Po Filtracji');
subplot(212), plot(f,WA,'b',f,WA_new,'m',f,100*BA,'r'); legend('Stare Widmo','Nowe Widmo','Filtr','Location','NW');

%%
clear; close all; clc;
Fs=50;
t=-5:(1/Fs):15;

x1=0.7*sin(2*pi*t/0.2); %5[Hz]
x2=1.02*(mod(t,1)/1);
A=linspace(0.2,0.4,length(t));
x3=A.*sin(2*pi*t*18);

x=x1+x2+x3;

f=linspace(-Fs/2,Fs/2,length(t));
XT=fftshift(fft(x));
WA=abs(XT);
plot(f,WA);

LP=1.0.*(abs(f)<=4 | abs(f)>=6);
XT_new=XT.*LP;
x_new=real(ifft(ifftshift(XT_new)));

WA_new=abs(XT_new);

subplot(211), plot(t,x,'r',t,x_new,'g'); legend('Przed filtracja','Po Filtracji');
subplot(212), plot(f,WA,'r',f,WA_new,'g',f,300*LP,'m');legend('Stare Widmo','Nowe Widmo','Filtr','Location','NW');
