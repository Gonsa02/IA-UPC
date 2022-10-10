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
        System.out.println(estado_actual.get_dinero());
        Random rand = new Random();
        int indice_random = rand.nextInt(2);
        
        // Aplicamos el operador asignar_cliente_a_central
        if (indice_random == 0) {
            List<Integer> cliente1 = new ArrayList<>();
            List<Integer> central1 = new ArrayList<>();
            
            for (int i = 0; i < clientes; ++i) {
                for (int j = -1; j < centrales; ++j) {
                    if (estado_actual.move_efectivo(i, j)) {
                        Integer cli = i;
                        cliente1.add(cli);
                        Integer cent = j;
                        central1.add(cent);
                    }
                }
            }
             if (cliente1.isEmpty()) {
                System.out.println("No hay sucesores");
                return retval;
            }
            else {
                int indice = rand.nextInt(cliente1.size());
                int cli = cliente1.get(indice);
                int cent = central1.get(indice);
                Estado next = estado_actual.clonar();
                next.asignar_cliente_a_central(cli, cent);
                String accion = "Cliente " + cli + " es transferido a la central " + cent;
                Successor s = new Successor(accion,next);
                retval.add(s);
                return retval;
            }
        }
        // Aplicamos el operador swap
        else {
            List<Integer> cliente1 = new ArrayList<Integer>();
            List<Integer> cliente2 = new ArrayList<Integer>();
            for (int i = 0; i < clientes; ++i) {
                for (int j = i + 1; j < clientes; ++j) {
                    if (estado_actual.swap_efectivo(i, j)) {
                        Integer cli = i;
                        cliente1.add(cli);
                        Integer cli2 = j;
                        cliente2.add(cli2);
                    }
                }
            }
            if (cliente1.isEmpty()) {
                System.out.println("No hay sucesores");
                return retval;
            }
            else {
                int indice = rand.nextInt(cliente1.size());
                int cli = cliente1.get(indice);
                int cli2 = cliente2.get(indice);
                Estado next = estado_actual.clonar();
                next.swap(cli, cli2);
                String accion = "Cliente " + cli + " es intercambiado por el cliente " + cli2;
                Successor s = new Successor(accion,next);
                retval.add(s);
                return retval;
            }
        }
    }
}


 