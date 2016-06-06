function [y, w, e] = my_rls(u, d, M)
%MY_RLS Filter signal using the RLS algorithm.
%   [Y, W, E] = MY_RLS(U, D, M) computes the output Y using M filter coefficients
%   W with desired signal D and input signal U. E is the error signal.

u = u(:);
d = d(:);
n = length(u);

delta = 200;
lambda = 0.99;

P = delta * eye(M, M);
w = zeros(M, 1);
y = zeros(size(u));
e = zeros(size(u));

counter = 0;
for i = (M + 1):n
    fprintf(1, repmat('\b', 1, counter));
    counter = fprintf('%f%% done.\r', (i - M - 1) / n * 100);
    ubar = u(i:-1:i - M + 1);
    y(i) = w.' * ubar;
    k = 1 / lambda * P * ubar / (1 + 1 / lambda * ubar' * P * ubar);
    e(i) = d(i) - y(i);
    w = w + k * e(i);
    P = 1 / lambda * P - 1 / lambda * k * ubar.' * P;
end

end
