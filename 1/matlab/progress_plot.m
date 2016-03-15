function [] = progress_plot(Wh, x, J, target, axes)
% PROGRESS_PLOT Create a contour plot with the progress of the steepest descent
% algorithm.
%   PROGRESS_PLOT(WH, X, J, TARGET, AXES) creates the plot given the WH history
%   of the W vector, X axis points, J criterion values. TARGET is the
%   convergence point, AXES is the Axes object for the plot.

contour(axes, x, x, J, 100);
plot(Wh(:, 1), Wh(:, 2), 'r*');
plot(Wh(:, 1), Wh(:, 2), 'k');
plot(target(1), target(2), 'square');

end
