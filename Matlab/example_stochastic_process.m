%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Example of a Stochastic Process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all

disp(' ')
disp(' ')
disp('Example of a Stochastic Process:')
disp(' ')
disp('x(t;w_1)=1, for all t>=0')
disp('x(t;w_2)=2, for all t>=0')
disp('x(t;w_3)=exp(-t), for all t>=0')
disp('x(t;w_4)=sin(t), for all t>=0')
disp(' ')
disp('p(w_1)=p(w_2)=p(w_3)=p(w_4)=1/4')
disp(' ')
disp(' ')
disp('Press return to generate a sample from this process')
pause

% Let's define the stochastic process 
t=-2:.01:10;
x_1 = 1;
x_2 = 2;
x_3 = exp(-t);
x_4 = sin(t);

%Define the pulse p(t)
pulse = [zeros(1,200) ones(1,1001)];

%Simulate one realization of the stochastic process
w=ceil(4*rand);
figure(1)
if(w==1)
   H=plot(t,x_1*pulse,'linewidth',2);
elseif(w==2)
   H=plot(t,x_2*pulse,'linewidth',2);
elseif(w==3)
   H=plot(t,x_3.*pulse,'linewidth',2);
elseif(w==4)
   H=plot(t,x_4.*pulse,'linewidth',2);
end
set(get(H(1),'parent'),'fontsize',15);
xlabel('t','fontsize',25)
ylabel('x(t,w_i)','fontsize',25)
hold on

%Simulate several realizations of the stochastic process
Q=['b','g','r','c','m','y','k'];
for i=2:20
   if(i<=5)
       disp('Press return to generate another sample from this process')
       pause
   end
   w=ceil(4*rand);
   if(w==1)
       plot(t,x_1*pulse,Q(mod(i-1,7)+1),'linewidth',2);
   elseif(w==2)
       plot(t,x_2*pulse,Q(mod(i-1,7)+1),'linewidth',2);
   elseif(w==3)
       plot(t,x_3.*pulse,Q(mod(i-1,7)+1),'linewidth',2);
   elseif(w==4)
       plot(t,x_4.*pulse,Q(mod(i-1,7)+1),'linewidth',2);
   end
   drawnow
end
hold off

% Mean
disp(' ')
disp(' ')
disp('Press return to generate the mean of this process')
pause

%Compute the mean of the stochastic process
media = x_1.*pulse/4 + x_2.*pulse/4 + x_3.*pulse/4 + x_4.*pulse/4;

figure(2)
H=plot(t,x_1*pulse,'--',t,x_2*pulse,'--',t,x_3.*pulse,'--',t,x_4.*pulse,'--');
hold on
plot(t,media,'k','linewidth',2)
hold off
set(get(H(1),'parent'),'fontsize',15);
xlabel('t','fontsize',25)
ylabel('m_X(t)','fontsize',25)

%Autocorrelation

disp(' ')
disp(' ')
disp('Press return to generate the autocorrelation of this process')
pause

% Redefine the vector t and the pulse signal
t = -2:0.1:10;
pulse = [zeros(1,20) ones(1,101)];

%Compute the autocorrelation of the stochastic process
x1 = x_1*pulse;
x2 = x_2*pulse;
x3 = exp(-t).*pulse;
x4 = sin(t).*pulse;

Rx = zeros(length(t));
for t1 = 1:length(t)
   for t2 = 1:length(t)
       Rx(t1,t2) = (x1(t1)*x1(t2) + x2(t1)*x2(t2) + x3(t1)*x3(t2) + x4(t1)*x4(t2))/4;
   end
end

figure(3)
H=mesh(t,t,Rx);
set(get(H(1),'parent'),'fontsize',15);
xlabel('t_1','fontsize',25)
ylabel('t_2','fontsize',25)
zlabel('R_X(t_1,t_2)','fontsize',25)
axis([-2 10 -2 10 0 1.5])



