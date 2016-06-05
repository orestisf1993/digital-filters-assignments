function [y, x] = avg_every(a, n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if ~exist('n', 'var')
    % average every n values
    n = 3000;
end

x = 1:n:length(a)-n+1;
y = arrayfun(@(i) mean(a(i:i+n-1)), x); % the averaged vector

end
