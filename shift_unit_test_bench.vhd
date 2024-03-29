library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_unit_test_bench is
end shift_unit_test_bench;

architecture Behavioral of shift_unit_test_bench is

    component shift_unit is
        Port (
            selection: in std_logic_vector(2 downto 0);
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            data_out_1: out std_logic_vector(31 downto 0);
            data_out_2: out std_logic_vector(31 downto 0)
        );
    end component;

    signal selection_signal: std_logic_vector(2 downto 0);
    signal data_in_1_signal: std_logic_vector(31 downto 0);
    signal data_in_2_signal: std_logic_vector(31 downto 0);
    signal data_out_1_signal: std_logic_vector(31 downto 0);
    signal data_out_2_signal: std_logic_vector(31 downto 0);

begin
    
    selection_signal <= "000";
--    data_in_1_signal <= B"0_00000001_01111110011110101110001";
--    data_in_2_signal <= B"0_11111101_10011000101000111101100";
    
--    data_in_1_signal <= B"0_01111000_01000111101011100001010"; -- 0.01
--    data_in_2_signal <= B"0_10011101_00000000000000000000000"; -- 1073741824.0
    
    data_in_1_signal <= x"00000000";
    data_in_2_signal <= x"00000000";
    
    uut: shift_unit port map (
        selection => selection_signal,
        data_in_1 => data_in_1_signal,
        data_in_2 => data_in_2_signal,
        data_out_1 => data_out_1_signal,
        data_out_2 => data_out_2_signal
    );

end Behavioral;
