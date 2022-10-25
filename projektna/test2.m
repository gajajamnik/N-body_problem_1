mase = [1; 1; 1];
%polozaji = [-1 0 0; 1 0 0; 0 0 0];
%hitrosti = [0.3471 0.5327 0; 0.3471 0.5327 0; -2*0.3471 -2*0.5327 0];

max = 1e2;
vvar = 1e0;
polozaji = -max+(max+max).*rand(3, 3);
hitrosti = sqrt(vvar)*rand(3, 3);



%Y2 = n_body(1, ic);

[T, Y] = vrni_resitev(mase, polozaji, hitrosti, 1e4);

%[T2, Y2] = vrni_resitevMack(mase, polozaji, hitrosti);