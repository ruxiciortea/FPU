library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity normalization_unit is
    Port ( 
        data_in: in std_logic_vector(31 downto 0);
        operand_in: in std_logic_vector(31 downto 0);
        overflow: in std_logic;
        performed_operation: in std_logic;
        data_out: out std_logic_vector(31 downto 0);
        exceptions: out std_logic_vector(1 downto 0)
    );
end normalization_unit;

architecture Behavioral of normalization_unit is

begin

    process (data_in, overflow, performed_operation)
    
        variable data_out_aux: std_logic_vector(31 downto 0);
        variable operand_exponent_in: std_logic_vector(7 downto 0);
    
    begin        
        operand_exponent_in := operand_in(30 downto 23) - "00000001";
    
        if performed_operation = '0' then
            if overflow = '1' then 
                data_out_aux := data_in;
            else
                -- shift left once
                data_out_aux := data_in(31) & data_in(30 downto 23) - "00000001" & data_in(21 downto 0) & '0';
            end if;
        else
            -- shift left until no leading zeros and then one more time
            data_out_aux := data_in(31) & data_in(30 downto 23) - "00000001" & data_in(21 downto 0) & '0';
            
            if data_in(22) = '1' then
                data_out <= data_out_aux;
            elsif data_in(21) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000001" & data_out_aux(21 downto 0) & '0';
            elsif data_in(20) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000010" & data_out_aux(20 downto 0) & "00";
            elsif data_in(19) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000011" & data_out_aux(19 downto 0) & "000";
            elsif data_in(18) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000100" & data_out_aux(18 downto 0) & "0000";
            elsif data_in(17) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000101" & data_out_aux(17 downto 0) & "00000";
            elsif data_in(16) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000110" & data_out_aux(16 downto 0) & "000000";
            elsif data_in(15) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00000111" & data_out_aux(15 downto 0) & "0000000";
            elsif data_in(14) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001000" & data_out_aux(14 downto 0) & "00000000";
            elsif data_in(13) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001001" & data_out_aux(13 downto 0) & "000000000";
            elsif data_in(12) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001010" & data_out_aux(12 downto 0) & "0000000000";
            elsif data_in(11) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001011" & data_out_aux(11 downto 0) & "00000000000";
            elsif data_in(10) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001100" & data_out_aux(10 downto 0) & "000000000000";
            elsif data_in(9) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001101" & data_out_aux(9 downto 0) & "0000000000000";
            elsif data_in(8) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001110" & data_out_aux(8 downto 0) & "00000000000000";
            elsif data_in(7) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00001111" & data_out_aux(7 downto 0) & "000000000000000";
            elsif data_in(6) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010000" & data_out_aux(6 downto 0) & "0000000000000000";
            elsif data_in(5) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010001" & data_out_aux(5 downto 0) & "00000000000000000";
            elsif data_in(4) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010010" & data_out_aux(4 downto 0) & "000000000000000000";
            elsif data_in(3) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010011" & data_out_aux(3 downto 0) & "0000000000000000000";
            elsif data_in(2) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010100" & data_out_aux(2 downto 0) & "00000000000000000000";
            elsif data_in(1) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010101" & data_out_aux(1 downto 0) & "000000000000000000000";
            elsif data_in(0) = '1' then
                data_out_aux := data_out_aux(31) & data_out_aux(30 downto 23) - "00010110" & data_out_aux(0 downto 0) & "0000000000000000000000";
            end if;            
        end if;
        
        if data_in = x"00000000" or data_in = x"80000000" then
            exceptions <= "01";
            data_out_aux := data_in;
        end if;
        
        if performed_operation = '0' and data_out_aux(30 downto 0) < operand_exponent_in then
            exceptions <= "10"; -- overflow detection
        elsif performed_operation = '1' and data_out_aux(30 downto 0) > operand_exponent_in then
            exceptions <= "11"; -- underflow detection
        end if;
        
        data_out <= data_out_aux;
    end process;

end Behavioral;