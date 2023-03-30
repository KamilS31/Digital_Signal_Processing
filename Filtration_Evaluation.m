%% I Wstęp i przedstawienie filtrów.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;
% Sygnał prostokątny Śr.=3, szer=2, amp=2
x1 = 2.0*(abs(t-3)<=1);
% Stgnał trójkątny, Śr.=8s, szer=2, amp=2.5
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
%Suma:
x=x1+x2;
%Dodajemy szum Gaussowski:
xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

%Filtracja liniowa sprowadza się do splotu.
%Rozróżniamy dwa filtry uśredniające w splocie:
%filtr jednorodny i niejednorodny o określonej długości.

%Długość filtru (wielkość maski):
N=15;

%Filtr dolnoprzepustwy uśredniający, gdy mamy sygnał poziomy:
LP=ones(1,N)/N;

%Filtr Gaussa:
N2=floor(N/2);
%odchylenie standardowe:
stdG=N2/4;
%Krok 1) Zwykły rozkład Gaussa:
LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
%Krok 2) Normalizacja do jedynki:
LPG=LPG/sum(LPG);

%Przefiltrowane sygnały:
%splot sygnału z maską filtru dolnoprzepustowego, (filtr uśredniający):
xA = conv(x,LP,'same');%xA=x average
%Splot sygnału z maską filtru Gaussa, (filtr uśredniający Gaussowski):
xG = conv(x, LPG, 'same');
%Filtr medianowy:
xM=medfilt1(x,N);
%Filtr wienera inaczej Adaptacyjny:
xW=wiener2(x,[1,N]);

%Odszumienie, jak to rozumieć?
%1) degeneracja krawędzi jak najwmiejsza.
%2) Sygnał wejściowy ma przypominać sygnał wyjściowy.

subplot(511), plot(t,x,'k',t,xA,'r');
title("Wynik Filtracji Filtrem Uśredniający sygnału xS (czerwony)");
subplot(512), plot(t,x,'k',t,xG,'g');
title("Wynik Filtracji Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(513), plot(t,x,'k',t,xM,'b');
title("Wynik Filtracji Filtrem Medianowy sygnału xS (niebieski)");
subplot(514), plot(t,x,'k',t,xW,'m');
title("Wynik FIltracji Filtrem Wienera sygnału xS (fioletowy)");
subplot(515), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");


%Prostokąt dla filtracji medianowej xM jest idealnie przepisany;
%Trójkąt dla filtracji medianowej xM ścina wierzchołek;
%Dla dużych wartości N, filtracja medianowa xM "zetnie" w całości
%sygnały do 0, pozostałe tak nie zrobią.

%Prostokąt dla filtru wienera xW w górnych rogach pojawiają się "ubytki",
%natomiast w dolnych rograch filtr "rozmywa się";

%dla małej maski N=3, niewiele się zmienia, po zwiększeniu
%do N=35 pojawiają się odchylenia, dla prostokąta
%gauss sie zaokrągla - tworzy się grzbiet gaussa, 
%a z uśredniającego robi się trapez

%% II Odszumienie sygnału za pomocą filtrów.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<=1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

%Dodajemy szum Gaussowski:
xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

N=15;
LP=ones(1,N)/N;

N2=floor(N/2);
stdG=N2/4;
LPG=exp(-(-N2:N).^2/(2*stdG*stdG));
LPG=LPG/sum(LPG);

%Musimy się zastanowić który z tych filtrów i dla jakiej długości okna
%najlepiej odszumi nasz sygnał xS?

%Filtrujemy sygnał zaszumiony i porównujemy z sygnałem niezaszumionym!
xA=conv(xS,LP,'same');
xG=conv(xS, LPG, 'same');
xM=medfilt1(xS,N);
xW=wiener2(xS,[1,N]);

%Odszumienie, jak to rozumieć?
%1) degeneracja krawędzi jak najwmiejsza.
%2) Sygnał wejściowy ma przypominać sygnał wyjściowy.

subplot(411), plot(t,x,'k',t,xA,'r');
title("Wynik Odszumiania Filtrem Uśredniający sygnału xS (czerwony)");
subplot(412), plot(t,x,'k',t,xG,'g');
title("Wynik Odszumiania Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(413), plot(t,x,'k',t,xM,'b');
title("Wynik Odszumiania Filtrem Medianowy sygnału xS (niebieski)");
subplot(414), plot(t,x,'k',t,xW,'m');
title("Wynik Odszumianiai Filtrem Wienera sygnału xS (fioletowy)");

figure;
subplot(111), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");

%subplot(211), plot(t,x,'r',t,xA, 'g',t,xG, 'b');
%subplot(212), plot(t,x,'r',t,xM,'g',t,xW,'b');
%% III Ocena jakości odszumienia.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

%Dodajemy ocenę za pomocą funkcji oceny, która będzie podana.
%Funkcję oceny mozemy "przypisać" a później wywołać za pomocą tzw. function
%handle: nazwa=@(x,y)
ocena=@(x,xn)sqrt(sum((x-xn).^2)); %xn - xS odszumione
%Tutaj dajemy zeros(length(3:2:101),5) czyli ilość przejść pętli oraz
%liczba filtrów + 1:
wynik=zeros(50,5);
k=1;
%Pętla od 3 do 101 z krokiem 2
for N=3:2:101
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xS,LP,'same');
    xG=conv(xS, LPG, 'same');
    xM=medfilt1(xS,N);
    xW=wiener2(xS,[1,N]);
    
    wynik(k,1)=N; %Wielkość progu
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    k=k+1;
end
%ctrl+i przesuwanie bloku kodu w prawo;

subplot(411), plot(t,x,'k',t,xA,'r');
title("Wynik Odszumiania Filtrem Uśredniający sygnału xS (czerwony)");
subplot(412), plot(t,x,'k',t,xG,'g');
title("Wynik Odszumiania Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(413), plot(t,x,'k',t,xM,'b');
title("Wynik Odszumiania Filtrem Medianowy sygnału xS (niebieski)");
subplot(414), plot(t,x,'k',t,xW,'m');
title("Wynik Odszumianiai Filtrem Wienera sygnału xS (fioletowy)");

figure;
subplot(111), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");

figure;
plot(wynik(:,1),wynik(:,2:5));
legend('avg','Gauss','Mediana','Wiener');
%% Która filtracja działa najlepiej dla funkcji x=sin(pi*t)
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x=sin(pi*t);

%szum:
xs=x+0.1*randn(size(x));

ocena=@(x,xn)sqrt(sum((x-xn).^2));
wynik=zeros(5,51);
k=1;

for N=21
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xs,LP,'same');
    xG=conv(xs,LPG,'same');
    xM=medfilt1(xs,N);
    xW=wiener2(xs,[1,N]);
    
    wynik(k,1)=N;
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    
    k=k+1;
end
plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'m',t,xW,'b');

figure;
plot(wynik(:,1), wynik(:,2:5));
legend("avg","Gauss","Median","Wiener");
%Jeżeli nie wyświetla lini na legendzie dodać "opengl software"

%% Szum implusowy:
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

%szum impulsowy:
xs=rand(size(x)); %liczby z rozkładu równomiernego od 0 do 1,d=10 amp=0.5
xs=x+0.5*(xs<0.05)-0.5*(xs>0.95);

ocena=@(x,xn)sqrt(sum((x-xn).^2));
wynik=zeros(5,51);
k=1;

for N=5
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xs,LP,'same');
    xG=conv(xs,LPG,'same');
    xM=medfilt1(xs,N);
    xW=wiener2(xs,[1,N]);
    
    wynik(k,1)=N;
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    
    k=k+1;
end
plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'m',t,xW,'b');

%Dla N=5 najlepiej, NAJLEPSZE FILTRACJA MEDIANOWA ZAWSZE dla małego okna.
figure;
plot(wynik(:,1), wynik(:,2:5));
legend("avg","Gauss","Median","Wiener");
%%
%% I Wstęp i przedstawienie filtrów.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;
% Sygnał prostokątny Śr.=3, szer=2, amp=2
x1 = 2.0*(abs(t-3)<=1);
% Stgnał trójkątny, Śr.=8s, szer=2, amp=2.5
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
%Suma:
x=x1+x2;
%Dodajemy szum Gaussowski:
xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

%Filtracja liniowa sprowadza się do splotu.
%Rozróżniamy dwa filtry uśredniające w splocie:
%filtr jednorodny i niejednorodny o określonej długości.

%Długość filtru (wielkość maski):
N=15;

%Filtr dolnoprzepustwy uśredniający, gdy mamy sygnał poziomy:
LP=ones(1,N)/N;

%Filtr Gaussa:
N2=floor(N/2);
%odchylenie standardowe:
stdG=N2/4;
%Krok 1) Zwykły rozkład Gaussa:
LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
%Krok 2) Normalizacja do jedynki:
LPG=LPG/sum(LPG);

%Przefiltrowane sygnały:
%splot sygnału z maską filtru dolnoprzepustowego, (filtr uśredniający):
xA = conv(x,LP,'same');%xA=x average
%Splot sygnału z maską filtru Gaussa, (filtr uśredniający Gaussowski):
xG = conv(x, LPG, 'same');
%Filtr medianowy:
xM=medfilt1(x,N);
%Filtr wienera inaczej Adaptacyjny:
xW=wiener2(x,[1,N]);

%Odszumienie, jak to rozumieć?
%1) degeneracja krawędzi jak najwmiejsza.
%2) Sygnał wejściowy ma przypominać sygnał wyjściowy.

subplot(511), plot(t,x,'k',t,xA,'r');
title("Wynik Filtracji Filtrem Uśredniający sygnału xS (czerwony)");
subplot(512), plot(t,x,'k',t,xG,'g');
title("Wynik Filtracji Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(513), plot(t,x,'k',t,xM,'b');
title("Wynik Filtracji Filtrem Medianowy sygnału xS (niebieski)");
subplot(514), plot(t,x,'k',t,xW,'m');
title("Wynik FIltracji Filtrem Wienera sygnału xS (fioletowy)");
subplot(515), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");


%Prostokąt dla filtracji medianowej xM jest idealnie przepisany;
%Trójkąt dla filtracji medianowej xM ścina wierzchołek;
%Dla dużych wartości N, filtracja medianowa xM "zetnie" w całości
%sygnały do 0, pozostałe tak nie zrobią.

%Prostokąt dla filtru wienera xW w górnych rogach pojawiają się "ubytki",
%natomiast w dolnych rograch filtr "rozmywa się";



%dla małej maski N=3, niewiele się zmienia, po zwiększeniu
%do N=35 pojawiają się odchylenia, dla prostokąta
%gauss sie zaokrągla - tworzy się grzbiet gaussa, 
%a z uśredniającego robi się trapez

%% II Odszumienie sygnału za pomocą filtrów.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<=1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

%Dodajemy szum Gaussowski:
xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

N=15;
LP=ones(1,N)/N;

N2=floor(N/2);
stdG=N2/4;
LPG=exp(-(-N2:N).^2/(2*stdG*stdG));
LPG=LPG/sum(LPG);

%Musimy się zastanowić który z tych filtrów i dla jakiej długości okna
%najlepiej odszumi nasz sygnał xS?

%Filtrujemy sygnał zaszumiony i porównujemy z sygnałem niezaszumionym!
xA=conv(xS,LP,'same');
xG=conv(xS, LPG, 'same');
xM=medfilt1(xS,N);
xW=wiener2(xS,[1,N]);

%Odszumienie, jak to rozumieć?
%1) degeneracja krawędzi jak najwmiejsza.
%2) Sygnał wejściowy ma przypominać sygnał wyjściowy.

subplot(411), plot(t,x,'k',t,xA,'r');
title("Wynik Odszumiania Filtrem Uśredniający sygnału xS (czerwony)");
subplot(412), plot(t,x,'k',t,xG,'g');
title("Wynik Odszumiania Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(413), plot(t,x,'k',t,xM,'b');
title("Wynik Odszumiania Filtrem Medianowy sygnału xS (niebieski)");
subplot(414), plot(t,x,'k',t,xW,'m');
title("Wynik Odszumianiai Filtrem Wienera sygnału xS (fioletowy)");

figure;
subplot(111), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");

%subplot(211), plot(t,x,'r',t,xA, 'g',t,xG, 'b');
%subplot(212), plot(t,x,'r',t,xM,'g',t,xW,'b');
%% III Ocena jakości odszumienia.
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

xS=x+0.1*randn(size(x));
%plot(t,xS,'r',t,x,'b')

%Dodajemy ocenę za pomocą funkcji oceny, która będzie podana.
%Funkcję oceny mozemy "przypisać" a później wywołać za pomocą tzw. function
%handle: nazwa=@(x,y)
ocena=@(x,xn)sqrt(sum((x-xn).^2)); %xn - xS odszumione
%Tutaj dajemy zeros(length(3:2:101),5) czyli ilość przejść pętli oraz
%liczba filtrów + 1:
wynik=zeros(50,5);
k=1;
%Pętla od 3 do 101 z krokiem 2
for N=3:2:101
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xS,LP,'same');
    xG=conv(xS, LPG, 'same');
    xM=medfilt1(xS,N);
    xW=wiener2(xS,[1,N]);
    
    wynik(k,1)=N; %Wielkość progu
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    k=k+1;
end
%ctrl+i przesuwanie bloku kodu w prawo;

subplot(411), plot(t,x,'k',t,xA,'r');
title("Wynik Odszumiania Filtrem Uśredniający sygnału xS (czerwony)");
subplot(412), plot(t,x,'k',t,xG,'g');
title("Wynik Odszumiania Filtrem Uśredniajacy Gaussa sygnału xS (zielony)");
subplot(413), plot(t,x,'k',t,xM,'b');
title("Wynik Odszumiania Filtrem Medianowy sygnału xS (niebieski)");
subplot(414), plot(t,x,'k',t,xW,'m');
title("Wynik Odszumianiai Filtrem Wienera sygnału xS (fioletowy)");

figure;
subplot(111), plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'b',t,xW,'m');
title("Zestawienie powyższych");

figure;
plot(wynik(:,1),wynik(:,2:5));
legend('avg','Gauss','Mediana','Wiener');
%% Która filtracja działa najlepiej dla funkcji x=sin(pi*t)
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x=sin(pi*t);

%szum:
xs=x+0.1*randn(size(x));

ocena=@(x,xn)sqrt(sum((x-xn).^2));
wynik=zeros(5,51);
k=1;

for N=21
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xs,LP,'same');
    xG=conv(xs,LPG,'same');
    xM=medfilt1(xs,N);
    xW=wiener2(xs,[1,N]);
    
    wynik(k,1)=N;
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    
    k=k+1;
end
plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'m',t,xW,'b');

figure;
plot(wynik(:,1), wynik(:,2:5));
legend("avg","Gauss","Median","Wiener");
%Jeżeli nie wyświetla lini na legendzie dodać "opengl software"

%% Szum implusowy:
clear; close all; clc;

Fs=100;
t=0:(1/Fs):10;

x1 = 2.0*(abs(t-3)<1);
x2 = 2.5*(1-abs(t-8)).*(abs(t-8)<1);
x=x1+x2;

%szum impulsowy:
xs=rand(size(x)); %liczby z rozkładu równomiernego od 0 do 1,d=10 amp=0.5
xs=x+0.5*(xs<0.05)-0.5*(xs>0.95);

ocena=@(x,xn)sqrt(sum((x-xn).^2));
wynik=zeros(5,51);
k=1;

for N=5
    LP=ones(1,N)/N;
    
    N2=floor(N/2);
    stdG=N2/4;
    LPG=exp(-(-N2:N2).^2/(2*stdG*stdG));
    LPG=LPG/sum(LPG);
    
    xA=conv(xs,LP,'same');
    xG=conv(xs,LPG,'same');
    xM=medfilt1(xs,N);
    xW=wiener2(xs,[1,N]);
    
    wynik(k,1)=N;
    wynik(k,2)=ocena(x,xA);
    wynik(k,3)=ocena(x,xG);
    wynik(k,4)=ocena(x,xM);
    wynik(k,5)=ocena(x,xW);
    
    k=k+1;
end
plot(t,x,'k',t,xA,'r',t,xG,'g',t,xM,'m',t,xW,'b');

%Dla N=5 najlepiej, NAJLEPSZE FILTRACJA MEDIANOWA ZAWSZE dla małego okna.
figure;
plot(wynik(:,1), wynik(:,2:5));
legend("avg","Gauss","Median","Wiener");