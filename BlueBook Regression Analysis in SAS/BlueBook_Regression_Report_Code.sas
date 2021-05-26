*IMPORT THE DATASET;

PROC IMPORT OUT= WORK.BlueBook 
            DATAFILE= "\\Client\C$\Users\ltyle\Documents\UTSA\STA 6013\PROJECT\Blue Book Modified Car Data 2015 11 11 2020.xlsX" 
            DBMS=EXCEL REPLACE;
     RANGE="'Cars Lab Data$'"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

Title "Appendex";
*Discriptive by numerical and catogorical; 
title2 'Discriptive by numerical and catogorical';
proc means data=Bluebook n nmiss mean std median min max range clm cv maxdec=3;
class Type Make Model Trim Type Cylinder Liter; 
 var Price Mileage Cruise Sound Leather; 
 run;
 *Discriptive means of numerical values;
title2 'Summary Statistics of each numerical values';
proc means data=Bluebook n nmiss mean std median min max range maxdec=3; 
var Price Mileage Cruise Sound Leather ; 
run;
*Discriptive by Classification;
title2 'Summary Statistics of each categorical values';
proc means data=Bluebook n nmiss mean std median min max range maxdec=3;
id Type Make Model Trim Type Cylinder Liter; 
 var Price Mileage Cruise Sound Leather; 
 run;

 *Scatter plots;
proc sgscatter data=Bluebook; 
matrix Price Mileage Cruise Sound Leather
       / ellipse=(type=mean)
         diagonal=(histogram kernel);
run;
*Box plots for catogorial values based on Price;

proc sgplot data=BlueBook;
vbox Price / category= Model;
run;

proc sgplot data=BlueBook;
vbox Price / category= Make;
run;

proc sgplot data=BlueBook;
vbox Price / category= Trim;
run;

proc sgplot data=BlueBook;
vbox Price / category= Type;
run;

proc sgplot data=BlueBook;
vbox Price / category= Cylinder;
run;

proc sgplot data=BlueBook;
vbox Price / category= Liter;
run;

proc sgplot data=BlueBook;
vbox Price / category= Doors;
run;

proc sgplot data=BlueBook;
vbox Price / category= Cruise;
run;

proc sgplot data=BlueBook;
vbox Price / category= Sound;
run;

proc sgplot data=BlueBook;
vbox Price / category= Leather;
run;

title2'Loess plots';
proc loess data=Bluebook plot(only)=fitplot;
  model Price=mileage /smooth=0.1 0.2 0.4 0.6 0.8 1.0;
run;


*Specification of the model, transformation;

data BlueBook;
	length Model_  8;
	set BlueBook;

	select (Model);
		when ('AVEO') Model_=1;
		when ('Vibe') Model_=1;
		when ('Cavalier') Model_=1;
		when ('Century') Model_=1;
		when ('Classic') Model_=1;
		when ('Cobalt') Model_=1;
		when ('Grand Am') Model_=1;
		when ('Grand Prix') Model_=1;
		when ('Lesabre') Model_=1;
		when ('Malibu') Model_=1;
		when ('Monte Carlo') Model_=1;
		when ('Sunfire') Model_=1;
		when ('9-2XAWD') Model_=2;
		when ('9_3') Model_=2;
		when ('9_3 HO') Model_=2;
		when ('9_5') Model_=2;
		when ('9_5 HO') Model_=2;
		when ('9-2X AWD') Model_=2;
		when ('Bonneville') Model_=2;
		when ('CTS') Model_=2;
		when ('G6') Model_=2;
		when ('GTO') Model_=2;
		when ('Impala') Model_=2;
		when ('GTO') Model_=2;
		when ('Lacrosse') Model_=2;
		when ('Park Avenue') Model_=2;
		when ('CST-V') Model_=3;
		when ('Corvette') Model_=3;
		when ('Deville') Model_=3;
		when ('STS-V6') Model_=3;
		when ('STS-V8') Model_=3;
		when ('XLR-V8') Model_=3;
		otherwise Model_=Model;
	end;
run;

data BlueBook;
	length Make_ 8;
	set BlueBook;

	select (Make);
	when ('Buick') Make_=1;
	when ('Chevrolet') Make_=1;
	when ('Pontiac') Make_=1;
	when ('Cadillac') Make_=2;
	when ('SAAB') Make_=3;
	otherwise Make_=Make;
	end;
	run;
	

data BlueBook;
	length Trim_  8;
	set BlueBook;
	select (Trim);
	when ('CXL Sedan 4') Trim_=1;
	when ('DTS Sedan 4') Trim_=1;
	when ('LS Coupe 2D') Trim_=1;
	when ('LS Sport Coupe 2D') Trim_=1;
	when ('LS Sedan 4D') Trim_=1;
	when ('LT Hatchback 4D') Trim_=1;
	when ('Coupe 2D') Trim_=1;
	when ('CXL Sedan 4D') Trim_=1;
	when ('DTS Sedan 4D') Trim_=1;
	when ('SS Sedan 4D') Trim_=1;
	when ('GT Coupe 2D') Trim_=1;
	when ('LS Hatchback 4D') Trim_=1;
	when ('LT Sedan 4D') Trim_=1;
	when ('CX Sedan 4D') Trim_=1;
	when ('SVM Sedan 4D') Trim_=1;
	when ('SVM Hatchback 4D') Trim_=1;
	when ('LS MAXX Hback 4D') Trim_=1;
	when ('LT MAXX Hback 4D') Trim_=1;
	when ('MAXX Hback 4D') Trim_=1;
	when ('Custom Sedan 4D') Trim_=1;
	when ('LS Sport Sedan 4D') Trim_=1;
	when ('SE Sedan 4D') Trim_=1;
	when ('GT Sedan 4D') Trim_=1;
	when ('GT Sportwagon') Trim_=1;
	when ('Sportwagon 4D') Trim_=1;
	when ('AWD Sportwagon 4D') Trim_=1;
	when ('SS Coupe 2D') Trim_=2;
	when ('Linear Wagon 4D') Trim_=2;
	when ('Coupe 2D') Trim_=2;
	when ('LT Coupe 2D') Trim_=2;
	when ('Arc Sedan 4D') Trim_=2;
	when ('GXP Sedan 4D') Trim_=2;
	when ('SLE Sedan 4D') Trim_=2;
	when ('Linear Sedan 4D') Trim_=2;
	when ('Aero Sedan 4D') Trim_=2;
	when ('Aero Wagon 4D') Trim_=2;
	when ('CXS Sedan 4D') Trim_=2;
	when ('GT Sedan 4D') Trim_=2;
	when ('GTP Sedan 4D') Trim_=2;
	when ('Limited Sedan 4D') Trim_=2;
	when ('Linear Seda') Trim_=2;
	when ('Linear Sedan 4D') Trim_=2;
	when ('Linear Wagon 4D') Trim_=2;
	when ('Sedan 4D') Trim_=2;
	when ('Special Ed Ultra 4D') Trim_=2;
	when ('Aero Conv 2D') Trim_=3;
	when ('Arc Conv 2D') Trim_=3;
    when ('Arc Sedan 4D') Trim_=3;
	when ('Arc Wagon 4D') Trim_=3;
	when ('Conv 2D') Trim_=3;
	when ('Coupe 2D') Trim_=3;
	when ('DHS Sedan 4D') Trim_=3;
	when ('Hardtop Conv 2D') Trim_=3;
	when ('Linear Conv 2D') Trim_=3;
	otherwise Trim_=Trim;
	end;
	run;
data BlueBook;
	length Liter_  8;
	set BlueBook;
	select (Liter);
	when ('1.6') Liter_=1;
	when ('1.8') Liter_=1;
	when ('2.2') Liter_=1;
	when ('3.1') Liter_=1;
	when ('3.4') Liter_=1;
	when ('3.5') Liter_=1;
	when ('3.8') Liter_=1;
	when ('2') Liter_=2;
	when ('2.3') Liter_=2;
	when ('2.5') Liter_=2;
	when ('2.8') Liter_=2;
	when ('3.6') Liter_=2;
	when ('4.6') Liter_=2;
	when ('5.7') Liter_=2;
	when ('6') Liter_=2;
	otherwise Liter_=Liter;
	end;
	run;

*Creating the model and diagnotics;
ods graphics on;
proc glmselect data=bluebook plot=all outdesign(addinputvars)=Work.reg_design;
	class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather / show 
		param=glm;
	model Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  
		  / showpvalues stats = adjrsq stats = AIC stats = PRESS stats= RSQUARE stb selection=none;
		 
run;
 ods graphics off;

 *Another way to view model diagnostic plot;
 ods graphics on;
 proc glm data=bluebook plots=(DIAGNOSTICS RESIDUALS) ;
 class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
	model Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  ;
	run;
	 ods graphics off;

 *diagnostic plot;
 ods graphics on;
Proc reg data=Work.reg_design alpha=0.05 ;
	ods select DiagnosticsPanel ResidualPlot ObservedByPredicted ParameterEstimates OutputStatistics ResidualStatistics CollinDiag 
		  PartialPlot RStudentByPredicted DFFITSPlot 
		DFBETASPanel;
	model Price=&_GLSMOD /  r stb influence collin vif;

run; 
quit;
	 ods graphics off;
*RStudent residual;
proc reg data=Work.reg_design alpha=0.05 ;
		model Price=&_GLSMOD/ vif;
	plot rstudent.*(predicted. &_GLSMOD obs.);
      plot npp.*rstudent.;
run; 
quit;

*correlation matrix; 
proc corr data = work.reg_design;
var &_GLSMOD;
run;

*refit of correlation with out doors;
proc glmselect data=bluebook plot=all outdesign(addinputvars)=Work.reg_designcor;
	class  Make_ Type Model_ Trim_ Cylinder  Liter_ Cruise Sound Leather / show 
		param=glm;
	model Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_  Cruise Sound Leather  
		   
		  ;
		 
run;


proc corr data = work.reg_designcor;
var Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather
Cruise;

run;
ods graphics on;
*refit of residuals;
Proc reg data=Work.reg_design alpha=0.05 ;
	ods select DiagnosticsPanel ResidualPlot ObservedByPredicted ParameterEstimates OutputStatistics ResidualStatistics CollinDiag 
		  PartialPlot RStudentByPredicted DFFITSPlot 
		DFBETASPanel;
	model Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather
Cruise /  r stb influence collin vif;

run; 
quit;

proc glm data=bluebook plots=(DIAGNOSTICS RESIDUALS) ;
 class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
	model Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  ;
	run;
	 ods graphics off;
ods graphics on;
*Running Box Cox Transformation of y with variables removed and transformed;
*using the three new tranformation variables ;
proc transreg data = Work.reg_design;
	model boxcox(price)=identity(&_GLSMOD );
run;
	 ods graphics off;

*Need to inverse x;
data Work.reg_design;
	set Work.reg_design;
	Tr_Price =Price**.25;
	log_Price=log(Price);
	Tr_price5=price**.5;
run;
data Bluebook;
set Bluebook;
log_Price=log(Price);
run;

*Transformation of y to Log(y);
 *Another way to view model diagnostic plot;
 ods graphics on;
 proc glm data=bluebook plots=(DIAGNOSTICS RESIDUALS) ;
 class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
	model log_Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  ;

	run;
	 ods graphics off;
*Creating the model and diagnotics;
ods graphics on;
proc glmselect data=bluebook plot=all outdesign(addinputvars)=Work.reg_design2;
	class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather / show 
		param=glm;
	model Log_Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  
		  / showpvalues stats = adjrsq stats = AIC stats = PRESS stats= RSQUARE stb selection=none;
		  
		 
run;

*reviewing transformation correlation;
proc corr data = work.reg_design2;
var log_price Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather
Cruise;

run;
 *RStudent residual check on transformed y and Mileage;
proc reg data=Work.reg_design2 alpha=0.05 ;
		model Log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1/ vif;
	plot rstudent.*(predicted. log_price Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1 obs.);
      plot npp.*rstudent.;
run; 
quit;
ods graphics off;




 ods graphics on;
 proc glm data=bluebook plots=(DIAGNOSTICS RESIDUALS) ;
 class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
	model log_Price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  ;

	run;
	 ods graphics off;

 ods graphics on;
 proc glm data=bluebook plots=(DIAGNOSTICS (unpack)) ;
 class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
	model Log_price=Mileage Make_ Model_  Trim_ Type Cylinder Liter_ Doors Cruise Sound Leather  ;
	output out=infl COOKD=CO COVRATIO=cov DFFITS=df H=h RSTUDENT=r RESIDUAL=re ;
	run;
	QUIT;
	 ods graphics off;

proc reg data=reg_design2 plots=(DIAGNOSTICS (unpack)) ;

model Log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1;
output out=infl COOKD=CO COVRATIO=cov DFFITS=df H=h RSTUDENT=r RESIDUAL=re student=s ;
run;
quit;


*Correct issues with obs weights;
 ods graphics on;

proc reg data=Work.reg_design2 alpha=0.05 plots(label)=(diagnostics 
		residuals dffits dfbetas observedbypredicted);
		
		model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1 / vif;

reweight r.<-.15 or r.>.15 /weight = .5; 
refit;
reweight cookd>.010 /weight = .5;
refit;
reweight dfbetas>.1 /weight = .05;
refit;
output out=reg_design3; 
run; 
quit;
	 ods graphics off;

*Check correlineatiry;
 ods graphics on;

proc glm data=Work.reg_design3 plots=(DIAGNOSTICS (unpack));
		class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather;
		model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1;

run; 
quit;
	 ods graphics off;

	 proc reg data=Work.reg_design3 alpha=0.05 ;
		model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1/ partial r p cli clm clb stb rsquare covb influence collin vif;
	plot rstudent.*(predicted. log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1 obs.);
      plot npp.*rstudent.;
run; 
quit;
ods graphics on;
proc reg data=Work.reg_design3  ;
		model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1 ;
run;

*selection of subset;
proc glmselect data=work.reg_design3;
	class  Make_ Type Model_ Trim_ Cylinder Doors Liter_ Cruise Sound Leather / show 
		param=glm;
	model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1   
		  / showpvalues stats = adjrsq stats = AIC stats = PRESS stats= RSQUARE stb selection=LASSO;
		  
		 
run;

*All possible regression method;
proc reg data=work.reg_design3;
  model log_Price=Mileage Make__1 Make__2 Make__3 
Model__1 Model__2  
Trim__1 Trim__3 
Type_Hatchback Type_Sedan Type_Wagon 
Cylinder_4 Cylinder_6 Cylinder_8 
Sound_0 Sound_1 
Leather_0 Leather_1
Cruise_0 Cruise_1   /
	selection=rsquare cp mse adjrsq aic bic best=3 b;
run;

*lasso order for regressor;
proc glm data=Work.reg_design3 plots=(DIAGNOSTICS (unpack));
		
		model log_Price=Model__1 Make__1 Cylinder_8 Cylinder_4 Trim__3 Trim__1  
Mileage   Type_Hatchback Type_Sedan Type_Wagon Make__3 Sound_0 
Model__2  ;

run; 
quit;