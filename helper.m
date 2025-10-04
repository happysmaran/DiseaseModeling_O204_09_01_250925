function [s_n, q_n, i_n, r_n] = helper(s, q, i, r, m, o, beta, gamma)

% compute new infections and recoveries
sq_p1 = (1 - o) * i * s * beta * m;
sq_p2 = s * o * m * i * beta;
sq = sq_p1 + sq_p2;
% sq = min(sq, floor(s));

qq_p1 = s * o * m * beta * i;
qq_p2 = q * gamma;
qq = qq_p1 - qq_p2;
% qq = min(qq, floor(q));

iq_p1 = i * s * (1 - o) * beta * m;
iq_p2 = i * gamma;
iq = iq_p1 - iq_p2;
% iq = min(iq, floor(i));

rq = (i * gamma) + (q * gamma);
% rq = min(rq, floor(r));

s_n = s - sq;
q_n = q + qq;
i_n = i + iq;
r_n = r + rq;


% Enforce invariants
s_n = max(s_n, 0);
q_n = max(q_n, 0);
i_n = max(i_n, 0);
r_n = max(r_n, 0);

end