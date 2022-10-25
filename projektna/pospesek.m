function [dY] = pospesek(~, mase, Y)
%pospesek izracuna pospeske N delcev
%INPUT:
%cas...prvi arg, ki ni potreben
%mase...Nx1 vektor mas posameznih delcev
%Y = [x y z x' y' z']
%Prvi tri stoplci Y predstavljajo koordinate visin delcev.
%Od cetrte do seste predstavljajo koordinate hitrosti delcev.
%
%OUTPUT:
%dY je sistem NDE, vrnemo desno stran sistema dY = F(t,Y)

N = length(mase);
%G = 6.672 * 10^(-11); %gravitacijska konstanta
G = 0.5;

%reshape
Y = reshape(Y, [6, N])';

%koordinate polozajev vseh N delcev
x = Y(:,1);
y = Y(:,2);
z = Y(:,3);

%resitev bo vsebovala hitrosti
dY(:, 1) = Y(:, 4);
dY(:, 2) = Y(:, 5);
dY(:, 3) = Y(:, 6);

%matrike razdalji
%na mestu ij v matriki dx je x_i - x_j
dx = x' - x;
dy = y' - y;
dz = z' - z;

%popravek za r, da ne pridemo v neskoncnost
softening = 0.001;

%matrika absolutnih vrednosti razdalij na -3/2
inv_r3 = (dx.^2 + dy.^2 + dz.^2 + softening.^2).^(-3/2);

% fix diagonal values (representing j=i interaction), which are currently 1/0=Infinity. Set to 0
inv_r3(inv_r3 == Inf) = 0;

ax = G * (dx .* inv_r3) * mase;
ay = G * (dy .* inv_r3) * mase;
az = G * (dz .* inv_r3) * mase;

dY(:, 4) = ax;
dY(:, 5) = ay;
dY(:, 6) = az;

dY = reshape(dY' , [N*6, 1]);

%a = [ax ay az]

end