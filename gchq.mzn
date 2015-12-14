% knowns
int: n; % board side
int: m; % max number of intervals per row/column (assuming padding with 0-length intervals, if the amount is smaller than this)

set of int: N = 1..n;
set of int: M = 1..m;

array[int, 1..2] of N: stubs; % stub cell positions

array[N, M] of 0..n: h_int; % interval lengths - horizontal
array[N, M] of 0..n: v_int; % interval lengths - vertical

% unknowns
array[N, M] of var N: h_offs; % the intervals' start positions - horizontal
array[N, M] of var N: v_offs; % the intervals' start positions - vertical

array[N, N] of var 0..1: x; % the grid itself

% stub cells constraint
int: ns = length(stubs) div 2;
constraint forall(i in 1..ns) (x[stubs[i, 2], stubs[i, 1]] = 1);

% horizontal constraints
constraint forall(j in N, i in 1..m, k in 0..h_int[j, i] - 1) 
                  (x[j, h_offs[j, i] + k] = 1);
constraint forall(j in N, i in 2..m where h_int[j, i] > 0)
                  ((x[j, h_offs[j, i] - 1] = 0) /\ (h_offs[j, i] > h_offs[j, i - 1] + h_int[j, i - 1]));
constraint forall(j in N) 
                  (sum(k in N)(x[j, k]) = sum(k in M)(h_int[j, k]));

% vertical constraints
constraint forall(j in N, i in 1..m, k in 0..v_int[j, i] - 1) 
                  (x[v_offs[j, i] + k, j] = 1); 
constraint forall(j in N, i in 2..m where v_int[j, i] > 0)
                  ((x[v_offs[j, i] - 1, j] = 0) /\ (v_offs[j, i] > v_offs[j, i - 1] + v_int[j, i - 1]));
constraint forall(j in N) 
                  (sum(k in N)(x[k, j]) = sum(k in M)(v_int[j, k]));

solve satisfy;

output [show(if x[j, i] == 1 then "██" else "  " endif) ++
  if i == n then "\n" else "" endif
  | j in N, i in N];
