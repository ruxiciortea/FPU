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
        result: out std_logic_vector(31 downto 0)
    );
end arithmetic_unit;

architecture Behavioural of arithmetic_unit is

    signal operation_result: std_logic_vector(22 downto 0);
    signal sign: std_logic;

begin

    process(operation_select, data_in_1, data_in_2)
    
        variable mantissa_1: std_logic_vector(22 downto 0);
        variable mantissa_2: std_logic_vector(22 downto 0);
        variable aux: std_logic_vector(22 downto 0);
        variable sign_1: std_logic;
        variable sign_2: std_logic;
        variable operation: std_logic;
    
    begin 
        mantissa_1 := data_in_1(22 downto 0);
        mantissa_2 := data_in_2(22 downto 0);
        sign_1 := data_in_1(31);
        sign_2 := data_in_2(31);
        
        case operation_select is
            when '0' => -- addition
                if sign_1 = sign_2 then
                    operation_result <= mantissa_1 + mantissa_2;
                    sign <= sign_1;
                else
                    if mantissa_2 > mantissa_1 then
                        aux := mantissa_1;
                        mantissa_1 := mantissa_2;
                        mantissa_2 := aux;
                        
                        sign_1 := data_in_2(31);
                        sign_2 := data_in_1(31);
                    end if;
                    
                    operation_result <= mantissa_1 - mantissa_2;
                    
                    if mantissa_1 > mantissa_2 then
                        sign <= sign_1;
                    else
                        sign <= not sign_1;
                    end if;
                end if;
            when '1' => -- subtraction              
                if sign_1 = sign_2 then   
                    if mantissa_2 > mantissa_1 then
                        aux := mantissa_1;
                        mantissa_1 := mantissa_2;
                        mantissa_2 := aux;
                        
                        sign_1 := data_in_2(31);
                        sign_2 := data_in_1(31);
                    end if;
                    
                    operation_result <= mantissa_1 - mantissa_2;    
                                 
                    if mantissa_1 > mantissa_2 then
                        sign <= sign_1;
                    else
                        sign <= not sign_1;
                    end if;
                else
                    operation_result <= mantissa_1 + mantissa_2;
                    sign <= sign_1;
                end if;                
            when others => 
                operation_result <= (others => '0');
                sign <= '0';
        end case;
    end process;
    
    result <= sign & data_in_1(30 downto 23) & operation_result;

end Behavioural;