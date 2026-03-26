module cpu_master(
    input clk, rst,
    output reg [31:0] addr, wdata,
    input [31:0] rdata,
    output reg valid,
    input ready
);

reg [3:0] state;

always @(posedge clk) begin
    if (rst) begin
        state <= 0;
        valid <= 0;
    end else begin
        case(state)
            0: begin
                addr <= 32'h0000_0004;
                wdata <= 32'hDEADBEEF;
                valid <= 1;
                state <= 1;
            end
            1: if (ready) begin
                valid <= 0;
                state <= 2;
            end
            2: begin
                addr <= 32'h0000_0004;
                valid <= 1;
                state <= 3;
            end
            3: if (ready) begin
                valid <= 0;
                state <= 4;
            end
        endcase
    end
end

endmodule
