library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity tb_alu8bit is
end tb_alu8bit;

architecture Behavioral of tb_alu8bit is
  
component alu8bit is
port ( 
		  data1_i : in std_logic_vector (7 downto 0);
		  data2_i : in std_logic_vector (7 downto 0);
	    optype_i : in std_logic_vector (2 downto 0);
	    data_o   : out std_logic_vector(7 downto 0)
);
end component;
  
signal data1_i  : std_logic_vector (7 downto 0) := (others => '0');
signal data2_i  : std_logic_vector (7 downto 0) := (others => '0');
signal optype_i : std_logic_vector (2 downto 0) := (others => '0');
signal data_o   : std_logic_vector(7 downto 0);
constant clkperiod : time := 20 ns;

begin

TEST_UNIT : alu8bit 
port map ( 
		data1_i  => data1_i ,
		data2_i  => data2_i ,
	  optype_i => optype_i,
	  data_o   => data_o  
);

P_SIM : process begin 

for i in 0 to 255 loop 
	data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  optype_i <= "000" ;
	wait for clkperiod ;
end loop;

for i in 0 to 255 loop 
	data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	data1_i(3 downto 0)  <= data1_i(3 downto 0) + 2;
	data2_i(7 downto 4)  <= data2_i(7 downto 4) + 3;
	data2_i(3 downto 0)  <= data2_i(3 downto 0) + 4;
  optype_i <= "001" ;
	wait for clkperiod ;
end loop; 
    
-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "010" ;
	-- wait for clkperiod ;
-- end loop; 
  
-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "011" ;
	-- wait for clkperiod ;
-- end loop; 


-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "100" ;
	-- wait for clkperiod ;
-- end loop; 


-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "101" ;
	-- wait for clkperiod ;
-- end loop; 


-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "110" ;
	-- wait for clkperiod ;
-- end loop; 

-- for i in 0 to 255 loop 
	-- data1_i(7 downto 4)  <= data1_i(7 downto 4) + 1;
	-- data1_i(3 downto 0)  <= data1_i(3 downto 0) + 1;
	-- data2_i(7 downto 4)  <= data2_i(7 downto 4) + 1;
	-- data2_i(3 downto 0)  <= data2_i(3 downto 0) + 1;
  -- optype_i <= "111" ;
	-- wait for clkperiod ;
-- end loop; 

assert false 
report "SIM DONE"
severity failure;
end process P_SIM;
end Behavioral;
