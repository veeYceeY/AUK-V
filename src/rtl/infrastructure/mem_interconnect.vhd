library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity mem_interconnect is
    generic (
            MAX_LIMIT       : integer :=4096
    );
    port(
            i_clk           : in std_logic;
            i_rst           : in std_logic;

            i_en            : in std_logic;
            i_we            : in std_logic;
            i_addr          : in std_logic_vector(31 downto 0);
            i_data          : in std_logic_vector(31 downto 0);
            i_strobe        : in std_logic_vector(3 downto 0);
            o_valid         : out std_logic;
            o_data          : out std_logic_vector(31 downto 0);

            o_port0_clk       : out std_logic;
            o_port0_rst       : out std_logic;

            o_port0_en        : out std_logic;
            o_port0_we        : out std_logic;
            o_port0_addr      : out std_logic_vector(31 downto 0);
            o_port0_data      : out std_logic_vector(31 downto 0);
            o_port0_strobe    : out std_logic_vector(3 downto 0);
            i_port0_valid     : in std_logic;
            i_port0_data      : in std_logic_vector(31 downto 0);

            o_port1_clk    : out std_logic;
            o_port1_rst    : out std_logic;

            o_port1_en     : out std_logic;
            o_port1_we     : out std_logic;
            o_port1_addr   : out std_logic_vector(31 downto 0);
            o_port1_data   : out std_logic_vector(31 downto 0);
            o_port1_strobe : out std_logic_vector(3 downto 0);
            i_port1_valid  : in std_logic;
            i_port1_data   : in std_logic_vector(31 downto 0)
    );

end mem_interconnect;

architecture behave of mem_interconnect is
signal addr : std_logic_vector(31 downto 0);
begin

    process(i_clk,i_rst)begin
        if i_rst='1' then
            addr      <= (others => '0');
        elsif rising_edge(i_clk) then
            if i_en = '1' then
                addr<= i_addr;
            end if;
        end if;
    end process;


    process(i_en,i_port0_valid,i_port0_data,i_strobe,i_data,i_addr,i_we,i_port1_valid,i_port1_data)
    begin
       if i_addr < MAX_LIMIT then
            o_port0_en        <= i_en;
            o_valid           <= i_port0_valid;
            o_data            <= i_port0_data;

            o_port0_we        <= i_we;
            o_port0_addr      <= i_addr;
            o_port0_data      <= i_data;
            o_port0_strobe    <= i_strobe;
            
            o_port1_en     <='0'    ;
            o_port1_we     <= '0';
            o_port1_addr   <= (others => '0');
            o_port1_data   <= (others => '0');
            o_port1_strobe <= (others => '0');
       else
            o_port1_en     <=i_en    ;
            o_valid         <=i_port1_valid ;
            o_data          <=i_port1_data  ;
            o_port1_we     <= i_we;
            o_port1_addr   <= i_addr-MAX_LIMIT;
            o_port1_data   <= i_data;
            o_port1_strobe <= i_strobe;

            o_port0_en        <= '0';
            o_port0_we        <= '0';
            o_port0_addr      <= (others => '0');
            o_port0_data      <= (others => '0');
            o_port0_strobe    <= (others => '0');
       end if;

    end process;

end behave;