function [s_n, i_n, r_n] = helper(s, i, r, m, beta, gamma)

% compute new infections and recoveries
infected = beta * i * s * m;
recovered = floor(gamma * i);

infected = min(infected, floor(s));
recovered = min(recovered, floor(i));

s_n = s - infected;
i_n = i + infected - recovered;
r_n = r + recovered;

% Enforce invariants
s_n = max(s_n, 0);
i_n = max(i_n, 0);
r_n = max(r_n, 0);

end