`include "mux.v"
`include "mux4to1.v"
`include "programCounter.v"
`include "instruction_mem.v"
`include "buffer.v"
`include "bufferWE.v"
`include "data_mem.v"
//`include "registerForward.v"
`include "registers.v"
`include "add.v"
`include "alu.v"
//`include "aluControl.v"
`include "comparator.v"
`include "control.v"
//`include "shiftLeft.v"
`include "signExtend.v"
`include "zeroSignExtend.v"

module cpu(input clk, rst);
	//---- Fetch Wires ----
	wire [15:0] inst_out_tmp, pc_out_tmp, fetch_adder_out, decode_adder_out, pc_in, decode_buffer_out;

	//---- Decode Wires ----
	wire [15:0] write_r15_in, write_data_in, read_r15_out, readData1_out, readData2_out, signExt2_out, zeroExtend_out, extend_out,
		    execute_buffer_out1, execute_buffer_out2, execute_buffer_out3;
	wire [3:0] signExt1_out, execute_buffer_out4, execute_buffer_out5, ifdf_op1, ifdf_op2;

	//---- Execute Wires ----
	wire [15:0] aluSrc1_out, aluSrc2_out, aluSrc3_out, aluSrc4_out, alu_out, mem_buffer_out1, mem_buffer_out2;
	wire [3:0] fw_out, mem_buffer_out3;
	wire cout;	
	//---- Memory Wires ----
	wire [15:0] readData_out, wb_buffer_out1, wb_buffer_out2;
	wire [3:0] wb_buffer_out3;

	//---- Write Back Wires ----
	wire [15:0] wb_out;

	//---- Control/AluControl Wires ----
	wire [3:0] fw_opCode_out, fw_funCode_out;
	wire [1:0] seSrc_out, cpCtrl_out, memWrite_out, memRead_out, memToReg_out;
	wire regWrite_out, seCtrl_out, aluSrc1_ctrl_out, aluSrc4_ctrl_out, fwSrc_out, pcSrc_out;

	//---- Fetch Stage ----
	add a1(.dataIn_1(pc_out_tmp), .dataIn_2(16'd2), .dataOut(fetch_adder_out));

	mux #(.N(16)) m1(.sel(pcSrc_out/*PC src*/), .d0(decode_adder_out), .d1(fetch_adder_out), .y(pc_in));
	

	programCounter p1(.clk(clk), .rst(rst), .w_enable(1'b1/*"Hazard Signal"*/), .inc(pc_in), .pc(pc_out_tmp));

	instruction_mem i1(.clk(clk), .rst(rst), .addr(pc_out_tmp), .inst_out(inst_out_tmp));

	bufferWE #(.N(16)) b1 (.data_in(inst_out_tmp), .clk(clk), .w_enable (1'b1), .rst(rst), .data_out(decode_buffer_out));

	//---- Fetch Stage End ----
	
	
	
	//---- Decode Stage ----
	registers r1 (.regAddress1(decode_buffer_out[11:8]), .regAddress2(decode_buffer_out[7:4]), .writeAddress(decode_buffer_out[11:8]),
		      .writeData(write_data_in), .writeR15(write_r15_in), .clk(clk), .rst(rst), .regWrite(1'b0/*regWrite_out*/),
		      .readData1(readData1_out),.readData2(readData2_out),.readR15(read_r15_out));

//	comparator c1 (.branchControl(2'd0/*Cp Ctrl*/), .Op1(readData1_out), .r15(read_r15_out), .branch(/*Branch Output*/));

	control ctrl(.opCode(decode_buffer_out[15:12]), .funCode(decode_buffer_out[3:0]), .fw_opCode(fw_opCode_out), 
		     .fw_funCode(fw_funCode_out), .seSrc(seSrc_out), .cpCtrl(cpCtrl_out), .memWrite(memWrite_out), 
		     .memRead(memRead_out), .memToReg(memToReg_out), .regWrite(regWrite_out), .seCtrl(seCtrl_out), 
		     .aluSrc1(aluSrc1_ctrl_out), .aluSrc4(aluSrc4_ctrl_out), .fwSrc(fwSrc_out), .pcSrc(pcSrc_out));


	mux4to1 #(.N(4)) m2(.sel(seSrc_out), .d0(decode_buffer_out[3:0]), .d1(decode_buffer_out[7:4]), .d2(decode_buffer_out[11:8]),
		 .d3(4'd0), .y(signExt1_out));

	mux #(.N(16)) m3(.sel(seCtrl_out), .d0(signExt2_out), .d1(zeroExtend_out), .y(extend_out));

	signExtend #(.N(4)) s1 (.dataIn(signExt1_out), .dataOut(signExt2_out));

	zeroSignExtend z1(.dataIn(decode_buffer_out[7:0]/*8-bit input*/), .dataOut(zeroExtend_out));

	//readData1
	bufferWE #(.N(16)) b2 (.data_in(readData1_out), .clk(clk), .w_enable(1'b1), .rst(rst), .data_out(execute_buffer_out1));

	//readData2
	bufferWE #(.N(16)) b3 (.data_in(readData2_out), .clk(clk), .w_enable(1'b1), .rst(rst), .data_out(execute_buffer_out2));
	
	//Extend
	bufferWE #(.N(16)) b4 (.data_in(extend_out), .clk(clk), .w_enable(1'b0/*w_enable*/), .rst(rst), .data_out(execute_buffer_out3));	

	//IF/ID op1_wire1
	bufferWE #(.N(4)) b5 (.data_in(ifdf_op1), .clk(clk), .w_enable(1'b0/*w_enable*/), .rst(rst), .data_out(execute_buffer_out4));

	//IF/ID op2_wire2
	bufferWE #(.N(4)) b6 (.data_in(ifdf_op2), .clk(clk), .w_enable(1'b0/*w_enable*/), .rst(rst), .data_out(execute_buffer_out5));
	
	
	//---- Decode Stage End ----
	


	//---- Execute Stage ----
	mux4to1 #(.N(16)) m4(.sel(2'd0/*aluSrc2*/), .d0(execute_buffer_out2), .d1(wb_out), .d2(16'd0/**/), .d3(16'd0), .y(aluSrc2_out));
	
	mux4to1 #(.N(16)) m5(.sel(2'd0/*aluSrc3*/), .d0(execute_buffer_out1), .d1(wb_out), .d2(16'd0/**/), .d3(16'd0), .y(aluSrc3_out));

	mux #(.N(16)) m6(.sel(aluSrc1_ctrl_out), .d0(aluSrc2_out), .d1(execute_buffer_out3), .y(aluSrc1_out));
	
	mux #(.N(16)) m7(.sel(aluSrc4_ctrl_out), .d0(aluSrc3_out), .d1(execute_buffer_out3), .y(aluSrc4_out));

	mux #(.N(4)) m8(.sel(fwSrc_out), .d0(execute_buffer_out4), .d1(execute_buffer_out5), .y(fw_out));

	alu alu1 (.A(aluSrc1_out), .B(aluSrc4_out), .Operation(3'd0/*alu op*/), .signFlag(cout), .Out(alu_out), .R(write_r15_in));

//	aluControl aluC (.opCode(), .funCode(), .aluOp());

	//ALU_out
	buffer #(.N(16)) b7 (.data_in(alu_out), .clk(clk), .rst(rst), .data_out(mem_buffer_out1));

	//sw_out
	buffer #(.N(16)) b8 (.data_in(aluSrc4_out), .clk(clk), .rst(rst), .data_out(mem_buffer_out2));

	//FW_out
	buffer #(.N(4)) b9 (.data_in(fw_out), .clk(clk), .rst(rst), .data_out(mem_buffer_out3));

//	registerForward rf (

	//---- Execute Stage End ----


	//---- Memory Stage ----
	data_mem d1(.rst(rst), .clk(clk), .memRead(memRead_out), .memWrite(memWrite_out), .addr(mem_buffer_out1),
		    .writeData(mem_buffer_out2),  .readData(readData_out));

	bufferWE #(.N(16)) b10 (.data_in(readData_out), .clk(clk), .w_enable(1'b1/**/), .rst(rst), .data_out(wb_buffer_out1));

	bufferWE #(.N(16)) b11 (.data_in(mem_buffer_out1), .clk(clk), .w_enable(1'b1/**/), .rst(rst), .data_out(wb_buffer_out2));

	bufferWE #(.N(4)) b12 (.data_in(mem_buffer_out3), .clk(clk), .w_enable(1'b1/**/), .rst(rst), .data_out(wb_buffer_out3));
	//---- Memory Stage End ----
	
	
	//---- Write Back Stage ----
	mux #(.N(16)) m9 (.sel(1'b0), .d0(wb_buffer_out1), .d1(mem_buffer_out1), .y(wb_out));
	//---- Write Back Stage End ----
endmodule
