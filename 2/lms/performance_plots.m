plot_functions = {@plot @semilogy};
line_widths = [1 2];

for plot_id = 1:2
    f = new_figure(1, 2);
    for function_id = 1:nfunctions
        y = yvalues(function_id, :);
        plot_functions{plot_id}(xvalues, y, 'LineWidth', line_widths(plot_id));
        % http://www.mathworks.com/matlabcentral/answers/95921-why-does-the-semilogy-function-not-plot-onto-a-logarithmic-scale-in-matlab-6-5-r13
        hold on;
    end
    title('Performance of LMS algorithms');
    xlabel('n');
    ylabel('time (seconds)');
    legend({'2 Nested Loops', 'Single loop', 'FDAF', 'Unconstrained FDAF'}, 'Location', 'NorthWest');
    print(sprintf('../doc/plots/performance-%d.pdf', plot_id), '-dpdf', '-r0')
    close(f);
end
