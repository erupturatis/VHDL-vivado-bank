

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Add this line


entity AUTOMAT is
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
        ---output    : out STD_LOGIC_VECTOR (15 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        cat : out STD_LOGIC_VECTOR (6 downto 0)
    );
end AUTOMAT;

architecture Behavioral of AUTOMAT is

    type state_type is (initial_state, introduce_state);
    signal state : state_type;
    signal balance, introduced_sum: STD_LOGIC_VECTOR(15 downto 0);
    signal output :  STD_LOGIC_VECTOR (15 downto 0);
    
    component SSD is
        Port (
            CLK : in STD_LOGIC;
            digit0 : in STD_LOGIC_VECTOR (3 downto 0);
            digit1 : in STD_LOGIC_VECTOR (3 downto 0);
            digit2 : in STD_LOGIC_VECTOR (3 downto 0);
            digit3 : in STD_LOGIC_VECTOR (3 downto 0);
            an : out STD_LOGIC_VECTOR (3 downto 0);
            cat : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
   
    
begin

inst:SSD port map (
     CLK => clk,
     digit0 => output(3 downto 0),
     digit1 => output(7 downto 4),
     digit2 => output(11 downto 8),
     digit3 => output(15 downto 12),
     AN => AN,
     CAT => CAT
);

process (clk, reset_n)
    
    begin
        if reset_n = '0' then
            state <= initial_state;
            balance <= (others => '0');
            introduced_sum <= (others => '0');
        elsif rising_edge(clk) then
        
            case state is
                when initial_state =>
                 
                    if introduceSum = '1' then
                        state <= introduce_state;
                    end if;

                when introduce_state =>
                    if increaseSum1 = '1' then
                        introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) + 1);
                    end if;
                    if increaseSum10 = '1' then
                        introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) + 10);
                    end if;
                    if increaseSum100 = '1' then
                        introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) + 100);
                    end if;
                    if decreaseSum1 = '1' then
                        if UNSIGNED(introduced_sum) >= 1 then
                            introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) - 1);
                        end if;
                    end if;
                    if decreaseSum10 = '1' then
                         if UNSIGNED(introduced_sum) >= 10 then
                            introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) - 10);
                        end if;
                    end if;
                    if decreaseSum100 = '1' then
                         if UNSIGNED(introduced_sum) >= 100 then
                            introduced_sum <= STD_LOGIC_VECTOR(UNSIGNED(introduced_sum) - 100);
                        end if;
                    end if;
                    
                    if addFromSum = '1' then
                        balance <= STD_LOGIC_VECTOR(UNSIGNED(balance) + UNSIGNED(introduced_sum));
                        state <= initial_state;
                        introduced_sum <= (others => '0');
                    end if;
                    if substractFromSum = '1' then
                        if UNSIGNED(balance) >= UNSIGNED(introduced_sum) then
                            balance <= STD_LOGIC_VECTOR(UNSIGNED(balance) - UNSIGNED(introduced_sum));
                        end if;
                        if UNSIGNED(balance) < UNSIGNED(introduced_sum) then
                            balance <=  (others => '0');
                        end if;
                        state <= initial_state;
                        introduced_sum <= (others => '0');
                    end if;
                        
            end case;
        end if;
         if state = initial_state then
            output <= balance;
        elsif state = introduce_state then
            output <= introduced_sum;
    end if;
    end process;

end Behavioral;
