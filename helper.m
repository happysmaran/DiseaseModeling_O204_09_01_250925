function [s_n, q_n, i_n, r_n] = helper(s, q, i, r, m, o, beta, gamma)
total = s + q + i + r; % total population

% Disease dynamics
newInf_noQuarantine = (1 - o) * s * i * beta * m;   % unquarantined new infections
newInf_quarantined  = s * o * m * i * beta;         % quarantined new infections

recoverQ = q * gamma;
recoverI = i * gamma;

% Raw updates
s_n = s - (newInf_noQuarantine + newInf_quarantined);
q_n = q + newInf_quarantined - recoverQ;
i_n = i + newInf_noQuarantine - recoverI;
r_n = r + recoverQ + recoverI;

% Clamp tiny negative values (numerical protection)
epsTol = 1e-12;
s_n = max(s_n, 0);
q_n = max(q_n, 0);
i_n = max(i_n, 0);
r_n = max(r_n, 0);

% Enforce conservation exactly
sumNow = s_n + q_n + i_n + r_n;
if abs(sumNow - total) > epsTol
    diff = total - sumNow;
    % add tiny correction to recovered, since rounding errors mostly land there
    r_n = r_n + diff;
    % if correction made r_n negative, rebalance across others proportionally
    if r_n < 0
        deficit = -r_n;
        r_n = 0;
        % remove deficit proportionally from s,q,i if possible
        live = [s_n, q_n, i_n];
        posIdx = live > 0;
        if any(posIdx)
            factor = deficit / sum(live(posIdx));
            live(posIdx) = live(posIdx) - factor * live(posIdx);
            s_n = live(1); q_n = live(2); i_n = live(3);
        end
    end
end

% sanity checks: ensure no negatives remain to prevent the weird
s_n = max(s_n, 0);
q_n = max(q_n, 0);
i_n = max(i_n, 0);
r_n = max(r_n, 0);

end