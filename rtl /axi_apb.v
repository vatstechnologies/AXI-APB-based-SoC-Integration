module axi_to_apb_bridge(
    input clk, rst,
    input [31:0] addr, wdata,
    output reg [31:0] rdata,
    input valid,
    output reg ready
);

reg [31:0] mem [0:255];

always @(posedge clk) begin
    if (rst) begin
        ready <= 0;
    end else if (valid) begin
        mem[addr[7:0]] <= wdata;
        rdata <= mem[addr[7:0]];
        ready <= 1;
    end else begin
        ready <= 0;
    end
end

endmodule
