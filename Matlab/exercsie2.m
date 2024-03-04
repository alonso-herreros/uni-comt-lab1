%% Clear
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultLegendInterpreter', 'latex');

%% Distribution and simulation parameters
avg = 0;
var = 1/2;
stdev = sqrt(var);
f0 = 1/3; % frequency

tstep = 0.5;
t = (0:tstep:20);
N = 100; % realizations


%% Generate normal distribution
X = normrnd(avg, stdev, [N, 1]);
Y = normrnd(avg, stdev, [N, 1]);
Z = X.*cos(2*pi*f0*t) + Y.*sin(2*pi*f0*t);

%% Numerical computations
mZ_ = mean(Z, 1); % Using _ to indicate numerical approximation
mZ = repmat(avg, size(t)); % Not using _ to indicate analytical expression

RZ_ = permute(mean(Z.*permute(Z, [1, 3, 2])), [2,3,1]);

tau = linspace(-10, 10, size(t, 2));
RZtau = var * cos(2 * pi * f0 * tau); % No _ because this uses the analytical expression


%% Plots
figure(1);
legend('show');
subplot(2, 2, 1:2, 'replace'); grid on; hold on;
title('$Z(t) = X*cos(2 \pi f_0*t) + Y*sin(2 \pi*f0*t)$', Interpreter='latex');
for i = 1:N
    plot(t, Z(i, :), HandleVisibility='off', LineWidth=0.1);
end
plot(t, mZ_, Color='black', LineStyle=':', DisplayName='$\hat{m}_Z(t)$', LineWidth=1.8);
plot(t, mZ, Color='#660000', LineStyle=':', DisplayName='$m_Z(t)$', LineWidth=1.8);
xlabel('$t$'); ylabel('$Z(t)$');


subplot(2, 2, 3, 'replace');
[t1_, t2_] = meshgrid(t);
surf(t1_, t2_, RZ_, FaceAlpha=0.5, EdgeColor='none');

title('Autocorrelation approximation $\hat{R}_Z(t_1, t_2)$', Interpreter='latex');
xlabel('$t_1$'); ylabel('$t_2$'); zlabel('$\hat{R}_Z(t_1, t_2)$');


subplot(2, 2, 4, 'replace'); grid on; hold on;
plot(tau, RZtau);

title('Autocorrelation in time difference $R_Z(\tau)$', Interpreter='latex');
xlabel('$\tau$'); ylabel('$R_Z(\tau)$');
