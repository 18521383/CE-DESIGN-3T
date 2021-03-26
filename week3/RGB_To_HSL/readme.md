- Bộ RGB_to_HSL được thiết kế bằng verilog: nhận input đầu vào là giá trị của R, G, B được dịnh dạng binary, qua bộ chuyển sẽ cho ra kết quả output là floating point của H, S, L được lưu dưới dạng IEEE 754 single precision. 
- Thiết kế bộ RGB sang HSL vẫn chưa được tối ưu.
- Divide chưa thiết kế để tách khỏi bộ fpu tìm được trên google.
- sourcecode bộ FPU https://opencores.org/websvn/listing?repname=fpu&path=%2Ffpu%2Fbranches%2Frusselmann%2Fverilog%2F#path_fpu_branches_russelmann_verilog_
![BT1](https://user-images.githubusercontent.com/80138353/112620541-42ded500-8e5b-11eb-81c1-6ec49d71d0e6.jpg)
