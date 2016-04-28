% "Proof" by MATLAB
% A simple technique to develop and verify the steps of a proof
% using random data input
%
% N P P
% Cornell U
% Sept 1992
%

%% Init

clear
n = 2 ^ 10; % n is power of 2.

% input
x = randn(n, 1) + 1i * randn(n, 1);
y_correct = fft(x);

%% DFT

% root of unity
w = @(n, e) exp(-2 * pi * 1i .* e / n);

k = (0:n - 1)';

% DFT proof steps
y = zeros(n, 1);

for j = 0:n - 1
    y(j + 1) = sum(w(n, j * k) .* x(k + 1));
end

fprintf('DFT : %e\n', norm(y - y_correct))

%% Split output top bottom
y = zeros(n, 1);

for j = 0:n / 2 - 1
    y(j + 1) = sum(w(n, j * k) .* x(k + 1));
end
for j = n / 2:n - 1
    y(j + 1) = sum(w(n, j * k) .* x(k + 1));
end

fprintf('split output top bottom : %e\n', norm(y - y_correct))

%% Split input even odd
y = zeros(n, 1);

k = (0:n / 2 - 1)';
for j = 0:n / 2 - 1
    y(j + 1) = sum(w(n, j * 2 * k) .* x(2 * k + 1)) + sum(w(n, j * (2 * k + 1)) .* x(2 * k + 1 + 1));
end
for j = n / 2:n - 1
    y(j + 1) = sum(w(n, j * 2 * k) .* x(2 * k + 1)) + sum(w(n, j * (2 * k + 1)) .* x(2 * k + 1 + 1));
end

fprintf('split input even odd : %e\n', norm(y - y_correct))

%% Apply w identities
j = (0:n / 2 - 1)';

x1 = zeros(n / 2, 1);
for k = 0:n / 2 - 1
    x1(k + 1) = sum(x(2 * j + 1) .* w(n / 2, j * k));
end

x2 = zeros(n / 2, 1);
for k = 0:n / 2 - 1
    x2(k + 1) = sum(x(2 * j + 1 + 1) .* w(n / 2, j * k));
end

omega = diag(w(n, j));
y = [x1 + omega * x2; x1 - omega * x2];

fprintf('apply w identities : %e\n', norm(y - y_correct))


%% Complete the proof
fe = fft(x((0:2:n - 1) + 1));
fo = fft(x((1:2:n - 1) + 1));

wfo = w(n, (0:n / 2 - 1)') .* fo;
y = [fe + wfo; fe - wfo];

fprintf('done : %e\n', norm(y - y_correct))
