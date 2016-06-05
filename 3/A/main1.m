clear; close;

%% Initialize.
% Create the white noise.
sigmav2 = 0.34;  % Noise variance.
n = 250000;
v = sqrt(sigmav2) * randn(n, 1);
v = v - mean(v);

% Create the periodical interference.
f_o = 1 / 4;
phi = pi / 2;
A = 2.3;
i = 1:n;
x(i, 1) = A * (sin(2 * pi * f_o * i + phi) + cos(4 * pi * f_o * i + phi) + cos(7 * pi * i + phi / 3));

s = x + v;
delta = 10;  % delay.
M = 100;  % Number of filter coefficients.

% u(n) = s(n - delta).
u = zeros(size(s));
u(delta + 1:end) = s(1:end - delta);

%% Calculate correlations. Lecture 7 Page 3.
[r, lags] = xcorr(u, u, M + 1, 'unbiased');
r = r(lags >= 0);  % Autocorrelation vector (including r(0)).
R = toeplitz(r(1:end - 1));  % Autocorrelation matrix (needs r(0)).
rbar = r(2:end);  % Autocorrelation vector (withour r(0).
rbar = rbar(:);  % Make sure that rbar is a column vector.

%% Wiener filter coefficients.
w_o = R \ rbar;

%% Call levinson function and compare with MATLAB's function.
[a, L, G, P] = my_levinson(r, M);
[matlab_a, matlab_P, matlab_G] = levinson(r, M);
fprintf('Filter coefficient MSE: %e \n', immse(a{end}(:), matlab_a(:)));
fprintf('Reflection coefficient MSE:  %e \n', immse(G(:), matlab_G(:)));
fprintf('Prediction Error power MSE: %e \n', (P(end) - matlab_P) ^ 2);

%% Orthogonalization of u(n).
% Gram-Schmidt orthogonalization algorithm. Lecture 7 page 18.
b = zeros(n, M + 1);
b(1:M) = u(1:M);

for i = M + 1:n % i>M => i-M>0
    b(i,:) = L * u(i:- 1:i - M);
end

% Autocorrelation matrix of backward errors. Lecture 7 Page 19.
D = diag(P);

p = zeros(M + 1, 1);
% Calculate the cross correlation between each signal b[i] and the desired
% signal s.
for i = 1:M + 1
    [rb, lags] = xcorr(b(:, i), s, M, 'unbiased');
    p(i) = rb(lags == 0);
end

g_o = D \ p;  % The optimal parameters for the joint process estimator.

% Compare g_o results with w_o. Lecture 8 page 10.
fprintf('L^T*g_o = w_o MSE: %e \n', immse(L.' * g_o, w_o));

%% Filters.
diffs = cell(2, 1);
names = {'wiener', 'jpe'};

% Wiener.
y = zeros(n, 1);
for i = M + 2:n
    y(i) = w_o' * u(i - 1:- 1:i - M - 1);
end
y = y(1:length(x));
e = s - y;
diffs{1} = (e - v) .^ 2;

% JPE.
y = zeros(n, 1);
y(1:M) = u(1:M);
for i = M + 1:n
    y(i) = b(i,:) * g_o;
end
e = s - y;
diffs{2} = (e - v) .^ 2;

for id = 1:length(diffs)
    name = names{id};
    f = new_figure();
    hold on;

    subplot(1, 2, 1);
    semilogy(diffs{id});
    title('log');
    xlabel('$n$');
    ylabel('$(e-v)^2$');

    subplot(1, 2, 2);
    plot(diffs{id});
    title('linear');
    xlabel('$n$');
    ylabel('$(e-v)^2$');

    print(strcat(name, '.pdf'), '-dpdf', '-r0')
    close(f);
end
