library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FPU_test_bench is
end FPU_test_bench;

architecture Behavioral of FPU_test_bench is

    component FPU is
        Port ( 
            operand_1: in std_logic_vector(31 downto 0);
            operand_2: in std_logic_vector(31 downto 0);
            operation: in std_logic;
            final_result: out std_logic_vector(31 downto 0)
        );
    end component;

    signal operand_1_in: std_logic_vector(31 downto 0);
    signal operand_2_in: std_logic_vector(31 downto 0);
    signal operation_signal: std_logic;
    signal operation_result: std_logic_vector(31 downto 0);

begin

    operand_1_in <= B"0_10000010_00000011110101110000110";
    operand_2_in <= B"0_10000010_00100000011010101000000";
    operation_signal <= '0';

    uut: FPU port map(
        operand_1 => operand_1_in,
        operand_2 => operand_2_in,
        operation => operation_signal,
        final_result => operation_result
    );

end Behavioral;