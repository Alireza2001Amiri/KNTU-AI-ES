clc
clear
close all;

FitFnc = @fitness;
nvars = 2;

options = optimoptions(@ga,'Display','iter');

[x, fval] = ga(FitFnc, nvars, options)
