-- ENTITY NOT
ENTITY inversor IS
PORT (a: IN BIT;
      z: OUT BIT);
END inversor;

----- ARQUITECTURA logica
ARCHITECTURE logica OF inversor IS
BEGIN
z <= not a;
END logica;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF inversor IS
BEGIN
z <= not a AFTER 3 ns;
END logicaretard;

--------------------------------------

-- ENTITY AND2
ENTITY and2 IS
PORT (a,b: IN BIT;
	z: OUT BIT);
END and2;

---- ARQUITECTURA logica
ARCHITECTURE logica OF and2 IS
BEGIN
z <= a AND b;
END logica;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF and2 IS
BEGIN
z <= a AND b AFTER 3 ns;
END logicaretard;


--------------------------------------

-- ENTITY AND3
ENTITY and3 IS
PORT (a,b,c: IN BIT;
	  z: OUT BIT);
END and3;

---- ARQUITECTURA logica
ARCHITECTURE logica OF and3 IS
BEGIN
z <= a AND b AND c;
END logica;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF and3 IS
BEGIN
z <= a AND b AND c AFTER 3 ns;
END logicaretard;

-------------------------------------

-- ENTITY AND4
ENTITY and4 IS
PORT (a,b,c,d: IN BIT;
	    z: OUT BIT);
END and4;

---- ARQUITECTURA logica
ARCHITECTURE logica OF and4 IS
BEGIN
z <= a AND b AND c AND d;
END logica;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF and4 IS
BEGIN
z <= a AND b AND c AND d AFTER 3 ns;
END logicaretard;

--------------------------------------

-- ENTITY OR2
ENTITY or2 is
PORT (a,b: IN BIT;
	z: OUT BIT);
END or2;
----- ARQUITECTURA logica
ARCHITECTURE logica OF or2 IS
BEGIN
z <= a OR b;
END logica;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF or2 IS
BEGIN
z <= a OR b AFTER 3 ns; 
END logicaretard;


--------------------------------------

-- ENTITY OR3
ENTITY or3 is
PORT (a,b,c: IN BIT;
	  z: OUT BIT);
END or3;

---- ARQUITECTURA logica
ARCHITECTURE logica OF or3 IS
BEGIN
z <= a OR b OR c;
END logica;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF or3 IS
BEGIN
z <= a OR b OR c AFTER 3 ns; 
END logicaretard;

--------------------------------------

-- ENTITY OR4
ENTITY or4 is
PORT (a,b,c,d: IN BIT;
	    z: OUT BIT);
END or4;

---- ARQUITECTURA logica:
ARCHITECTURE logica OF or4 IS
BEGIN
z <= a OR b OR c OR d;
END logica;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF or4 IS
BEGIN
z <= a OR b OR c OR d AFTER 3 ns; 
END logicaretard;

----------------------------------------

---- ENTITY XOR2
ENTITY xor2 is
PORT (a,b: IN BIT;
	z: OUT BIT);
END xor2;

---- ARQUITECTURE logica
ARCHITECTURE logica OF xor2 IS
BEGIN
z <= a XOR b; 
END logica;

---- ARQUITECTURE logicaretard
ARCHITECTURE logicaretard OF xor2 IS
BEGIN
z <= a XOR b AFTER 3 ns; 
END logicaretard;

-----------------------------------------------------------------

-----------------------------------------------------------------

ENTITY bdp_portes IS
END bdp_portes;

ARCHITECTURE test OF bdp_portes IS

-- PORTA INVERSOR
COMPONENT la_porta_inversor
PORT(a: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA AND2
COMPONENT la_porta_and2
PORT (a, b: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA AND3
COMPONENT la_porta_and3
PORT (a, b, c: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA AND4
COMPONENT la_porta_and4
PORT (a, b, c, d: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA OR2 
COMPONENT la_porta_or2
PORT (a, b: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA OR3
COMPONENT la_porta_or3
PORT (a, b, c: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA OR4
COMPONENT la_porta_or4
PORT (a, b, c, d: IN BIT; z: OUT BIT);
END COMPONENT;

-- PORTA XOR2 
COMPONENT la_porta_xor2
PORT (a, b: IN BIT; z: OUT BIT);
END COMPONENT;

--------------------------------------------------

SIGNAL ent1, ent2, ent3, ent4, sort_inversor_logica, sort_inversor_logica_retard, sort_and2_logica, sort_and2_logica_retard, sort_and3_logica, sort_and3_logica_retard, sort_and4_logica, sort_and4_logica_retard, sort_or2_logica, sort_or2_logica_retard, sort_or3_logica, sort_or3_logica_retard, sort_or4_logica, sort_or4_logica_retard, sort_xor2_logica, sort_xor2_logica_retard: BIT; 

FOR DUT_IN_L: la_porta_inversor USE ENTITY WORK.inversor(logica);
FOR DUT_IN_LR: la_porta_inversor USE ENTITY WORK.inversor(logicaretard);

FOR DUT_AND2_L: la_porta_and2 USE ENTITY WORK.and2(logica);
FOR DUT_AND2_LR: la_porta_and2 USE ENTITY WORK.and2(logicaretard);

FOR DUT_AND3_L: la_porta_and3 USE ENTITY WORK.and3(logica);
FOR DUT_AND3_LR: la_porta_and3 USE ENTITY WORK.and3(logicaretard);

FOR DUT_AND4_L: la_porta_and4 USE ENTITY WORK.and4(logica);
FOR DUT_AND4_LR: la_porta_and4 USE ENTITY WORK.and4(logicaretard);

FOR DUT_OR2_L: la_porta_or2 USE ENTITY WORK.or2(logica);
FOR DUT_OR2_LR: la_porta_or2 USE ENTITY WORK.or2(logicaretard);

FOR DUT_OR3_L: la_porta_or3 USE ENTITY WORK.or3(logica);
FOR DUT_OR3_LR: la_porta_or3 USE ENTITY WORK.or3(logicaretard);

FOR DUT_OR4_L: la_porta_or4 USE ENTITY WORK.or4(logica);
FOR DUT_OR4_LR: la_porta_or4 USE ENTITY WORK.or4(logicaretard);

FOR DUT_XOR2_L: la_porta_xor2 USE ENTITY WORK.xor2(logica);
FOR DUT_XOR2_LR: la_porta_xor2 USE ENTITY WORK.xor2(logicaretard);

BEGIN
DUT_IN_L: la_porta_inversor PORT MAP (ent1, sort_inversor_logica);
DUT_IN_LR: la_porta_inversor PORT MAP (ent1, sort_inversor_logica_retard);

DUT_AND2_L: la_porta_and2 PORT MAP (ent1, ent2, sort_and2_logica);
DUT_AND2_LR: la_porta_and2 PORT MAP (ent1, ent2, sort_and2_logica_retard);

DUT_AND3_L: la_porta_and3 PORT MAP (ent1, ent2, ent3, sort_and3_logica);
DUT_AND3_LR: la_porta_and3 PORT MAP (ent1, ent2,ent3, sort_and3_logica_retard);

DUT_AND4_L: la_porta_and4 PORT MAP (ent1, ent2, ent3, ent4, sort_and4_logica);
DUT_AND4_LR: la_porta_and4 PORT MAP (ent1, ent2, ent3, ent4, sort_and4_logica_retard);

DUT_OR2_L: la_porta_or2 PORT MAP (ent1, ent2, sort_or2_logica);
DUT_OR2_LR: la_porta_or2 PORT MAP (ent1, ent2, sort_or2_logica_retard);

DUT_OR3_L: la_porta_or3 PORT MAP (ent1, ent2, ent3, sort_or3_logica);
DUT_OR3_LR: la_porta_or3 PORT MAP (ent1, ent2, ent3, sort_or3_logica_retard);

DUT_OR4_L: la_porta_or4 PORT MAP (ent1, ent2, ent3, ent4, sort_or4_logica);
DUT_OR4_LR: la_porta_or4 PORT MAP (ent1, ent2, ent3, ent4, sort_or4_logica_retard);

DUT_XOR2_L: la_porta_xor2 PORT MAP (ent1, ent2, sort_xor2_logica);
DUT_XOR2_LR: la_porta_xor2 PORT MAP (ent1, ent2, sort_xor2_logica_retard);


PROCESS (ent1,ent2,ent3,ent4)

BEGIN
ent1 <= NOT ent1 AFTER 50 ns;
ent2 <= NOT ent2 AFTER 100 ns;
ent3 <= NOT ent3 AFTER 200 ns;
ent4 <= NOT ent4 AFTER 400 ns;

END PROCESS;

END test;

