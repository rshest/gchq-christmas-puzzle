[MiniZinc](http://www.minizinc.org/) solution to the first step of the ["Christmas GCHQ Puzzle"](http://www.telegraph.co.uk/news/uknews/12041894/GCHQ-Christmas-card-question-Do-you-know-the-puzzle-answer.html):

##### The constraints:

It is similar to the Sudoku puzzle, with a little bit more complex vertical/horizontal constraints.

* The first constraint is for the "fixed" cells to be in place
* The other two (almost identical) groups of horizontal/vertical constraints ensure that:
** The provided intervals have 1's all along
** Every interval (except of the first one) has a preceding 0 AND the intervals do not overlap
** The total amount in 1's in every row/column is the same as the sum of the provided intervals' lengths

##### The puzzle itself:

![](img/puzzle.jpg)

> In this type of grid-shading puzzle, each square is either black or white. 
> Some of the black squares have already been filled in for you.
> Each row or column is labelled with a string of numbers. 
> The numbers indicate the length of all consecutive runs of black squares, and are displayed in the order that the runs appear in that line. 
> For example, a label "2 1 6" indicates sets of two, one and six black squares, 
> each of which will have at least one white square separating them.”

