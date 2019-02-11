# ASPSolvers
ASP Solvers for solving puzzles/labyrinth games.<br />
These 3 game solvers are to solve the excercise tasks given by University Potsdam by Prof. Dr. Schaub in the Institut für Informatik.<br />
# For further knowledges please check:
1) https://www.youtube.com/channel/UCnvoHDf9RqBJxKPSGdToLzA/videos<br />
2) https://potassco.org/ <br />
# How to implemente
1) Install clingo onto your system (https://github.com/potassco/clingo/blob/master/INSTALL.md).<br />
2) Commando to run the solvers in clingo:<br />
$ clingo-5.3.0 sudoku.lp example.lp 0<br />
or<br />
$ clingo-5.3.0 instance01.lp yosenabe.lp<br />
or<br />
$ clingo --opt-mode=optN mino.lp example.lp<br />
