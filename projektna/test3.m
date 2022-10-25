mase = [10; 10; 60];
polozaji = [0 0 0; 0 3 4; 12 1 6];
hitrosti = [1 1 0; 1 1 1; 3 1 0];

N = 3;

mass = 60*ones(N,1)/N;  % total mass of particles is 20
pos = randn(N,3);       % randomly selected positions and velocities
vel = randn(N,3);

%ic = [polozaji, hitrosti];

%ic = reshape(ic.', [1, 6*length(mase)]);

%Y2 = n_body(1, ic)

%Y = pospesek(1, mase, ic);

[T, Y] = vrni_resitev(mase, pos, vel, 50);

