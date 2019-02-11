% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:

%possible steps
%At every step you can stay in your current field, or move one field in any direction: up, down, left or right.
step(0,0). step(1,0). step(0,1). step(-1,0). step(0,-1). 

% Generate player position and mino position 
at(X,Y,0) :- start(X,Y).
minow(XX,YY,0,2) :- mino(XX,YY).


% The facts of a solution should represent a sequence. This means that there must be nogaps between the steps, i.e., if there is a fact at(X,Y,S) for % S > 0 then there must be a fact at(XX,YY,S-1) for some XX and YY.
{at(X+DX,Y+DY,S+1): step(DX,DY), field(X+DX,Y+DY)}=1  :- at(X,Y,S), not goal(X,Y), maxsteps(N), S<N.

% create deterministic movement (two fields every step) for mino based on player move
{minow(XX+DX,YY+DY,S,1): step(DX,DY), field(XX+DX,YY+DY)}=1 :- at(X,Y,S), minow(XX,YY,S-1,2).
{minow(XX+DX,YY+DY,S,2): step(DX,DY), field(XX+DX,YY+DY)}=1 :- at(X,Y,S), minow(XX,YY,S,1).

% define movements for mino :  He can move two fields every step, but his movements are
% determined by his and our position: there is no choice for him. He will try to move right
% or left to become closer to you. If that is not possible, he will try to move up and down
% to become closer. If this is also not possible, the Minotaur will not move. In this way
% the Minotaur may move in a step first in one direction (e.g., up) and then in another
% direction (e.g., left). 
minow(XX+1,YY,S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X>XX, not x_blocked(S,1).
minow(XX-1,YY,S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X<XX, not x_blocked(S,1).
minow(XX,YY+1,S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y>YY, not y_blocked(S,1), x_blocked(S,1).
minow(XX,YY-1,S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y<YY, not y_blocked(S,1), x_blocked(S,1).
minow(XX,YY,S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), y_blocked(S,1), x_blocked(S,1).

minow(XX+1,YY,S,2) :- at(X,Y,S), minow(XX,YY,S,1), X>XX, not x_blocked(S,2).
minow(XX-1,YY,S,2) :- at(X,Y,S), minow(XX,YY,S,1), X<XX, not x_blocked(S,2).
minow(XX,YY+1,S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y>YY, not y_blocked(S,2), x_blocked(S,2).
minow(XX,YY-1,S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y<YY, not y_blocked(S,2), x_blocked(S,2).
minow(XX,YY,S,2) :- at(X,Y,S), minow(XX,YY,S,1), y_blocked(S,2), x_blocked(S,2).

% mino is horizontal blocked at step 1 or step 2 
x_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X==XX.
x_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), X==XX.
x_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X<XX, wall(XX,YY,XX-1,YY).
x_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X<XX, wall(XX-1,YY,XX,YY).
x_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X>XX, wall(XX,YY,XX+1,YY).
x_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), X>XX, wall(XX+1,YY,XX,YY).
x_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), X<XX, wall(XX,YY,XX-1,YY).
x_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), X<XX, wall(XX-1,YY,XX,YY).
x_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), X>XX, wall(XX,YY,XX+1,YY).
x_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), X>XX, wall(XX+1,YY,XX,YY).

% mino is vertical blocked at step 1 or 2 
y_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y==YY.
y_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y==YY.
y_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y<YY, wall(XX,YY,XX,YY-1).
y_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y<YY, wall(XX,YY-1,XX,YY).
y_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y>YY, wall(XX,YY,XX,YY+1).
y_blocked(S,1) :- at(X,Y,S), minow(XX,YY,S-1,2), Y>YY, wall(XX,YY+1,XX,YY).
y_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y<YY, wall(XX,YY,XX,YY-1).
y_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y<YY, wall(XX,YY-1,XX,YY).
y_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y>YY, wall(XX,YY,XX,YY+1).
y_blocked(S,2) :- at(X,Y,S), minow(XX,YY,S,1), Y>YY, wall(XX,YY+1,XX,YY).

mino(X,Y,S) :- minow(X,Y,S,2).

%The labyrinth has walls, and neither you nor the Minotaur can go through them.
:- wall(X1,Y1,X2,Y2), at(X1,Y1,S-1), at(X2,Y2,S).
:- wall(X1,Y1,X2,Y2), at(X1,Y1,S), at(X2,Y2,S-1).

% forbidden the case to be eaten
:- minow(X,Y,S,1), at(X,Y,S).
:- minow(X,Y,S,2), at(X,Y,S).

% Guess solution candidates here!

% Test
% define the length of maxsteps in order to minimize it 
length(S) :- at(X,Y,S), not at(XX,YY,S+1), field(XX,YY).
max(S) :- length(S), not length(S+1).
:- at(X,Y,S), max(S), not goal(X,Y).

% Optimize

#minimize {S:max(S)}.
% Optimize solutions here!

% Display

#show at/3.
