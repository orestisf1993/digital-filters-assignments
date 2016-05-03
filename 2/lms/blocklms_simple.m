function [w, J] = blocklms_simple(u, d)
%BLOCKLMS_SIMPLE Block LMS algorithm using 2 nested loops.
%   BLOCKLMS_SIMPLE(U, D) will execute the Least Mean Square (LMS) Algorithm for
%   the input vector U and the desired response D. The following values are
%   used:
%       filter length M = 3000
%       block size L = M
%       step mu = 2.0e-04

% Esure that u and d are column vectors.
u = u(:);
d = d(:);

mu = 2.0e-04;
M = 3000;
L = M;
w = zeros(M, 1);
N = length(u);

% Iterate for k block index
kmax = floor(N / L) - 1;
J = zeros(1, kmax * L);
for k = 1:kmax
    phi = zeros(M, 1);
    for i = 0:L - 1
        idx = k * L + i:-1:k * L + i - M + 1;
        newu = u(idx);
        newd = d(idx(1));
        y = w'*newu;
        newe = newd - y;
        J((k - 1) * L + i + 1) = newe .^ 2;
        phi = phi + mu * newe * newu;
    end
    w = w + phi;
end
