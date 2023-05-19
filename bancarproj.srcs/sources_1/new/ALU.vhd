library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           RES : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is


begin

  process (A, B, SEL)
        variable temp_result : STD_LOGIC_VECTOR (7 downto 0);
    begin
        if SEL = "000" then  
            temp_result := "00S00" & (A + B);
        elsif SEL = "001" then  
            temp_result := "0000" & (A - B);
        elsif SEL = "010" then  -- Shift Left 
            temp_result := "0000" &(A(2 downto 0) & "0");
        elsif SEL = "011" then  -- Shift Right 
            temp_result := "00000" &(A(3 downto 1) );
        elsif SEL = "100" then  -- Rotate Left (ROL)
            temp_result := "000" &(A(3 downto 0) & "0");
        elsif SEL = "101" then  
            temp_result := A * B;
        elsif SEL = "110" then  
            if B /= "0000" then
               -- nu am stiut la diviziune ca nu ma lasa cu /
            else
                temp_result := (others => 'X');
            end if;
        else  -- Undefined operation
            temp_result := (others => 'X');
        end if;
        RES <= temp_result;
    end process;
end Behavioral;