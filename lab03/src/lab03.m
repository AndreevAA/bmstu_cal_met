function lab03()
    clc();

    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-6;

    fplot(@f, [a, b]);
    hold on;

    pause(3);

    fprintf('-------Метод золотого сечения (поиск начальных точек x1, x2, x3)-------\n');
    [x1, x2, x3, f1, f2, f3, a, b] = find_initial_points(a, b, eps, delayS);

    fprintf('-------Параболический метод-------\n');
    optimize_parabolic(x1, x2, x3, f1, f2, f3, a, b, eps, delayS);
end

function [x1, x2, x3, f1, f2, f3, a, b] = find_initial_points(a, b, eps, delayS)
    tau = (sqrt(5)-1) / 2;
    l = b - a;

    x1 = b - tau*l;
    x2 = a + tau*l;
    f1 = f(x1);
    f2 = f(x2);

    i = 0;

    fprintf('№ %2d:\t [a, b] = [%.10f, %.10f], f(a) = %.10f, f(b) = %.10f\n', i, a, b, f(a), f(b));
    line([a b], [f(a) f(b)], 'color', 'b');

     i = 0;

    fprintf('№ %2d:\t [a, b] = [%.10f, %.10f], f(a) = %.10f, f(b) = %.10f\n', i, a, b, f(a), f(b));
    line([a b], [f(a) f(b)], 'color', 'b');

    while l > 2*eps
        i = i + 1;

        line([a b], [f(a) f(b)], 'color', 'b');
        hold on;

        if f1 <= f2
            b = x2;
            l = b - a;

            new_x = b - tau*l;
            new_f = f(new_x);

            if f1 <= new_f
               x3 = x2;     f3 = f2;
               x2 = x1;     f2 = f1;
               x1 = new_x;  f1 = new_f;
               break;
            end

            x2 = x1;        f2 = f1;
            x1 = new_x;     f1 = new_f;
        else
            a = x1;
            l = b - a;

            new_x = a + tau*l;
            new_f = f(new_x);

            if f2 <= new_f
                x1 = a;
                x3 = new_x; f3 = new_f;
                break;
            end

            x1 = x2;        f1 = f2;
            x2 = new_x;     f2 = new_f;
        end

        fprintf('№ %2d:\t [a, b] = [%.10f, %.10f], f(a) = %.10f, f(b) = %.10f\n', i, a, b, f(a), f(b));
        line([a b], [f(a) f(b)], 'color', 'r');
        hold on;
        pause(delayS);
    end
end

function optimize_parabolic(x1, x2, x3, f1, f2, f3, a, b, eps, delayS)
    a1 = (f2 - f1) / (x2 - x1);
    a2 = ((f3 - f1)/(x3 - x1) - (f2 - f1)/(x2 - x1)) / (x3 - x2);
    x_ = 1 / 2 * (x1 + x2 - a1/a2);
    f_ = f(x_);

    for i = 1:1000
        old_x_ = x_;

        if f_ > f2
            temp = f_; f_ = f2; f2 = temp;
            temp = x_; x_ = x2; x2 = temp;
        end

        if x_ > x2
            x1 = x2; f1 = f2;
            x2 = x_; f2 = f_;
        else
            x3 = x2; f3 = f2;
            x2 = x_; f2 = f_;
        end

        fprintf('№ %2d:\t [x1, x3] = [%.10f, %.10f], f(x1) = %.10f, f(x3) = %.10f\n', i, x1, x3, f1, f3);
        fprintf('Current min point: x=%.10f, f(x)=%.10f\n', x_, f_);
        line([x1 x3], [f1 f3], 'color', 'b');
        plot(x_, f_, 'xk');
        hold on;
        pause(delayS);

        a1 = (f2 - f1) / (x2 - x1);
        a2 = ((f3 - f1)/(x3 - x1) - (f2 - f1)/(x2 - x1)) / (x3 - x2);
        x_ = 1 / 2 * (x1 + x2 - a1/a2);
        f_ = f(x_);

        if abs(old_x_ - x_) <= eps
            break
        end
    end

    x_res = x_;
    f_res = f_;

    scatter(x_res, f_res, 'r', 'filled');
    fprintf('РЕЗУЛЬТАТ: %2d итераций, x=%.10f, f(x)=%.10f\n', i, x_res, f_res);
end

function y = f(x)
    %y = exp(((x^4) + (x^2) - x + sqrt(5)) / 5) + sinh((x^3 + 21 * x + 9) / (21*x + 6)) - 3.0;
    y = (x-0.222).^4;
end
