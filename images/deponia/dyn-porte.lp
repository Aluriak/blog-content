
% Recherche d'une solution avec les couleurs en état dynamique !

% On choisi une valeur pour une couleur donnée.
1{colorvalue(C,1..2)}1:- color(_,C).
rjv(R,J,V):- colorvalue(rouge,R) ; colorvalue(jaune,J) ; colorvalue(vert,V).
% On choisi une couleur pour chaque porte.
1{gatecolor(Num,(rouge;jaune;vert))}1:- gate(Num,_).

% fix config (for debug)
% colorvalue(rouge,2). colorvalue(jaune,1). colorvalue(vert,1).
% gatecolor(2,rouge;1,vert).

% Le path nous permettra de suivre le déplacement.
%  On commence au nœud de départ, avec la configuration de départ (logique).
path(1,Noeud,rjv(R,J,V)):- start(Noeud) ; rjv(R,J,V).
% On arrive au nœud succédant au dernier path, selon les valeurs de couleur.
path(N,Succ,RJV):- path(N-1,Pred,RJV) ; rel(Pred,ColorVal,Succ) ; color(Pred,Color) ; define_colorvalue(Color,RJV,ColorVal).
% Cas spécial: les portes n'ont pas de couleur.
path(N,Succ,rjv(R2,J2,V2)):-
    path(N-1,Pred,rjv(R,J,V)) ; rel(Pred,_,Succ) ;
    gate(NumGate,Pred) ;  % on s'apprête à quitter une porte
    gatecolor(NumGate,GateColor) ;  % on s'apprête à changer une couleur
    define_state(rouge,GateColor,R,R2) ;  % on détermine la nouvelle valeur de RJV.
    define_state(jaune,GateColor,J,J2) ;
    define_state(vert,GateColor,V,V2).

% Partie un peu difficile : il faut définir le nouvel état (arg 4) d'une couleur (arg 1), sachant la couleur d'une porte traversée (arg 2), et son état actuel (arg 3).
define_state(Color,Color,State,New):-  % la couleur considérée est la même que la porte : la valeur doit changer !
    color(_,Color) ; State=1..2 ; New=3-State.
define_state(Color,OtherColor,State,State):-  % couleur différente de la porte : on laisse en l'état
    color(_,Color) ; color(_,OtherColor) ; Color!=OtherColor ; State=1..2.

% De la même manière, il faut définir la valeur d'état à prendre en compte (arg 3), sachant la couleur d'une fourche (arg 1) et la config actuel (arg 2).
define_colorvalue(rouge,rjv(R,J,V),R):- R=1..2 ; J=1..2 ; V=1..2.
define_colorvalue(jaune,rjv(R,J,V),J):- R=1..2 ; J=1..2 ; V=1..2.
define_colorvalue(vert,rjv(R,J,V),V):- R=1..2 ; J=1..2 ; V=1..2.

% État de la réponse: soit on a trouvé (win), soit on est retourné au départ (loss).
game(win,N):- path(N,t,_).
game(loss,N):- path(N,s,_).

% On vire les cas qui nous intéressent pas !
:- game(loss,_).

#show.
#show rjv/3.
#show path/3.
#show game/2.
#show gatecolor/2.
