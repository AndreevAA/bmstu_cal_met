function lab04()
    clc();

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-6;
    h = 1e-3;

    create_figure(a, b)

    pause(3);
    modified_newton_method(a, b, eps, h, debugFlg, delayS);

    output_fminbnd(a, b)
end

function output_fminbnd(a, b)
    [x, f_x, temp] = fminbnd(@f, a, b);
    fprintf('fminbnd: x=%.10f, f(x)=%.10f\n', x, f_x);
    scatter(x, f_x, 's', 'filled');
end

function output_tmp_nearest(i, x, f_x, f1)
    fprintf("№ %2d:\t x = %.10f, f(x) = %.10f, f\'(x) = %.10f \n", i, x, f_x, f1);
    plot(x, f_x, 'xk');
    hold on;
end

function output_nearest(i, x, f_x)
    fprintf('RESULT: %2d iterations: x=%.10f, f(x)=%.10f\n', i, x, f_x);
    scatter(x, f_x, 'b', 'filled');
end

function [x, x_temp, f_x, i] = modified_newton_method_iteration(x_val, h, i_val)
    f_inc = f(x_val + h);
    f_dec = f(x_val - h);
    f_x = f(x_val);

    f1 = (f_inc - f_dec) / (2 * h);
    f2 = (f_inc - 2 * f_x + f_dec) / (h^2);

    output_tmp_nearest(i_val, x_val, f_x, f1)

    x_temp = x_val;
    x = x_temp - f1 / f2;

    i = i_val + 1;
end

function modified_newton_method(a, b, eps, h, debugFlg, delayS)
    x = (a + b) / 2;
    i = 1;

    [x, x_temp, f_x, i] = modified_newton_method_iteration(x, h, i)
    pause(delayS);

    while abs(x - x_temp) >= eps
        [x, x_temp, f_x, i] = modified_newton_method_iteration(x, h, i)
        pause(delayS);
    end

    x_star = x;
    f_star = f_x;

    output_nearest(i, x, f_x)
end

function y = f(x)
    y = exp(((x.^4) + (x.^2) - x + sqrt(5)) / 5) + sinh((x.^3 + 21 * x + 9) ./ (21*x + 6)) - 3.0 * ones(size(x));
    %y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
    %y = (x - 0.111)^4;
    %y = sinh((3 * x.^4 - x + sqrt(17) - 3) / 2) + sin((5.^ 1/3 * x.^3 - 5.^1/3 * x + 1 - 2 * 5.^1/3) / (-x.^3 + x + 2));
end

function create_figure(a, b)
    figure;
    fplot(@f, [a, b]);
    hold on;
end
