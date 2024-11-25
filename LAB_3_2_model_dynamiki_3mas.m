    % Parametry układu
    m = [1, 2, 1.5];  % Masy: m1, m2, m3
    k = [100, 100];   % Stałe sprężystości: k1 między m1 i m2, k2 między m2 i m3

    % Warunki początkowe [x1, v1, x2, v2, x3, v3]
    x0 = [0.5, 0, -0.5, 0, 0, 0];

    % Czas symulacji
    tspan = [0 20];

    % Rozwiązanie równań różniczkowych
    [t, x] = ode45(@(t, x) ruch(t, x, m, k), tspan, x0);

    % Wykresy przemieszczeń każdej z mas
    figure;
    plot(t, x(:, 1), 'r', t, x(:, 3), 'g', t, x(:, 5), 'b');
    legend('Masa 1', 'Masa 2', 'Masa 3');
    xlabel('Czas [s]');
    ylabel('Przemieszczenie [m]');
    title('Dynamika trzech mas połączonych dwoma sprężynami');
    grid on;

    function dxdt = ruch(t, x, m, k)
        % x = [x1, v1, x2, v2, x3, v3]
        % dxdt = [dx1/dt, dv1/dt, dx2/dt, dv2/dt, dx3/dt, dv3/dt]
        
        % Przemieszczenia
        x1 = x(1);
        x2 = x(3);
        x3 = x(5);

        % Prędkości
        v1 = x(2);
        v2 = x(4);
        v3 = x(6);

        % Siły związane ze sprężynami
        F1 = -k(1) * (x1 - x2);  % Siła wywołana przez sprężynę 1 na m1 i m2
        F2 = -k(2) * (x2 - x3);  % Siła wywołana przez sprężynę 2 na m2 i m3

        % Równania różniczkowe
        dv1dt = (F1) / m(1);
        dv2dt = (-F1 + F2) / m(2);
        dv3dt = (-F2) / m(3);
        dxdt = [v1; dv1dt; v2; dv2dt; v3; dv3dt];
    end
