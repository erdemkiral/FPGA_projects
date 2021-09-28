library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity alu8bit is
generic(
	c_datalength : integer := 8

);	
port ( 
	    data1_i  : in  std_logic_vector (c_datalength -1 downto 0);
	    data2_i  : in  std_logic_vector (c_datalength -1 downto 0);
	    optype_i : in  std_logic_vector (2 downto 0);
	    data_o   : out std_logic_vector(c_datalength -1 downto 0)
);
end alu8bit;

architecture Behavioral of alu8bit is

constant negative_sign 				: std_logic := '1';
constant positive_sign 				: std_logic := '0';
signal   data1_i_signbit,data2_i_signbit  	: std_logic ;
signal   data1_i_mag,data2_i_mag 		: unsigned (c_datalength -2 downto 0);
signal   substract,sum 				: std_logic_vector(c_datalength -1 downto 0);

begin

data1_i_signbit <= data1_i(c_datalength -1); 
data2_i_signbit <= data2_i(c_datalength -1);
data1_i_mag <= unsigned (data1_i(c_datalength -2 downto 0));
data2_i_mag <= unsigned (data2_i(c_datalength -2 downto 0));
 
  
  
sum  <=  negative_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '1') and (data1_i_mag < data2_i_mag) else
	 negative_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '1') and (data1_i_mag = data2_i_mag) else
	 negative_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '1') and (data1_i_mag > data2_i_mag) else 
															   
	 positive_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '0') and (data1_i_mag > data2_i_mag) else
	 positive_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '0') and (data1_i_mag = data2_i_mag) else
	 positive_sign& std_logic_vector(data1_i_mag+data2_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '0') and (data1_i_mag < data2_i_mag) else
															  
	 negative_sign& std_logic_vector(data1_i_mag-data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '0') and (data1_i_mag > data2_i_mag) else
	 positive_sign& std_logic_vector(data1_i_mag-data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '0') and (data1_i_mag < data2_i_mag) else
	 
	 negative_sign&std_logic_vector(data2_i_mag-data1_i_mag)  when (data1_i_signbit = '0' and data2_i_signbit = '1') and (data1_i_mag < data2_i_mag) else
	 positive_sign&std_logic_vector(data1_i_mag-data2_i_mag)  when (data1_i_signbit = '0' and data2_i_signbit = '1') and (data1_i_mag > data2_i_mag) else
	 x"00";
		 



substract <=   positive_sign & std_logic_vector(data2_i_mag-data1_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '1') and (data1_i_mag < data2_i_mag) else
	       negative_sign & std_logic_vector(data1_i_mag-data2_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '1') and (data1_i_mag > data2_i_mag) else
	       			  										
	       positive_sign & std_logic_vector(data1_i_mag-data2_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '0') and (data1_i_mag > data2_i_mag) else 
	       negative_sign & std_logic_vector(data2_i_mag-data1_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '0') and (data1_i_mag < data2_i_mag) else
	       			  												
	       negative_sign & std_logic_vector(data2_i_mag+data1_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '0') and (data1_i_mag > data2_i_mag) else
	       positive_sign & std_logic_vector(data2_i_mag-data1_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '0') and (data1_i_mag < data2_i_mag) else
	       negative_sign & std_logic_vector(data2_i_mag+data1_i_mag) when (data1_i_signbit = '1' and data2_i_signbit = '0') and (data1_i_mag = data2_i_mag) else
	       			  												
	       positive_sign & std_logic_vector(data2_i_mag+data1_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '1') and (data1_i_mag < data2_i_mag) else
	       positive_sign & std_logic_vector(data2_i_mag+data1_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '1') and (data1_i_mag > data2_i_mag) else
	       positive_sign & std_logic_vector(data2_i_mag+data1_i_mag) when (data1_i_signbit = '0' and data2_i_signbit = '1') and (data1_i_mag = data2_i_mag) else
	       x"00"; 

        
data_o <=    sum		                		when optype_i = "000" else 
	     substract 			        		when optype_i = "001" else 
	     not data1_i					when optype_i = "010" else 
	     data1_i	and data2_i				when optype_i = "011" else 
	     data1_i	or data2_i				when optype_i = "100" else 
	     data1_i	xor data2_i				when optype_i = "101" else
	     data1_i(c_datalength -1 downto 1)	& '0'		when optype_i = "110" else 		   
	     '0' &	data1_i(c_datalength -1  downto 1)	when optype_i = "111" else 		   
	      x"00";
		   


end Behavioral;
