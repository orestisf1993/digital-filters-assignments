xvalues = 6000:1650:60000;
yvalues = zeros(nfunctions, length(xvalues));

for idx = 1:length(xvalues)
    n = xvalues(idx);
    [u, d] = create_ud(n);

    % Run LMS variations:
    fprintf('Running %d LMS functions using n=%d. Iteration %d/%d.\n', nfunctions, n, idx, length(xvalues));

    for function_id = 1:nfunctions
        tic;
        lms_functions{function_id}(u, d);
        yvalues(function_id, idx) = toc;
    end
end
