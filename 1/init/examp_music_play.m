% A simple example of how to play music from matlab
%
% author: Nikos Sismanis
% date: March 2014


clear all
close all

% load sound data
load('sound.mat');
% load('music.mat');

% play the music
sound(d, Fs); % play

