module alu(
    input clk_p_i,
    input reset_n_i,
    input [7:0]data_a_i,
    input [7:0]data_b_i,
    input [2:0]inst_i,
    output reg [15:0] data_o
);
reg [15:0]data_i;
reg [7:0]data_a_ff,data_b_ff;
reg [2:0]inst_ff;

reg [15:0]result_and,result_xor,result_div2,result_mod,result_mul,result_add,result_sub,result_abs;

wire [7:0]temp_a,temp_b;
always@(posedge clk_p_i or negedge reset_n_i)begin
    if(!reset_n_i)begin
            data_a_ff <= 0;
            data_b_ff <= 0;
            inst_ff <= 0;
        end
    else begin
            data_a_ff <= data_a_i;
            data_b_ff <= data_b_i;
            inst_ff <= inst_i;
        end
end

assign temp_a = data_a_ff[7] ? {8'b1,data_a_ff}  : {8'b0,data_a_ff};
assign temp_b = data_b_ff[7] ?{ 8'b1,data_b_ff}  : {8'b0,data_b_ff};

always@(*)begin
    result_add = $signed(temp_a)+$signed(temp_b);   
    result_sub = $signed(temp_b)-$signed(temp_a);   
    result_mul = {8'b0,data_a_ff }*{ 8'b0,data_b_ff};
    result_and = {8'b0,data_a_ff & data_b_ff};
    result_xor = {8'b0,data_a_ff ^ data_b_ff};
    result_abs = {8'b0,data_a_ff[7]? ~data_a_ff+1'b1  : data_a_ff};   
    result_div2 = (data_a_ff+data_b_ff)>>1;   
    result_mod = {8'b0,data_b_ff % data_a_ff };
end

always@(*)begin
    case (inst_ff)
        3'b000: data_i = result_add;
        3'b001: data_i = result_sub;
        3'b010: data_i = result_mul;
        3'b011: data_i = result_and;
        3'b100: data_i = result_xor;
        3'b101: data_i = result_abs;
        3'b110: data_i = result_div2;
        3'b111: data_i = result_mod;
        default: data_i = 0;
    endcase
end

always@(posedge clk_p_i or negedge reset_n_i)begin
    if(!reset_n_i)begin
            data_o <= 0;
        end
    else begin
            data_o <= data_i;
    end
end
endmodule