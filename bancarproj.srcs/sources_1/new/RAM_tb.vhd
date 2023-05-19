library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity RAM_tb is
end;

architecture bench of RAM_tb is

  component RAM
    PORT (
   clock   : in STD_LOGIC;
            address : in STD_LOGIC_VECTOR (2 downto 0);
            CS      : in STD_LOGIC;
            WE      : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR (15 downto 0);
            data_out: out STD_LOGIC_VECTOR (15 downto 0)
      );
  end component;

  signal clock: STD_LOGIC;
  signal address: STD_LOGIC_VECTOR (2 downto 0);
  signal CS: STD_LOGIC;
  signal WE: STD_LOGIC;
  signal data_in: STD_LOGIC_VECTOR (15 downto 0);
  signal data_out: STD_LOGIC_VECTOR (15 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: RAM port map ( clock    => clock,
                      address  => address,
                      CS       => CS,
                      WE       => WE,
                      data_in  => data_in,
                      data_out => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
 -- Initialization
    CS <= '0';
    WE <= '0';
    data_in <= (others => '0');
    address <= (others => '0');
    wait for clock_period * 2;

    -- Write data to the RAM
    for i in 0 to 7 loop
      CS <= '1';
      WE <= '1';
      data_in <= std_logic_vector(to_unsigned(i * 2, data_in'length));
      address <= std_logic_vector(to_unsigned(i, address'length));
      wait for clock_period;
      CS <= '0';
      WE <= '0';
      wait for clock_period;
    end loop;

    -- Read data from the RAM
    for i in 0 to 7 loop
      CS <= '1';
      WE <= '0';
      address <= std_logic_vector(to_unsigned(i, address'length));
      wait for clock_period;
      assert data_out = std_logic_vector(to_unsigned(i * 2, data_out'length))
        report "Mismatch at address " & integer'image(i)
        severity ERROR;
      CS <= '0';
      wait for clock_period;
    end loop;
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;