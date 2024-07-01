% x and y are the minimum and maximum number of focuses allowable
#const x=1.
#const y=1.

% i, ii, iii, iv, x, a, b, c, ge, k, ma and p
in((inf7010;inf7020;inf7030;inf7040;inf7060;inf7061;inf7070;inf7080),i).
in((inf10010;inf10020),ii).
in((inf8010;inf8011;inf8020;inf8021;inf8030;inf8031;inf8032;inf8033;
    inf8040;inf8041;inf8050;inf8060;inf8061;inf8062;inf8063;inf8070;
    inf8072;inf8080;inf8090;inf8091),iii).
in(M,iv) :- in(M,(x;a)).
in((biobm108;chea14;chea1nf;cheocgee;chea8cs;gewbp01;phy131c;csema013),x).
in((inf9010;inf9011),a).
in((biombip03;biombip04;matmbip05;biombiw03;biombiw04;biombiw05;biombiw08),b).
in((cheb1;cheb6;che15cs),c).
in((gewrcm01;gewrcm02;gewrsm01;gewrsm02),ge).
in((csema011;csema014),k).
in((matvmd837;matvmd838;matvmd844;matdsam2a),ma).
in((phy541b;phyastcs;phy541e;phyklics),p).

% m                             
in(E,m) :- in(E,(i;ii;iii;iv;x;a;b;c;ge;k;ma;p)).  
in(msc,m).

% e
in((chea14;gewbp01;inf9011),e).

%c
map(c,(inf7010;inf7020;inf7030;inf7040;inf7060;inf7061;inf7070;inf7080;
    inf10020;inf8010;inf8011;inf8020;inf8021;inf8030;inf8031;inf8032;inf8033;
    inf8040;inf8041;inf8050;inf8060;inf8061;inf8062;inf8063;inf8070;
    inf8072;inf8080;inf8090;inf8091;biobm108;chea14;chea1nf;cheocgee;
    chea8cs;gewbp01;phy131c;csema013;inf9010;inf9011;biombip03;biombip04;
    matmbip05;biombiw03;biombiw04;biombiw05;biombiw08;
    cheb1;cheb6;che15cs;gewrcm01;gewrcm02;gewrsm01;gewrsm02),6).
map(c,(csema011;csema014;matvmd837;matvmd838;matvmd844;matdsam2a;phy541b;
    phyastcs;phy541e;phyklics),9).
map(c,inf10010,12).
map(c,msc,30).


% l and u
map(l,i,12;l,ii,18;l,iii,18;l,iv,24;l,x,0;l,b,18;l,c,18;l,ge,18;l,k,18;l,ma,18;l,p,18;l,m,120).
map(u,i,12;u,ii,18;u,iii,18;u,iv,24;u,x,12;u,b,18;u,c,18;u,ge,18;u,k,18;u,ma,18;u,p,18;u,m,120).

% s
map(s,(biombip03;biombiw04;biombiw08;chea14;chea1nf;cheb1;csema011;gewbp01;
    gewrcm01;gewrcm02;inf7010;inf7060;inf7070;inf7080;inf8011;inf8021;inf8030;
    inf8031;inf8061;inf8062;inf8072;inf8080;matvmd837;matvmd844;phy131c;phy541e
    ),w).
map(s,(biobm108;biombip04;biombiw03;biombiw05;chea8cs;csema013;gewrsm01;
    gewrsm02;inf7030;inf7040;inf8010;inf8020;inf8032;inf8033;inf8040;
    inf8050;inf8060;inf8063;inf8070;matdsam2a;matmbip05;matvmd838),s).
map(s,(che15cs;cheb6;cheocgee;csema014;inf10010;inf10020;inf7020;inf7061;
    inf8041;inf8090;inf8091;inf9010;inf9011;phy541b;phyastcs;phyklics),e).

% f
in((bioinformatics;chemistry;geoscience;cognitivesciences;mathematics;physics),f).

% h
in(b,biset;c,chset;ge,geset;k,coset;ma,maset;p,phset).
map(h,bioinformatics,biset;h,chemistry,chset;h,geoscience,geset;h,cognitivesciences,coset;h,mathematics,maset;h,physics,phset).


% global constraints
card(h,bw,(x,y)). 
in(E,gc1) :- in(E,e). 
subseteq(gc1,s).
in(M,gc1b) :- in(M,e), in(M,x).
sum(int(H,s),c,bw,(L,U)) :- H = gc1b, map(l,x,L), map(u,x,U).

in(E,gc2) :- in(E,e), in(E,a). 
subseteq(gc2,s).

sum(int(Z,s),c,bw,(L,U)) :- Z = (ii;m), map(l,Z,L), map(u,Z,U).
sum(int(Z,s),c,geq,L) :- Z = (i;iii;V), map(l,Z,L), in(F,h), map(h,F,Fs), in(V,Fs).

lsum(S) :- S' = #sum{L,RG: map(l,RG,L), RG = (i;iii;V), in(F,h), map(h,F,Fs), in(V,Fs)}, S = S' + L', map(l,iv,L').
usum(S) :- S' = #sum{U,RG: map(u,RG,U), RG = (i;iii;V), in(F,h), map(h,F,Fs), in(V,Fs)}, S = S' + U', map(u,iv,U').
in(M,gc5) :- in(F,h), map(h,F,Fs), in(V,Fs), in(M,H), H=(i;iii;iv;V).
sum(int(V,s),c,bw,(L,U)) :- V = gc5, lsum(L), usum(U).

in(gewrcm02,gc6) :- in(F,h), F=geoscience.
subseteq(gc6,s).
in(msc,gc7). subseteq(gc7,s).

% temporal constraints
in(msc,tc4). sum(before(tc4),c,geq,72).


% focus input
in((bioinformatics),h).
