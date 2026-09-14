// multiplier_control.sv (Estilo baseado no template original)

module multiplier_control (
    input  logic clk,
    input  logic rst_n,

    input  logic start,
    output logic done,

    output logic load,
    output logic compute_en
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        LOAD    = 2'b01,
        COMPUTE = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;

    logic [5:0] count;
    logic       count_en;
    logic       count_rst;

    // 1. Registrador do contador (igual à Imagem 1)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)         count <= '0;
        else if (count_rst) count <= '0;
        else if (count_en)  count <= count + 6'd1;
    end

    // 2. Registrador de estado
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else        state <= next_state;
    end

    // 3. Lógica de próximo estado
    always_comb begin
        next_state = state;
        case (state)
            IDLE:    if (start)          next_state = LOAD;
            LOAD:                        next_state = COMPUTE;
            COMPUTE: if (count == 6'd31) next_state = DONE;
                     else                next_state = COMPUTE;
            DONE:    if (!start)         next_state = IDLE;
            default:                     next_state = IDLE;
        endcase
    end

    // 4. Lógica de saída e controle do contador
    always_comb begin
        load       = 1'b0;
        compute_en = 1'b0;
        done       = 1'b0;
        count_en   = 1'b0;
        count_rst  = 1'b0;

        case (state)
            IDLE: begin
                count_rst = 1'b1;
            end

            LOAD: begin
                load      = 1'b1;
                count_rst = 1'b1;
            end

            COMPUTE: begin
                compute_en = 1'b1;
                count_en   = 1'b1;
            end

            DONE: begin
                done = 1'b1;
            end

            default: ;
        endcase
    end

endmodule