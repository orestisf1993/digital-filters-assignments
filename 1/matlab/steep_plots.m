% Script to create multiple plots of steepest descent progress according to mu
% value.
%% Initialize pre-calculated values & constants to use.
r = [1 0.78; 0.78 1] \ [0.19; 0];  % solve the system calculated in report.pdf
R = [r(1) r(2); r(2) r(1)];  % autocorrelation matrix.
P = [0.19 0]';  % cross-correlation vector.
mumax = 2 / max(eig(R));  % 0 < mu < mumax
precision = 1e-5;  % precision for steepest descent.
max_steps = 10000;  % max steps for steepest descent.

% For which mu values to plot
mu_values = {1e-2, 1e-1, 2e-1, 2, mumax * 0.99, mumax * 1.01, 4};

% Create a "background" surface for the contour plot.
[J, x] = construct_J(R, P);

%% Create and save plots.
for i = 1:length(mu_values)
    hold off;
    figure('visible', 'off', 'PaperType', 'a4', 'PaperOrientation', 'portrait', ...
  'PaperUnits', 'centimeters', 'PaperPosition', [0 0 21 29.7], 'PaperPositionMode', 'manual', ...
  'Menubar', 'none', 'defaulttextinterpreter', 'latex', 'units', 'normalized', 'outerposition', [0 0 1 1]);
    hold on;
    mu = mu_values{i};
    [Wh, W] = steepest_descent(P, R, mu, precision, max_steps);
    Wh = remove_huge(Wh);
    progress_plot(Wh, x, J, [1 0.78], gca);
    title_str = 'Steepest descent progress with $\\mu = %g$';
    title_str = sprintf(title_str, mu);
    title(title_str);
    xlabel('w_1');
    ylabel('w_2');
    xlim([-2.5 2.5]);
    ylim([-2.5 2.5]);
    colorbar;
    fname = sprintf('../doc/plots/steepest%d.pdf', i);
    print(fname, '-dpdf', '-r0')
end