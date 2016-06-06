%% Initialize.
clear; close;
load speakerA;
fsA = fs;
load speakerB;
assert(fs == fsA); clear fsA;

%% Run algorithms.
M = 6600;
functions = {@my_lms, @my_nlms};
results = cell(3, 2);
function_names = {'LMS', 'NLMS'};

for f_id = 1:length(functions)
    name = function_names{f_id};
    fprintf('Executing %s.\n', name);
    tic;
    [results{f_id, 1}, results{f_id, 2}, ~] = functions{f_id}(u, d, M);
    toc;
end

%% Display results and play sounds.
for f_id = 1:length(functions)
    name = function_names{f_id};
    y = results{f_id, 1};
    w = results{f_id, 2};
    fprintf('Playing sound resulting from %s.\nPress Enter to stop sound.\n', name);
    sound(d - y, fs);
    pause;
    clear sound;
end
