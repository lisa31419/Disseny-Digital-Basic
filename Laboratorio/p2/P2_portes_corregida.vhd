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

-----------------------------------------

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

-----------------------------------------

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

-----------------------------------------

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

-----------------------------------------

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

------------------------------------------

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

------------------------------------------

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

------------------------------------------

-- ENTITY NOT
ENTITY inv IS
PORT (a: IN BIT;
      z: OUT BIT);
END inv;

----- ARQUITECTURA logica
ARCHITECTURE logica OF inv IS
BEGIN
z <= not a;
END logica;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF inv IS
BEGIN
z <= not a AFTER 3 ns;
END logicaretard;

----------------------------------------

