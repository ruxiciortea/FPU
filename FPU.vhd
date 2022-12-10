library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FPU is
    Port ( 
        operand_1: in std_logic_vector(31 downto 0);
        operand_2: in std_logic_vector(31 downto 0);
        operation: in std_logic;
        final_result: out std_logic_vector(31 downto 0)
    );
end FPU;

architecture Structural of FPU is

--    component data_register is
--        Port (
--            clk: in std_logic;
--            enable: in std_logic;
--            absolute_write_data: in std_logic_vector(31 downto 0);
--            write_data: in std_logic_vector(15 downto 0);
--            write_address: in std_logic;
--            read_address: in std_logic;
--            write_selection: in std_logic_vector(1 downto 0);
--            read_selection: in std_logic_vector(1 downto 0);
--            absolute_read_data: out std_logic_vector(31 downto 0);
--            read_data: out std_logic_vector(15 downto 0)
--        );
--    end component;

    component comparison_unit is
        Port (
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            result: out std_logic_vector(2 downto 0)
        );
    end component;

    component shift_unit is
        Port (
            selection: in std_logic_vector(2 downto 0);
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            data_out_1: out std_logic_vector(31 downto 0);
            data_out_2: out std_logic_vector(31 downto 0)
        );
    end component;

    component arithmetic_unit is
        Port (
            operation_select: in std_logic;
            data_in_1: in std_logic_vector(31 downto 0);
            data_in_2: in std_logic_vector(31 downto 0);
            result: out std_logic_vector(31 downto 0)
        );
    end component;

--    -- data registers signals
--    signal operand_1_out: std_logic_vector(31 downto 0);
--    signal operand_2_out: std_logic_vector(31 downto 0);
    
--    signal half_operand_1_in: std_logic_vector(16 downto 0);
--    signal half_operand_2_in: std_logic_vector(16 downto 0);
--    signal half_operand_1_out: std_logic_vector(16 downto 0);
--    signal half_operand_2_out: std_logic_vector(16 downto 0);
    
    -- comparison unit signals
    signal comparison_result: std_logic_vector(2 downto 0);
    
    -- shift unit signals
    signal shifted_operand_1: std_logic_vector(31 downto 0);    
    signal shifted_operand_2: std_logic_vector(31 downto 0);   
    signal operation_result: std_logic_vector(31 downto 0);   
    
    -- arithmetic unit signals
    
begin
    
    comparison: comparison_unit port map(
        data_in_1 => operand_1,
        data_in_2 => operand_2,
        result => comparison_result
    );
    
    shift: shift_unit port map(
        selection => comparison_result,
        data_in_1 => operand_1,
        data_in_2 => operand_2,
        data_out_1 => shifted_operand_1,
        data_out_2 => shifted_operand_2
    );
    
    arithmetic: arithmetic_unit port map(
        operation_select => operation,
        data_in_1 => shifted_operand_1,
        data_in_2 => shifted_operand_2,
        result => final_result
    );

end Structural;
