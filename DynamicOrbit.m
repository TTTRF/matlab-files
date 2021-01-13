clear,clc,close all;
color=[1 0 0;0 0 1;0.5 0.3 0.8;0.2 0.2 0.6; 0 0 0 ; 0.4 0.2 0.9;0.5 0 0.3;0.6 0.8 0.2];
color=[color;color];
G=6.672e-11;
ME=5.97e24;
VE=29.8e3;
tspan=[0,60*60*2];
n=1:16;
x=(n-8.5)*0.015e8+1.0728e8;
y=-5.4e7*ones(1,16);
vx=zeros(1,16);
vy=ones(1,16)*15e3;
state0=[x;y;vx;vy];
state0_X=[x;y;vx-VE;vy];
state_X=state0_X;
xt=zeros(60*60*2,16);
yt=zeros(60*60*2,16);
vt=zeros(60*60*2,16);
Xt=VE*[1:60*60*2].';
Yt=zeros(length(Xt),1);
[XE,YE,ZE]=sphere(100);
RE=1.5e6;
for t=1:60*60*2
    for id=1:16
        ds_X=StateTransfer(state_X(:,id));
        state_X(:,id)=state_X(:,id)+ds_X;
        xt(t,id)=state_X(1,id)+VE*t;
        yt(t,id)=state_X(2,id);
        vt(t,id)=sqrt((state_X(3,id)+VE)^2+state_X(4,id)^2);
    end
end

% figure(1),hold on,box on
% axis([0.5e8,2e8,-0.7e8,1.5e8]);
% fmat1=moviein(120);
% for t=1:7200
%      if mod(t,60)==0
%        for id=1:16
%            plot(xt(t-59:t,id),yt(t-59:t,id),'color',color(id,:))
%        end  
%        p=mesh(RE*XE+VE*t,RE*YE,0*ZE);
%        fmat1(:,round(t/60))=getframe;
%     end
% end
% movie(fmat1,1);
% movie2gif(fmat1, 'trace.gif', 'LoopCount', 0, 'DelayTime', 0);

% figure(2),hold on,box on
% axis([0,7200,0,9e4]);
% fmat2=moviein(120);
% for t=1:60*60*2
%      if mod(t,60)==0
%          for id=1:16
%              plot(t-59:t,vt(t-59:t,id),'color',color(id,:))
%          end
%          fmat2(:,round(t/60))=getframe;
%      end
% end
% movie(fmat2,1);
% movie2gif(fmat2,'velocity.gif', 'LoopCount', 0, 'DelayTime', 0);


fmat3=moviein(120);
for t=1:7200
    if mod(t,60)==0
         h3=figure(3);
         hold on,box on;
         axis([0.5e8,2e8,-0.7e8,1.5e8])
         for id=1:16
              plot(xt(t,id),yt(t,id),'Marker','o','MarkerSize',3)
         end
         p=mesh(RE*XE+Xt(t),RE*YE,0*ZE);
         fmat3(:,round(t/60))=getframe;
         close(h3)
    end
end
movie(fmat3,1);
movie2gif(fmat3,'figure.gif', 'LoopCount', 0, 'DelayTime', 0);
        