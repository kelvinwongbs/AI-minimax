# Implement the game Pentago using minimax algorithm

### Course: Fundamentals of Artificial Intelligence

About Pentago: https://en.wikipedia.org/wiki/Pentago

**Calculate threats of Player posed by its opponent:**
```prolog
threatening(board(BlackL,RedL),Player,S)
```
Given ```board(BlackL,RedL)``` and ```Player```   
returns ```S```, which is the number of threats.

**Evalution function:**
```prolog
threatening(board(BlackL,RedL),Opponent,S) - threatening(board(BlackL,RedL),Player,S)
```
This function is used in minimax.

**Find the best moves for Player:**
```prolog
pentago_ai(board(BlackL,RedL),Player,move(Position,Direction,Quadrant),board(NextBlackL,NextRedL))
```
Given ```board(BlackL,RedL)``` and ```Player```   
returns ```move(Position,Direction,Quadrant)``` and ```board(NextBlackL,NextRedL)```

**Copyright:**   
**I own Pentago.pl.**
