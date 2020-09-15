#
#
#
#      Author : veeYceeY
#      Code ROM generator
#
#
#

import sys



#9307000089C741651305A5307DAC8280



def parse( line,vfile ):
    #if not hasattr(myfunc, "addr"):
    #    parse.addr=0
    if len( line ) == 0: return
    bytecount = int( line[0:2], 16 )
    address = int( line[2:6], 16 )
    rec_type = int( line[6:8], 16 )
    c='"'
    if rec_type == 0:
        i=0
        tmp=""
        instr=""
        op=""
        j=0
        while i< bytecount:
            tmp=line[(8+(i*2)):(8+(2*i+8))]
            instr=""
            op=""
            #instr[7]=tmp[1]
            #instr[5:4]=tmp[3:2]
            #instr[3:2]=tmp[5:4]
            #instr[1:0]=tmp[7:6]
            instr+=tmp[6]
            instr+=tmp[7]
            instr+=tmp[4]
            instr+=tmp[5]
            instr+=tmp[2]
            instr+=tmp[3]
            instr+=tmp[0]
            instr+=tmp[1]
            #print(instr)
            op+=instr[6]
            op+=instr[7]
            #print(op[1])
            vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+instr+c+";\n"
            parse.addr+=1
            if op=='6F' or op=='EF' or op=='67' or op=='E7' or op=='63' or op=='E3' :
                #vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
                #parse.addr+=1
                #vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
                #parse.addr+=1
                #vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
                #parse.addr+=1
                #vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
                #parse.addr+=1
                pass
            elif op=='83' or op=='03':
                #vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
                #parse.addr+=1
                pass
            
            i+=4
            j+=4
            #print(i)
        
    return vfile
parse.addr = 0




path = sys.argv[1]
f=open(path,"r")

c='"'
i=0
char="x"
line=""
line=f.read()
cline=""
vfile=""
vf=open("build/code_mem.vhd","w")
vfile+="----------------------------------------------------------------------------------\n"
vfile+="-- Company:  SCiMOS\n"
vfile+="-- Engineer: Veeyceey\n"
vfile+="-- \n"
vfile+="-- Create Date: 24.05.2020 12:49:36\n"
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


vfile+="entity code_mem is\n"
vfile+="    port(\n"
vfile+="            i_en : in std_logic;\n"
vfile+="            i_addr : in std_logic_vector(31 downto 0);\n"
vfile+="            o_data : out std_logic_vector(31 downto 0);\n"
vfile+="            o_valid: out std_logic\n"
vfile+="    );\n"

vfile+="end code_mem;\n"

vfile+="architecture behave of code_mem is\n"
vfile+="attribute rom_style : string;\n"
vfile+="type mem_type is array(1023 downto 0) of std_logic_vector(31 downto 0);\n"
vfile+="signal mem : mem_type;\n"

vfile+="begin\n\n\n"
vfile+="    o_data <= mem(to_integer(unsigned(( i_addr(31 downto 2)))));\n"
vfile+="    o_valid<='1';\n\n\n"
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
vfile=vfile+"    mem("+str(int(parse.addr))+")<=x"+c+"00000033"+c+";\n"
parse.addr+=1
try:
    while i<len(line)-1:
        i+=1
        #print(i)
        char=line[i]
        if char == ":":
            vfile=parse( cline,vfile)
            #print(cline)
            cline=""
        else:
            cline+=str(char)
            #print(line)
finally:
    i=0
#print(vfile)

vfile+="end behave;\n"

vf.write(vfile) 
