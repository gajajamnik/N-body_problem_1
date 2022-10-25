close all;
clear all;
clc;

%% Simulation parameters
N         = 2;   % Number of particles
t         = 0;     % current time of the simulation
tEnd      = 10;    % time at which simulation ends
dt        = 0.01;  % timestep
softening = 0.1;   % softening length
G         = 6.672 * 10^(-11);     % Newton's Gravitational Constant
plotRealTime = 1;  % switch on (1) for plotting as the simulation goes along

%% Generate Initial Conditions
rng(42);                % set the random number generator seed

mass = 20*ones(N,1)/N;  % total mass of particles is 20
pos = randn(N,3);       % randomly selected positions and velocities
vel = randn(N,3);

% Convert to Center-of-Mass Frame
vel = vel - mean((mass*[1 1 1]) .* vel) / mean(mass);

% calculate initial gravitational accelerations

zac_pogoji = [pos vel];
zac_pogoji = reshape(zac_pogoji', [1, 6*N]);
acc = pospesek(1, mass, zac_pogoji);

% number of timesteps(rounded up)
Nt = ceil(tEnd/dt);

%% save energies, particle orbits for plotting trails
pos_save = zeros(N,3,Nt+1);
pos_save(:,:,1) = pos;
t_all = (0:Nt)*dt; %tabela vseh časov

%% Simulation Main Loop
fh = figure('position',[0 0 600 800]);

for i = 1:Nt
    
    % (1/2) kick
    vel = vel + acc * dt/2;
    
    % drift
    pos = pos + vel * dt;
    
    % update accelerations
    acc = pospesek(1, mass, zac_pogoji);
    
    % (1/2) kick
    vel = vel + acc * dt/2;
    
    % update time
    t = t + dt;

    % save energies, positions for plotting trail
    pos_save(:,:,i+1) = pos;

    % plot in real time
    if (plotRealTime) || (i==Nt)
        xx = pos_save(:,1,max(i-50,1):i);
        yy = pos_save(:,2,max(i-50,1):i);
        plot(xx(:),yy(:),'.','color',[.7 .7 1]);
        hold on
        plot(pos(:,1),pos(:,2),'b.','markersize',14);
        hold off
        axis square
        axis([-2 2 -2 2])

        drawnow
    end
end
