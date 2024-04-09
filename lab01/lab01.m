function main()
    clc();

    % Установка параметров
    debugFlag = 1;
    delaySeconds = 0.8;
    intervalStart = 0;
    intervalEnd = 1;
    epsilon = 0.000001;

    % Отображение графика функции
    fplot(@functionToOptimize, [intervalStart, intervalEnd]);
    hold on;

    % Поиск оптимального значения
    [optimalX, optimalF] = optimizeFunction(intervalStart, intervalEnd, epsilon, debugFlag, delaySeconds);

    % Отображение оптимальной точки на графике
    scatter(optimalX, optimalF, 'r', 'filled');
end

function [optimalX, optimalF] = optimizeFunction(start, finish, epsilon, debugFlag, delaySeconds)
    % Инициализация переменных
    i = 0;
    delta = (finish - start) / 4;
    x0 = start;
    f0 = functionToOptimize(x0);

    plotX = [];
    plotF = [];

    % Цикл оптимизации
    while 1
        i = i + 1;
        x1 = x0 + delta;
        f1 = functionToOptimize(x1);

        if debugFlag
            fprintf('Iteration %2d: x=%.10f, f(x)=%.10f\n', i, x1, f1);

            plotX(end + 1) = x1;
            plotF(end + 1) = f1;

            clc();
            plot(plotX, plotF, 'xk');

            plot(x1, f1, 'xr');
            hold on;
            pause(delaySeconds);
        end

        % Проверка условия оптимизации
        if f0 > f1
            x0 = x1;
            f0 = f1;

            if start < x0 && x0 < finish
                continue
            else
                if abs(delta) <= epsilon
                    break;
                else
                    x0 = x1;
                    f0 = f1;
                    delta = -delta / 4;
                end
            end
        else
            if abs(delta) <= epsilon
                break;
            else
                x0 = x1;
                f0 = f1;
                delta = -delta / 4;
            end
        end
    end

    i = i + 1;
    if debugFlag
        fprintf('Iteration %2d: x=%.10f, f(x)=%.10f\n', i, x0, f0);
        fprintf('RESULT: x=%.10f, f(x)=%.10f\n', x0, f0);
        plot(plotX, plotF, 'xk');
    end

    optimalX = x0;
    optimalF = f0;
end

function y = functionToOptimize(x)
    y = exp(((x^4) + (x^2) - x + sqrt(5)) / 5) + sinh((x^3 + 21 * x + 9) / (21*x + 6)) - 3.0;
end

