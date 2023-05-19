

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY RAM IS
  PORT (
 clock   : in STD_LOGIC;
          address : in STD_LOGIC_VECTOR (2 downto 0);
          CS      : in STD_LOGIC;
          WE      : in STD_LOGIC;
          data_in : in STD_LOGIC_VECTOR (15 downto 0);
          data_out: out STD_LOGIC_VECTOR (15 downto 0)
    );
END RAM;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF RAM IS
    type memory_array is array (0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
    signal memory_map: memory_array;
    signal read_address: integer range 0 to 15 := 0;
BEGIN
process(clock)
begin 
if rising_edge(clock) then
	if  CS = '1' then
		  if WE = '1' then 
                    memory_map(to_integer(unsigned(address))) <= data_in;
                else
                    read_address <= to_integer(unsigned(address));
                    data_out <= memory_map(read_address);
                end if;
	end if;
end if;

end process;


END TypeArchitecture;