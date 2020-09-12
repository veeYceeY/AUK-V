---------------------------------------------------------------------------------------
--Author : veeYceeY
--Company: SCiMOS
--This code implements FIFO
---------------------------------------------------------------------------------------





library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;






entity fifo is 
generic(
            FIFO_WIDTH: integer :=8;
            FIFO_DEPTH: integer :=8
);
    port (
        i_wrclk : in std_logic;
        i_wrrst : in std_logic;
        i_wren  : in std_logic;
        i_wrdata : in std_logic_vector(FIFO_WIDTH-1 downto 0);
        o_full : out std_logic;

        i_rdclk : in std_logic;
        i_rdrst : in std_logic;
        i_rden  : in std_logic;
        o_rddata : out std_logic_vector(FIFO_WIDTH-1 downto 0);
        o_empty  : out std_logic
    );
end fifo;



architecture arch_fifo of fifo is 
type ff is array(FIFO_DEPTH-1 downto 0) of std_logic_vector(FIFO_WIDTH-1 downto 0);
signal mem : ff;
signal rd_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);
signal wr_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);

signal ac_rd_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH))))-1 downto 0);
signal ac_wr_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH))))-1 downto 0);

signal grey_rd_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);
signal grey_wr_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);

signal sync_rd_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);
signal sync_wr_addr : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);

signal grey_rd_addr1 : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);
signal grey_wr_addr1 : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);

signal grey_rd_addr2 : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);
signal grey_wr_addr2 : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH)))) downto 0);

signal rd_data : std_logic_vector(FIFO_WIDTH-1 downto 0);
signal wr_data : std_logic_vector(FIFO_WIDTH-1 downto 0);
signal count : std_logic_vector(integer(ceil(log2(real(FIFO_DEPTH))))-1 downto 0);
signal full: std_logic;
signal empty : std_logic;

begin

--    count <= wr_addr-rd_addr ;--when ov='1' else rd_clk-wr_clk;
 --   full<= '1' when count = FIFO_DEPTH-1 else '0';
--    empty <= '1' when count = 0 else '0';
      full <= '1' when rd_addr(integer(ceil(log2(real(FIFO_DEPTH))))) /= rd_addr(integer(ceil(log2(real(FIFO_DEPTH))))) and rd_addr(integer(ceil(log2(real(FIFO_DEPTH))))-1 downto 0) = sync_rd_addr(integer(ceil(log2(real(FIFO_DEPTH))))-1 downto 0) else '0';
      empty <= '1' when rd_addr = sync_rd_addr else '0';
    process(i_wrclk,i_wrrst)
    begin
        if i_wrrst = '1' then
            wr_addr<= (others=> '0');
        elsif rising_edge(i_wrclk) then
            if i_wren = '1' then
                if full = '0' then
                    wr_addr <= wr_addr + '1';
                end if;
            end if;
        end if;
    end process;

    process(i_rdclk,i_rdrst)
    begin
        if i_rdrst = '1' then
            rd_addr<= (others=> '0');
        elsif rising_edge(i_rdclk) then
            if i_rden = '1' then
                if empty = '0' then
                    rd_addr <= rd_addr + '1';
                end if;
            end if;
        end if;
    end process;

    --integer gen1;
    grey_rd_addr(0) <= rd_addr(0);
    G0:for gen1 in 1 to integer(ceil(log2(real(FIFO_DEPTH))))-1 generate
    grey_rd_addr(gen1) <= rd_addr(gen1-1) xor rd_addr(gen1);
    end generate;

    --integer gen2;
    grey_wr_addr(0) <= wr_addr(0);
    G1:for gen2 in 1 to integer(ceil(log2(real(FIFO_DEPTH))))-1 generate
    grey_wr_addr(gen2) <= wr_addr(gen2-1) xor wr_addr(gen2);
    end generate;
  
    --integer gen3;
    sync_rd_addr(0) <= grey_rd_addr2(0);
    G2:for gen3 in 1 to integer(ceil(log2(real(FIFO_DEPTH))))-1 generate
    sync_rd_addr(gen3) <= grey_rd_addr2(gen3-1) xor rd_addr(gen3);
    end generate;

    --integer gen4;
    sync_wr_addr(0) <= grey_wr_addr2(0);
    G3:for gen4 in 1 to integer(ceil(log2(real(FIFO_DEPTH))))-1 generate
    sync_wr_addr(gen4) <= grey_wr_addr2(gen4-1) xor wr_addr(gen4);
    end generate;
  
    process(i_wrclk,i_wrrst)
    begin
        if i_wrrst = '1' then

        elsif rising_edge(i_wrclk) then
            grey_wr_addr1<=grey_wr_addr;
            grey_wr_addr2<=grey_wr_addr1;
        end if;
    end process;
    process(i_rdclk,i_rdrst)
    begin
        if i_rdrst = '1' then

        elsif rising_edge(i_rdclk) then
            grey_rd_addr1<=grey_rd_addr;
            grey_rd_addr2<=grey_rd_addr1;
        end if;
    end process;


    ac_rd_addr<=rd_addr((integer(ceil(log2(real(FIFO_DEPTH)))))-1 downto 0);

    ac_wr_addr<=wr_addr((integer(ceil(log2(real(FIFO_DEPTH)))))-1 downto 0);


    process(i_wrclk,i_wrrst)
    begin
        if i_wrrst = '1' then

        elsif rising_edge(i_wrclk) then
            mem(to_integer(unsigned(ac_wr_addr)))<=i_wrdata;
        end if;
    end process;


    process(i_rdclk,i_rdrst)
    begin
        if i_rdrst = '1' then
            rd_data<= (others=> '0');
        elsif rising_edge(i_wrclk) then
            rd_data<=mem(to_integer(unsigned(ac_rd_addr)));
        end if;
    end process;

o_full <= full;
o_empty <= empty;
o_rddata <= rd_data;

end arch_fifo;

