%% N-body simulation

%začetni pogoji
mase = [10; 10; 60];

N = 3;
pos = randn(N,3);
vel = randn(N,3);

t_end = 10;

%sproži simulacijo
[~, Y] = vrni_resitev(mase, pos, vel, t_end);

