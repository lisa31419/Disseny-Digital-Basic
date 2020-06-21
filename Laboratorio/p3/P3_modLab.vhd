ENTITY funcio_logica is
PORT ( a,b,c: IN BIT;
	f: OUT BIT);
END funcio_logica;

----  arquitectura ?ifthen?
ARCHITECTURE ifthen OF funcio_logica IS
BEGIN
	PROCESS (a, b, c)
	BEGIN
		IF a='0' AND b='0' AND c='0' THEN
			f<= '0' AFTER 3 ns;
		ELSIF a='0' AND b='0' AND c='1' THEN
			f<= '0' AFTER 3 ns;
		ELSIF a='0' AND b='1' AND c='0' THEN
			f<= '1' AFTER 3 ns;
		ELSIF a='0' AND b='1' AND c='1' THEN
			f<= '1' AFTER 3 ns;
		ELSIF a='1' AND b='0' AND c='0' THEN
			f<= '1' AFTER 3 ns;
		ELSIF a='1' AND b='0' AND c='1' THEN
			f<= '0' AFTER 3 ns;
		ELSIF a='1' AND b='1' AND c='0' THEN
			f<= '1' AFTER 3 ns;
		ELSIF a='1' AND b='1' AND c='1' THEN
			f<= '0' AFTER 3 ns;
		END IF;

	END PROCESS;

END ifthen;

----------------------------------------------------------------------
-- ENTITY OR2
ENTITY or2 is
PORT (a,b: IN BIT;
	z: OUT BIT);
END or2;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF or2 IS
BEGIN
z <= a OR b AFTER 3 ns; 
END logicaretard;

-- ENTITY AND2
ENTITY and2 IS
PORT (a,b: IN BIT;
	z: OUT BIT);
END and2;

---- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF and2 IS
BEGIN
z <= a AND b AFTER 3 ns;
END logicaretard;

-- ENTITY NOT
ENTITY inv IS
PORT (a: IN BIT;
      z: OUT BIT);
END inv;

----- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF inv IS
BEGIN
z <= not a AFTER 3 ns;
END logicaretard;

-----------------------------------------------------------------------------
---- Flip-Flop D per flanc de baixada amb Preset i Clear

ENTITY D_Bajada_PreClr IS
PORT(D, Clk, Pre, Clr: IN BIT;
              Q, NO_Q: OUT BIT);

END D_Bajada_PreClr;

ARCHITECTURE ifthen OF D_Bajada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (D, Clk, Pre, Clr)
BEGIN
	IF Clr='0' THEN qint<='0' AFTER 2 ns;
	ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;
	ELSIF Clk'EVENT AND Clk='0' THEN
	qint <= D AFTER 2 ns;
END IF;
END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---- Flip-Flop JK per flanc de baixada amb Preset i Clear
ENTITY JK_Bajada_PreClr IS
PORT(J, K, Clk, Pre, Clr: IN BIT;
                 Q, NO_Q: OUT BIT);

END JK_Bajada_PreClr;

ARCHITECTURE ifthen OF JK_Bajada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (J, K, Clk, Pre, Clr)
BEGIN
	IF Clr='0' THEN qint<='0' AFTER 2 ns;
	ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;
	ELSIF Clk'EVENT AND Clk='0' THEN
		IF J = '0' AND K = '0' THEN qint <= qint AFTER 2 ns;
		ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 2 ns;
		ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 2 ns;
		ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 2 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---- Flip-Flop JK per flanc de pujada amb Preset i Clear
ENTITY JK_Pujada_PreClr IS
PORT(J, K, Clk, Pre, Clr: IN BIT;
                 Q, NO_Q: OUT BIT);

END JK_Pujada_PreClr;

ARCHITECTURE ifthen OF JK_Pujada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (J, K, Clk, Pre, Clr)
BEGIN
	IF Pre='1' THEN qint<='1' AFTER 2 ns;
	ELSIF Clk='1' THEN qint<='0' AFTER 2 ns;
	ELSIF Clk'EVENT AND Clk='0' THEN
		IF J = '0' AND K = '0' THEN qint <= qint AFTER 2 ns;
		ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 2 ns;
		ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 2 ns;
		ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 2 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---- Flip-Flop T per flanc de baixada amb Preset i Clear
ENTITY T_Bajada_PreClr IS
PORT(T, Clk, Pre, Clr: IN BIT;
              Q, NO_Q: OUT BIT);

END T_Bajada_PreClr;

ARCHITECTURE ifthen OF T_Bajada_PreClr IS
SIGNAL qint: BIT;

BEGIN

PROCESS (T, Clk, Pre, Clr)
BEGIN
	IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
	ELSIF Pre='0' THEN qint <= '1' AFTER 2 ns;
	ELSIF Clk'EVENT AND Clk = '0' THEN
		IF T = '0' THEN qint <= qint AFTER 2 ns;
		ELSIF T = '1' THEN qint <= NOT qint AFTER 2 ns;
		END IF;

	END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


-------------------------------------------------------------------------------------------
---- Latch JK amb Preset i Clear

ENTITY JK_Latch_PreClr IS
PORT(J, K, Clk, Pre, Clr: IN BIT; 
	 	 Q, NO_Q: OUT BIT);
END JK_Latch_PreClr;

ARCHITECTURE ifthen OF JK_Latch_PreClr IS

SIGNAL qint: BIT;
BEGIN
PROCESS (J, K, Clk, Pre, Clr)

BEGIN
IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
ELSE
	IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
	ELSE
		IF Clk = '1' THEN
			IF J = '0' AND K = '0' THEN qint <= qint AFTER 2 ns;
			ELSIF J = '0' AND K = '1' THEN qint <= '0' AFTER 2 ns;
			ELSIF J = '1' AND K = '0' THEN qint <= '1' AFTER 2 ns;
			ELSIF J = '1' AND K = '1' THEN qint <= NOT qint AFTER 2 ns;
			END IF;

		END IF;

	END IF;

END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---- Latch D per nivell baix amb Preset i Clear
ENTITY D_Latch_PreClr IS
PORT(D, Clk, Pre, Clr: IN BIT; 
	      Q, NO_Q: OUT BIT);
END D_Latch_PreClr;

ARCHITECTURE ifthen OF D_Latch_PreClr IS

SIGNAL qint: BIT;
BEGIN
PROCESS (D, Clk, Pre, Clr)

BEGIN
IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
ELSE
	IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
	ELSE
		IF Clk = '1' THEN
			IF D = '0'  THEN qint <= '0' AFTER 2 ns;
			ELSIF D = '1'  THEN qint <= '1' AFTER 2 ns;
			END IF;

		END IF;

	END IF;

END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---- Latch D per nivell alt amb Preset i Clear
ENTITY D_Latch_Alt_PreClr IS
PORT(D, Clk, Pre, Clr: IN BIT; 
	      Q, NO_Q: OUT BIT);
END D_Latch_Alt_PreClr;

ARCHITECTURE ifthen OF D_Latch_Alt_PreClr IS

SIGNAL qint: BIT;
BEGIN
PROCESS (D, Clk, Pre, Clr)

BEGIN
IF Pre = '1' THEN qint <= '1' AFTER 2 ns;
ELSE
	IF Clr = '1' THEN qint <= '0' AFTER 2 ns;
	ELSE
		IF Clk = '0' THEN
			IF D = '0'  THEN qint <= '0' AFTER 2 ns;
			ELSIF D = '1'  THEN qint <= '1' AFTER 2 ns;
			END IF;

		END IF;

	END IF;

END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;

---- Latch T amb Preset i Clear
ENTITY T_Latch_PreClr IS
PORT(T, Clk, Pre, Clr: IN BIT; 
	      Q, NO_Q: OUT BIT);
END T_Latch_PreClr;

ARCHITECTURE ifthen OF T_Latch_PreClr IS

SIGNAL qint: BIT;
BEGIN
PROCESS (T, Clk, Pre, Clr)

BEGIN
IF Clr = '0' THEN qint <= '0' AFTER 2 ns;
ELSE
	IF Pre = '0' THEN qint <= '1' AFTER 2 ns;
	ELSE
		IF Clk = '1' THEN
			IF T = '0'  THEN qint <= qint AFTER 2 ns;
			ELSIF T = '1'  THEN qint <= NOT qint AFTER 2 ns;
			END IF;

		END IF;

	END IF;

END IF;

END PROCESS;

Q <= qint;
NO_Q <= NOT qint;

END ifthen;


---------------------------------------------------------------------

-- CIRCUIT
ENTITY circuit is
PORT (x, Clk, Pre, Clr: IN BIT;
		     z: OUT BIT);

END circuit;

----------------------------------------------------------------------------------------
-- ARQUITECTURA estructural
ARCHITECTURE estructural OF circuit IS

---- PORTA AND2 ----
COMPONENT portaand2 IS
PORT(a,b: IN BIT; 
       z: OUT BIT);
END COMPONENT;

---- PORTA OR2 ----
COMPONENT portaor2 IS
PORT(a,b: IN BIT;
	z: OUT BIT);
END COMPONENT;

---- PORTA NOT ----
COMPONENT portainv IS
PORT(a: IN BIT;
     z: OUT BIT);
END COMPONENT;

COMPONENT mi_JK_Pujada_PreClr IS
PORT(J, K, Clk, Pre, Clr: IN BIT;
	       Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT mi_D_Latch_Alt_PreClr IS
PORT(D, Clk, Pre, Clr: IN BIT; 
	       Q,NO_Q: OUT BIT);
END COMPONENT;

SIGNAL inv_x, Latch_D_Alt_sort_Q, Latch_D_Alt_sort_noQ, K_sort, J_sort, not_z: BIT;
	
	FOR DUT1: mi_JK_Pujada_PreClr USE ENTITY WORK.JK_Pujada_PreClr(ifthen);
	FOR DUT2: mi_D_Latch_Alt_PreClr USE ENTITY WORK.D_Latch_Alt_PreClr(ifthen);
	FOR DUT3: portainv USE ENTITY WORK.inv(logicaretard);
	FOR DUT4: portaand2 USE ENTITY WORK.and2(logicaretard);
	FOR DUT5: portaor2 USE ENTITY WORK.or2(logicaretard);

	

BEGIN
DUT3: portainv PORT MAP (x, inv_x);
DUT2: mi_D_Latch_Alt_PreClr PORT MAP (x, Clk, Pre, Clr, Latch_D_Alt_sort_Q, Latch_D_Alt_sort_noQ);
DUT5: portaor2 PORT MAP (inv_x, Latch_D_Alt_sort_noQ, K_sort); 
DUT4: portaand2 PORT MAP (Latch_D_Alt_sort_Q, x, J_sort);
DUT1: mi_JK_Pujada_PreClr PORT MAP (J_sort, K_sort, Clk, Pre, Clr, z, not_z);

END estructural;

-- Banc de Proves 
ENTITY banc_d_p IS
END banc_d_p;

ARCHITECTURE test OF banc_d_p IS

COMPONENT bloc_que_simulem IS
PORT(x, Clk, Pre, Clr: IN BIT;
		    z: OUT BIT);
END COMPONENT;


SIGNAL x, Clk, Pre, Clr, z_sort: BIT;
FOR DUT1: bloc_que_simulem USE ENTITY WORK.circuit(estructural);

BEGIN
	
	DUT1: bloc_que_simulem PORT MAP(x, Clk, Pre, Clr, z_sort);

PROCESS (Clk, Pre, Clr)
BEGIN
Clk <= NOT Clk AFTER 50 ns;
Pre <= '1';
Clr <= '1';

END PROCESS;

PROCESS
BEGIN
x <= '0'; WAIT FOR 75 ns;

x <= '1'; WAIT FOR 105 ns;

x <= '0'; WAIT FOR 35 ns;

x <= '1'; WAIT FOR 10 ns;

x <= '0'; WAIT FOR 20 ns;

x <= '1'; WAIT FOR 10 ns;

x <= '0'; WAIT FOR 20 ns;

x <= '1'; WAIT FOR 10 ns;

x <= '0'; WAIT FOR 25 ns;

x <= '1'; WAIT FOR 50 ns;

x <= '0'; WAIT FOR 140 ns;


END PROCESS;

END test;


--------- APARTADO 4 -------------
-- Las diferencias entre un Latch y un Flip-Flop son_
--    -> EL Latch no necesita una señal de reloj (clock) para su funcionamiento y
--       los Flip-Flop si.
--    -> En el Latch, los estados se pueden mantener por un tiempo limitado, mientras 
--       que en los Flip-Flop se pueden mantener indefinidamente.
--    -> El latch cambia de estado inmediatamente por sus señales de excitación,pero
--       los Flip-Flop esperan al cambio de estado de la señal de reloj.