% remove_consecutive(L) where L - list of numbers
% flow model (i,i) (i,o)
% base case
remove([],[]).
remove([H],[H]).
remove([H,H2],[]):-
    N is H+1,
    H2 =:= N.
remove([H,H2,H3|T],R):-
    N is H+1,
    H2 =:= N,
    N2 is H2+1,
    H3 =:= N2,
    remove(T,R).
remove([H,H2,H3|T],R):-
    N is H+1,
    H2 =\= N,
    N2 is H2+1,
    H3 =\= N2,
    remove([H3|T],R2),
    R = [H2|R2].
remove([H,H2,H3|T],R):-
    N is H+1,
    H2 =:= N,
    N2 is H2+1,
    H3 =\= N2,
    remove([H3|T],R).
remove([H,H2,H3|T],R):-
	N is H+1,
    H2 =\= N,
    N2 is H2+1,
    H3 =:= N2,
    remove([H2,H3|T],R2),
    R = [H|R2].
main(L,R):-
    remove(L,R).