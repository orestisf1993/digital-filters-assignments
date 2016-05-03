function [w, J] = blocklms_array(u, d)

% Esure that u and d are column vectors.
u = u(:);
d = d(:);

mu = 2.0e-04;
M = 3000;  % number of coefficients.
L = M;  % block length
w = zeros(M, 1);
N = length(u);

% Iterate for k block index
kmax = floor(N / L);  % round? floor? ceil?
J = zeros(1, kmax * L);
for k = 1:kmax-1
    idx = repmat(k*L:-1:k*L - M + 1, L, 1) + repmat((0:L-1).', 1, M);
    newu = u(idx);
    newd = d(idx(:, 1));
    newe = newd - newu*w;
    save_range = (k-1) * L + 1:k * L;
    J(save_range) = newe.^2;
    w = w + mu * (newe.' * newu).';
end
