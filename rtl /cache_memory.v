module cache(
    input clk, rst,
    input [31:0] addr,
    input [31:0] wdata,
    input cpu_valid,
    output reg cpu_ready,
    output reg [31:0] rdata,
    output reg hit
);

reg [31:0] cache_data [0:15];
reg [27:0] tag [0:15];
reg valid_bit [0:15];

wire [3:0] index = addr[5:2];
wire [27:0] addr_tag = addr[31:6];

always @(posedge clk) begin
    if (rst) begin
        cpu_ready <= 0;
        hit <= 0;
    end else if (cpu_valid) begin
        if (valid_bit[index] && tag[index] == addr_tag) begin
            // CACHE HIT
            rdata <= cache_data[index];
            cpu_ready <= 1;
            hit <= 1;
        end else begin
            // CACHE MISS
            cache_data[index] <= wdata;
            tag[index] <= addr_tag;
            valid_bit[index] <= 1;
            cpu_ready <= 1;
            hit <= 0;
        end
    end else begin
        cpu_ready <= 0;
    end
end

endmodule
