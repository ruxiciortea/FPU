library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_register is
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
end data_register;

architecture Behavioural of data_register is

signal my_register: std_logic_vector(31 downto 0) := (others => '0');

begin

    process(clk) 
    begin
        if rising_edge(clk) and enable = '1' then
            if write_selection = "01" then -- absolute writing
                my_register <= absolute_write_data;
            elsif write_selection = "10" then -- normal writing
                if write_address = '1' then -- low (0...15)
                    my_register(15 downto 0) <= write_data;
                elsif write_address = '0' then -- high (16...31)
                    my_register(31 downto 16) <= write_data;
                end if;
            end if;

            if read_selection = "01" then -- absolute reading
                absolute_read_data <= my_register;
            elsif read_selection = "10" then -- normal reading
                if read_address = '1' then -- low (0...15)
                    read_data <= my_register(15 downto 0);
                elsif read_address = '0' then -- high (16...31)
                    read_data <= my_register(31 downto 16);
                end if;
            end if;
        end if;
    end process;

end Behavioural;