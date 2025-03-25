module tb ();

string str1 = "Hello";

initial begin
    foreach(str1[i]) begin
        $display("str1[%0d] = %0s", i, str1[i]);
    end
    str1[0] = "h";
    $display("str1 = %s", str1);
    str1[0] = "hello";
    $display("str1 = %s", str1);
end


endmodule