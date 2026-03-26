module top (
    input clk,
    input rst
);

wire [31:0] addr, wdata, rdata;
wire valid, ready;
wire hit;

// CPU
cpu_master cpu (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata),
    .valid(valid),
    .ready(ready)
);

// CACHE
cache cache_inst (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .wdata(wdata),
    .cpu_valid(valid),
    .cpu_ready(ready),
    .rdata(rdata),
    .hit(hit)
);

// AXI to APB bridge (used on miss)
axi_to_apb_bridge bridge (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata),
    .valid(valid & ~hit),
    .ready()
);

endmodule
