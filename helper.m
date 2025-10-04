function [s_n, q_n, i_n, r_n] = helper(s, q, i, r, m, o, beta, gamma)

% beta is infectivity
% gamma is recovery

% s is current susceptible
% q is current quarantined
% i is current infected
% r is current recovered

% m is mask effectiveness
% o is obedience rate

% s_n is next susceptible
% q_n is next quarantined
% i_n is next infected
% r_n is next recovered

% compute new infections and recoveries
sq_p1 = (1 - o) * s * i * beta * m;
sq_p2 = s * o * m * i * beta;
sq = sq_p1 + sq_p2;

qq_p2 = q * gamma;
qq = sq_p2 - qq_p2;

iq_p2 = i * gamma;
iq = sq_p1 - iq_p2;

rq = iq_p2 + qq_p2;
s_n = s - sq;
q_n = q + qq;
i_n = i + iq;
r_n = r + rq;

% Enforce invariants
s_n = max(s_n, 0);
q_n = max(q_n, 0);
i_n = max(i_n, 0);
r_n = max(r_n, 0);

s_n = round(s_n);
q_n = round(q_n);
i_n = round(i_n);
r_n = round(r_n);

end