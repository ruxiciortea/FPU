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
    
--    operand_1_in <= B"1_10000010_00100000011010101000000"; -- 9.01   
--    operand_2_in <= B"1_10000010_00000011110101110000110"; -- 8.12

--    operand_1_in <= B"0_10000100_11000110011110101110010"; -- 56.81
--    operand_2_in <= B"0_10000101_00010001110101110000110"; -- 68.46

--    operand_2_in <= B"0_10011101_00000000000000000000000"; -- 1073741824.0
--    operand_1_in <= B"0_01111000_01000111101011100001010"; -- 0.01    
    
    operand_2_in <= x"00000000"; -- 0
    operand_1_in <= x"00000000"; -- 0

    operation_signal <= '1';

    uut: FPU port map(
        operand_1 => operand_1_in,
        operand_2 => operand_2_in,
        operation => operation_signal,
        final_result => operation_result
    );

end Behavioral;
