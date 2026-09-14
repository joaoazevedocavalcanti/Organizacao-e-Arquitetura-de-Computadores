// multiplier_datapath.sv
// Datapath da versão refinada do multiplicador de 32 bits
module multiplier_datapath (
    input  logic        clk,
    input  logic        rst_n,

    //Entrada de dados
    input  logic [31:0] multiplicand_in,
    input  logic [31:0] multiplier_in,

    //Sinais vindo da FSM
    input  logic        load,
    input  logic        compute_en,

    //Saida do resultado
    output logic [63:0] product
);

    //Registrados internos
    logic [31:0] multiplicand_reg; 
    logic [63:0] product_reg;

     // ALU de 32 bits (opera sobre os 32 bits superiores )
    logic [31:0] alu_sum;
    logic        alu_carry;

    alu_32 alu (
        .a         (product_reg[63:32]), // 32 bits superiores 
        .b         (multiplicand_reg),
        .sum       (alu_sum),
        .carry_out (alu_carry)
    );

    //Saida combinacional   
    assign product = product_reg;

     // Atualizacao dos registradores
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multiplicand_reg <= '0;
            product_reg      <= '0;
        end else if (load) begin
            multiplicand_reg <= multiplicand_in;
            product_reg      <= {32'b0, multiplier_in};
        end else if (compute_en) begin
            if (product_reg[0])
                product_reg <= {alu_carry, alu_sum, product_reg[31:1]};
            else
                product_reg <= {1'b0, product_reg[63:1]};
        end
    end

endmodule