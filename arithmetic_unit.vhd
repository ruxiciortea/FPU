library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity arithmetic_unit is
    Port (
        operation_select: in std_logic;
        data_in_1: in std_logic_vector(31 downto 0);
        data_in_2: in std_logic_vector(31 downto 0);
        performed_operation: out std_logic;
        overflow: out std_logic;
        result: out std_logic_vector(31 downto 0)
    );
end arithmetic_unit;

architecture Behavioural of arithmetic_unit is

begin

    process(operation_select, data_in_1, data_in_2)
        
        -- operation signal
        variable mantissa_1: std_logic_vector(22 downto 0);
        variable mantissa_2: std_logic_vector(22 downto 0);
        variable aux: std_logic_vector(22 downto 0);
        variable sign_1: std_logic;
        variable sign_2: std_logic;
        variable operation: std_logic;
        variable operation_result: std_logic_vector(22 downto 0);
        variable sign: std_logic;
        
        -- overflow detection signals
        variable extended_operand_1: std_logic_vector(23 downto 0);
        variable extended_operand_2: std_logic_vector(23 downto 0);
        variable extended_sum: std_logic_vector(23 downto 0);
        variable detected_overflow: std_logic;
    
    begin 
        mantissa_1 := data_in_1(22 downto 0);
        mantissa_2 := data_in_2(22 downto 0);
        sign_1 := data_in_1(31);
        sign_2 := data_in_2(31);
        
        extended_operand_1 := '0' & data_in_1(22 downto 0);
        extended_operand_2 := '0' & data_in_2(22 downto 0);
        extended_sum := extended_operand_1 + extended_operand_2;
        detected_overflow := '0';
        
        case operation_select is
            when '0' => -- addition
                if sign_1 = sign_2 then
                    operation_result := mantissa_1 + mantissa_2;
                    performed_operation <= '0';
                    sign := sign_1;
                    detected_overflow := extended_sum(23);
                else
                    if mantissa_2 > mantissa_1 then
                        aux := mantissa_1;
                        mantissa_1 := mantissa_2;
                        mantissa_2 := aux;
                        
                        sign := sign_2;
                    else 
                        sign := sign_1;
                    end if;
                    
                    operation_result := mantissa_1 - mantissa_2;
                    performed_operation <= '1';
                end if;
            when '1' => -- subtraction              
                if sign_1 = sign_2 then   
                    if mantissa_2 > mantissa_1 then
                        aux := mantissa_1;
                        mantissa_1 := mantissa_2;
                        mantissa_2 := aux;
                        
                        sign := not sign_1;
                    else
                        sign := sign_1;
                    end if;
                    
                    operation_result := mantissa_1 - mantissa_2;  
                    performed_operation <= '1';  
                else
                    operation_result := mantissa_1 + mantissa_2;
                    performed_operation <= '0';
                    sign := sign_1;
                    detected_overflow := extended_sum(23);
                end if;                
            when others => 
                operation_result := (others => '0');
                sign := '0';
        end case;
                
        overflow <= detected_overflow;
        result <= sign & data_in_1(30 downto 23) & operation_result;
    end process;

end Behavioural;