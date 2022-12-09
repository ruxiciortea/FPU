library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity shift_unit is
    Port (
        selection: in std_logic_vector(2 downto 0);
        data_in_1: in std_logic_vector(31 downto 0);
        data_in_2: in std_logic_vector(31 downto 0);
        data_out_1: out std_logic_vector(31 downto 0);
        data_out_2: out std_logic_vector(31 downto 0)
    );
end shift_unit;

architecture Behavioural of shift_unit is

    signal data_out_1_aux: std_logic_vector(31 downto 0);
    signal data_out_2_aux: std_logic_vector(31 downto 0);
    signal mantissa_signal: std_logic_vector(22 downto 0);
    
begin

    process(selection, data_in_1, data_in_2)
        variable shift_amount: std_logic_vector(7 downto 0);
        variable shift_amount_mantissa: std_logic_vector(7 downto 0);
        variable mantissa: std_logic_vector(22 downto 0);
        variable shifted_mantissa: std_logic_vector(22 downto 0);
        variable exponent: std_logic_vector(7 downto 0);
        variable subtracted_exponent: std_logic_vector(7 downto 0);
    begin 
        case selection is
            when "000" =>
                data_out_1_aux <= data_in_1;
                data_out_2_aux <= data_in_2;
            when "001" => --(e1 > e2)
                data_out_1_aux <= data_in_1;

                shift_amount := data_in_1(30 downto 23) - data_in_2(30 downto 23);
                shift_amount_mantissa := shift_amount - "0000001";
                mantissa := '1' & data_in_2(22 downto 1);
                shifted_mantissa := std_logic_vector(unsigned(mantissa) srl to_integer(unsigned(shift_amount_mantissa)));
                exponent := data_in_2(30 downto 23);
                subtracted_exponent := exponent + shift_amount;
                
                data_out_2_aux <= data_in_2(31) & subtracted_exponent & shifted_mantissa;
            when "010" => -- (e2 > e1)
                data_out_2_aux <= data_in_2;

                shift_amount := data_in_1(30 downto 23) - data_in_1(30 downto 23);
                shift_amount_mantissa := shift_amount - "0000001";
                mantissa := '1' & data_in_1(22 downto 1);
                shifted_mantissa := std_logic_vector(unsigned(mantissa) srl to_integer(unsigned(shift_amount_mantissa)));
                exponent := data_in_1(30 downto 23);
                subtracted_exponent := exponent + shift_amount;
                
                data_out_1_aux <= data_in_1(31) & subtracted_exponent & shifted_mantissa;
            when "011" =>
                data_out_1_aux <= data_in_1;
                data_out_2_aux <= (others => '0');
            when "100" =>
                data_out_1_aux <= (others => '0');
                data_out_2_aux <= data_in_2;
            when others =>
                data_out_1_aux <= (others => '0');
                data_out_2_aux <= (others => '0');
        end case;
        
        mantissa_signal <= mantissa;
    end process;
    
    data_out_1 <= data_out_1_aux;
    data_out_2 <= data_out_2_aux;

end Behavioural;