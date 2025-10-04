function [S, Q, I, R, W] = simulate_sir(s_0, q_0, i_0, r_0, m, o, beta, gamma, num_steps)

% beta is infectivity
% gamma is recovery

% num_steps is total simulation runtime

% s_0 is initial susceptible
% q_0 is initial quarantined
% i_0 is initial infected
% r_0 is initial recovered

% m is mask effectiveness
% o is obedience rate

% S is susceptible list
% Q is quarantined list
% I is infected list
% R is recovered list
% W is time counter for graphing

% Setup
S = zeros(1, num_steps); S(1) = s_0;
Q = zeros(1, num_steps); Q(1) = q_0;
I = zeros(1, num_steps); I(1) = i_0;
R = zeros(1, num_steps); R(1) = r_0;
W = 1 : num_steps;

% Run simulation
for step = 1 : (num_steps - 1)
    [S(step+1), Q(step+1), I(step+1), R(step+1)] = helper(S(step), Q(step), I(step), R(step), m, o, beta, gamma);
end

end