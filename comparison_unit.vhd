library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity comparison_unit is
    Port (
        data_in_1: in std_logic_vector(31 downto 0);
        data_in_2: in std_logic_vector(31 downto 0);
        result: out std_logic_vector(2 downto 0)
    );
end comparison_unit;

architecture Behavioural of comparison_unit is

    signal result_signal: std_logic_vector(2 downto 0);
    signal diff: std_logic_vector(7 downto 0);
begin

    process(data_in_1, data_in_2) 
        variable exponent_1: std_logic_vector(7 downto 0);
        variable exponent_2: std_logic_vector(7 downto 0);
        variable differerence: std_logic_vector(7 downto 0);
    begin
        exponent_1 := data_in_1(30 downto 23);
        exponent_2 := data_in_2(30 downto 23);

        if exponent_1 = exponent_2 then -- equality case
            result_signal <= "000";
        elsif (exponent_1 > exponent_2) then
            differerence := exponent_1 - exponent_2;
            diff <= differerence;
            if differerence < 23 then
                result_signal <= "001";
            else 
                result_signal <= "011";
            end if;
        elsif (exponent_2 > exponent_1) then
            differerence := exponent_2 - exponent_1;
            
            if differerence < 23 then
                result_signal <= "010";
            else 
                result_signal <= "100";
            end if;
        else
            result_signal <= "111";
        end if;
    end process;

    result <= result_signal;

end Behavioural;