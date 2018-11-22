// Esta fsm controla que los pulsadores
// generen una sola salida en el instante que se pulsan
// y no vuelvan a generar otra seÃ±al en tanto
// no se suelte y vuelva a presionar.

// Debe tener u clock tal que 'filtre' el rebote
// y tal que permita presionarlo repetidamente relativamente 'rapido'

module fsm_boton(clk, btn, signal);

    input clk, btn;
    output signal;

    wire clk, btn;
    reg signal;

    parameter IDLE = 1'b0, PRESSED = 1'b1;

    reg state, next_state;

    initial
    begin
        state <= IDLE;
        signal <= 0;
    end

    always @ (posedge clk)
    begin: FSM
    case(state)
        IDLE:       if(btn == 1'b0)
                    begin
                        state <= PRESSED;
                        signal <= 1;
                    end
                    else if(btn == 1'b1)
                    begin
                        state <= IDLE;
                        signal <=0;
                    end
        PRESSED:    if(btn == 1'b0)
                    begin
                        state <= PRESSED;
                        signal <= 0;
                    end
                    else if(btn == 1'b1)
                    begin
                        state <= IDLE;
                        signal <= 0;
                    end
        default:    state <= IDLE;
                    
    endcase
    end
endmodule