%% Clear
clear all;
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultLegendInterpreter', 'latex');

%% Distribution and simulation parameters
avg = 0;
var = 1/2;
stdev = sqrt(var);
f0 = 1/3; % frequency

tstep = 0.5; % TODO: The guide says 0.5 step, but the resolution is shit...
t = (0:tstep:20);
N = 100; % realizations


%% Generate normal distribution
X = normrnd(avg, sqrt(var), [N, 1]);
Y = normrnd(avg, sqrt(var), [N, 1]);
Z = X.*cos(2*pi*f0*t) + Y.*sin(2*pi*f0*t);

%% Numerical computations
mZ = mean(Z, 1);
mZavg = mean(mZ);

RZ = permute(mean(Z.*permute(Z, [1, 3, 2])), [2,3,1]);
RZavg = mean(RZ, 'all');

tau = linspace(-10, 10, size(t, 2));
RZtau = var * cos(2 * pi * f0 * tau);

%% Plots
figure(1);
subplot(2, 2, 1:2, 'replace'); grid on; hold on;
title('$Z(t) = X*cos(2 \pi f_0*t) + Y*sin(2 \pi*f0*t)$', Interpreter='latex');
for i = 1:N
    plot(t, Z(i, :), HandleVisibility='off', LineWidth=0.1);
end
plot(t, mZ, Color='#660000', LineStyle=':', DisplayName='$m_Z(t)$', LineWidth=1.6);
plot(t, repmat(mZavg, size(t)), Color='black', LineStyle=':', DisplayName='$\hat{m}_Z(t)$', LineWidth=1.3);
legend('show');
xlabel('$t$'); ylabel('$Z(t)$');

subplot(2, 2, 3, 'replace');
title('Autocorrelation $R_Z(t_1, t_2)$', Interpreter='latex');
[t1_, t2_] = meshgrid(t);
surf(t1_, t2_, RZ, FaceAlpha=0.5, EdgeColor='none');
xlabel('$t_1$'); ylabel('$t_2$'); zlabel('$R_Z(t_1, t_2)$');

subplot(2, 2, 4, 'replace');
title('Autocorrelation in time difference $R_Z(\tau)$', Interpreter='latex');
plot(tau, RZtau);
xlabel('$\tau$'); ylabel('$R_Z(\tau)$');
