function [T, Y] = vrni_resitevMack(mase, polozaji, hitrost)

N = length(mase);

ic = [polozaji hitrost];
ic = reshape(ic.', [1, N*6]);

%time parameters
t_start = 0;
t_end = 1e4;
%n = 10;
%t = linspace(t_start,t_end,n);

t = [t_start t_end];


[T, Y] = ode113(@(T, Y) n_body(T, Y), t, ic);

n = size(T, 1);

Y_plot = zeros(6, N, n);
for i=1:n
    Y_plot(:, :, i) = reshape(Y(i, :).', [6, N]);
end

figure
hold all
grid on
grid minor
box on
view(3)

for i=1:n
    if (i~=1 && i~=n)
        plot3(Y_plot(1, :, i), Y_plot(2, :, i), Y_plot(3, :, i), 'b.', MarkerSize=3)
    elseif (i==1)
        plot3(Y_plot(1, :, 1), Y_plot(2, :, 1), Y_plot(3, :, 1), 'g.', MarkerSize=20)
    else
        plot3(Y_plot(1, :, n), Y_plot(2, :, n), Y_plot(3, :, n), 'r.', MarkerSize=20)
    end
end


end