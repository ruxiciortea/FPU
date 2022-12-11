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
            performed_operation: out std_logic;
            overflow: out std_logic;
            result: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component normalization_unit is
        Port ( 
            data_in: in std_logic_vector(31 downto 0);
            operand_in: in std_logic_vector(31 downto 0);
            overflow: in std_logic;
            performed_operation: in std_logic;
            data_out: out std_logic_vector(31 downto 0);
            exceptions: out std_logic_vector(1 downto 0)
        );
    end component;

    -- comparison unit signals
    signal comparison_result: std_logic_vector(2 downto 0);
    
    -- shift unit signals
    signal shifted_operand_1: std_logic_vector(31 downto 0);    
    signal shifted_operand_2: std_logic_vector(31 downto 0);   
    
    -- arithmetic unit signals
    signal operation_result: std_logic_vector(31 downto 0);
    signal performed_operation_signal: std_logic;
    signal detected_overflow: std_logic;
    
    -- normalization unit signals
    signal detected_exceptions: std_logic_vector(1 downto 0);
    
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
        performed_operation => performed_operation_signal,
        overflow => detected_overflow,
        result => operation_result
    );
    
    normalization: normalization_unit port map(
        data_in => operation_result,
        operand_in => shifted_operand_1,
        overflow => detected_overflow,
        performed_operation => performed_operation_signal,
        data_out => final_result,
        exceptions => detected_exceptions
    );

end Structural;
