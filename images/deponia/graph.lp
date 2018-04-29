

start(a).
target(t).
final_node(s;t).  % the two possible nodes that can end the thing

% fork colors
nodecolor((a;d;h;i;k;r;v;z),vert).
nodecolor((b;g;l;m;q;x),jaune).
nodecolor((c;e;f;j;n;o;u;y),rouge).
color(C):- nodecolor(_,C).


error(uncolored,N):- nodecolor(N,_) ; not rel(N,_,_).

% Portes: faites en deux nœuds, car on ne va pas au même endroit après, selon le sens par lequel on passe.
rel(p1r,h).  % quand on rentre par la droite
rel(p1l,j).  % quand on rentre par la gauche
rel(p2r,s).  % retour à la case départ
rel(p2l,v).

% On marque les nœuds symbolisant chaque porte.
gate(1,(p1l;p1r)).
gate(2,(p2l;p2r)).

% Si rien n'est dit, l'arc est valable tout le temps.
rel(X,(1;2),Y):- rel(X,Y).


nb_rel(N):- N={rel(_,_,_)}.
#show nb_rel/1.


rel(a,1,b).
rel(a,2,f).

rel(b,1,e).
rel(b,2,d).

rel(c,1,s).  % retour au début :(
rel(c,2,g).

rel(d,1,g).
rel(d,2,p1l).  % entre dans porte 1 par la gauche

rel(e,1,c).
rel(e,2,g).

rel(f,1,q).
rel(f,2,e).

rel(g,1,p1l).
rel(g,2,n).

rel(h,1,e).
rel(h,2,s).

rel(i,1,p1r).
rel(i,2,l).

rel(j,1,l).
rel(j,2,y).

rel(k,1,s).  % notons que K est inutile par essence, mais probablement
rel(k,2,s).  % a-t-il été gardé pour la cohérence: il n'y a pas de fourche sans nœud.

rel(l,1,r).
rel(l,2,o).

rel(m,1,i).
rel(m,2,j).

rel(n,1,k).  % comme K, N est inutile directement, il s'agit juste
rel(n,2,s).  % d'une jonction entre deux passages.

rel(o,1,p2r).
rel(o,2,z).

rel(q,1,p2l).
rel(q,2,e).

rel(r,1,z).
rel(r,2,p2r).

rel(u,1,m).  % encore un faux choix pour complexifier le puzzle :)
rel(u,2,m).

rel(v,1,u).
rel(v,2,z).

% oui, j'ai oublié la lettre w.
rel(x,1,m).
rel(x,2,p2r).

rel(y,1,m).
rel(y,2,x).

rel(z,1,t).  % la fin !
rel(z,2,i).  % c'est reparti pour un tour !
