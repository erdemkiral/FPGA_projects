library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_uart_rx is
generic(
		clkfreq  : integer := 100_000_000;
		baudrate : integer := 115_200
);
end tb_uart_rx;

architecture Behavioral of tb_uart_rx is


component uart_rx is
generic(
		clkfreq  : integer := 100_000_000;
		baudrate : integer := 115_200
);
port ( 
		clk 	: in  std_logic;
		rx_i	: in  std_logic;
		data	: out std_logic_vector(7 downto 0);
		rx_done	: out std_logic
);
end component;

signal clk 		: std_logic := '0';
signal rx_i		: std_logic := '0';
signal data		: std_logic_vector(7 downto 0);
signal rx_done	: std_logic;

constant clkperiod 	: time := 10 ns;
constant baud115200 : time := 8.68 us ;

constant hex48 : std_logic_vector (9 downto 0) := '1' & x"48" & '0'; 


begin


TEST_U : uart_rx
generic map (
		clkfreq   => clkfreq ,
		baudrate  => baudrate 
)
port map ( 
		clk 	=> clk 	,
		rx_i	=> rx	,	
		data	=> data ,
		rx_done	=> rx_done
);


P_CLKGEN : process begin
clk	<= '0';
wait for clkperiod/2;
clk	<= '1';
wait for clkperiod/2;

end process P_CLKGEN;



P_STIMULI : process begin

wait for 10*clkperiod;
for i in 0 to 9 loop  rx_i <= hex48(i); wait for baud115200; end loop; -- h

assert false
report "SIM DONE"
severity failure;

end process P_STIMULI;




end Behavioral;
