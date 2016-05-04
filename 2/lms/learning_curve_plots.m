f = new_figure();

% Plot J for every block.
for function_id = 1:nfunctions
    plot(avg_every(j{function_id}, M));
    hold on;
end

legend({'2 Nested Loops', 'Single loop', 'FDAF', 'Unconstrained FDAF'}, 'Location', 'NorthEast');
xlabel('block');
ylabel('Mean Square Error (y-d)^2');
title(sprintf('Learning curve for n = %d', n));
print('../doc/plots/learning-curve.pdf', '-dpdf', '-r0')
close(f);