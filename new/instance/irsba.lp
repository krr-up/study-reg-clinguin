% x and y are the minimum and maximum number of focuses allowable
#const x=1.
#const y=1.

% i, ii, l, p and e
in((slrba014;slrba001;slrba002;slrba003;slrba006;rusba001;
    bbmvwl110;bbmpuv610;bbmpuv110;bbmpuv210;bbmpuv310;bbmpuv410;
    bbmpuv510;bbmvwl210;slrba022;slrba023;rusba002;zruba01;
    zruba02;slrba017;zruba04;rusba003;slrba021),i).
in((bamaO1;bamaO2;bamaO3;bamaO4;bamaO5;bamaO6;
    bamaO7;bamaO8;zruos01;zruos02;zruos03),ii).
in((slrba010;slrba012;rusba005),l).
in((bbmvwl310;bbmvwl320;rusba004),p).
in((bvmpuv110;bvmpuv210;bvmpuv120;bvmpuv220;bvmpuv310;bvmpuv320;
    bvmpuv410;bvmpuv420;bvmpuv510;bvmpuv520),e).
% m                             
in(E,m) :- in(E,(i;ii;l;p;e)).  
in(ba,m).

%c
map(c,(slrba001;slrba002;bbmvwl110;bbmpuv610;bbmpuv110;bbmpuv210;
    bbmpuv310;bbmpuv410;bbmpuv510;bbmvwl210;slrba022;slrba023;
    slrba017;zruba04;rusba003;bamaO1;bamaO2;bamaO3;
    bamaO4;bamaO5;bamaO6;bamaO7;bamaO8;zruos01;
    zruos02;zruos03;rusba005;bbmvwl310;bbmvwl320;rusba004;
    bvmpuv110;bvmpuv210;bvmpuv120;bvmpuv220;bvmpuv310;bvmpuv320;
    bvmpuv410;bvmpuv420;bvmpuv510;bvmpuv520),6).
map(c,(slrba006;rusba001;rusba002;zruba01;zruba02),9).
map(c,(slrba014;slrba003;slrba010;slrba012),12).
map(c,slrba021,24).
map(c,ba,9).

% l and u
map(l,i,183;l,ii,18;l,l,30;l,p,18;l,e,12;l,m,240).
map(u,i,183;u,ii,18;u,l,30;u,p,18;u,e,12;u,m,240).

% s
map(s,(bbmpuv110;bbmpuv210;bbmpuv410;bbmpuv610;bbmvwl110;bbmvwl210;
    bbmvwl320;rusba001;rusba002;rusba003;rusba004;rusba005;
    slrba022;zruos01;zruos02),w).
map(s,(bbmpuv310;bbmpuv510;bbmvwl310;slrba021;slrba023),s).
map(s,(bvmpuv110;bvmpuv120;bvmpuv210;bvmpuv220;bvmpuv310;bvmpuv320;
    bvmpuv410;bvmpuv420;bvmpuv510;bvmpuv520;slrba001;slrba002;
    slrba003;slrba006;slrba010;slrba012;slrba014;slrba017;
    zruba01;zruba02;zruba04;zruos03;bamaO1;bamaO2;
    bamaO3;bamaO4;bamaO5;bamaO6;bamaO7;bamaO8),e).

% D
d(zruba01,rusba001;zruba01,rusba002;zruba01,rusba003;
    zruba01,rusba004;zruos03,slrba003;zruos03,slrba006;
    zruos03,slrba010;zruos03,slrba012;zruos03,slrba017;
    zruba01,slrba021;zruos03,zruba02;zruba01,zruba02;
    zruba02,zruba04).

% f
in((language;politics),f).

% h
in(l,lset;(p;e),pset).
map(h,language,lset;h,politics,pset).

% global constraints
card(h,bw,(x,y)). 
sum(int(H,s),c,bw,(L,U)) :- H = (i;ii;m;V), in(F,f), in(F,h), map(h,F,Fs), in(V,Fs), map(l,H,L), map(u,H,U).
in(ba,gc2). subseteq(gc2,s).

% temporal constraints
in(ba,tc4). sum(before(tc4),c,geq,171).


% focus input
in((language),h).
