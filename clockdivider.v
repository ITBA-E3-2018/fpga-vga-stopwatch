module clockdivider (			// Módulo de división de clock.
input wire boardCLK, 			// Recibe el clock de la FPGA: 50Mhz para Altera De0-Nano EP4CE22F17C6N.
input wire [31:0] divider,		// El divisor deseado, en formato de bus de 32 bits. (Binario no signado, 
										// interpreta correctamente enteros distintos de cero solamente).
										// De llamárselo con un cero, el clock resultante nunca sale de su estado bajo.
output wire clk_out				// Devuelve el resultado de la división, un clock de menor frecuencia.
);

// Declaración de parámetros y registros de uso interno:

reg [31:0] counter; 				// Se genera un contador tan grande como el divisor.
reg clk; 							// Registro del clock. Aquí se guarda su estado.	

// Bloque always para el control del divisor:

always @(posedge boardCLK)
begin
	counter <= counter + 1; // Cuenta hasta el divisor y al llegar genera un pulso de clock tras reiniciar el contador.
	if(counter == divider)
	begin
		counter<=0;
		clk = !clk; // Generación del pulso de clock.
	end
end


assign clk_out = clk; // Asignación del cable de salida al registro del clock.

endmodule