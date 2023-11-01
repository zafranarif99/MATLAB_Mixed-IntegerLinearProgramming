%% MATH 464 FINAL PROJECT - MULTI PERIOD TEAM ASSIGNMENT PLANNING
% Zafran Arif - 11594791

%% Data & Calculation
% Productivity scores of staff members
p = [96	42	99	49	68	95	60	71	40	98	99	41	35	69	72	88	59	77	40	46	28	74	75	79	97	55	59	68	97	55	54	65	83	53	42	86	76	76	12	50	32	60	95	99	92	61	75	95	59	63];
% Creativity scores of staff members
c = [85	59	69	60	91	72	31	13	80	34	82	47	73	59	81	36	64	81	51	100	100	98	97	97	76	92	64	26	96	96	51	61	48	84	41	90	19	64	88	70	37	17	83	28	53	78	56	19	89	85];
% Teamwork scores scores of staff members
t = [61	10	48	96	51	25	94	35	52	16	86	68	53	49	34	46	51	2	71	75	3	14	71	35	14	70	98	35	59	55	56	60	91	86	89	69	76	76	74	69	76	6	17	65	42	23	65	20	76	32];

% Calculating a necessary values for the first 3 constraints.
% Important to find the average on each scores.
calcP = 70-p;
calcC = 50-c;
calcT = 50-t;

% Calculation for A52
block1 = eye(8); % top left block
block2 = zeros(8,42); % top right block
block3 = zeros(42,8); % bottom left block
block4 = zeros(42,42); % bottom right block
block = [block1 block2; block3 block4]; % whole block

%% Matrices
% Objective Function
z = kron(ones(1,5),p);

% Constraints in Matrix Form
A1 = kron(eye(5),calcP); % Average Productivity
A2 = kron(eye(5),calcC); % Average Creativity
A3 = kron(eye(5),calcT); % Average Teamwork
A41 = kron([1 0 0 1 0],eye(50)); % 1st and 4th projects can't overlap
A42 = kron([0 0 1 0 1],eye(50)); % 3rd and 5th projects can't overlap
A43 = kron([0 1 0 1 0],eye(50)); % 2nd and 4th projects can't overlap
A44 = kron([0 1 0 0 1],eye(50)); % 2nd and 5th projects can't overlap
A51 = kron(eye(5),[-ones(1,8),zeros(1,42)]); % At least 1 senior in a project
A52 = kron(ones(1,5), block); % Senior can't be in more than 1 project
A61 = kron(eye(5),-ones(1,50)); % A61&62 = team size Au
A62 = kron(eye(5),ones(1,50));
A71 = A61; % A71&72 = team size Br
A72 = A62;
A81 = A61; % A81&82 = team size Cs
A82 = A62;
A91 = A61; % A91&92 = team size Dy
A92 = A62;
A101 = A61; % A101&102 = team size Eu
A102 = A62;

% Matrix A
A = [A1;A2;A3;A41;A42;A43;A44;A51;A52;A61;A62;A71;A72;A81;A82;A91;A92;A101;A102];

% b
b123 = zeros(15,1); % average productivity, creativity, teamwork (A1-3)
b41234 = ones(200,1); % overlapping problem (A41-44)
b51 = -ones(5,1); % senior (A51)
b521 = ones(8,1); % senior (A52) -- first 8 rows
b522 = zeros(42,1); % senior (A52) -- row 9-42
b52 = [b521;b522]; % senior (A52)
b61 = -5*ones(5,1); % team size Au
b62 = 8*ones(5,1);
b71 = -5*ones(5,1); % team size Br
b72 = 9*ones(5,1);
b81 = -6*ones(5,1); % team size Cs
b82 = 12*ones(5,1);
b91 = -6*ones(5,1); % team size Dy
b92 = 11*ones(5,1);
b101 = -5*ones(5,1); % team size EU
b102 = 15*ones(5,1);

% Matrix b
b = [b123;b41234;b51;b52;b61;b62;b71;b72;b81;b82;b91;b92;b101;b102];

%% Optimal Solution and Objective Value
[xVal,zVal] = intlinprog(z,1:250,A,b,[],[],zeros(1,250),ones(1,250))



