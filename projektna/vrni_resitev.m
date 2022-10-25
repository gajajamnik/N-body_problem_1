
function [T, Y] = vrni_resitev(mase, zac_polozaji, zac_hitrosti, tk)
%vrne resitev sistema NDE
%INPUT
%mase...vektor mas N delcev
%zac_polozaji...matrika zacetnih polozajev N delcev [x y z]
%zac_hitrosti...matrika zacetnih hitrosti N delcev [x' y' z']
%tk...koncen cas
%
%OUTPUT:
%T...vektor casov v ketrih je izracunan sistem NDE
%Y...rezultat sistema NDE, v vsaki vrstici so podatki za dolocen cas:
%    [x1 y1 z1 x1' y1' z1' x2 y2 z2 x2' ... x_N y_N z_N x_N' y_N' z_N']

n = 1000; %stevilo delilnih tock
t = linspace(0,tk,n);
%t = 0:5e1:1e4;

tspan = [0 tk];
N = length(mase);

zac_pogoji = [zac_polozaji zac_hitrosti];

zac_pogoji = reshape(zac_pogoji', [1, 6*N]);

%funkcija
%f = @(t,r) pospesek(t, mase, r);
%F = @(t,Y) [Y(2), f(t, Y(2))]';

[T, Y] = ode113(@(t,Y) pospesek(t, mase, Y), t, zac_pogoji);

%PLOT

n = size(T, 1);

Y_graf = zeros(6, N, n);

for i=1:n
    Y_graf(:, :, i) = reshape(Y(i, :).', [6, N]);    
end

x_max = max(max(Y_graf(1, :, :)));
x_min = min(min(Y_graf(1, :, :)));

y_max = max(max(Y_graf(2, :, :)));
y_min = min(min(Y_graf(2, :, :)));

z_max = max(max(Y_graf(3, :, :)));
z_min = min(min(Y_graf(3, :, :)));

figure
%hold on
hold all
grid on
grid minor
box on
view(3)
%set(gcf,'color','w');

for i=1:n
    if (i~=1 && i~=n)
        plot3(Y_graf(1, :, i), Y_graf(2, :, i), Y_graf(3, :, i), 'b.', MarkerSize=3)
        xlim([x_min x_max])
        ylim([y_min y_max])
        zlim([z_min z_max])
        pause(0.01)
    elseif(i == 1)
        plot3(Y_graf(1, :, 1), Y_graf(2, :, 1), Y_graf(3, :, 1), 'g.', MarkerSize=20)
    else
        plot3(Y_graf(1, :, n), Y_graf(2, :, n), Y_graf(3, :, n), 'r.', MarkerSize=20)
    end

end

xlabel('x')
ylabel('y')
zlabel('z')
end