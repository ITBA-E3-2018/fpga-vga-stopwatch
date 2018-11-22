module fsm_enable(clk, signal, enable_count);
    input   clk, signal;
    output reg enable_count;

    parameter COUNT = 1'b1, NO_COUNT = 1'b0;

    reg state;

    initial
    begin
        state <= NO_COUNT;
        enable_count <= 0;
    end

    always @ (posedge clk)
    begin : FSM
    case(state)
        NO_COUNT:   if(signal == 1'b0)
                    begin
                        state <= NO_COUNT;
                        enable_count <= 0;
                    end
                    else if(signal == 1'b1)
                    begin
                        state <= COUNT;
                        enable_count <= 1;
                    end
        COUNT:      if(signal == 1'b0)
                    begin
                        state <= COUNT;
                        enable_count <= 1;
                    end
                    else if (signal == 1'b1)
                    begin
                        state <= NO_COUNT;
                        enable_count <= 0;
                    end
        default:    state <= NO_COUNT;
    endcase
    end
endmodule