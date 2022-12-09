library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparison_unit_test_bench is
end comparison_unit_test_bench;

architecture Structural of comparison_unit_test_bench is

    component comparison_unit is
        Port (
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            result: out std_logic_vector(2 downto 0)
        );
    end component;

    signal data_in_1_signal: std_logic_vector(31 downto 0);
    signal data_in_2_signal: std_logic_vector(31 downto 0);
    signal result_signal: std_logic_vector(2 downto 0);

begin

    data_in_1_signal <= B"0_00000111_00000000000000000101111" after 100 ns;
    data_in_2_signal <= B"0_11111111_00000000000000000101111" after 100 ns;

    uut: comparison_unit port map (
        data_in_1 => data_in_1_signal,
        data_in_2 => data_in_2_signal,
        result => result_signal
    );

end Structural;
