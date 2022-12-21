library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity arithmetic_unit_test_bench is
end arithmetic_unit_test_bench;

architecture Behavioral of arithmetic_unit_test_bench is

    component arithmetic_unit is
        Port (
            operation_select: in std_logic;
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            performed_operation: out std_logic;
            overflow: out std_logic;
            result: out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal operation_select_signal: std_logic;
    signal data_in_1_signal: std_logic_vector(31 downto 0);
    signal data_in_2_signal: std_logic_vector(31 downto 0);
    signal result_signal: std_logic_vector(31 downto 0);
    signal performed_operation_signal: std_logic;
    signal overflow_signal: std_logic;
    
begin

    operation_select_signal <= '1';
--    data_in_1_signal <= B"0_10000011_10010000001101010100000"; -- 9
--    data_in_2_signal <= B"0_10000011_10000001111010111000011"; -- 8
    
--    data_in_1_signal <= B"0_00000000_00000000000000000000000"; -- 0.01
--    data_in_2_signal <= B"0_10011101_00000000000000000000000"; -- 1073741824.0

    data_in_1_signal <= x"00000000";
    data_in_2_signal <= x"00000000";
    
    uut: arithmetic_unit port map(
        operation_select => operation_select_signal,
        data_in_1 => data_in_1_signal,
        data_in_2 => data_in_2_signal,
        performed_operation => performed_operation_signal,
        overflow => overflow_signal,
        result => result_signal
    );
    
end Behavioral;
