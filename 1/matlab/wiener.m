%% Load files with sound data.
clear all; close all;
load('noise.mat');
load('sound.mat');

%% Parameters for Wiener filter.
n = length(u); % Number of samples / sound length.
n_coeffs = 60; % Number of coefficients in wiener filter.
max_lag = n_coeffs - 1;

%% Calculate needed values.
% Αutocorrelation sequence.
ruu = xcorr(u, max_lag, 'biased');
% Construct autocorrelation matrix.
R = toeplitz(ruu(n_coeffs: -1:1));
% Cross-correlation sequence.
rdu = xcorr(d, u, max_lag, 'biased');
% Cross-correlation vector.
p = rdu(n_coeffs:2 * n_coeffs - 1);

%% Ask for wiener filter coefficient calculation method.
while true
    answer = input('Use steepest descent for wiener coefficients? [Y/n]', 's');
    answer = lower(answer);
    if strcmp(answer, '')
        answer = 'y';
    end
    if strcmp(answer, 'y')
        fprintf('Using steepest descent.\n')
        mu = 0.75 * 2 / max(eig(R));
        [~, w_opt] = steepest_descent(p, R, mu, 0.0000001, 100000);
        break
    elseif strcmp(answer, 'n')
        fprintf('Using Wiener-Hopf.\n')
        w_opt = R \ p; % Wiener-Hopf solution
        break
    end
end

%% Filter sound.
y = conv(w_opt, u);
e = d - y(1:length(d));

%% Play result.
sound(e, Fs);
audiowrite('result.wav', e, Fs);
fprintf('Press Enter to stop playing the song.\n')
pause;
clear sound;
