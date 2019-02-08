% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
%
%


% HINTS:
% - You may use the gaps of adjacent cells' coordinates to denote directions.
% - Develop your encoding incrementally and check the additions. If in doubt
%   whether rules are correct, the "--text" option of gringo/clingo allows
%   for investigating the instantiation, while small instances are advisable.

% Your implementation please...

% creation of target -> targets 
{target(X,Y,X,Y',Id,N): number(X,Y,N), area(X,Y',Id)}.
{target(X,Y,X',Y,Id,N): number(X,Y,N), area(X',Y,Id)}.

%creation of marked cells
marked(X..X',Y..Y',X,Y) :- target(X,Y,X',Y',_,_).
marked(X'..X,Y..Y',X,Y) :- target(X,Y,X',Y',_,_).
marked(X..X',Y'..Y,X,Y) :- target(X,Y,X',Y',_,_).
marked(X'..X,Y'..Y,X,Y) :- target(X,Y,X',Y',_,_).

% constraints to remove duplicates and overlapping
:-#sum{1,X,Y:target(X,Y,_,_,_,_)} != N, N = #sum{1,A,B:number(A,B,_)}.
:-#sum{1,X',Y':target(_,_,X',Y',_,_)} != N, N = #sum{1,A,B:number(A,B,_)}.
:-#sum{1,X,Y,X',Y':target(X,Y,X',Y',_,_)} != N, N = #sum{1,A,B:number(A,B,_)}.

% constraints to fill up all grey areas
:-#sum{1,Id:target(_,_,_,_,Id,_)} != N, N = #sum{1,C:area(_,_,C)}.

% constraints to prevent crossing by marked cells
:- marked(X,Y,X',_), marked(X,Y,X'',_), X''!= X'.
:- marked(X,Y,_,Y'), marked(X,Y,_,Y''), Y''!= Y'.

% constraints to reach the goal
:-#sum{N,Id,X,Y:target(X,Y,_,_,Id,N)} != G, G = #sum{N,Id:goal(Id,N)}, goal(Id,_).

% create targets
target(X,Y,X',Y') :- target(X,Y,X',Y',Id,N).

% print
#show target/4.