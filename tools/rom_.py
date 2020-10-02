#
#
#
#      Author : veeYceeY
#      Code ROM generator
#
#
#

import sys
import time


#9307000089C741651305A5307DAC8280
def reverse(instr):
	j=len(instr)
	res=""
	#while (j>0):
	#	res+=instr[j-1]
	#	j-=1
	res=instr
	res=flip(res)
	return res

def flip(instr):
	j=len(instr)
	res=""
	while (j>0):
		res+=instr[j-2]
		res+=instr[j-1]
		j-=2
	return res

def parse( line,vfile ):
    #if not hasattr(myfunc, "addr"):
    #    parse.addr=0
    c='"'
    tmp=""
    length=len(line)
    if length == 0: 
    	return vfile
    if line[0] == '@' :
    	parse.addr = int(line[1 :length],16)/4
    	return vfile
    line=line.replace(" ","")
    instr=""
    i=0;
    length=len(line)
    print(line)
    print(length)
    while i<=length-1:
    	print(i)
    	#print(i%8)
    	m=i%8
    	if (i>0 and (i%8)==0):
    		#print(parse.addr)
    		#print(i)
    		print(instr)
    		instr=flip(instr)
    		print(instr)
    		vfile=vfile+"    mem("+str(int(parse.addr-16384))+")<=x"+c+instr+c+";\n"
    		instr=""
    		tmp=""
    		parse.addr+=1
    		if i==length:
    			return vfile
    		else:
    			instr+=line[i]
    	else:
    		if i==length-1 :
    			instr=flip(instr)
    			fill=""
    			j=8-(i%8)
    			while j>0:
    				fill+="0"
    				j-=1
	    		vfile=vfile+"    mem("+str(int(parse.addr-16384))+")<=x"+c+fill+instr+c+";\n"
	    		instr=""
	    		tmp=""
	    		parse.addr+=1
	    		print("dddddddddddddddddddddddddddddddddddddddddddddddddd")
	    		print(i)
	    		print(i%8)
	    		return vfile
	    	else:
    			instr+=line[i]
    	i+=1		
    return vfile
parse.addr = 0




path = sys.argv[1]
f=open(path,"r")
tm=time.ctime()
c='"'
i=0
char="x"
line=""
#line=f.read()
cline=""
vfile=""
vf=open("build/wb_oc_rom.vhd","w")
vfile+="-----sd-----------------------------------------------------------------------------\n"
vfile+="-- Company:  SCiMOS\n"
vfile+="-- Engineer: Veeyceey\n"
vfile+="-- \n"
vfile+="-- Create Date: "+tm+"\n"
vfile+="-- Design Name: \n"
vfile+="-- Module Name: sciv_core - Behavioral\n"
vfile+="-- Project Name: \n"
vfile+="-- Target Devices: \n"
vfile+="-- Tool Versions: \n"
vfile+="-- Description: \n"
vfile+="-- \n"
vfile+="-- Dependencies: \n"
vfile+="-- \n"
vfile+="-- Revision:\n"
vfile+="-- Revision 0.01 - File Created\n"
vfile+="-- Additional Comments:\n"
vfile+="-- \n"
vfile+="----------------------------------------------------------------------------------\n\n\n\n"

vfile+="library ieee;\n"
vfile+="use ieee.std_logic_1164.all;\n"
vfile+="use ieee.std_logic_unsigned.all;\n"
vfile+="--use ieee.std_logic_arith.all;\n"
vfile+="use ieee.numeric_std.all;\n\n\n"
vfile+="use work.pkg_aukv.all;\n\n\n"


vfile+="entity wb_oc_rom is\n"
vfile+="    port(\n"
vfile+="            i_clk    : in std_logic;\n"
vfile+="            i_rst    : in std_logic;\n"
vfile+="            o_m_wb  : out t_in_wb_master;\n"
vfile+="            i_m_wb  : in t_out_wb_master\n"
vfile+="    );\n"

vfile+="end wb_oc_rom;\n"

vfile+="architecture behave of wb_oc_rom is\n"
vfile+="attribute rom_style : string;\n"
vfile+="type mem_type is array(1023 downto 0) of std_logic_vector(31 downto 0);\n"
vfile+="signal data : std_logic_vector(31 downto 0);\n"
vfile+="signal addr : std_logic_vector(13 downto 0);\n"
vfile+="signal mem : mem_type;\n"
vfile+="signal byte_addr : std_logic_vector(1 downto 0);\n"
vfile+="signal sel : std_logic_vector(3 downto 0);\n"




vfile+="begin\n\n\n"

vfile+="    addr <= i_m_wb.addr(15 downto 2)  ;\n"
vfile+="    sel <= i_m_wb.sel;\n"
vfile+="    byte_addr <= i_m_wb.addr(1 downto 0)  ;\n"
vfile+="    data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');\n\n"


vfile+="    process(addr,sel,byte_addr,data)\n"
vfile+="    begin\n"
vfile+="        if sel="+c+"1111"+c+" then\n"
vfile+="            o_m_wb.data <=data;\n"
vfile+="        elsif sel="+c+"0011"+c+" then\n"
vfile+="            if byte_addr="+c+"01"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"0000"+c+" & data(15 downto 0);\n"
vfile+="            elsif byte_addr="+c+"11"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"0000"+c+" & data(31 downto 16);\n"
vfile+="            end if;\n"
vfile+="        elsif sel="+c+"0001"+c+" then\n"
vfile+="            if byte_addr="+c+"00"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"000000"+c+" & data(7 downto 0);\n"
vfile+="            elsif byte_addr="+c+"01"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"000000"+c+" & data(15 downto 8);\n"
vfile+="            elsif byte_addr="+c+"10"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"000000"+c+" & data(23 downto 16);\n"
vfile+="            elsif byte_addr="+c+"11"+c+" then\n"
vfile+="                o_m_wb.data <=x"+c+"000000"+c+" & data(31 downto 24);\n"
vfile+="            end if;\n"
vfile+="        end if;\n"
vfile+="    end process;\n\n"

vfile+="    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc ;\n\n\n"
#vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
#parse.addr+=1
i=0
for cline in f:
	print(cline)
	vfile=parse( cline,vfile)
	i+=1
	#if i>1:
		#break;

#print(vfile)

vfile+="end behave;\n"

vf.write(vfile) 
