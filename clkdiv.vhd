-- Project includes following features
-- Making 25 and 10 Mhz clock divider by using 50 Mhz FPGA clock 
-- Depending on divided clock frequencies it has 2 up and down counter and also has synchronous reset and enable mod.
-- If you would like to change output frequencies, it is enough to change generic parameters.
-- If you see any mistakes ,feel free to contact with me via e-mail at erdemkiral@gmail.com.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkdiv is
generic(
		c_clkfreq    : integer := 50_000_000; -- 20 ns
		c_clk2freq   : integer := 25_000_000; -- 40 ns
		c_clk3freq   : integer := 10_000_000; -- 100 ns 

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
end clkdiv;

architecture Behavioral of clkdiv is

constant c_frstclklim   : integer := c_clkfreq/c_clk2freq;  -- first frequency is set to 25 MHz,40 ns
constant c_scndclklim   : integer := c_clkfreq/c_clk3freq;  -- first frequency is set to 10 MHz ,100 ns 

signal   frstclk     : integer range 0 to c_clkfreq/c_clk2freq := 0 ;
signal   scndclk     : integer range 0 to c_clkfreq/c_clk3freq := 0 ;
	     
signal   frstclk_reg : std_logic := '0' ;
signal   scndclk_reg : std_logic := '0' ;

signal   data1_reg   : std_logic_vector (3 downto 0) := (others =>'0');
signal   data2_reg   : std_logic_vector (3 downto 0) := (others =>'0');

begin

P_CLKDIV : process(clk) begin
 
if(rising_edge(clk)) then 
	
 if(en= '1') then 
	if(frstclk = c_frstclklim-1) then 
		frstclk_reg <= not(frstclk_reg);
		frstclk <= 0 ;
	else 
		frstclk <= frstclk +1;
	end if;
	
	if(scndclk = c_scndclklim-1) then 
		scndclk_reg <= not(scndclk_reg);
		scndclk <= 0;
	else 
		scndclk <= scndclk +1;
	end if;
	
  end if;
end if;
end process P_CLKDIV;


P_FIRSTCOUNTER : process(frstclk_reg) begin

if(rising_edge(frstclk_reg)) then 
 if(reset = '1') then
 
 	data1_reg <= "0000";
 end if;
 
 if(en= '1') then 			

		if(increment = '1') then 
			
			data1_reg <= data1_reg +1;
			if(data1_reg = "1111") then 
				data1_reg <= "0000";
			elsif(reset = '1') then 
				data1_reg <= "0000";
		end if;
			
		if(decrement = '1') then 
			
			data1_reg <= data1_reg - 1;
			if(data1_reg = "0000") then 
				data1_reg <= "1111";
			elsif(reset = '1') then 
				data1_reg <= "0000";
				
		end if;
		
	  end if;
	end if;
  end if;
end if;
end process P_FIRSTCOUNTER;

P_SECONDCOUNTER : process(scndclk_reg) begin

if(rising_edge(scndclk_reg)) then 
		
		if(reset = '1') then
			data2_reg <= "0000";
		end if;
		
    if(en= '1') then 
	
		if(increment = '1') then 
			data2_reg <= data2_reg +1;
			if(data2_reg = "1111") then 
				data2_reg <= "0000";
			elsif(reset = '1') then
				data2_reg <= "0000";
			end if;
		end if;
			
		if(decrement = '1') then 
			data2_reg <= data2_reg - 1;
			if(data2_reg = "0000") then 
				data2_reg <= "1111";
			elsif(reset = '1') then
				data2_reg <= "0000";
			end if;
			
	     end if;
  
    end if;
end if;
end process P_SECONDCOUNTER;

 data1 <= data1_reg ;
 data2 <= data2_reg ;

end Behavioral;
