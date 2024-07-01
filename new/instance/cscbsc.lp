% x and y are the minimum and maximum number of focuses allowable
#const x=1.
#const y=2.

% i, ii, iii, iv, v, vi and x
in((inf1010;inf1011;inf1020;inf1021;inf1030;inf1031;inf1040;
    inf1050;inf1060;inf1070;inf1080;mat1100;mat1101;mat1102;
    mat1103;inf6010;inf6030),i).
in((inf2010;inf2020;inf2021;inf2030;inf2031;inf2040;inf2041;
    inf2050;inf2060;inf2061;inf2070;inf2080;inf2090;inf2091),ii).
% iii, b, c, ge, k and p
in(M,iii) :- in(M,(b;c;ge;k;p)).
    in(biobm105,b).
    in(chea1nf,c).
    in(gewbp01,ge).
    in(psybs013,k).
    in(phy131c,p).
% iv, ba, ca, gea, ka and pa
in(M,iv) :- in(M,(ba;ca;gea;ka;pa)).
    in((biobm107;biobm108;bioam212;bioam302;bioam314),ba).
    in((cheocgee;cheawp23;cheawp3;chea8cs),ca).
    in((gewbp02;gewgis1;geekl;geehy;gewbwp01;gewbwp02;gewbwp05),gea).
    in((psybs011;psybs012;linbs101;linbs102;linbs103;linbs061),ka).
    in((phy131d;phy511las;phy611las;phy101geo;phy201geo;phy531),pa).
in(matd230cs,v).
in((inf6020;bamaO1;bamaO2;bamaO3),vi).

in(M,x) :- in(M,(iii;iv)).

% m                             
in(E,m) :- in(E,(i;ii;iii;iv;v;vi;x)).  
in(bsc,m).


%c
map(c,(inf1010;inf1011;inf1020;inf1021;inf1030;inf1031;inf1040;
    inf1050;inf1060;inf1070;inf1080;mat1100;mat1101;mat1102;
    mat1103;inf6010;inf6030;inf2010;inf2020;inf2021;inf2030;
    inf2031;inf2040;inf2041;inf2050;inf2060;inf2061;inf2070;
    inf2080;inf2090;inf2091;biobm105;chea1nf;gewbp01;phy131c;
    biobm107;biobm108;bioam212;bioam302;bioam314;cheocgee;
    cheawp23;cheawp3;chea8cs;gewbp02;gewgis1;geekl;geehy;
    gewbwp01;gewbwp02;gewbwp05;linbs101;linbs102;linbs103;
    linbs061;phy131d;phy511las;phy611las;phy101geo;phy201geo;phy531;
    matd230cs;bamaO1;bamaO2;bamaO3),6).
map(c,(psybs011;psybs012;psybs013),9).
map(c,(inf6020;bsc),12).


% l and u
map(l,i,102;l,ii,12;l,v,6;l,vi,18;l,x,30;l,m,180).
map(u,i,102;u,ii,12;u,v,6;u,vi,18;u,x,30;u,m,180).

% s
map(s,(bioam314;biobm105;chea1nf;gewbp01;gewbwp01;gewbwp05;
    gewgis1;inf1010;inf1020;inf1030;inf1031;inf1060;inf1060;
    inf1080;inf2020;inf2021;inf2031;inf2041;inf2061;linbs101;
    mat1100;mat1101;matd230cs;phy101geo;phy131c;phy131d;phy511las),w).
map(s,(bioam212;biobm107;biobm108;chea8cs;cheawp23;cheawp3;
    gewbp02;gewbwp02;inf1011;inf1021;inf1040;inf1050;inf1070;
    inf2010;inf2030;inf2040;inf2050;inf2060;inf2070;inf2080;
    inf6010;linbs103;mat1102;mat1103;phy201geo;phy611las),s).
map(s,(bioam302;cheocgee;geehy;geekl;inf2090;inf2091;inf6020;
    inf6030;linbs061;linbs102;phy531;psybs011;psybs012;psybs013;
    bamaO1;bamaO2;bamaO3),e).

% f
in((bioinformatics;chemistry;geoscience;cognitivesciences;physics),f).

% h
in((b;ba),biset;(c;ca),chset;(ge;gea),geset;(k;ka),coset;(p;pa),phset).
map(h,bioinformatics,biset;h,chemistry,chset;h,geoscience,geset;h,cognitivesciences,coset;h,physics,phset).


% global constraints
card(h,bw,(x,y)). 
sum(int(Z,s),c,bw,(L,U)) :- Z = (i;ii;v;vi;m), map(l,Z,L), map(u,Z,U).
in(M,gc2) :- in(F,h), in(F,f), map(h,F,Fs), in(V,Fs), in(M,V).
sum(int(Z,s),c,bw,(L,U)) :- Z = gc2, map(l,x,L), map(u,x,U).
in(inf6020,gc3). in(bsc,gc3). subseteq(gc3,s).

% temporal constraints
in(bsc,tc4). sum(before(tc4),c,geq,126).


% focus input
in((bioinformatics;physics),h).