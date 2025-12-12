/***************************************/
%     CS 381 - Programming Lab #5       %
%                                       %
%  Tess Ellis                           %
%  elliste@oregonstate.edu              %
%                                       %
/***************************************/

% load family tree
:- consult('royal.pl').

% enables piping in tests
portray(Term) :- atom(Term), format("~s", Term).

% Mother = Parent of child + Female
mother(M, C) :- parent(M,C), female(M).

% Father = Parent of child + Male
father(F, C) :- parent(F,C), male(F).

% Spouse = Married
spouse(X,Y) :- married(X,Y).
spouse(X,Y) :- married(Y,X).

% Child = Child of parent
child(C, P) :- parent(P, C).

% Son = Child of Parent + Male
son(S, P) :- child(S, P), male(S).

% Dauther = Child of Parent, Female
daughter(D, P) :- child(D, P), female(D).

% Sibling = Shared Parents (cannot be your own sibling)
sibling(A, B) :- 
    parent(P, A), 
    parent(P, B), 
    A \= B.

% Brother = Sibling + Male
brother(B, S) :- sibling(B, S), male(B).

% Sister + Sibling + Female
sister(Sis, S) :- sibling(Sis, S), female(Sis).

% Blood Uncle
uncle(U, N) :- brother(U, P), parent(P, N).
% Non Blood Uncle (marriage)
uncle(U, N) :- spouse(U, A), sister(A, P), parent(P, N).

% Blood Aunt
aunt(A, N) :- sister(A, P), parent(P, N).
% Non Blood Aunt (marriage)
aunt(A, N) :- spouse(A, U), brother(U, P), parent(P, N).

% Grandparent = Parent of + Parent of
grandparent(G, C) :- parent(G, P), parent(P, C).

% Grandfather = Granparent + Male
grandfather(GF, C) :- grandparent(GF, C), male(GF).

% Grandmother = Grandparent + Female
grandmother(GM, C) :- grandparent(GM, C), female(GM).

% Grandchild = Child of Parent + Child of Parent
grandchild(C, G) :- grandparent(G,C).

% Ancestor = Parent or Ancestor of Parent
ancestor(A, D) :- parent(A, D).
ancestor(A, D) :- parent(P, D), ancestor(A, P).

% Descendant = Reversed Ancestor
descendant(D, A) :- ancestor(A, D). 

% Older = Born Before
older(X, Y) :- born(X, BX), born(Y, BY), BX < BY.

% Younger = Born After
younger(X, Y) :- born(X, BX), born(Y, BY), BX > BY.

% Regent (from birth)
regentWhenBorn(R, Person) :- 
    born(Person, Year),
    reigned(R, Start, End),
    Year > Start,
    Year < End.

% Cousins (EC) --> If parents are siblings, cannot be cousin of a sibling
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y,
    \+ sibling(X, Y).

