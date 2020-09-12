library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity m_axilite is
    port(
            i_aclk    : in std_logic;
            i_arst_n    : in std_logic;

            i_en     : in std_logic;
            i_we     : in std_logic;
            i_raddr   : in std_logic_vector(31 downto 0);
            i_waddr   : in std_logic_vector(31 downto 0);
            i_data   : in std_logic_vector(31 downto 0);
            i_strobe : in std_logic_vector(3 downto 0);
            o_valid  : out std_logic;
            o_data   : out std_logic_vector(31 downto 0);


            --o_axi_aresetn : out std_logic;

            o_axi_araddr : out std_logic_vector(31 downto 0);
            o_axi_arvalid: out std_logic;
            i_axi_arready: in std_logic;
            i_axi_rdata : in std_logic_vector(31 downto 0);
            i_axi_rvalid: in std_logic;
            o_axi_rready: out std_logic;
            i_axi_rresp : in std_logic_vector(1 downto 0);

            o_axi_awaddr : out std_logic_vector(31 downto 0);
            o_axi_awvalid: out std_logic;
            i_axi_awready: in std_logic;
            o_axi_wdata : out std_logic_vector(31 downto 0);
            i_axi_wvalid: in std_logic;
            o_axi_wstrb : out std_logic_vector(7 downto 0);
            i_axi_wready: in std_logic;

            i_axi_bresp : in std_logic_vector(1 downto 0);
            i_axi_bvalid: in std_logic;
            o_axi_bready: out std_logic
            
    );

end m_axilite;

architecture behave of m_axilite is

attribute rom_style : string;
type mem_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
attribute rom_style of mem : signal is "block";
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(4 downto 0);
signal axi_araddr : std_logic_vector(31 downto 0);
signal axi_arvalid: std_logic;
signal axi_awaddr : std_logic_vector(31 downto 0);
signal axi_awvalid: std_logic;
signal axi_wdata  : std_logic_vector(31 downto 0);
signal axi_wstrb  : std_logic_vector(7 downto 0);
signal axi_bready : std_logic;
signal axi_wvalid: std_logic;
signal axi_bvalid: std_logic;
signal axi_rready: std_logic;
begin
    
    process(i_aclk,i_arst_n)
    begin
        if i_arst_n = '0' then
            
        elsif rising_edge(i_aclk) then
            if i_we='0' then
                if axi_arvalid = '0' then
                    if i_en = '1' then
                        axi_araddr<=i_raddr;
                        axi_arvalid<='1';
                    end if;
                else 
                    if i_axi_arready = '1' then
                        axi_arvalid<='0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    
    process(i_aclk,i_arst_n)
    begin
        if i_arst_n = '0' then
            
        elsif rising_edge(i_aclk) then
            if i_we='1' then
                if axi_awvalid = '0' then
                    if i_en = '1' then
                        axi_awaddr<=i_waddr;
                        axi_awvalid<='1';
                    end if;
                else 
                    if i_axi_awready = '1' then
                        axi_awvalid<='0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    process(i_aclk,i_arst_n)
    begin
        if i_arst_n = '0' then
            
        elsif rising_edge(i_aclk) then
            if i_we='1' then
                if axi_wvalid = '0' then
                    if i_en = '1' then
                        axi_wdata<=i_data;
                        axi_wvalid<='1';
                    end if;
                else 
                    if i_axi_wready = '1' then
                        axi_wvalid<='0';
                    end if;
                end if;
            end if;
        end if;
    end process;   
    
--    process(i_aclk,i_arst_n)
--    begin
--        if i_arst_n = '0' then
            
--        elsif rising_edge(i_aclk) then
--            if i_we='1' then
--                 if i_en = '1' then
--                    axi_bready<=i_axi_bvalid;
--                 end if;
--            end if;
--        end if;
--    end process;   
    axi_bready<='1';
    axi_rready<='1';

--    process(i_aclk,i_arst_n)
--    begin
--        if i_arst_n = '0' then
            
--        elsif rising_edge(i_aclk) then
--            if i_we='1' then
--                if axi_rready = '0' then
--                    if i_en = '1' then
--                        --axi_wdata<=i_data;
--                        axi_rready<='1';
--                    end if;
--                else 
--                    if i_axi_bready = '1' then
--                        axi_bvalid<='0';
--                    end if;
--                end if;
--            end if;
--        end if;
--    end process;
    o_axi_wstrb<= x"ff";
    o_data <= i_axi_rdata;
    o_valid <= i_axi_rvalid;

    o_axi_araddr <=axi_araddr ;
    o_axi_arvalid<=axi_arvalid;
    o_axi_awaddr <=axi_awaddr ;
    o_axi_awvalid<=axi_awvalid;
    o_axi_wdata  <=axi_wdata  ;
    o_axi_wstrb  <=axi_wstrb  ;
    o_axi_bready <=axi_bready ;
    o_axi_rready <=axi_rready ;








end behave;