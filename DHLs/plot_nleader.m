close all
clear all
clc
%%
Max_iter=100;
NL=30;

NGWO_v1=[];
NGWO_v2=[];
NGWO_v3=[];
NGWO_v4=[];
for l=1:Max_iter
    %% v1
    AA=1-l/(Max_iter/2);       %for iter 1:max/4 linear from 1 to 0
    if AA>0
        GWO_n=3+round(AA*(NL-3));
    else
        AA=1-(l/(Max_iter));   %for iter max/2 to max linear from 0.5 to 0
        GWO_n=1+round(AA*4);
    end
    NGWO_v1=[NGWO_v1 GWO_n];


%% V2
AA=1-l/(Max_iter);       %for iter 1:max/2 linear from 1 to 0
GWO_n=1+round(AA*(NL-1));
NGWO_v2=[NGWO_v2 GWO_n];


%% v3
AA=-l*10/(Max_iter);       %for iter 1:maxit linear from 0 to -10
   %GWO_n=1+NL/log(10/Max_iter)*log(AA*10);
   GWO_n=NL*exp(AA)+1;
    NGWO_v3=[NGWO_v3 GWO_n];



end

plot(NGWO_v1)
hold on
plot(NGWO_v2)
hold on
plot(NGWO_v3)

legend('V1','V2','v3')


