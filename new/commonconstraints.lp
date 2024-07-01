

empty(int(s(I),s(J)))       :- I = 1..n, J = 1..n, I < J.
empty(int(m(w),s(2*K  )))   :- K = 1..n, 1 <= 2*K,   2*K   <= n.
empty(int(m(s),s(2*K-1)))   :- K = 1..n, 1 <= 2*K-1, 2*K-1 <= n.