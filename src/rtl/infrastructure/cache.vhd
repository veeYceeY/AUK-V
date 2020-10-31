library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;


entity cache is

    generic(
            LINE_SIZE : natural :=16;
            OFFSET : natural := 6
    );
    port(
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            ---cpu interface--------
            i_req : in std_logic;
            i_addr: in std_logic_vector(31 downto 0);
            
            o_data: out std_logic_vector(31 downto 0);
            o_ack: out std_logic;
            
            ---memory interface--------
            o_req : out std_logic;
            o_addr: out std_logic_vector(31 downto 0);
            
            i_data: in std_logic_vector(31 downto 0);
            i_ack: in std_logic
            
    );
end entity;

architecture behave of cache is
type t_cache_line is array(LINE_SIZE-1 downto 0) of std_logic_vector(31 downto 0);
type t_cache_tag is array(3 downto 0) of std_logic_vector(31-(OFFSET+2) downto 0);
type t_cache_valid is array(3 downto 0) of std_logic;
type t_state is (ST_IDLE,ST_LOAD,ST_WAIT);
signal state : t_state;
signal line0: t_cache_line;
signal line1: t_cache_line;
signal line2: t_cache_line;
signal line3: t_cache_line;
signal tag  : t_cache_tag;
signal valid: std_logic_vector(3 downto 0);
signal valid_selected: std_logic;
signal line_selected: t_cache_line;
signal tag_selected: std_logic_vector(31-(OFFSET+2) downto 0);
signal addr: std_logic_vector(31 downto 0);
signal addr_in: std_logic_vector(31 downto 0);
alias tag_in is addr_in(31 downto OFFSET+2);
alias set_in is addr_in(OFFSET+1 downto OFFSET);
alias offset_in is addr_in(OFFSET-1 downto 2);
alias tag_wr is addr(31 downto OFFSET+2);
alias set_wr is addr(OFFSET+1 downto OFFSET);
signal tag_match: std_logic;
signal hit: std_logic;
signal load: std_logic;
signal data: std_logic_vector(31 downto 0);
signal req: std_logic;
signal req_in: std_logic;
signal count: std_logic_vector(31 downto 0);
signal ack: std_logic;
signal statistics: std_logic_vector(3 downto 0);
signal offset_pad: std_logic_vector(OFFSET-1 downto 0);

begin
offset_pad<= (others=>'0');

line_selected <=    line0 when set_in="00" else
                    line1 when set_in="01" else
                    line2 when set_in="10" else
                    line3 when set_in="11" ;
valid_selected <=   valid(0) when set_in="00" else
                    valid(1) when set_in="01" else
                    valid(2) when set_in="10" else
                    valid(3) when set_in="11" ;
tag_selected <=     tag(0) when set_in="00" else
                    tag(1) when set_in="01" else
                    tag(2) when set_in="10" else
                    tag(3) when set_in="11" ;


tag_match   <=  '1' when tag_selected=tag_in else '0';
hit<= tag_match and valid_selected;
data<=line_selected(to_integer(unsigned(offset_in)));

addr_in<=(others=>'0') when i_rst='1' else i_addr when i_req='1' and rising_edge(i_clk); 
load<= (not hit) and req_in;
o_data<=data when (hit and (req_in or ack))='1' else x"00000000";--when rising_edge(i_clk);
req_in<=i_req when rising_edge(i_clk);
o_ack<=(hit and (req_in or ack));-- when rising_edge(i_clk);
o_req<=req ; --when rising_edge(i_clk);
o_addr<=addr; -- when rising_edge(i_clk);

process(i_clk,i_rst)
begin
    if i_rst='1' then
        state<= ST_IDLE;
    elsif rising_edge(i_clk) then
        if i_req='1' then
            state<= ST_IDLE;
        else
            case state is
            when ST_IDLE =>
                    ack<= '0';
                if load='1' then
                    --valid(to_integer(unsigned(set_in)))<='0';
                    state<= ST_LOAD;
                    addr<= addr_in(31 downto OFFSET) & offset_pad;
                    count<= (others=>'0');
                    --req<= '1';
                end if;
            when ST_LOAD =>
                if count<LINE_SIZE then
                    count<= count+1;
                    state<= ST_WAIT;
                    req<= '1';
                else
                    req<= '0';
                    state<= ST_IDLE;
                    ack<= '1';
                    
                end if;
            when ST_WAIT =>
                    req<= '0';
                if i_ack='1' then
                    addr<= addr+4;
                    state<= ST_LOAD;
                end if;
            end case;
        end if;
    end if;
end process;

process(i_clk)
begin
    if i_rst='1' then
        valid<=x"0";
    elsif rising_edge(i_clk) then
        if i_ack='1' then
            if count="01111" then
                valid(to_integer(unsigned(set_in)))<='1';
                tag(to_integer(unsigned(set_wr)))<=tag_wr;
            end if;
            
            if set_wr="00" then
                line0(to_integer(unsigned(addr(OFFSET-1 downto 2))))<=i_data;
            elsif set_wr="01" then
                line1(to_integer(unsigned(addr(OFFSET-1 downto 2))))<=i_data;
            elsif set_wr="10" then
                line2(to_integer(unsigned(addr(OFFSET-1 downto 2))))<=i_data;
            else
                line3(to_integer(unsigned(addr(OFFSET-1 downto 2))))<=i_data;
            end if;
        end if;
    end if;
end process;




end behave;