import os
#convert image to binary text file
os. system('python3 /home/ngocthai18521383/CE434.L21/week3/conv.py')
#compile hdl
os.system ('cd /home/ngocthai18521383/CE434.L21/week3')
os.system ('vlog Addition_Subtraction.v compare.v convert.v Counter.v except.v fpu.v IMEM.v Multiplication.v pc.v post_norm.v pre_norm.v pre_norm_fmul.v primitives.v priority_encoder.v RGB_to_HSL.v testbench.v')
#run simulation
os.system ('vsim -c -do "run -all" testbench')
#convert output from HDL (floating point 32bit) to float
os.system ('python3 32bitFP_to_float.py')
#Convert RGB (text file) to HSL: using python
os.system ('python3 rgb_hsl.py')
#compare result between python and hdl
os.system ('python3 comparetxt.py')
