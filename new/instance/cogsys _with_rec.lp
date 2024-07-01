% b, f, a, o and p               % c
in((bm1;bm2;bm3),b).             map(c,(bm1;bm2;bm3),9).
in((fm1;fm2;fm3),f).             map(c,(fm1;fm2;fm3),6).
in((am11;am12;am21),a).          map(c,(am11;am12;am21),6).
in((am22;am31;am32),a).          map(c,(am22;am31;am32),6).
in(E,o) :- in(E,(f;a)).          map(c,(pm1;pm2;pm3),12).
in((pm1;pm2;pm3),p).             map(c,im,15).
                                 map(c,msc,30).

% m                              % s
in(E,m) :- in(E,(b;f;a;p)).      map(s,bm1,w;s,bm2,s;s,bm3,w).
in((im;msc),m).                  map(s,(fm1;fm2;fm3),w).
                                 map(s,(am11;am12;am21),e).
                                 map(s,(am22;am31;am32),e).
%* e  *%                         map(s,(pm1;pm2;pm3),e).
in(fm1,e).                       map(s,(im1;msc1),e).

                                 % l and u
                                 map(l,b,27;l,o,24;l,p,24;l,m,120).
                                 map(u,b,27;u,o,24;u,p,24;u,m,120).

% global constraints
card(e,leq,2).  equal(int(s,f),e).
sum(int(H,s),c,bw,(L,U)) :- H = (b;o;p;m), map(l,H,L), map(u,H,U).
in(im,gc3). in(msc,gc3). subseteq(gc3,s).

% temporal constraints
in(msc,tc4). sum(before(tc4),c,geq,90).

% recommendations

recommend(bm1,am11).
recommend(am11,am12).
recommend(am11,pm1).
recommend(am12,pm1).

recommend(bm2,am21).
recommend(am21,am22).
recommend(am21,pm2).
recommend(am22,pm2).

recommend(bm3,am31).
recommend(am31,am32).
recommend(am31,pm3).
recommend(am32,pm3).



%*
% Examination tasks

% Ep
in((822211;822311;822411;822511;556111;556211;822611;822711;556311),ep).

% Es
in((555813;821912;555913;555914;822012;556012;822112),es).

% ep
map(ep,am11,am11epset;ep,am21,am21epset;ep,am22,am22epset;ep,am31,am31epset;
ep,am32,am32epset;ep,pm1,pm1epset;ep,pm2,pm2epset;ep,pm3,pm3epset;ep,am12,am12epset).

% es
map(es,bm2,bm2esset;es,bm1,bm1esset;es,bm3,bm3esset;
es,fm1,fm1esset;es,fm2,fm2esset;es,fm3,fm3esset).

    in((822211;822311),s1).
    in(s1,am11epset).

    in(822311,s3).
    in(s3,am12epset).

    in(822411,s2).
    in(s2,am21epset).

    in(822511,s4).
    in(s4,am22epset).

    in(556111,s5).
    in(s5,am31epset).

    in(556211,s6).
    in(s6,am32epset).

    in(822611,s7).
    in(s7,pm1epset).

    in(822711,s8).
    in(s8,pm2epset).

    in(556311,s9).
    in(s9,pm3epset).


    in(821912,bm1esset).
    in(555813,bm2esset).
    in((555913;555914),bm3esset).
    in(822012,fm1esset).
    in(556012,fm2esset).
    in(822112,fm3esset).

% d

*%