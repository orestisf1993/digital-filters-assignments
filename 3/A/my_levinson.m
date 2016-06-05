function [a, L, G, P] = my_levinson(r, M)
%MY_LEVINSON Applies the iterative version of the Levinson-Durbin algorithm.
%   [A, L, G, P] = MY_LEVINSON(R, M) solves for the input R (auto-correlation
%   vector) and filter order M. Output is:
%       A: Tap-weight vector.
%       L: Lower triangular matrix used to orthogonalize b.
%       G: Vector of reflection coefficients.
%       P: The power of prediction error.

% Make sure that r is a column vector.
r = r(:);

% r is at least r(0), r(1), ..., r(M).
assert(M > 1);
assert(length(r) > M);

% Initialize.
P = [r(1), zeros(1, M)];
G = zeros(1, M);
L = zeros(M + 1, M + 1);
a = cell(1, M);
a{1} = 1;
L(1, 1) = a{1};
D = r(2);

% Main loop.
for m = 1:M
    G(m) = - D / P(m);
    a{m + 1} = [a{m}; 0] + G(m) * [0; a{m}(end:-1:1)];
    if (m < M)
        % We don't need to calculate D during the last iteration.
        D = a{m + 1}.' * r(m + 2:- 1:2);
    end
    P(m + 1) = P(m) * (1 - G(m) ^ 2);
    L(m + 1, 1:m + 1) = a{m + 1}(end:-1:1);
end

end
