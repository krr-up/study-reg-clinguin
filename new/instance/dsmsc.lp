
% c, r, i and ba
in((infdsc1;matvmd837;matvmd838;infdsc2;infdsc3;infdsc4),c).
in((infdsrma;infdsrmb),r).
in((infdsam1a;infdsam1b;matdsam2a;matdsam2b;matdsam3a;matdsam3b;
    infdsam4a;infdsam4b;infdsam5a;infdsam5b;infdsam6a;infdsam6b;
    infdsam7;matdsam8a;matdsam8b;infdsam9;infdsam10;infdsam11;bm3),i).
in((fm2;matdsbm1),ba).
in(M,l) :- in(M,(i;ba)).

% m                             
in(E,m) :- in(E,(c;r;i;ba)).  
in(msc,m).

% e
in((fm2;matdsbm1),e).

%c
map(c,(infdsc1;matvmd837;matvmd838;infdsc3;
    infdsam1a;matdsam2a;matdsam3a;infdsam5a;infdsam6a;
    matdsam8a;bm3),9).
map(c,(infdsc2;infdsc4;infdsam1b;matdsam2b;matdsam3b;
    infdsam4a;infdsam4b;infdsam5b;infdsam6b;
    infdsam7;matdsam8b;infdsam9;infdsam10;fm2;matdsbm1),6).
map(c,(infdsrma;infdsam11),12).
map(c,infdsrmb,15).
map(c,msc,30).

% l and u
map(l,c,48;l,r,12;l,l,27;l,m,120).
map(u,c,48;u,r,15;u,l,30;u,m,120).

% s
map(s,(bm3;fm2;infdsam1a;infdsam1b;infdsam5b;infdsam6a;infdsc3;
    infdsc4;matdsam3a;matdsam3b;matdsam8b;matdsbm1;matvmd837),w).
map(s,(infdsam10;infdsam5a;infdsam6b;infdsam7;infdsc1;matdsam2a;
    matdsam2b;matvmd838),s).
map(s,(infdsam11;infdsam4a;infdsam4b;infdsam9;infdsc2;infdsrma;infdsrmb;
    matdsam8a),e).

% B
b(infdsam1a,infdsam1b;matdsam2a,matdsam2b;matdsam3a,matdsam3b;
    infdsam4a,infdsam4b;infdsam5a,infdsam5b;infdsam6a,infdsam6b;
    matdsam8a,matdsam8b).

% global constraints
card(e,leq,2).  equal(int(s,ba),e).
sum(int(Z,s),c,bw,(L,U)) :- Z = (c;r;l;m), map(l,Z,L), map(u,Z,U).

% temporal constraints
in(msc,tc4). sum(before(tc4),c,geq,72).
