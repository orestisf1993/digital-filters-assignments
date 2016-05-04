n = 45000;
M = 3000;
L = M;
[u, d] = create_ud(n);

j = cell(4, 1);

% Turn on the Profiler, and enable the function call history option.
profile on -history

for function_id = 1:nfunctions
    [~, j{function_id}] = lms_functions{function_id}(u, d);
end

% Save the profile results.
profsave(profile('info'), 'profiler_results');
