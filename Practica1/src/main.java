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
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};
            int opcion = 1;
            Centrales cent = new Centrales(centrales, 1234);
            System.out.println(1);
            Clientes cli = new Clientes(1000,clientes,0.75, 1234);
            System.out.println(2);
            Estado state = new Estado(cent, cli, 2);
             System.out.println(3);
          
            System.out.println(4);
             Search alg1 = new HillClimbingSearch();
             Search alg2 = new SimulatedAnnealingSearch(1000000, 1000, 50, 30);
             System.out.println(5); System.out.println();
           
            if (opcion == 1) {
                Problem p = new Problem(state,
                            new GetSuccessorsHillClimbing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                SearchAgent agent = new SearchAgent(p,alg1);
                Estado goal = (Estado)alg1.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Hill Climbing ganancias = " + goal.get_dinero());
                printInstrumentation(agent.getInstrumentation());
            }
            else if (opcion == 2) {
                Problem p = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                SearchAgent agent = new SearchAgent(p,alg2);
                Estado goal = (Estado)alg2.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Hill Climbing ganancias = " + goal.get_dinero());
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
