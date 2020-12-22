winning_row([1,7,13,19,25]).
winning_row([1,2,3,4,5]).
winning_row([1,8,15,22,29]).
winning_row([2,8,14,20,26]).
winning_row([2,3,4,5,6]).
winning_row([2,9,16,23,30]).
winning_row([3,9,15,21,27]).
winning_row([4,10,16,22,28]).
winning_row([5,11,17,23,29]).
winning_row([5,10,15,20,25]).
winning_row([6,12,18,24,30]).
winning_row([6,11,16,21,26]).
winning_row([7,13,19,25,31]).
winning_row([7,8,9,10,11]).
winning_row([7,14,21,28,35]).
winning_row([8,14,20,26,32]).
winning_row([8,9,10,11,12]).
winning_row([8,15,22,29,36]).
winning_row([9,15,21,27,33]).
winning_row([10,16,22,28,34]).
winning_row([11,17,23,29,35]).
winning_row([11,16,21,26,31]).
winning_row([12,18,24,30,36]).
winning_row([12,17,22,27,32]).
winning_row([13,14,15,16,17]).
winning_row([14,15,16,17,18]).
winning_row([19,20,21,22,23]).
winning_row([20,21,22,23,24]).
winning_row([25,26,27,28,29]).
winning_row([26,27,28,29,30]).
winning_row([31,32,33,34,35]).
winning_row([32,33,34,35,36]).

threatening_row(OpponentL,CurrentL):-winning_row([One,Two,Three,Four,Five]),
   ((member(Two,OpponentL),member(Three,OpponentL),member(Four,OpponentL),member(Five,OpponentL),not(member(One,CurrentL)));
    (member(One,OpponentL),member(Three,OpponentL),member(Four,OpponentL),member(Five,OpponentL),not(member(Two,CurrentL)));
    (member(One,OpponentL),member(Two,OpponentL),member(Four,OpponentL),member(Five,OpponentL),not(member(Three,CurrentL)));
    (member(One,OpponentL),member(Two,OpponentL),member(Three,OpponentL),member(Five,OpponentL),not(member(Four,CurrentL)));
    (member(One,OpponentL),member(Two,OpponentL),member(Three,OpponentL),member(Four,OpponentL),not(member(Five,CurrentL)))).

count_threatening(OpponentL,CurrentL,S):-
    aggregate_all(count,threatening_row(OpponentL,CurrentL),S).

threatening(board(BlackL, RedL),black,S):-count_threatening(RedL,BlackL,S).
threatening(board(BlackL, RedL),red,S):-count_threatening(BlackL,RedL,S).


% winning move without rotation
winning_move(CurrentL,OpponentL,One):-winning_row([One,Two,Three,Four,Five]),
    member(Two,CurrentL),member(Three,CurrentL),member(Four,CurrentL),member(Five,CurrentL),not(member(One,OpponentL)),!.
winning_move(CurrentL,OpponentL,Two):-winning_row([One,Two,Three,Four,Five]),                                                                                                            
    member(One,CurrentL),member(Three,CurrentL),member(Four,CurrentL),member(Five,CurrentL),not(member(Two,OpponentL)),!.
winning_move(CurrentL,OpponentL,Three):-winning_row([One,Two,Three,Four,Five]),     
    member(One,CurrentL),member(Two,CurrentL),member(Four,CurrentL),member(Five,CurrentL),not(member(Three,OpponentL)),!.
winning_move(CurrentL,OpponentL,Four):-winning_row([One,Two,Three,Four,Five]),
    member(One,CurrentL),member(Two,CurrentL),member(Three,CurrentL),member(Five,CurrentL),not(member(Four,OpponentL)),!.
winning_move(CurrentL,OpponentL,Five):-winning_row([One,Two,Three,Four,Five]), 
    member(One,CurrentL),member(Two,CurrentL),member(Three,CurrentL),member(Four,CurrentL),not(member(Five,OpponentL)),!.

% rotatations
rotating(L,NewL,TmpL,NewTmpL,Pos,NewPos):-
    member(Pos,L) ->
    select(Pos,L,NewL), append(TmpL,[NewPos],NewTmpL);   
    duplicate_term(L,NewL), duplicate_term(TmpL,NewTmpL).

rotate(L,NewL,anti-clockwise,top-left):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,1,13),
    rotating(L2,L3,TmpL2,TmpL3,2,7),
    rotating(L3,L4,TmpL3,TmpL4,3,1),
    rotating(L4,L5,TmpL4,TmpL5,7,14),
    rotating(L5,L6,TmpL5,TmpL6,9,2),
    rotating(L6,L7,TmpL6,TmpL7,13,15),
    rotating(L7,L8,TmpL7,TmpL8,14,9),
    rotating(L8,L9,TmpL8,TmpL9,15,3),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,clockwise,top-left):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,1,3),
    rotating(L2,L3,TmpL2,TmpL3,2,9),
    rotating(L3,L4,TmpL3,TmpL4,3,15),
    rotating(L4,L5,TmpL4,TmpL5,7,2),
    rotating(L5,L6,TmpL5,TmpL6,9,14),
    rotating(L6,L7,TmpL6,TmpL7,13,1),
    rotating(L7,L8,TmpL7,TmpL8,14,7),
    rotating(L8,L9,TmpL8,TmpL9,15,13),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,anti-clockwise,top-right):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,4,16),
    rotating(L2,L3,TmpL2,TmpL3,5,10),
    rotating(L3,L4,TmpL3,TmpL4,6,4),
    rotating(L4,L5,TmpL4,TmpL5,10,17),
    rotating(L5,L6,TmpL5,TmpL6,12,5),
    rotating(L6,L7,TmpL6,TmpL7,16,18),
    rotating(L7,L8,TmpL7,TmpL8,17,12),
    rotating(L8,L9,TmpL8,TmpL9,18,6),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,clockwise,top-right):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,4,6),
    rotating(L2,L3,TmpL2,TmpL3,5,12),
    rotating(L3,L4,TmpL3,TmpL4,6,18),
    rotating(L4,L5,TmpL4,TmpL5,10,5),
    rotating(L5,L6,TmpL5,TmpL6,12,17),
    rotating(L6,L7,TmpL6,TmpL7,16,4),
    rotating(L7,L8,TmpL7,TmpL8,17,10),
    rotating(L8,L9,TmpL8,TmpL9,18,16),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,anti-clockwise,bottom-left):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,19,31),
    rotating(L2,L3,TmpL2,TmpL3,20,25),
    rotating(L3,L4,TmpL3,TmpL4,21,19),
    rotating(L4,L5,TmpL4,TmpL5,25,32),
    rotating(L5,L6,TmpL5,TmpL6,27,20),
    rotating(L6,L7,TmpL6,TmpL7,31,33),
    rotating(L7,L8,TmpL7,TmpL8,32,27),
    rotating(L8,L9,TmpL8,TmpL9,33,21),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,clockwise,bottom-left):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,19,21),
    rotating(L2,L3,TmpL2,TmpL3,20,27),
    rotating(L3,L4,TmpL3,TmpL4,21,33),
    rotating(L4,L5,TmpL4,TmpL5,25,20),
    rotating(L5,L6,TmpL5,TmpL6,27,32),
    rotating(L6,L7,TmpL6,TmpL7,31,19),
    rotating(L7,L8,TmpL7,TmpL8,32,25),
    rotating(L8,L9,TmpL8,TmpL9,33,31),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,anti-clockwise,bottom-right):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,22,34),
    rotating(L2,L3,TmpL2,TmpL3,23,28),
    rotating(L3,L4,TmpL3,TmpL4,24,22),
    rotating(L4,L5,TmpL4,TmpL5,28,35),
    rotating(L5,L6,TmpL5,TmpL6,30,23),
    rotating(L6,L7,TmpL6,TmpL7,34,36),
    rotating(L7,L8,TmpL7,TmpL8,35,30),
    rotating(L8,L9,TmpL8,TmpL9,36,24),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).

rotate(L,NewL,clockwise,bottom-right):-
    append([],[],TmpL),
    rotating(L,L2,TmpL,TmpL2,22,24),
    rotating(L2,L3,TmpL2,TmpL3,23,30),
    rotating(L3,L4,TmpL3,TmpL4,24,36),
    rotating(L4,L5,TmpL4,TmpL5,28,23),
    rotating(L5,L6,TmpL5,TmpL6,30,35),
    rotating(L6,L7,TmpL6,TmpL7,34,22),
    rotating(L7,L8,TmpL7,TmpL8,35,28),
    rotating(L8,L9,TmpL8,TmpL9,36,34),
    sort(TmpL9,SortedTmpL), merge(L9,SortedTmpL,NewL).


% black min_value for minimax
min_value(black,BlackL,RedL,Position,Direction,Quadrant,Score):-
    between(1,36,Position), not(member(Position,BlackL)), not(member(Position,RedL)),
    % red moves
    merge(RedL,[Position],TmpRedL), rotate(TmpRedL,TmpRedL2,Direction,Quadrant),
    rotate(BlackL,TmpBlackL,Direction,Quadrant),
    threatening(board(TmpBlackL, TmpRedL2),red,RedThreat),
    threatening(board(TmpBlackL, TmpRedL2),black,BlackThreat),
    Score is RedThreat-BlackThreat.

% red min_value for minimax
min_value(red,BlackL,RedL,Position,Direction,Quadrant,Score):-
    between(1,36,Position), not(member(Position,BlackL)), not(member(Position,RedL)),
    % black moves
    merge(BlackL,[Position],TmpBlackL), rotate(TmpBlackL,TmpBlackL2,Direction,Quadrant),
    rotate(RedL,TmpRedL,Direction,Quadrant),
    threatening(board(TmpBlackL2,TmpRedL),black,BlackThreat),
    threatening(board(TmpBlackL2,TmpRedL),red,RedThreat),
    Score is BlackThreat-RedThreat.

% black max_value for minimax
max_value(black,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL,Score):-
    between(1,36,Position), not(member(Position,BlackL)), not(member(Position,RedL)),
    % black moves
    merge(BlackL,[Position],TmpBlackL), rotate(TmpBlackL,NextBlackL,Direction,Quadrant),
    rotate(RedL,NextRedL,Direction,Quadrant),
    aggregate_all(min(Score),min_value(black,NextBlackL,NextRedL,Position,Direction,Quadrant,Score),Score).

% red max_value for minimax
max_value(red,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL,Score):-
    between(1,36,Position), not(member(Position,BlackL)), not(member(Position,RedL)),
    % red moves
    merge(RedL,[Position],TmpRedL), rotate(TmpRedL,NextRedL,Direction,Quadrant),
    rotate(BlackL,NextBlackL,Direction,Quadrant),
    aggregate_all(min(Score),min_value(red,NextBlackL,NextRedL,Position,Direction,Quadrant,Score),Score).
    
% win without rotation
find_best(_,CurrentL,OpponentL,Position,_,_,NextCurrentL,NextOpponentL):-
    winning_move(CurrentL,OpponentL,Position), 
    merge(CurrentL,[Position],NextCurrentL), duplicate_term(OpponentL,NextOpponentL),!.

% win with rotation
find_best(_,CurrentL,OpponentL,Position,Direction,Quadrant,NextCurrentL,NextOpponentL):-
    rotate(CurrentL,TmpCurrentL,Direction,Quadrant), rotate(OpponentL,NextOpponentL,Direction,Quadrant),
    winning_move(TmpCurrentL,NextOpponentL,Position),
    merge(TmpCurrentL,[Position],NextCurrentL),!.

% black minimax
find_best(black,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL):-
    aggregate_all(max(Score,[Position,Direction,Quadrant,NextBlackL,NextRedL]),
                  max_value(black,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL,Score),
                  max(_,[Position,Direction,Quadrant,NextBlackL,NextRedL])).

% red minimax
find_best(red,RedL,BlackL,Position,Direction,Quadrant,NextRedL,NextBlackL):-
    aggregate_all(max(Score,[Position,Direction,Quadrant,NextBlackL,NextRedL]),
                  max_value(red,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL,Score),
                  max(_,[Position,Direction,Quadrant,NextBlackL,NextRedL])).
    

pentago_ai(board(BlackL,RedL),black,move(Position,Direction,Quadrant),board(NextBlackL,NextRedL)):-
    find_best(black,BlackL,RedL,Position,Direction,Quadrant,NextBlackL,NextRedL).
pentago_ai(board(BlackL,RedL),red,move(Position,Direction,Quadrant),board(NextBlackL,NextRedL)):-
    find_best(red,RedL,BlackL,Position,Direction,Quadrant,NextRedL,NextBlackL).

