function lab02()
    clc; % Очистка командного окна

    delayS = 2; % Задержка для отладочной информации
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

    h = plot([a b], [f(a) f(b)], 'b'); % Построение пробного отрезка
    hold on; % Удержание текущего графика на рисунке

    cnt = 1; % Счетчик итераций

    while l > 2 * eps
        fprintf('№ %2d ai=%.10f bi=%.10f\n', cnt, a, b); % Вывод отладочной информации
        pause(delayS); % Пауза

        point_test_a = plot(a + tau * (b - a), f(a + tau * (b - a)), 'ro');
        point_test_b = plot(b - tau * (b - a), f(b - tau * (b - a)), 'ro');

        pause(delayS); % Пауза

        if f(a) <= f(b)
            b = a + tau * (b - a);
        else
            a = b - tau * (b - a);
        end

        delete(h); % Удаление пробного отрезка


        h = plot([a b], [f(a) f(b)], 'b'); % Построение нового пробного отрезка
        pause(delayS); % Пауза
        delete(point_test_a);
        delete(point_test_b);
        hold on; % Удержание текущего графика на рисунке

        cnt = cnt + 1;
        l = b - a;
    end

    xStar = (a + b) / 2; % Найденное приближение минимума
    fStar = f(xStar); % Значение функции в найденном минимуме

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
