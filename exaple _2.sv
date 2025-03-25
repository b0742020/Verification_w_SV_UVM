module tb;
logic [63:0]vecs[8];
initial begin
    foreach(vecs[i])begin
        case(i)
            0: vecs[i] = '1;
            1: vecs[i] = 64'b0 -1;
            2: vecs[i] = {64{1'b1}};
            3: vecs[i] = ~64'b0;
            4: vecs[i] = 'b1;
            5: vecs[i] = 0 -1;
            6: vecs[i] = {64{1}};
            7: vecs[i] = -0;
        endcase
        $display("vecs[%0d] = 'h%x",i,vecs[i]);
    end
end

endmodule