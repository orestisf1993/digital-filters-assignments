function [y, w, e] = my_lms(u, d, M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

u = u(:);
d = d(:);
n = length(u);

mu = 0.001;

w = zeros(M, 1);
y = zeros(size(u));
e = zeros(size(u));

for i = M + 1:n
    ubar = u(i:-1:i-M+1);
    y(i) = w.' * ubar;
    e(i) = d(i) - y(i);
    w = w + mu*e(i)*ubar;
end

end

