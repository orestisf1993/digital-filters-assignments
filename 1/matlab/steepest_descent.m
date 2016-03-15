function [W_history, W] = steepest_descent(p, R, mu, e, max_steps)
% STEEPEST_DESCENT Calculate weiner filter coefficients with steepest descent
% algorithm.
%   [Wh, W] = STEEPEST_DESCENT(p, R, mu, e) computes the coefficients with the
%   cross-correlation vector p, autocorrelation matrix R, adaptation step mu and
%   precision e. Wh is the history of the W coefficient vector.
%
%   [Wh, W] = STEEPEST_DESCENT(p, R, mu, e, max_steps) changes the maximum
%   number of loops the algorithm takes.

if ~exist('max_steps', 'var')
    max_steps = 1000;
end

W_history = zeros(max_steps, length(R));
W = -1 * ones(length(R), 1);
W_history(1, :) = W;
for step = 2:max_steps
    W = W + mu * (p - R * W);
    W_history(step, :) = W;
    diff = W_history(step) - W_history(step - 1);
    if norm(diff) < e
        % shrink history size.
        W_history = W_history(1:step, :);
        break
    end
end

end
