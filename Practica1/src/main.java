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
import java.util.ArrayList;
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
        
        // Main
        mainPrincipal();

        // Funciones para el Experimento 3
        //experimento3_steps1();
        //experimento3_k_lambda1();
        //experimento3_k_lambda2();
        //experimento3_k_lambda3();
        //experimento3_stiter();
        //experimento3_steps_final(); 
    }
    
    private static void mainPrincipal() {
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            //seed = 313;
            
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
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Heurístico: " + goal.get_dinero());
                System.out.println("Tiempo: " + (finish - start));
                printInstrumentation(agent.getInstrumentation());
                printActions(agent.getActions());
            }
            
            else if (opcion == 2) {
                // Variables obtenidas mediante la experimentación
                int steps = 32000, stiter = 250, k = 30;
                double lambda = 0.0001;
                System.out.println("Simulated Annealing ");
                if (asignacion == 1) System.out.println("Asignación 1");
                else System.out.println("Asignación 2");
                System.out.println("Semilla: " + seed);
                Search alg = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
                Problem p = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(goal.printEstado());
                System.out.println("Heurístico: " + goal.get_dinero());
                System.out.println("Tiempo: " + (finish - start));
                printInstrumentation(agent.getInstrumentation());
            }
        } catch(Exception e) {
            System.out.println(e);
        }  
    }
    
    private static void experimento3_steps1() {
        try {
            int stiter = 100, k = 20;
            double lambda = 0.005;
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            
            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};
            
            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);
            
            // 
            int steps[] = {5000, 10000, 50000, 80000, 100000, 150000};
            
            System.out.println("Semilla: " + seed); System.out.println();
            for (int i = 0; i < steps.length; ++i) {
                System.out.println("steps = " + steps[i]);
                
                // Ejecución del Simulated Annealing 
                Search alg2 = new SimulatedAnnealingSearch(steps[i], stiter, k, lambda);
                Problem p2 = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double start2 = System.currentTimeMillis();
                SearchAgent agent2 = new SearchAgent(p2,alg2);
                double finish2 = System.currentTimeMillis();
                Estado goal2 = (Estado)alg2.getGoalState();
                System.out.println("Heurístico SA: " + goal2.get_dinero());
                System.out.println("Tiempo SA: " + (finish2 - start2));
                
                // Ejecución del Hill Climbing con las mismas condiciones
                Search alg1 = new HillClimbingSearch();
                Problem p1 = new Problem(state,
                        new GetSuccessorsHillClimbing(),
                        new SolucionTest(),
                        new FuncionHeuristica());
                double start1 = System.currentTimeMillis();
                SearchAgent agent1 = new SearchAgent(p1,alg1);
                double finish1 = System.currentTimeMillis();
                Estado goal1 = (Estado)alg1.getGoalState();
                System.out.println("Heurístico HC: " + goal1.get_dinero());
                System.out.println("Tiempo HC: " + (finish1 - start1));
                System.out.println();
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
    
    private static void experimento3_k_lambda1() {
        try {
            int stiter = 100, steps = 100000;

            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);

            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};

            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);

            // 
            int ks[] = {1, 5, 25, 125};
            double lambdas[] = {1, 0.01, 0.0001};

            for (int i = 0; i < ks.length; ++i) {
                for (int j = 0; j < lambdas.length; ++j) {
                    // Ejecución del Simulated Annealing 
                    Search alg = new SimulatedAnnealingSearch(steps, stiter, ks[i], lambdas[j]);
                    Problem p = new Problem(state,
                                new GetSuccessorsSimulatedAnnealing(),
                                new SolucionTest(),
                                new FuncionHeuristica());
                    double start = System.currentTimeMillis();
                    SearchAgent agent = new SearchAgent(p,alg);
                    double finish = System.currentTimeMillis();
                    Estado goal = (Estado)alg.getGoalState();
                    System.out.println(seed + " " + ks[i] + " " + lambdas[j] + " " + (int)goal.get_dinero() + " " + (finish - start));
                }
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
    
    private static void experimento3_k_lambda2() {
        try {
            int stiter = 100, steps = 100000;

            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);

            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};

            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);

            // 
            int ks[] = {25, 125, 625};
            double lambdas[] = {0.001, 0.0001, 0.0001};

            for (int i = 0; i < ks.length; ++i) {
                for (int j = 0; j < lambdas.length; ++j) {
                    // Ejecución del Simulated Annealing 
                    Search alg = new SimulatedAnnealingSearch(steps, stiter, ks[i], lambdas[j]);
                    Problem p = new Problem(state,
                                new GetSuccessorsSimulatedAnnealing(),
                                new SolucionTest(),
                                new FuncionHeuristica());
                    double start = System.currentTimeMillis();
                    SearchAgent agent = new SearchAgent(p,alg);
                    double finish = System.currentTimeMillis();
                    Estado goal = (Estado)alg.getGoalState();
                    System.out.println(seed + " " + ks[i] + " " + lambdas[j] + " " + (int)goal.get_dinero() + " " + (finish - start));
                }
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
    
        private static void experimento3_k_lambda3() {
        try {
            int stiter = 100, steps = 100000;

            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);

            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};

            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);

            // 
            int ks[] = {15, 30, 60, 90};
            double lambdas[] = {0.001, 0.0005, 0.0001};

            for (int i = 0; i < ks.length; ++i) {
                for (int j = 0; j < lambdas.length; ++j) {
                    // Ejecución del Simulated Annealing 
                    Search alg = new SimulatedAnnealingSearch(steps, stiter, ks[i], lambdas[j]);
                    Problem p = new Problem(state,
                                new GetSuccessorsSimulatedAnnealing(),
                                new SolucionTest(),
                                new FuncionHeuristica());
                    double start = System.currentTimeMillis();
                    SearchAgent agent = new SearchAgent(p,alg);
                    double finish = System.currentTimeMillis();
                    Estado goal = (Estado)alg.getGoalState();
                    System.out.println(seed + " " + ks[i] + " " + lambdas[j] + " " + (int)goal.get_dinero() + " " + (finish - start));
                }
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
        
        private static void experimento3_stiter() {
        try {
            int steps = 100000, k = 30;
            double lambda = 0.0001;

            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);

            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};

            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);

            // 
            int stiters[] = {50, 100, 200, 250, 500, 1000, 1500, 2000, 2500};

            for (int i = 0; i < stiters.length; ++i) {
                // Ejecución del Simulated Annealing 
                Search alg = new SimulatedAnnealingSearch(steps, stiters[i], k, lambda);
                Problem p = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(seed + " " + stiters[i] + " " + (int)goal.get_dinero() + " " + (finish - start));
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
        
    private static void experimento3_steps_final() {
        try {
            int stiter = 250, k = 30;
            double lambda = 0.0001;

            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);

            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};

            // Creamos las varibles para generar el Problema
            Centrales cent = new Centrales(centrales, seed);
            Clientes cli = new Clientes(1000,clientes,0.75, seed);
            Estado state = new Estado(cent, cli, 2);

            // 
            int steps[] = {10000, 16000, 32000, 128000, 256000, 512000};

            for (int i = 0; i < steps.length; ++i) {
                // Ejecución del Simulated Annealing 
                Search alg = new SimulatedAnnealingSearch(steps[i], stiter, k, lambda);
                Problem p = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(seed + " " + steps[i] + " " + (int)goal.get_dinero() + " " + (finish - start));
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