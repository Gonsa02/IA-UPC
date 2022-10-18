/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author jeremy
 */
public class GetSuccessorsHillClimbing implements SuccessorFunction {
    public List getSuccessors(Object state){
        ArrayList retval = new ArrayList();
        Estado estado_actual = (Estado)state;
        int clientes = estado_actual.get_n_clientes();
        int centrales = estado_actual.get_n_centrales();
        System.out.println(estado_actual.get_dinero());
        
        // Aplicación de los operadores move
        for (int i = 0; i < clientes; ++i) {
            for (int j = -1; j < centrales; ++j) {
                if (estado_actual.move_efectivo(i, j)) {
                    Estado succesor = estado_actual.clonar();
                    succesor.asignar_cliente_a_central(i, j);
                    
                    String accion = succesor.printEstado();
                    Successor new_succ = new Successor(accion,succesor);
                    retval.add(new_succ);
                }
            }
        }
        
        // Aplicación de los operadores swap
        for (int i = 0; i < clientes; ++i) {
            for (int j = i+1; j < clientes; ++j) {

                if (estado_actual.swap_efectivo(i, j)) {
                    Estado succesor = estado_actual.clonar();
                   
                    succesor.swap(i, j);
                    
                    String accion = "Cliente " + i + " es intercambiado de central con el cliente " + j;
                    Successor new_succ = new Successor(accion,succesor);
                    retval.add(new_succ);
                }
            }
        }
        return retval;
    }
}
