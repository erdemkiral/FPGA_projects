library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_uart_tx is
generic(
		c_clkfreq  		: integer := 100_000_000;
		c_baudrate 		: integer := 115_200;
		c_stopbitcount  : integer := 2
);
end tb_uart_tx;

architecture Behavioral of tb_uart_tx is

component uart_tx is
generic(
		c_clkfreq  		: integer := 100_000_000;
		c_baudrate 		: integer := 115_200;
		c_stopbitcount  : integer := 2
);
port( 
	  clk 	       : in std_logic;
	  tx_data      : in std_logic_vector(7 downto 0);
	  tx_start     : in std_logic;
	  tx_o	       : out std_logic;
	  tx_done_tick : out std_logic	  
	  );
end component;

signal clk 	       	  : std_logic := '0';
signal tx_data     	  : std_logic_vector(7 downto 0) := (others=>'0');
signal tx_start    	  : std_logic := '0';
signal tx_o	       	  : std_logic; 
signal tx_done_tick	  : std_logic; 

constant clkperiod : time := 10 ns ;

begin

TEST_U : uart_tx 
generic map(
		c_clkfreq  		=> c_clkfreq , 		
		c_baudrate 		=> c_baudrate, 		
		c_stopbitcount  => c_stopbitcount 
)
port map( 
	  clk 	       =>   clk 	 ,      
	  tx_data      =>   tx_data  ,    
	  tx_start     =>   tx_start ,    
	  tx_o	       =>   tx_o	,
	  tx_done_tick =>  tx_done_tick
	  );


P_CLKGEN : process begin
clk	<= '0';
wait for clkperiod/2;
clk	<= '1';
wait for clkperiod/2;

end process P_CLKGEN;



P_STIMULI : process begin

tx_data		<= x"51";
tx_start	<= '0';
wait for clkperiod;
tx_start	<= '1';

wait until (rising_edge(tx_done_tick));
tx_start <= '0';
wait for 5*clkperiod;

tx_data		<= x"A3";
tx_start	<= '0';
wait for clkperiod;
tx_start	<= '1';

wait until (rising_edge(tx_done_tick));
tx_start <= '0';
wait for 5*clkperiod;

tx_data		<= x"c9";
tx_start	<= '0';
wait for clkperiod;
tx_start	<= '1';

wait until (rising_edge(tx_done_tick));


assert false
report "SIM DONE"
severity failure;


end process P_STIMULI;


end Behavioral;
