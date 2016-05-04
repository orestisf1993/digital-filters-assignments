function [u, d] = create_ud(n)
%CREATE_UD init a U, D pair.
%   CREATE_UD(N) will create the input vector U and the desired response D with
%   length N using sigma2 = 0.27. Both U and D are column vectors with size 1xN.

sigma2 = 0.27;

% Create a white noise vector with variance sigma2.
v = randn(1, n) * sqrt(sigma2);
u = zeros(size(v));
for i=2:length(v)
    u(i) = -0.18*u(i-1) + v(i);
end
d = plant(u);
d = d(:);
end
