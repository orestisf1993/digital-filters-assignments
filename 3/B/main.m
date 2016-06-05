clear; close;

%% Create u and d vectors.
n = 25000;
u = zeros(1, n);
d = zeros(size(u));
s = zeros(size(u));
x = zeros(size(u));
sigma1d = 0.73;
sigma2d = 0.39;
v1 = sqrt(sigma1d)*randn(n,1);
v2 = sqrt(sigma2d)*randn(n,1);

for i=4:1:n
    u(i)=-0.87*u(i-1)-0.12*u(i-2)-0.032*u(i-3)+v1(i);
    s(i)=-0.23*u(i)+0.67*u(i-1)-0.18*u(i-2)+0.39*u(i-3);
    x(i)=-0.57*x(i-1)-0.16*x(i-2)-0.08*x(i-3)+v2(i);
    d(i)=s(i)+x(i);
end

%% Run algorithms.
M = 4;
functions = {@my_lms, @my_rls, @my_nlms};
function_names = {'LMS', 'RLS', 'NLMS'};

for f_id = 1:length(functions)
    name = function_names{f_id};
    [~, ~, e] = functions{f_id}(u, d, M);
    J = e.^2;
    [J_avg, x_avg] = avg_every(J(M:end), 100);
    f = new_figure();
    hold on;

    subplot(1,2,1);
    semilogy(J);
    title('log');
    xlabel('$n$');
    ylabel('$(y-d)^2$');

    subplot(1,2,2);
    plot(x_avg, J_avg);
    title('linear');
    xlabel('$n$');
    ylabel('$(y-d)^2$');

    print(strcat(name, '.pdf'), '-dpdf', '-r0')
    close(f);
end
