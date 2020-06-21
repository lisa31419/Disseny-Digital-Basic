-- FUNCIO_2
ENTITY funcio_2 is
PORT (a,b,c,d: IN BIT;
	f1,f2: OUT BIT);

END funcio_2;

-- ARQUITECTURA logica
ARCHITECTURE logica OF funcio_2 IS
BEGIN
f1 <= (a AND c AND (a XOR d)) OR ((NOT b) AND c);
f2 <= a;
END logica;

-- ARQUITECTURA logicaretard
ARCHITECTURE logicaretard OF funcio_2 IS
BEGIN
f2 <= (a AND c AND (a XOR d)) OR ((NOT b) AND c) AFTER 3 ns;
f1 <= (a AND c AND (a XOR d)) OR ((NOT b) AND c);
END logicaretard;

-- ARQUITECTURA estructural
ARCHITECTURE estructural OF funcio_2 IS

---- PORTA AND2 ----
COMPONENT portaand2 IS
PORT(a,b: IN BIT; 
       z: OUT BIT);
END COMPONENT;

---- PORTA AND3 ----
COMPONENT portaand3 IS
PORT(a,b,c: IN BIT; 
         z: OUT BIT);
END COMPONENT;

---- PORTA OR2 ----
COMPONENT portaor2 IS
PORT(a,b: IN BIT;
	z: OUT BIT);
END COMPONENT;

---- PORTA XOR2 ----
COMPONENT portaxor2 IS
PORT(a,b: IN BIT;
       z: OUT BIT);
END COMPONENT;

---- PORTA NOT ----
COMPONENT portainv IS
PORT(a: IN BIT;
     z: OUT BIT);

END COMPONENT;

-----------------------------------------------

-- SIGNAL
SIGNAL inv_b_logica, xor_ad_logica, alpha_logica, beta_logica, inv_b_logica_retard, xor_ad_logica_retard, alpha_logica_retard, beta_logica_retard: BIT;

FOR DUT1: portainv USE ENTITY WORK.inv(logica);
FOR DUT1_LR: portainv USE ENTITY WORK.inv(logicaretard);

FOR DUT2: portaxor2 USE ENTITY WORK.xor2(logica);
FOR DUT2_LR: portaxor2 USE ENTITY WORK.xor2(logicaretard);

FOR DUT3: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT3_LR: portaand2 USE ENTITY WORK.and2(logicaretard);

FOR DUT4: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT4_LR: portaand3 USE ENTITY WORK.and3(logicaretard);

FOR DUT5: portaor2 USE ENTITY WORK.or2(logica);
FOR DUT5_LR: portaor2 USE ENTITY WORK.or2(logicaretard);


BEGIN

	DUT1: portainv PORT MAP(b, inv_b_logica);
	DUT1_LR: portainv PORT MAP(b, inv_b_logica_retard);

	DUT2: portaxor2 PORT MAP(a, d, xor_ad_logica);
	DUT2_LR: portaxor2 PORT MAP(a, d, xor_ad_logica_retard);

	DUT3: portaand2 PORT MAP(inv_b_logica, c, alpha_logica);
	DUT3_LR: portaand2 PORT MAP(inv_b_logica_retard, c, alpha_logica_retard);

	DUT4: portaand3 PORT MAP(a, c, xor_ad_logica, beta_logica);
	DUT4_LR: portaand3 PORT MAP(a, c, xor_ad_logica_retard, beta_logica_retard);

	DUT5: portaor2 PORT MAP(beta_logica, alpha_logica, f1);
	DUT5_LR: portaor2 PORT MAP(beta_logica_retard, alpha_logica_retard, f2);

END estructural;

---------------------------------------------------------------------
---------------------------------------------------------------------

ENTITY banc_de_proves IS
END banc_de_proves;


ARCHITECTURE test_de_proves OF banc_de_proves IS

COMPONENT bloc_que_simulem IS
PORT(a,b,c,d: IN BIT;
	   f1: OUT BIT;
	   f2: OUT BIT);
END COMPONENT;

SIGNAL ent3, ent2, ent1, ent0, sort_logica, sort_logica_retard, sort_estructural: BIT;
FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_2(logica);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_2(logicaretard);
FOR DUT3: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural);

BEGIN
	DUT1: bloc_que_simulem PORT MAP(ent3, ent2, ent1, ent0, sort_logica );
	DUT2: bloc_que_simulem PORT MAP(ent3, ent2, ent1, ent0, sort_logica_retard);
	DUT3: bloc_que_simulem PORT MAP(ent3, ent2, ent1, ent0, sort_estructural);

PROCESS (ent3, ent2, ent1, ent0)

BEGIN
ent3 <= NOT ent3 AFTER 40 ns;
ent2 <= NOT ent2 AFTER 20 ns;
ent1 <= NOT ent1 AFTER 10 ns;
ent0 <= NOT ent0 AFTER 5 ns;

END PROCESS;
END test_de_proves;

---- EXERCICI C : A parte de un atraso de la función, la salida lógica cambia de 0 a 1 sin una frecuencia periódica, 
----              mientras que la salida logicaretard sí lo hace cada 200 ns. En el caso de la logica, a los 100 ns se
----              estrablece a 1 y a 150 vuelve a ser 0, tambien entre 300 y 400 ns está a 1 y entre 700 y 750 ns.
----
---- EXERCICI D: Al establecer los cambios de las entidades cada 5 ns entre ellos, podemos apreciar cierta peridiocidad
----             en la salida logica con periodos en 1 de 5, 10, 5, 5 y 10 ns (con periodos a 0 de 15 y 40 ns entre ellos).

