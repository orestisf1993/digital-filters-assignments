function [f] = new_figure(x, y)
%NEW_FIGURE Create a figure.

if ~exist('x', 'var')
    x = 1;
end
if ~exist('y', 'var')
    y = 1.1;
end

f = figure('visible', 'off', 'PaperType', 'a4', 'PaperOrientation', 'portrait', ...
    'PaperUnits', 'centimeters', 'PaperPosition', [0, 0, 21 / x, 29.7 / y], 'PaperPositionMode', 'manual', ...
    'Menubar', 'none', 'defaulttextinterpreter', 'latex', 'units', 'normalized', 'outerposition', [0, 0, 1, 1]);

end
