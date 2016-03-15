function [J, axis_points] = construct_J(R, p)
% CONSTRUCT_J Calculate the criterion J in a 2D grid.
%   Uses a 100 x 100 grid from (-2.5, -2.5) to (2.5, 2.5).

grid_points = 150;
axis_points = linspace(-2.5, 2.5, grid_points);

J = zeros([grid_points, grid_points]);

% Calculate the standard Deviation of d approximately.
% x = @(n) cos(pi * n) .* sin(pi * n / 25 + pi/3);
% var_d = var(x(0:1:100000)) + 0.19;
var_d = 0.5 + 0.19;  % comment this & un-comment 2 lines above to calculate approximately.
% Construct the error surface.
for i = 1:grid_points
    for k = 1:grid_points
        wp = [axis_points(i); axis_points(k)];
        % Equation 17 of Lecture 2.
        J(k, i) = var_d - 2 * (p') * wp + wp' * R * wp;
    end
end

end
