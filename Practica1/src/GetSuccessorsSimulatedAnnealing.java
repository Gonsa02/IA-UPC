/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
/**
 *
 * @author jk
 */
public class GetSuccessorsSimulatedAnnealing implements SuccessorFunction {
    
    public List getSuccessors(Object state) {
        ArrayList retval = new ArrayList();
        Estado estado_actual = (Estado)state;
        
        int clientes = estado_actual.get_n_clientes();
        int centrales = estado_actual.get_n_centrales();
        
        Random rand = new Random();
        int indice_random = rand.nextInt(2);
        
        // Aplicamos el operador asignar_cliente_a_central
        if (indice_random == 0) {
            int i = rand.nextInt(clientes);
            int j = rand.nextInt(centrales);

            while (!estado_actual.move_efectivo(i, j)) {
                i = rand.nextInt(clientes);
                j = rand.nextInt(centrales);
            }

                Estado succesor = estado_actual.clonar();
                succesor.asignar_cliente_a_central(i, j);

                String accion = "Cliente " + i + " es transferido a la central " + j;
                Successor new_succ = new Successor(accion,succesor);
                retval.add(new_succ);
        }
        // Aplicamos el operador swap
        else {
            int i = rand.nextInt(clientes);
            int j = rand.nextInt(centrales);

            while (!estado_actual.swap_efectivo(i, j)) {
                i = rand.nextInt(clientes);
                j = rand.nextInt(centrales);
            }

            Estado succesor = estado_actual.clonar();

            succesor.swap(i, j);

            String accion = "Cliente " + i + " es intercambiado de central con el cliente " + j;
            Successor new_succ = new Successor(accion,succesor);
            retval.add(new_succ);
        }
        return retval;
    }
}


 


 