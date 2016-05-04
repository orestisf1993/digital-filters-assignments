function [b] = avg_every(a, n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if ~exist('n', 'var')
    % average every n values
    n = 3000;
end
b = arrayfun(@(i) mean(a(i:i+n-1)),1:n:length(a)-n+1)'; % the averaged vector

end

