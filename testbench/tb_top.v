module tb;

reg clk = 0;
reg rst = 1;

always #5 clk = ~clk;

top uut (
    .clk(clk),
    .rst(rst)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb);

    #20 rst = 0;

    #200 $finish;
end

endmodule
