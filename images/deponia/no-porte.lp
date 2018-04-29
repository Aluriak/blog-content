
% Recherche d'une solution sans passer par les portes !

% On choisi une valeur pour une couleur donnée:
1{colorvalue(C,1..2)}1:- nodecolor(_,C).
rjv(R,J,V):- colorvalue(rouge,R) ; colorvalue(jaune,J) ; colorvalue(vert,V).

% Le path nous permettra de suivre le déplacement.
%  On commence au nœud de départ (logique).
path(1,Noeud):- start(Noeud).
% On arrive au nœud succédant au dernier path, selon les valeurs de couleur.
path(N,Succ):- path(N-1,Pred) ; rel(Pred,ColorVal,Succ) ; nodecolor(Pred,Color) ; colorvalue(Color,ColorVal).
% Cas spécial: les portes n'ont pas de couleur.
% path(N,Succ):- path(N-1,Pred) ; rel(Pred,_,Succ) ; not nodecolor(Pred,_).  % on désactive, car on gère pas encore les portes

% État de la réponse: soit on a trouvé (win), soit on est retourné au départ (loss).
game(win,N):- path(N,t).
game(loss,N):- path(N,s).
% Cas spécial dû à notre contrainte sur les portes: on peut être n'importe où.
game(lost,(N,E)):- path(N,E) ; not path(N+1,_) ; not final_node(E).

#show.
#show rjv/3.
#show path/2.
#show game/2.
