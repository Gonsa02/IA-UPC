/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */

/**
 *
 * @author jeremy
 */
import IA.Energia.*;
import aima.search.framework.GraphSearch;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;
import java.util.Random;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
public class main {
 
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic her
        
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt();
            
            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};
            
            // Escogemos si queremos usar Hill Climbing (opcion == 1)
            // o Simulated Annealing (opcion == 2)
            int opcion = 1;
            
            // Escogemos si queremos generar la solución inicial con
            // asignar1 (asignacion == 1) o asignar2 (asignacion == 2)
            int asignacion = 2;
            
            // Creamos las varaibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, asignacion);
           
            if (opcion == 1) {
                System.out.print("Hill Climbing ");
                if (asignacion == 1) System.out.println("Asignación 1");
                else System.out.println("Asignación 2");
                System.out.println("Semilla: " + seed);
                Search alg = new HillClimbingSearch();
                Problem p = new Problem(state,
                            new GetSuccessorsHillClimbing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                SearchAgent agent = new SearchAgent(p,alg);
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Heurístico: " + goal.get_dinero());
                printInstrumentation(agent.getInstrumentation());
            }
            
            else if (opcion == 2) {
                System.out.println("Simulated Annealing ");
                if (asignacion == 1) System.out.println("Asignación 1");
                else System.out.println("Asignación 2");
                System.out.println("Semilla: " + seed);
                Search alg = new SimulatedAnnealingSearch(1000000, 1000, 50, 30);
                Problem p = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                SearchAgent agent = new SearchAgent(p,alg);
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Heurístico: " + goal.get_dinero());
                printInstrumentation(agent.getInstrumentation());
            }
        } catch(Exception e) {
            System.out.println(e);
        }  
    }
    
    private static void printInstrumentation(Properties properties) {
        Iterator keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }  
    }
    
    private static void printActions(List actions) {
        for (int i = 0; i < actions.size(); i++) {
            String action = (String) actions.get(i);
            System.out.println(action);
        }
    }
}
