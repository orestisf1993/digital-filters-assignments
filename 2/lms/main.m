clear; close all;
lms_functions = {@blocklms_simple, @blocklms_array, @blocklms_fft, @blocklms_unconstrained_fft};
nfunctions = length(lms_functions);

performance_stats;
performance_plots;
learning_curve_stats;
learning_curve_plots;

save('data');