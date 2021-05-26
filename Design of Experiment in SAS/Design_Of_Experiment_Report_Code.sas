*Design uncoded;
Proc factex;
factors A B C D E;
size fraction = 2;
model resolution = 5;
Examine design aliasing confounding; 
output out=randperm;
Title 'Acidic Solution Uncoded Factors';
run;
quit;

*Design Codede;
Proc factex;
Factors Water Temp Acid Size Time;
size fraction = 2;
model resolution = 5;
Examine design aliasing confounding; 
output out=repdesign randomize
	Water cvals=('Bottle' 'River')
 	Temp cvals=('24 C' '53 C')
	Acid cvals = ('Lemon' 'Vinegar')
	Size cvals = ('1 Cup' '3 Cups')
	Time cvals = ('15 Min' '30 Min');
title1 'Acidic Solution Coded Factors';
run;
quit;

proc print data=repdesign;
run;
quit;



Data Rand;
  seed = -1;
  set randperm;
  randordr = ranuni(seed);
run;

Proc Sort data=Rand out=Rand(drop=randordr);
  by randordr;
run;

proc print data=rand;
var A B C D E;
run;
quit;


data report;
input RUN WATER TEMP ACID SIZE TIME pH;
DATALINES;
1	-1	-1	-1	-1	1	3.33
2	1	-1	-1	-1	-1	6.43
3	1	-1	-1	-1	-1	6.84
4	-1	1	-1	-1	-1	5.92
5	-1	1	-1	-1	-1	5.63
6	1	1	-1	-1	1	5.69
7	-1	-1	1	-1	-1	3.03
8	-1	-1	1	-1	-1	3.59
9	1	-1	1	-1	1	7.01
10	-1	1	1	-1	1	5.89
11	-1	1	1	-1	1	7.13
12	1	1	1	-1	-1	4.83
13	1	1	1	-1	-1	4.77
14	-1	-1	-1	1	-1	6.87
15	1	-1	-1	1	1	7.82
16	1	-1	-1	1	1	6.93
17	-1	1	-1	1	1	5.93
18	1	1	-1	1	-1	6.73
19	1	1	-1	1	-1	6.84
20	-1	-1	1	1	1	3.82
21	1	-1	1	1	-1	6.07
22	1	-1	1	1	-1	6.46
23	-1	1	1	1	-1	3.77
24	-1	1	1	1	-1	4.06
25	1	1	1	1	1	6.13
26	1	1	1	1	1	6.76
;
RUN;
QUIT;

proc glm;
class WATER TEMP ACID SIZE TIME ;
model ph = WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME;
lsmeans WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME / adjust = tukey pdiff = all;
run;
quit;

Proc mixed data = report;
class WATER TEMP ACID SIZE TIME ;
model ph = WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME;
random TEMP SIZE TIME ;
lsmeans WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME / adjust = tukey pdiff = all;
run;
quit;

Proc glm data = report;
class WATER TEMP ACID SIZE TIME ;
model ph = WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME;
random TEMP SIZE TIME/test ;
lsmeans WATER TEMP ACID SIZE TIME WATER*TEMP WATER*ACID WATER*SIZE WATER*TIME TEMP*ACID TEMP*SIZE TEMP*TIME ACID*SIZE ACID*TIME SIZE*TIME / adjust = tukey pdiff = all;
run;
quit;