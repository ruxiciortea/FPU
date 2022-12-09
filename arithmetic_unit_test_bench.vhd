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
            result: out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal operation_select_signal: std_logic;
    signal data_in_1_signal: std_logic_vector(31 downto 0);
    signal data_in_2_signal: std_logic_vector(31 downto 0);
    signal result_signal: std_logic_vector(31 downto 0);
    
begin

    operation_select_signal <= '0';
    data_in_1_signal <= B"0_10000110_11001100010100011110110";
    data_in_2_signal <= B"0_10000110_01011111100111101011100";

    uut: arithmetic_unit port map(
        operation_select => operation_select_signal,
        data_in_1 => data_in_1_signal,
        data_in_2 => data_in_2_signal,
        result => result_signal
    );
    
end Behavioral;
