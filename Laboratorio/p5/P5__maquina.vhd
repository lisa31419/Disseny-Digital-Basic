-- ENTITY NOT
ENTITY inv IS
PORT (a: IN BIT;
      f: OUT BIT);
END inv;

----- ARQUITECTURA logicaretard
ARCHITECTURE logica_retard OF inv IS
BEGIN
f <= not a AFTER 4 ns;
END logica_retard;

-------------------------------------------------------

-- ENTITY AND2
ENTITY and2 IS
PORT (a,b: IN BIT;
	f: OUT BIT);
END and2;

---- ARQUITECTURA logica_retard
ARCHITECTURE logica_retard OF and2 IS
BEGIN
f <= a AND b AFTER 4 ns;
END logica_retard;

-------------------------------------------------------

---- ENTITY XOR2
ENTITY xor2 is
PORT (a,b: IN BIT;
	f: OUT BIT);
END xor2;

---- ARQUITECTURE logica_retard
ARCHITECTURE logica_retard OF xor2 IS
BEGIN
f <= a XOR b AFTER 4 ns; 
END logica_retard;

---------------------------------------------------------------------

---- Flip-Flop JK per flanc de pujada amb Preset i Clear
ENTITY JK_Pujada_PreClr IS
PORT(J, K, Clk, Pre, Clr: IN BIT;
                       Q: OUT BIT);

END JK_Pujada_PreClr;

ARCHITECTURE ifthen OF JK_Pujada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (J, K, Clk, Pre, Clr)
BEGIN
	IF Pre='1' THEN qint<='1' AFTER 4 ns;
	ELSIF Clr='1' THEN qint<='0' AFTER 4 ns;
	ELSIF Clk'EVENT AND Clk='1' THEN
		IF J = '0' AND K = '0' THEN qint <= qint AFTER 4 ns;
		ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 4 ns;
		ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 4 ns;
		ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 4 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;

END ifthen;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

---- ENTITY circuit

ENTITY circuit IS
PORT (x,Clk: IN BIT;
   Z2,Z1,Z0: OUT BIT);

END circuit;

---- ANQUITECTURA ESTRUCTURAL
ARCHITECTURE estructural OF circuit IS 

---- PORTA NOT ----
COMPONENT portanot IS
PORT(a: IN BIT;
     f: OUT BIT);
END COMPONENT;

---- PORTA XOR2 ----
COMPONENT portaxor2 IS
PORT(a,b:IN BIT;
       f: OUT BIT);
END COMPONENT;

---- PORTA AND2 ----
COMPONENT portaand2 IS
PORT(a,b: IN BIT;
       f: OUT BIT);
END COMPONENT;

---- FF_JK PUJADA ----

COMPONENT FF_JK_Pujada IS
PORT(J, K, Clk, Pre, Clr: IN BIT; 
	              Q: OUT BIT);
END COMPONENT;

-------------------------------------------------------------------------------

SIGNAL Q2, Q1, Q0, J2, J1, alpha: BIT;
	FOR DUT1: portaxor2 USE ENTITY WORK.xor2(logica_retard);
	FOR DUT2: portanot USE ENTITY WORK.inv(logica_retard);
	FOR DUT3: portaand2 USE ENTITY WORK.and2(logica_retard);

	FOR DUT4: FF_JK_Pujada USE ENTITY WORK.JK_Pujada_PreClr(ifthen);
	FOR DUT5: FF_JK_Pujada USE ENTITY WORK.JK_Pujada_PreClr(ifthen);
	FOR DUT6: FF_JK_Pujada USE ENTITY WORK.JK_Pujada_PreClr(ifthen);

BEGIN

	DUT1: portaxor2 PORT MAP (x,Q0,alpha);
	DUT2: portanot PORT MAP (alpha,J1);
	DUT3: portaand2 PORT MAP (J1,Q1,J2);

	DUT4: FF_JK_Pujada PORT MAP (J2,J2,Clk,'0','0',Q2);
	DUT5: FF_JK_Pujada PORT MAP (J1,J1,Clk,'0','0',Q1);
	DUT6: FF_JK_Pujada PORT MAP (x,'1',Clk,'0','0',Q0);

Z2 <= Q2;
Z1 <= Q1;
Z0 <= Q0;
 
END estructural;

-- Banc de Proves 
ENTITY bdp IS
END bdp;

ARCHITECTURE test OF bdp IS

COMPONENT bloc_que_simulem IS
PORT (x,Clk: IN BIT;
   Z2,Z1,Z0: OUT BIT);
END COMPONENT;


SIGNAL x,Clk,Z2,Z1,Z0: BIT;
FOR DUT1: bloc_que_simulem USE ENTITY WORK.circuit(estructural);

BEGIN
	
	DUT1: bloc_que_simulem PORT MAP(x,Clk,Z2,Z1,Z0);
	
PROCESS (Clk)
BEGIN

Clk <= NOT Clk AFTER 50 ns;
x <= NOT x AFTER 400 ns;

END PROCESS;
END test;