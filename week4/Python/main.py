import os
#convert image to binary text file
os. system('python3 /home/ngocthai18521383/CE434.L21/week4/conv.py')
#compile hdl
os.system ('cd /home/ngocthai18521383/CE434.L21/week4')
os.system ('vlog Addition_Subtraction.v compare.v Rounding.v FP32_To_Int.v convert.v Counter.v except.v fpu.v IMEM.v Multiplication.v pc.v post_norm.v pre_norm.v pre_norm_fmul.v primitives.v priority_encoder.v RGB_to_HSL.v testbench.v')
#run simulation
os.system ('vsim -c -do "run -all" testbench')
#Convert RGB (text file) to HSL: using python
os.system ('python3 rgb_hsl.py')
#compare result between python and hdl
os.system ('python3 comparetxt.py')
