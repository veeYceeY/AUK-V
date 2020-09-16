

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_aukv is

    type t_out_wb_master is record	
        addr : std_logic_vector(31 downto 0);
        sel : std_logic_vector( 3 downto 0);
        cyc : std_logic;
        stb : std_logic;
        we  : std_logic;
        data : std_logic_vector(31 downto 0);
    end record; 

    type t_in_wb_master is record
        data : std_logic_vector(31 downto 0);
        ack : std_logic;
    end record;

    constant idle_out_wb_master : t_out_wb_master := (
                                                        addr=>(others=>'0'),
                                                        sel=>(others=>'0'),
                                                        cyc=>'0',
                                                        stb=>'0',
                                                        we=>'0',
                                                        data=>(others=>'0')
                                                    );
    constant idle_in_wb_master : t_in_wb_master   := (
                                                        data=>(others=>'0'),
                                                        ack=>'0'
                                                    );

end package pkg_aukv;