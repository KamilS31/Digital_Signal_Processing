clear; close all; clc;

Fs=125;
t=-4:(1/Fs):4;

x=2.*(abs(t)>2) + (-1+t.*sign(-2*t)).*(abs(t)<=2);

XT=zeros(size(t));
for n=1:10
    an=-8/(n*n*pi*pi)*(cos(n*pi/2)-1)-10/(n*pi)*sin(n*pi/2);
    XT=XT+an*cos(n*pi*t/4);
end

XT1=zeros(size(t));
for n=1:120
    an=-8/(n*n*pi*pi)*(cos(n*pi/2)-1)-10/(n*pi)*sin(n*pi/2);
    XT1=XT1+an*cos(n*pi*t/4);
end

plot(t,x,'.k',t,XT,'r',t,XT1,'g');

%%
clear; close all; clc;

% sygnał prostokątny bipolarny

Fs=100;
t=-5:(1/Fs):5;

x=1.0.*((t<-3 & t>=-4) + (t<-1 & t>=-2) + (t<1 & t>=0) + (t<3 & t>=2) + (t<5 & t>=4))...
    -1.0.*((t<-4 & t>=-5) + (t<-2 & t>=-3) + (t<0 & t>=-1) + (t<2 & t>=1) + (t<4 & t>=3));

XT=0;
for n=1:7
    bn=2*(1-power(-1,n))/(n*pi);
    XT=XT+bn*sin(n*pi*t);
end

XT1=0;
for n=1:50
    bn=2*(1-power(-1,n))/(n*pi);
    XT1=XT1+bn*sin(n*pi*t);
end

plot(t,x,'.b',t,XT,'g',t,XT1,'r')

%%
clear; close all; clc;

Fs=50;
t=0:(1/Fs):2;

x=(2*t+1).*(t>=0 & t<=2);

XT=ones(size(t));
for n=1:10
    an=1/(n*pi)*(5*sin(2*n*pi/3)+6/(n*pi)*(cos(2*n*pi/3)-1));
    bn=1/(n*pi)*(1-5*cos(2*n*pi/3)+6/(n*pi)*sin(2*pi*n/3));
    XT=XT+an.*cos(n*t*pi/3)+bn.*sin(n*pi*t/3);
end

XT1=ones(size(t));
for n=1:100
    an=1/(n*pi)*(5*sin(2*n*pi/3)+6/(n*pi)*(cos(2*n*pi/3)-1));
    bn=1/(n*pi)*(1-5*cos(2*n*pi/3)+6/(n*pi)*sin(2*pi*n/3));
    XT1=XT1+an.*cos(n*t*pi/3)+bn.*sin(n*pi*t/3);
end

plot(t,x,'b',t,XT,'g',t,XT1,'r')
%%
clear; close all; clc;

% Impuls prostokątny

Fs=100;
t=-1:(1/Fs):1;

x=1.0*(abs(t)<=0.5);

XT=0.5*ones(size(t));

for n=1:6
    an=2*sin(0.5*n*pi)/(n*pi);
    XT=XT+an*cos(n*pi*t);
end

XT1=0.5*ones(size(t));
for n=1:50
    an=2*sin(0.5*n*pi)/(n*pi);
    XT1=XT1+an*cos(n*pi*t);
end

plot(t,x,'.b',t,XT,'g',t,XT1,'r')
%%
clear; close all; clc;

Fs=100;
t=-2:(1/Fs):4;

x=(1+0.5*sign(t).*t.*t).*(abs(t)<=2) + 1.0*(abs(t-3)<1);

XT=1.0*ones(size(t));

for n=1:7
    bn=18/(n*n*n*pi*pi*pi)*(cos(2*n*pi/3)-1)+12/(n*n*pi*pi)*sin(2*n*pi/3)-4/(n*pi)*cos(2*n*pi/3);
    XT=XT+bn*sin(n*pi*t/3);
end

XT1=1.0*ones(size(t));

for n=1:50
    bn=18/(n*n*n*pi*pi*pi)*(cos(2*n*pi/3)-1)+12/(n*n*pi*pi)*sin(2*n*pi/3)-4/(n*pi)*cos(2*n*pi/3);
    XT1=XT1+bn*sin(n*pi*t/3);
end

plot(t,x,'.b',t,XT,'g',t,XT1,'r')

%%
clear; close all; clc;

% Sygnał trójkątny

Fs=100;
t=-2:(1/Fs):2;

x=1.0*(1-abs(t)).*(abs(t)<=1);

XT=1/4*ones(size(t));
for n=1:7
    an=4/(n*n*pi*pi)*(1-cos((n*pi)/2));
    XT=XT+an*cos((n*pi*t)/2);
end

XT1=1/4*ones(size(t));
for n=1:50
    an=4/(n*n*pi*pi)*(1-cos((n*pi)/2));
    XT1=XT1+an*cos((n*pi*t)/2);
end

plot(t,x,'.b',t,XT,'g',t,XT1,'r')
%%
clear; close all; clc;

Fs=100;
t=0:(1/Fs):pi;

x=t.*(t>=0 & t<=pi);

XT=pi/4*ones(size(t));

for n=1:7
    an=(power(-1,n)-1)/(n*n*pi);
    bn=(power(-1,n+1))/(n);
    XT=XT+an.*cos(n*t)+bn.*sin(n*t);
end

XT1=pi/4*ones(size(t));

for n=1:50
    an=((-1)^(n)-1)/(n*n*pi);
    bn=((-1)^(n+1))/n;
    XT1=XT1+an.*cos(n*t)+bn.*sin(n*t);
end

plot(t,x,'.b',t,XT,'g',t,XT1,'r')
%%
clc; close all; clear;

Fs=100;
t=0:(1/Fs):6;
x=(t-1).*(t<2)+1*(t>=2 & t<=4)+(t-3).*(t>=4 & t<=6);

XT1=ones(size(t));
for n=1:10
    bn=(3/(pi*pi*n*n))*sin((2*pi*n)/3)-4/(pi*n)-3/(pi*pi*n*n)*sin((4*pi*n)/3);
    XT1=XT1+bn*sin(2*n*pi*t/6);
end

XT=ones(size(t));
for n=1:100
    bn=(3/(pi*pi*n*n))*sin((2*pi*n)/3)-4/(pi*n)-3/(pi*pi*n*n)*sin((4*pi*n)/3);
    XT=XT+bn*sin(2*n*pi*t/6);
end
plot(t,x,'.k',t,XT,'g',t,XT1,'r');

