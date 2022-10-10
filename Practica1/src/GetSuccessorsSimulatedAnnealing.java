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
        ArrayList v = new ArrayList();
        
        // Aplicamos el operador asignar_cliente_a_central
        if (indice_random == 0) {
            for (int i = 0; i < clientes; ++i) {
                for (int j = -1; j < centrales; ++j) {
                    if (estado_actual.move_efectivo(i, j)) {
                        Estado succesor = estado_actual.clonar();
                        succesor.asignar_cliente_a_central(i, j);
                    
                        String accion = "Cliente " + i + " es transferido a la central " + j;
                        Successor new_succ = new Successor(accion,succesor);
                        v.add(new_succ);
                    }
                }
            } 
        }
        // Aplicamos el operador swap
        else {
            for (int i = 0; i < clientes; ++i) {
                for (int j = 0; j < clientes; ++j) {
                    if (estado_actual.swap_efectivo(i, j)) {
                        Estado succesor = estado_actual.clonar();
                        succesor.swap(i, j);
                        String accion = "Cliente " + i + " es intercambiado de central con el cliente " + j;
                        Successor new_succ = new Successor(accion,succesor);
                        v.add(new_succ);
                    }
                }
            }
        }
        
        if (v.isEmpty()) {
            System.out.println("No hay sucesores");
            return retval;
        }
        else {
            Successor randomSuccessor = (Successor)v.get(rand.nextInt(v.size()));
            String accion = new String(randomSuccessor.getAction());
            Estado succesor = ((Estado)randomSuccessor.getState()).clonar();
            System.out.println(succesor == randomSuccessor.getState());
            retval.add(new Successor(accion,succesor));
        }
        
        return retval;
    }
}
