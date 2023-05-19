-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity AUTOMAT_tb is
end;

architecture bench of AUTOMAT_tb is

  component AUTOMAT
      Port (
          clk           : in STD_LOGIC;
          reset_n       : in STD_LOGIC;
          introduceSum  : in STD_LOGIC;
          increaseSum1   : in STD_LOGIC;
          increaseSum10   : in STD_LOGIC;
          increaseSum100   : in STD_LOGIC;
          decreaseSum1   : in STD_LOGIC;
          decreaseSum10   : in STD_LOGIC;
          decreaseSum100   : in STD_LOGIC; 
          addFromSum    : in STD_LOGIC;
          substractFromSum : in STD_LOGIC;
          an : out STD_LOGIC_VECTOR (3 downto 0);
          cat : out STD_LOGIC_VECTOR (6 downto 0)
      );
  end component;

  signal clk: STD_LOGIC;
  signal reset_n: STD_LOGIC;
  signal introduceSum: STD_LOGIC;
  signal increaseSum1: STD_LOGIC;
  signal increaseSum10: STD_LOGIC;
  signal increaseSum100: STD_LOGIC;
  signal decreaseSum1: STD_LOGIC;
  signal decreaseSum10: STD_LOGIC;
  signal decreaseSum100: STD_LOGIC;
  signal addFromSum: STD_LOGIC;
  signal substractFromSum: STD_LOGIC;
  signal an: STD_LOGIC_VECTOR (3 downto 0);
  signal cat: STD_LOGIC_VECTOR (6 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: AUTOMAT port map ( clk              => clk,
                          reset_n          => reset_n,
                          introduceSum     => introduceSum,
                          increaseSum1     => increaseSum1,
                          increaseSum10    => increaseSum10,
                          increaseSum100   => increaseSum100,
                          decreaseSum1     => decreaseSum1,
                          decreaseSum10    => decreaseSum10,
                          decreaseSum100   => decreaseSum100,
                          addFromSum       => addFromSum,
                          substractFromSum => substractFromSum,
                          an               => an,
                          cat              => cat );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset_n <= '0';
    wait for 5 ns;
    reset_n <= '1';
    wait for 5 ns;
    
      -- Test for introduceSum
  introduceSum <= '1';
  wait for clock_period;
  introduceSum <= '0';
  wait for clock_period;

  -- Test for increaseSum1
  increaseSum1 <= '1';
  wait for clock_period;
  increaseSum1 <= '0';
  wait for clock_period;

  -- Test for increaseSum10
  increaseSum10 <= '1';
  wait for clock_period;
  increaseSum10 <= '0';
  wait for clock_period;

  -- Test for increaseSum100
  increaseSum100 <= '1';
  wait for clock_period;
  increaseSum100 <= '0';
  wait for clock_period;

  -- Test for addFromSum
  addFromSum <= '1';
  wait for clock_period;
  addFromSum <= '0';
  wait for clock_period;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  