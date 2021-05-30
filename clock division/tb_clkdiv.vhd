library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_clkdiv is
generic(
			c_clkfreq  : integer := 50_000_000;
			c_clk2freq : integer := 25_000_000; 
			c_clk3freq : integer := 10_000_000
	
);

end tb_clkdiv;

architecture Behavioral of tb_clkdiv is

component clkdiv is
generic(
		c_clkfreq  : integer := 50_000_000;  -- 20 ns
		c_clk2freq : integer := 25_000_000; -- 40 ns
		c_clk3freq : integer := 10_000_000 -- 100 ns 
);
port ( 
		  clk  : in std_logic;
		  en   : in std_logic;
	increment  : in std_logic;
	decrement  : in std_logic;
	    reset  : in std_logic;
	    data1  : out std_logic_vector (3 downto 0);
		data2  : out std_logic_vector (3 downto 0)
	
);
end component;

signal 		  clk  : std_logic := '0';
signal 		  en   : std_logic := '0';
signal 	increment  : std_logic := '0';
signal 	decrement  : std_logic := '0';
signal 	    reset  : std_logic := '0';
signal 	    data1  : std_logic_vector (3 downto 0);		
signal 		data2  : std_logic_vector (3 downto 0);

constant clkperiod : time := 20 ns;

begin


TEST : clkdiv 
generic map (
		c_clkfreq  => c_clkfreq ,
		c_clk2freq => c_clk2freq,
		c_clk3freq => c_clk3freq
)
port map ( 
		  clk  => clk       ,
		  en   => en        ,
	increment  => increment ,
	decrement  => decrement ,
	    reset  => reset     ,
	    data1  => data1     ,
		data2  => data2
	
);


P_CLKGEN : process begin 

clk <= '0';
wait for clkperiod/2;
clk <= '1';
wait for clkperiod/2;
				

end process P_CLKGEN;

P_SIM : process begin 
	
	en <= '1';
	increment <= '1';
	wait for clkperiod*350;

	
	
assert false
report "SIM DONE"	  
severity failure ; 

end process P_SIM;

end Behavioral;
