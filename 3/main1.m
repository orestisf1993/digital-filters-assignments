clear; close;

%% Initialize.
M = 100; % Number of filter coefficients.
sigmav2 = 0.68; % noise variance
n = 250000;
v = sqrt(sigmav2) * randn(n, 1);
v = v - mean(v);

% Create the periodical distribution
f = 1 / 4;
phase = pi / 2;
A = 2.3;
i = 1:n;
x(i, 1) = A * (sin(2 * pi * f * i + phase) + cos(4 * pi * f * i + phase) + cos(7 * pi * i + phase / 3));

d = x + v;
s = d;
delta = 10;

u = zeros(size(d));
u(delta + 1:end) = d(1: end - delta);

%% Calculate correlations. Lecture 7 Page 3.
[r, lags] = xcorr(u, u, M + 1, 'unbiased');
% Autocorrelation vector (including r(0)).
r = r(lags >= 0);
% Autocorrelation matrix (needs r(0)).
R = toeplitz(r(1:end - 1));
% Autocorrelation vector (withour r(0).
rbar = r(2:end);
% Make sure that rbar is a column vector.
rbar = rbar(:);

%% Optimal forward linear prediction. Lecture 7 Page 4.
% Optimal Forward Predictor.
w_o = R \ rbar;
% Forward Prediction Error Power.
P_M = r(1) - rbar.'*w_o;

%% Optimal backward linear preditction. Lecture 7 Page 8.
% Optimal Backward Predictor.
% go = wo(end:-1:1);

%% Call levinson function and compare with MATLAB's function.
[a, L, G, P] = my_levinson(r, M);
[matlab_a, matlab_P, matlab_G] = levinson(r, M);
fprintf('Filter coefficient MSE: %e \n', immse(a{end}(:), matlab_a(:)));
fprintf('Reflection coefficient MSE:  %e \n', immse(G(:), matlab_G(:)));
fprintf('Prediction Error power MSE: %e \n', (P(end) - matlab_P) ^ 2);

%% Orthogonalization of u(n).
% Gram-Schmidt orthogonalization algorithm. Lecture 7 page 18
b = zeros(n, M + 1);
b(1:M) = u(1:M);

for i = M + 1: n % i>M => i-M>0
    b(i, :) = L * u(i:-1:i - M);
end

% Autocorrelation matrix of backward errors. Lecture 7 Page 19.
D = diag(P);

p = zeros(M + 1, 1);
% Calculate the cross correlation between each signal b[i] and the desired
% signal s.
for ii = 1 : M + 1
    [rb, lags] = xcorr(b(:, ii), s, M, 'unbiased');
    p(ii) = rb(lags == 0);
end

% Calculate the optimal parameters for the joint process estimator.
g_o = D \ p;

% Compare g_o results with w_o. Lecture 8 page 10.
fprintf('L^T*g_o = w_o MSE: %e \n', immse(L.'*g_o, w_o));