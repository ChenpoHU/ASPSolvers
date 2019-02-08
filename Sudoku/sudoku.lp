% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:


subgrid_size(3).

% HINTS:
% - For subgrid_size(s), subgrids can be identified by labels 0..s*s-1
% - A cell (x,y) can be mapped to the subgrid labeled (((x-1)/s)*s + (y-1)/s) 

% Your implementation please...


inrange(1..9).

1{sudoku(X,Y,N)}1 :- inrange(X), inrange(Y);inrange(N).

%Initialise sudoku with given initiations 
sudoku(X,Y,N):-initial(X,Y,N).

%No duplicate in a row nor column 
:-sudoku(X,Y,N),sudoku(X,Z,N),Y!=Z.
:-sudoku(X,Y,N),sudoku(Z,Y,N),X!=Z.

%No duplicate subgrid 
samesquare(X1,Y1, X2,Y2) :- (X1-1)/3 = (X2-1)/3 ,(Y1-1)/3 = (Y2-1)/3, inrange(X1), inrange(X2),inrange(Y1),inrange(Y2) . 
:-sudoku(X1,Y1,N), sudoku(X2, Y2, N), samesquare(X1,Y1, X2,Y2), 1 {X1!=X2: Y1!=Y2}.

#show sudoku/3. 