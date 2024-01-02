close all; clear all; clc;
t=1;
PREC='double'; 
ycoord=zeros(1,10);
y2coord=zeros(1,10);
y3coord=zeros(1,10);
xcoord=zeros(1,10);
for i=1:10
    n=i*100;
    xcoord(i)=n;
    A=rand(n,n);
    B=rand(n,1);
    correct=expm(A)*B; %built-in exp
    ans=expmv(t,A,B,[],PREC);%Higham's implementation
    F=impexpmv(A,B); %my implementation
    error3=norm(ans-correct)/norm(correct);
    error2=norm(F-correct)/norm(correct);
    error1=norm(F-ans)/norm(ans);
    ycoord(i)=error3;
    y2coord(i)=error2;
    y3coord(i)=error1;
end
figure
semilogy(xcoord,y3coord)
title('Higham vs my')
xlabel('Size of randomly generated square matrix(n)')
ylabel('Relative error')

figure
semilogy(xcoord,ycoord)
title('Higham vs expm')
xlabel('Size of randomly generated square matrix(n)')
ylabel('Relative error')

figure
semilogy(xcoord,ycoord,'r',xcoord,y2coord,'k--')
title('My vs expm and Higham vs expm')
xlabel('Size of randomly generated square matrix(n)')
ylabel('Relative error')