ndim=1000; % number of dimensions
H_t = flip(linspace(0,3100,ndim));
V_t = -1 -299/3000 * H_t;
funchandle = @(vt)(-robustTest(H_t, vt, 3000, -300, 100, 10));
funchandle(V_t)
options = optimoptions(@fminunc,'Display','iter');
fminunc(funchandle,V_t,options)
