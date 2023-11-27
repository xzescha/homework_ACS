.eqv    NAME_SIZE 256	
.eqv    TEXT_SIZE 512

.data
	file_name: .space NAME_SIZE
	out_file_name: .space NAME_SIZE
	strbuf:	.space TEXT_SIZE
	welcome: .asciz "==========================================================\n|   Welcome to my program! Hope you'll enjoy using it!   |\n==========================================================\n"
	bye: .asciz "===================== End of output ======================"
	input_nof: .asciz "	Enter path to input file here -> "
	script_running: .asciz "	Doing some magic with file... While waiting watch out, there's a cat over here 0_0"
	ascii_art: .asciz "|                      (`.-,')|\n|                    .-'     ;|\n|                _.-'   , `,- |\n|          _ _.-'     .'  /._ |\n|        .' `  _.-.  /  ,'._;)|\n|       (       .  )-| (      |\n|        )`,_ ,'_,'  \_;)      |\n|('_  _,'.'  (___,))          |\n `-:;.-'\n"
	output_nof: .asciz "	Enter path to output file here -> "
	success: .asciz "	Successfully done writing to file! You're lucky man!"
	errname: .asciz "Wrong name or path to file. Try again\n"
	errread: .asciz "Error reading file. Aborting.\n"
.text
	.include "ihw3notmainscripts.s" 
	.include "ihw3magicscript.s"
	hello
	input(s0)
	do_magic(s0)
