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
        
        try{
          int[] centrales = new int[]{5,10,25};
          double[] clientes = new double[]{0.25,0.3,0.45};
          
          Centrales cent = new Centrales(centrales, 1234);
          System.out.println(1);
          Clientes cli = new Clientes(1000,clientes,0.25, 1234);
          System.out.println(2);
          Estado state = new Estado(cent, cli, 1);
          System.out.println(3);
          Problem p = new Problem(state,
                                  new GetSuccessorsSimulatedAnnealing(),
                                  new SolucionTest(),
                                  new FuncionHeuristica());
          System.out.println(4);
          Search alg = new SimulatedAnnealingSearch();
          System.out.println(5);
          SearchAgent agent = new SearchAgent(p,alg);
          System.out.println(6);
          System.out.println();
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } 
        catch(Exception e){
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
         System.out.println(actions.size());
        for (int i = 0; i < actions.size(); i++) {
            String action = (String) actions.get(i);
            System.out.println(action);
        }
    }
    
}
