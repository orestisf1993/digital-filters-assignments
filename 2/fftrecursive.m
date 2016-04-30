function [y] = fftrecursive(x)
%FFTRECURSIVE Discrete Fourier transform using recursion.
%   FFTRECURSIVE(X) is the discrete Fourier transform (DFT) of vector X
%   calculated recursively.

n = length(x);
if ~(round(log2(n)) == log2(n))
    warning('Lenght of x is not a power of 2. Function may not behave correctly.');
end

if n == 1
    y = x;
else
%     y = zeros(n, 1);
    y_top = fftrecursive(x(1:2:n - 1));  % T(n/2) cost.
    y_bottom = fftrecursive(x(2:2:n));  % T(n/2) cost.
    d = exp(-2 * pi * 1i / n) .^ (0:n / 2 - 1);
    z = (d.') .* y_bottom;  % 6n/2 cost.
    y = [y_top + z; y_top - z];  % n complex additions => 2n cost.
end
end
