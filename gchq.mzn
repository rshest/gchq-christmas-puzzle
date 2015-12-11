% knowns
int: n; % board side
int: m; % max number of intervals per row/column (assuming padding with 0-length intervals, if the amount is smaller than this)

set of int: N = 1..n;
set of int: M = 1..m;

array[int] of N: sh; % stub cells: horizontal position
array[int] of N: sv; % stub cells: vertical position

array[N, M] of 0..n: hs; % interval start positions - horizontal
array[N, M] of 0..n: vs; % interval start positions - vertical

% unknowns
array[N, M] of var N: hof; % the 1's offsets (horizontal)
array[N, M] of var N: vof; % the 1's offsets (vertical)

array[N, N] of var 0..1: x; % the grid itself

% stub cells constraint
constraint forall(i in 1..length(sh)) (x[sv[i], sh[i]] = 1);

% horizontal constraints
constraint forall(j in N, i in 1..m, k in 0..hs[j, i] - 1) 
                  (x[j, hof[j, i] + k] = 1);
constraint forall(j in N, i in 2..m where hs[j, i] > 0)
                  ((x[j, hof[j, i] - 1] = 0) /\ (hof[j, i] > hof[j, i - 1] + hs[j, i - 1]));
constraint forall(j in N) 
                  (sum(k in N)(x[j, k]) = sum(k in M)(hs[j, k]));

% vertical constraints
constraint forall(j in N, i in 1..m, k in 0..vs[j, i] - 1) 
                  (x[vof[j, i] + k, j] = 1); 
constraint forall(j in N, i in 2..m where vs[j, i] > 0)
                  ((x[vof[j, i] - 1, j] = 0) /\ (vof[j, i] > vof[j, i - 1] + vs[j, i - 1]));
constraint forall(j in N) 
                  (sum(k in N)(x[k, j]) = sum(k in M)(vs[j, k]));

solve satisfy;

output [show(if x[j, i] == 1 then "██" else "  " endif) ++
  if i == n then "\n" else "" endif
  | j in N, i in N];
