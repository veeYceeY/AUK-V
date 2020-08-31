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
            vfile=vfile+"mem("+str(int(parse.addr))+")<=x"+c+instr+c+";\n"
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

i=0
char="x"
line=""
line=f.read()
cline=""
vfile=""
vf=open("codemem.v","w")
print(len(line))
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
vf.write(vfile) 














# import sys

# def parse_hex_line( line ):
#     if len( current_line ) == 0: return
#     bytecount = int( line[0:2], 16 )
#     address = int( line[2:6], 16 )
#     rec_type = int( line[6:8], 16 )

#     rec_output = str(hex(address)) + '\t(' + str(bytecount) + ')\t'
#     if rec_type == 0:
#         rec_output += '(data)'
#         rec_output += '\t\t' + line[8:(8+2*(bytecount))]
#     elif rec_type == 1:
#         rec_output += '(end of file)'
#     elif rec_type == 2:
#         rec_output += '(extended segment address)'
#     elif rec_type == 3:
#         rec_output += '(start segment address)'
#     elif rec_type == 4:
#         rec_output += '(extended linear address)'
#     elif rec_type == 5:
#         rec_output += '(start linear address)'
#     print (rec_output)

# #   (1) Open the Hex File
# hex_file_path = sys.argv[1]
# print ("Parsing " + hex_file_path)
# hex_file = open(hex_file_path, "rb")

# #   (2) Analyze the hex file line by line
# current_line = ""
# try:
#     byte = "1" # initial placeholder
#     while byte != "":
#         print(byte)
#         byte = hex_file.read(1)
#         if byte == ":":
#             #   (1) Parse the current line!
#             parse_hex_line( current_line )
#             #   (2) Reset the current line to build the next one!
#             current_line = ""
#         else:
#             current_line += str(byte)
#          parse_hex_line( current_line )
# finally:
#     hex_file.close()
