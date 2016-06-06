function [y, x] = avg_every(a, n)
%AVG_EVERY Average every N elements of a vector.
%   [Y, X] = AVG_EVERY(A, N) will calculate the averaged vector Y for every N
%   elements of vector A. X is the index of the new vector Y according to the
%   old index.

x = 1:n:length(a) - n + 1;
y = arrayfun(@(i) mean(a(i:i + n - 1)), x); % the averaged vector

end
