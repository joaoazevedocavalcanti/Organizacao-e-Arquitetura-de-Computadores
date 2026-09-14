// multiplier_top.sv
// Módulo top-level da versão refinada do multiplicador de 32 bits
module multiplier_top (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        start,
    input  logic [31:0] multiplicand_in,
    input  logic [31:0] multiplier_in,

    output logic [63:0] product,
    output logic        done
);

    // Sinais internos entre controle e datapath
    logic load;
    logic compute_en;

    // Instancia do datapath
    multiplier_datapath datapath (
        .clk             (clk),
        .rst_n           (rst_n),
        .multiplicand_in (multiplicand_in),
        .multiplier_in   (multiplier_in),
        .load            (load),
        .compute_en      (compute_en),
        .product         (product)
    );

    // Instancia da FSM de controle
    multiplier_control control (
        .clk        (clk),
        .rst_n      (rst_n),
        .start      (start),
        .done       (done),
        .load       (load),
        .compute_en (compute_en)
    );

endmodule