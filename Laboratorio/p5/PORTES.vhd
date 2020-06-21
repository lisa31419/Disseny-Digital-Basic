--------------------------------------------------------------
-----------------------  P O R T E S -------------------------
--------------------------------------------------------------
---- Flip-Flop T per flanc de baixada amb Preset i Clear
ENTITY T_Bajada_PreClr IS
PORT(T, Clk, Pre: IN BIT;
               Q: OUT BIT);

END T_Bajada_PreClr;

ARCHITECTURE ifthen OF T_Bajada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (T, Clk, Pre)
BEGIN
	IF Pre='0' THEN qint <= '1' AFTER 3 ns;
	ELSIF Clk'EVENT AND Clk = '0' THEN
		IF T = '0' THEN qint <= qint AFTER 3 ns;
		ELSIF T = '1' THEN qint <= NOT qint AFTER 3 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;

END ifthen;

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
	IF Pre='1' THEN qint<='1' AFTER 3 ns;
	ELSIF Clr='1' THEN qint<='0' AFTER 3 ns;
	ELSIF Clk'EVENT AND Clk='0' THEN
		IF J = '0' AND K = '0' THEN qint <= qint AFTER 3 ns;
		ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 3 ns;
		ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 3 ns;
		ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 3 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;

END ifthen;


----------------------------------------------------------------------
-- ENTITY OR2
ENTITY or2 is
PORT (a,b: IN BIT;
	f: OUT BIT);
END or2;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF or2 IS
BEGIN
f <= a OR b AFTER 3 ns; 
END logicaretard;

-- ENTITY AND2
ENTITY and2 IS
PORT (a,b: IN BIT;
	f: OUT BIT);
END and2;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF and2 IS
BEGIN
f <= a AND b AFTER 3 ns;
END logicaretard;


-- ENTITY NOT
ENTITY inv IS
PORT (a: IN BIT;
      f: OUT BIT);
END inv;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF inv IS
BEGIN
f <= NOT a AFTER 3 ns;
END logicaretard;
----------------------------------------------------------------------


