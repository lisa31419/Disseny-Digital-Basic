---- ENTITY Sumador de 1 bit
ENTITY sum_1_bit IS
PORT (c_in,a,b: IN BIT;
       c_out,s: OUT BIT);
END sum_1_bit;

---- ARQUITECTURA ESTRUCTURAL Sumador de 1 bit
ARCHITECTURE estructural OF sum_1_bit IS

-- AND2 --
COMPONENT porta_and2 IS
PORT (a,b: IN BIT;
	f: OUT BIT);
END COMPONENT;

-- OR2 --
COMPONENT porta_or2 IS
PORT (a,b: IN BIT;
	f: OUT BIT);
END COMPONENT;

-- NOT --
COMPONENT porta_not IS
PORT (a: IN BIT;
      f: OUT BIT);
END COMPONENT;

SIGNAL a_inv, b_inv, gamma_inv, c_in_inv, alpha, alpha_2, beta, beta_2,gamma, sort_and2_1, sort_and2_2, sort_c_out, sort_s: BIT;
	--- XOR num.1 --
	FOR DUT1: porta_not USE ENTITY WORK.inv(logicaretard);
	FOR DUT2: porta_not USE ENTITY WORK.inv(logicaretard);
	FOR DUT3: porta_and2 USE ENTITY WORK.and2(logicaretard);
	FOR DUT4: porta_and2 USE ENTITY WORK.and2(logicaretard);
	FOR DUT5: porta_or2 USE ENTITY WORK.or2(logicaretard);

	--- AND num.1 ---
	FOR DUT6: porta_and2 USE ENTITY WORK.and2(logicaretard);

	--- AND num.2 ---
	FOR DUT7: porta_and2 USE ENTITY WORK.and2(logicaretard);

	--- OR ---
	FOR DUT8: porta_or2 USE ENTITY WORK.or2(logicaretard);

	--- XOR num.2 --
	FOR DUT9: porta_not USE ENTITY WORK.inv(logicaretard);
	FOR DUT10: porta_not USE ENTITY WORK.inv(logicaretard);
	FOR DUT11: porta_and2 USE ENTITY WORK.and2(logicaretard);
	FOR DUT12: porta_and2 USE ENTITY WORK.and2(logicaretard);
	FOR DUT13: porta_or2 USE ENTITY WORK.or2(logicaretard);	

	
BEGIN
	--- XOR num.1 --
	DUT1: porta_not PORT MAP (a,a_inv);
	DUT2: porta_not PORT MAP (b,b_inv);
	DUT3: porta_and2 PORT MAP (a,b_inv,alpha);
	DUT4: porta_and2 PORT MAP (a_inv,b,beta);
	DUT5: porta_or2 PORT MAP (alpha,beta,gamma);

	--- AND num.1 ---
	DUT6: porta_and2 PORT MAP (c_in,a,sort_and2_1);

	--- AND num.2 ---
	DUT7: porta_and2 PORT MAP (c_in,gamma,sort_and2_2);

	--- OR ---
	DUT8: porta_or2 PORT MAP (sort_and2_1,sort_and2_2,sort_c_out);
	
	--- XOR num.2 --
	DUT9: porta_not PORT MAP (gamma,gamma_inv);
	DUT10: porta_not PORT MAP (c_in,c_in_inv);
	DUT11: porta_and2 PORT MAP (gamma,c_in_inv,alpha_2);
	DUT12: porta_and2 PORT MAP (gamma_inv,c_in,beta_2);
	DUT13: porta_or2 PORT MAP (alpha_2,beta_2,sort_s);

c_out <= sort_c_out;
s <= sort_s;


END estructural;

---- ENTITY CIRCUIT
ENTITY circuit is
PORT (x,y,ck: IN BIT;
   Q1,Z,sort: OUT BIT);
END circuit;

---- ARQUITECTURA ESTRUCTURAL Circuit
ARCHITECTURE estructural OF circuit IS

---- FF_T BAIXADA ----

COMPONENT FF_T_Baixada IS
PORT(T, Clk, Pre: IN BIT; 
	       Q: OUT BIT);
END COMPONENT;

---- SUMADOR 1 BIT ----
COMPONENT sum_1_bit IS
PORT(c_in, a, b: IN BIT;
       c_out, s: OUT BIT);
END COMPONENT;

---- FF_D PUJADA ----

COMPONENT FF_JK_Pujada IS
PORT(J, K, Clk, Pre, Clr: IN BIT; 
	     	       Q: OUT BIT);
END COMPONENT;

SIGNAL q_1, q_2, c_out, s: BIT;
	FOR DUT1: FF_T_Baixada USE ENTITY WORK.T_Bajada_PreClr(ifthen);
	FOR DUT2: sum_1_bit USE ENTITY WORK.sum_1_bit(estructural);
	FOR DUT3: FF_JK_Pujada USE ENTITY WORK.JK_Pujada_PreClr(ifthen);
BEGIN
	DUT1: FF_T_Baixada PORT MAP(x,ck,y,q_1);
	DUT2: sum_1_bit PORT MAP(q_1,ck,ck,c_out,s);
	DUT3: FF_JK_Pujada PORT MAP(s,c_out,ck,'1','1',q_2);
 
Q1 <= q_1;
Z <= q_2;
sort <= s;
 
END estructural;

---- BANC DE PROVES
ENTITY banc_proves IS
END banc_proves;

ARCHITECTURE test OF banc_proves IS

COMPONENT bloc_que_simulem IS
PORT (x,y,ck: IN BIT;
   Q1,Z,sort: OUT BIT);
END COMPONENT;

SIGNAL x,y,ck,Q1,Z,sort: BIT;
FOR DUT1: bloc_que_simulem USE ENTITY WORK.circuit(estructural);

BEGIN
	DUT1: bloc_que_simulem PORT MAP(x,y,ck,Q1,Z,sort);
	
PROCESS (ck)
BEGIN
ck <= NOT ck AFTER 50 ns;


END PROCESS;

---- X -----
PROCESS
BEGIN

x <= '1';
WAIT FOR 120 ns;

x <= '0';
WAIT FOR 35 ns;

x <= '1';
WAIT FOR 85 ns;

x <= '0';
WAIT FOR 70 ns;

x <= '1';
WAIT FOR 30 ns;

x <= '0';
WAIT FOR 85 ns;

x <= '1';
WAIT FOR 90 ns;

x <= '0';
WAIT FOR 30 ns;

x <= '1';
WAIT FOR 30 ns;

x <= '0';
WAIT FOR 30 ns;

x <= '1';
WAIT FOR 65 ns;

x <= '0';
WAIT FOR 60 ns;

END PROCESS;


---- Y ----
PROCESS
BEGIN
y <= '1';
WAIT FOR 67 ns;

y <= '0';
WAIT FOR 16 ns;

y <= '1';
WAIT FOR 282 ns;

y <= '0';
WAIT FOR 64 ns;

y <= '1';
WAIT FOR 190 ns;

y <= '0';
WAIT FOR 65 ns;

END PROCESS;
END test;