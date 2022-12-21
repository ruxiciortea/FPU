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
     
begin

    process(selection, data_in_1, data_in_2)
        variable data_1_aux: std_logic_vector(31 downto 0);
        variable data_2_aux: std_logic_vector(31 downto 0);
        variable shift_amount: std_logic_vector(7 downto 0);
        variable mantissa: std_logic_vector(22 downto 0);
        variable shifted_mantissa: std_logic_vector(22 downto 0);
        variable exponent: std_logic_vector(7 downto 0);
        variable subtracted_exponent: std_logic_vector(7 downto 0);
    begin 
        case selection is
            when "000" => -- (e1 = e2)
                if data_in_1 = x"00000000" then
                    data_out_1 <= data_in_1;
                    data_out_2 <= data_in_2;
                else
                    data_out_1 <= data_in_1(31) & (data_in_1(30 downto 23) + "00000001") & '1' & data_in_1(22 downto 1);
                    data_out_2 <= data_in_2(31) & (data_in_2(30 downto 23) + "00000001") & '1' & data_in_2(22 downto 1);
                end if;
            when "001" => --(e1 > e2)
                data_1_aux := data_in_1(31) & (data_in_1(30 downto 23) + "00000001") & '1' & data_in_1(22 downto 1);
                data_2_aux := data_in_2(31) & (data_in_2(30 downto 23) + "00000001") & '1' & data_in_2(22 downto 1);

                shift_amount := data_1_aux(30 downto 23) - data_2_aux(30 downto 23);
                mantissa := data_2_aux(22 downto 0);
                shifted_mantissa := std_logic_vector(unsigned(mantissa) srl to_integer(unsigned(shift_amount)));
                exponent := data_2_aux(30 downto 23);
                subtracted_exponent := exponent + shift_amount;
                
                data_out_1 <= data_1_aux;
                data_out_2 <= data_2_aux(31) & subtracted_exponent & shifted_mantissa;
            when "010" => -- (e2 > e1)
                data_1_aux := data_in_1(31) & (data_in_1(30 downto 23) + "00000001") & '1' & data_in_1(22 downto 1);
                data_2_aux := data_in_2(31) & (data_in_2(30 downto 23) + "00000001") & '1' & data_in_2(22 downto 1);

                shift_amount := data_2_aux(30 downto 23) - data_1_aux(30 downto 23);
                mantissa := data_1_aux(22 downto 0);
                shifted_mantissa := std_logic_vector(unsigned(mantissa) srl to_integer(unsigned(shift_amount)));
                exponent := data_1_aux(30 downto 23);
                subtracted_exponent := exponent + shift_amount;
                
                data_out_2 <= data_2_aux;
                data_out_1 <= data_1_aux(31) & subtracted_exponent & shifted_mantissa;
            when "011" =>
                data_out_1 <= data_in_1(31) & (data_in_1(30 downto 23) + "00000001") & '1' & data_in_1(22 downto 1);
                data_out_2 <= (others => '0');
            when "100" =>
                data_out_1 <= (others => '0');
                data_out_2 <= data_in_2(31) & (data_in_2(30 downto 23) + "00000001") & '1' & data_in_2(22 downto 1);
            when others =>
                data_out_1 <= (others => '0');
                data_out_2 <= (others => '0');
        end case;        
    end process;

end Behavioural;