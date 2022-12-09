library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_register_test_bench is
end data_register_test_bench;

architecture Structural of data_register_test_bench is

    component data_register is
        Port (
            clk: in std_logic;
            enable: in std_logic;
            absolute_write_data: in std_logic_vector(31 downto 0);
            write_data: in std_logic_vector(15 downto 0);
            write_address: in std_logic;
            read_address: in std_logic;
            write_selection: in std_logic_vector(1 downto 0);
            read_selection: in std_logic_vector(1 downto 0);
            absolute_read_data: out std_logic_vector(31 downto 0);
            read_data: out std_logic_vector(15 downto 0)
        );
    end component;

    signal absolute_write_data_signal: std_logic_vector(31 downto 0) := "11111111111111110000000000000000";
    signal write_data_signal: std_logic_vector(15 downto 0) := "0101010101010101";
    signal write_address_signal: std_logic := '1';
    
    signal absolute_read_data_signal: std_logic_vector(31 downto 0);
    signal read_data_signal: std_logic_vector(15 downto 0);
    signal read_address_signal: std_logic := '1';
    
    signal enable_signal: std_logic := '1';
    
    signal write_selection: std_logic_vector(1 downto 0);
    signal read_selection: std_logic_vector(1 downto 0);
    
    signal clock: std_logic := '0';
begin

    clock <= not clock after 5ns;
    write_selection <= "00" after 20 ns, "11" after 30 ns, "10" after 40 ns, "00" after 50 ns, "01" after 60 ns, "00" after 70 ns;
    read_selection <= "01" after 20 ns, "10" after 30 ns, "00" after 40 ns, "10" after 50 ns, "00" after 60 ns, "01" after 70 ns;
    
    uut: data_register port map (
        clk => clock,
        enable => enable_signal,
        absolute_write_data => absolute_write_data_signal,
        write_data => write_data_signal,
        write_address => write_address_signal,
        read_address => read_address_signal,
        write_selection => write_selection,
        read_selection => read_selection,
        absolute_read_data => absolute_read_data_signal,
        read_data => read_data_signal
    );
    
end Structural;
