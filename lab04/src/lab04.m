function lab04()
    clear; clc;

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-9;
    h = 1e-3;

    x = linspace(a, b, 100);
    plot(x, f(x));
    hold on;

    modified_newton_method(a, b, eps, h, debugFlg, delayS);

    [x_res, f_res] = fminbnd(@f, a, b);
    fprintf('fminbnd: x=%.10f, f(x)=%.10f\n', x_res, f_res);
end

function output_temp_nearest(i, x, f_x, f1, delayS)
    fprintf("nearest tmp ->№ %2d:\t x = %.10f, f(x) = %.10f, f'(x) = %.10f \n", i, x, f_x, f1);
    plot(x, f_x, 'xk');
    hold on;
    pause(delayS);
end

function output_nearest(i, x, f_x, delayS)
    fprintf("nearest min -> № %2d:\t x = %.10f, f(x) = %.10f", i, x, f_x);
    plot(x, f_x, 'ro', 'MarkerFaceColor', 'r');
    hold on;
    pause(delayS);
end

function [x, x_temp, i, f_x] = modified_newton_method_iteration(a, x_val, h, i_val, delayS)
    f_dec = f(x_val - h);
    f_x = f(x_val);
    f_inc = f(x_val + h);

    f1 = (f_inc - f_dec) / (2 * h);
    f2 = (f_inc - 2 * f_x + f_dec) / (h^2);

    output_temp_nearest(i_val, x_val, f_x, f1, delayS)

    x_temp = x_val;
    x = x_temp - f1 / f2;
    i = i_val + 1
end

function modified_newton_method(a, b, eps, h, debugFlg, delayS)
    x = (a + b) / 2;

    i = 1;
    f_x = 0;

    [x, x_temp, i, f_x] = modified_newton_method_iteration(a, x, h, i, delayS)

    while abs(x - x_temp) >= eps
        [x, x_temp, i, f_x] = modified_newton_method_iteration(a, x, h, i, delayS)
    end

    output_nearest(i, x, f_x, delayS)

end

function y = f(x)
    y = exp(((x.^4) + (x.^2) - x + sqrt(5)) / 5) + sinh((x.^3 + 21 * x + 9) / (21*x + 6)) - 3.0;
    %y = (x-0.222).^4;
end

