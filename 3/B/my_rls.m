function [y, w, e] = my_rls(u, d, M)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

u = u(:);
d = d(:);
n = length(u);

delta = 200;
lambda = 0.99;

P = delta * eye(M, M);
w = zeros(M, 1);
y = zeros(size(u));
e = zeros(size(u));

for i = (M + 1):n
    ubar = u(i:-1:i-M+1);
    y(i) = w.' * ubar;
    k = 1/lambda * P * ubar / (1 + 1/lambda * ubar'*P*ubar);
    e(i) = d(i) - y(i);
    w = w + k * e(i);
    P = 1/lambda * P - 1/lambda * k * ubar'*P;
end

end
