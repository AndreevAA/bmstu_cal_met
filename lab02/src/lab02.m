function lab02()
    clc; % Очистка командного окна

    delayS = 0.8; % Задержка для отладочной информации
    a = 0; % Начальное значение интервала
    b = 1; % Конечное значение интервала
    eps = 1e-2; % Точность

    createLineOfFunction(a, b, delayS)

    goldenRatio(a, b, eps, delayS); % Вызов функции оптимизации


end

function createLineOfFunction(a, b, delayS)
    x = linspace(a, b, 100); % Генерация точек для построения графика
    y = arrayfun(@f, x); % Вычисление значений функции f для точек x
    plot(x, y); % Построение графика функции f
    hold on; % Удержание текущего графика на рисунке

    pause(delayS); % Пауза
end

function goldenRatio(a, b, eps, delayS)
    tau = (sqrt(5) - 1) / 2; % Золотое сечение
    l = b - a; % Длина интервала

    x1 = b - tau * l; % Вычисление первой точки
    x2 = a + tau * l; % Вычисление второй точки
    f1 = f(x1); % Вычисление значения функции в первой точке
    f2 = f(x2); % Вычисление значения функции во второй точке

    cnt = 1; % Счетчик итераций

    while l > 2 * eps

        fprintf('№ %2d ai=%.10f bi=%.10f\n', cnt, a, b); % Вывод отладочной информации
        plot([a b], [f(a) f(b)], 'b'); % Построение отрезка
        hold on; % Удержание текущего графика на рисунке
        pause(delayS); % Пауза

        if f1 <= f2
            b = x2;
            x2 = x1;
            f2 = f1;

            l = b - a;
            x1 = b - tau * l;
            f1 = f(x1);
        else
            a = x1;
            x1 = x2;
            f1 = f2;

            l = b - a;
            x2 = a + tau * l;
            f2 = f(x2);
        end

        cnt = cnt + 1
    end

    xStar = (a + b) / 2; % Найденное приближение минимума
    fStar = f(xStar); % Значение функции в найденном минимуме

    i = i + 1; % Увеличение счетчика итераций

    fprintf('№ %2d ai=%.10f bi=%.10f\n', cnt, a, b); % Вывод отладочной информации
    fprintf('RESULT: x*=%.10f f(x*)=%.10f\n', xStar, fStar); % Вывод результата
    plot([a b], [f(a) f(b)], 'g'); % Подсветка отрезка
    plot(xStar, fStar, 'go'); % Подсветка точки минимума
end

function y = f(x)
    y = exp(((x^4) + (x^2) - x + sqrt(5)) / 5) + sinh((x^3 + 21 * x + 9) / (21*x + 6)) - 3.0;
    %y = (x - 0.50)^4; % Определение функции
    %y = x
end


