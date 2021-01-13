clear,clc,close all;
G=6.672e-11;
ME=5.97e24;
R=6.4e6;
n=0.6:0.2:2.4;
num=length(n);
vx=sqrt(G*ME*n/R);
State0=zeros(4,num);
State0(2,:)=R;
State0(3,:)=vx;
tspan=[0,60*60*24];
figure,hold on,box on
[XE,YE,ZE]=sphere(100);
mesh(R*XE,R*YE,0*ZE);
axis([-2e7,6e7,-6e7,2e7])
for id=1:num
    [t,st]=ode23('StateTransfer',tspan,State0(:,id));
    xt=st(:,1);
    yt=st(:,2);
    plot(xt,yt)  
end
plot(0,0,'r*')