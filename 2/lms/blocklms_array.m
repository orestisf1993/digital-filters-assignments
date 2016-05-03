function [w, J] = blocklms_array(u, d)
%BLOCKLMS_ARRAY Block LMS algorithm using a single loop and matrix operations.
%   BLOCKLMS_ARRAY(U, D) will execute the Least Mean Square (LMS) Algorithm for
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
    idx = repmat(k * L:-1:k * L - M + 1, L, 1) + repmat((0:L - 1).', 1, M);
    newu = u(idx);
    newd = d(idx(:, 1));
    newe = newd - newu * w;
    save_range = (k - 1) * L + 1:k * L;
    J(save_range) = newe .^ 2;
    w = w + mu * (newe.' * newu).';
end
