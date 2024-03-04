%% Setup
set(groot,'defaulttextinterpreter','latex');,
set(groot, 'defaultLegendInterpreter', 'latex');


%% Parameters

tstep = 0.1;
t = 0:tstep:10;
T = length(t);
N = 20;

stdev = 1/sqrt(2*pi); % Sigma
var = stdev^2; % Sigma squared

mX = zeros(size(t)); % Mu
CovX = exp(-(t-t').^2/(2*var));


%% Generate samples

X = mvnrnd(mX, CovX, N);
RX_ = permute(mean(X.*permute(X, [1, 3, 2])), [2,3,1]);

tau = -5:tstep:5;
RXtau = exp(-(tau).^2/(2*var)); 


%% Plot

figure(1);
subplot(2, 2, 1:2, 'replace'); grid on; hold on;
for i = 1:N
    plot(t, X(i, :), HandleVisibility='off', LineWidth=0.1);
end

title('Gaussian process $X(t)$', Interpreter='latex');
xlabel('$t$'); ylabel('$X(t)$');

subplot(2, 2, 3, 'replace');
[t1_, t2_] = meshgrid(t);
surf(t1_, t2_, RX_, FaceAlpha=0.5, EdgeColor='none'); hold on;

title('Autocorrelation approximation $\hat{R}_X(t_1, t_2)$', Interpreter='latex');
xlabel('$t_1$'); ylabel('$t_2$'); zlabel('$\hat{R}_X(t_1, t_2)$');


subplot(2, 2, 4, 'replace'); grid on; hold on;
plot(tau, RXtau);

title('Autocorrelation in time difference $R_X(\tau)$', Interpreter='latex');
xlabel('$\tau$'); ylabel('$R_X(\tau)$');
