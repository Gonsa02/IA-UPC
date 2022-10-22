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
        
        // Variables obtenidas mediante la experimentación del Simulated Annealing
        int steps = 64000, stiter = 250, k = 30;
        double lambda = 0.0001;
        
        // Programa Principal de la Práctica
            programaPrincipal(steps, stiter, k, lambda);

        // Funciones para el Experimento 3
            //experimento3_steps(100, 20, 0.005);
            //experimento3_k_lambda1();
            //experimento3_k_lambda2();
            //experimento3_k_lambda3();
            //experimento3_stiter();
            //experimento3_steps(stiter, k, lambda);
        
        // Funciones para el experimento 4
            //experimento4_fijar_clientes();
            //experimento4_fijar_centrales();
        
        // Función para el experimento 6
            //experimento6(steps, stiter, k, lambda);
        
        // Función para el experimento 7
            //experimento7();
    }
    
    private static void programaPrincipal(int steps, int stiter, int k, double lambda) {
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            seed = 20;
            
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
            }
            
            else if (opcion == 2) {
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
    
    private static void experimento3_steps(int stiter, int k, double lambda) {
        try {
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
            
            // Escoger entre esta línea para el primer experimento con steps
            //int steps[] = {5000, 10000, 50000, 80000, 100000, 150000};
            // o esta segunda línea para el último experimento con steps
            int steps[] = {10000, 16000, 32000, 128000, 256000, 512000};
            
            for (int i = 0; i < steps.length; ++i) {
                // Ejecución del Simulated Annealing 
                Search algSA = new SimulatedAnnealingSearch(steps[i], stiter, k, lambda);
                Problem pSA = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double startSA = System.currentTimeMillis();
                SearchAgent agentSA = new SearchAgent(pSA,algSA);
                double finishSA = System.currentTimeMillis();
                Estado goalSA = (Estado)algSA.getGoalState();
                
                System.out.print(seed + " " + steps[i] + " " + (int)goalSA.get_dinero() + " ");
                
                // Ejecución del Hill Climbing con las mismas condiciones
                Search algHC = new HillClimbingSearch();
                Problem pHC = new Problem(state,
                        new GetSuccessorsHillClimbing(),
                        new SolucionTest(),
                        new FuncionHeuristica());
                double startHC = System.currentTimeMillis();
                SearchAgent agentHC = new SearchAgent(pHC,algHC);
                double finishHC = System.currentTimeMillis();
                Estado goalHC = (Estado)algHC.getGoalState();
                
                System.out.println((int)goalHC.get_dinero() + " " + (int)(finishSA - startSA) + " " + (int)(finishHC - startHC));
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
    
    private static void experimento4_fijar_clientes() {
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            
            // Configuramos los clientes
            double[] clientes = new double[]{0.25,0.3,0.45};
            
            for (int i = 1; i <= 3; ++i) {
                // Configuramos las centrales
                int[] centrales = new int[]{5*i, 10*i, 25*i};
                
                // Creamos las varibles para generar el Problema
                Clientes cli = new Clientes(1000,clientes,0.75, seed);
                Centrales cent = new Centrales(centrales, seed);
                Estado state = new Estado(cent, cli, 2);
                
                // Ejecución del Hill Climbing
                Search alg = new HillClimbingSearch();
                Problem p = new Problem(state,
                        new GetSuccessorsHillClimbing(),
                        new SolucionTest(),
                        new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(seed + " " + 40*i + " " + (int)goal.get_dinero() + " " + (int)(finish - start));
                System.out.println();
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
    
    private static void experimento4_fijar_centrales() {
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            
            // Configuramos los clientes y las centrales
            double[] clientes = new double[]{0.25,0.3,0.45};
            int[] centrales = new int[]{5, 10, 25};
            
            for (int i = 0; i <= 4; ++i) {
                // Creamos las varibles para generar el Problema
                Clientes cli = new Clientes(1000+500*i,clientes,0.25, seed);
                Centrales cent = new Centrales(centrales, seed);
                Estado state = new Estado(cent, cli, 2);
                
                // Ejecución del Hill Climbing
                Search alg = new HillClimbingSearch();
                Problem p = new Problem(state,
                        new GetSuccessorsHillClimbing(),
                        new SolucionTest(),
                        new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(seed + " " + (1000 + 500*i) + " " + (int)goal.get_dinero() + " " + (int)(finish - start));
                System.out.println(goal.printEstado());
                System.out.println();
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
        
    private static void experimento6(int steps, int stiter, int k, double lambda) {
        try {
            // Generamos una configuración inicial aleatoria
            Random generator = new Random(System.currentTimeMillis());
            int seed = generator.nextInt(500);
            
            // Configuramos los clientes
            double[] clientes = new double[]{0.25, 0.3, 0.45};
            
            for (int i = 1; i <= 3; ++i) {
                // Configuramos las centrales
                int[] centrales = new int[]{5, 10, 25*i};
                
                // Creamos las varibles para generar el Problema
                Clientes cli = new Clientes(1000,clientes,0.75, seed);
                Centrales cent = new Centrales(centrales, seed);
                Estado state = new Estado(cent, cli, 2);
                
                // Ejecución del Simulated Annealing 
                Search algSA = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
                Problem pSA = new Problem(state,
                            new GetSuccessorsSimulatedAnnealing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double startSA = System.currentTimeMillis();
                SearchAgent agentSA = new SearchAgent(pSA,algSA);
                double finishSA = System.currentTimeMillis();
                Estado goalSA = (Estado)algSA.getGoalState();
                int centASA = goalSA.getAsignacionesA(), centBSA = goalSA.getAsignacionesB(), centCSA = goalSA.getAsignacionesC();
                System.out.println(seed + " " + 25*i + " " + centASA + " " + centBSA + " " + centCSA + " " + (int)goalSA.get_dinero() + " " + (int)(finishSA - startSA));
                
                // Ejecución del Hill Climbing con las mismas condiciones
                Search algHC = new HillClimbingSearch();
                Problem pHC = new Problem(state,
                        new GetSuccessorsHillClimbing(),
                        new SolucionTest(),
                        new FuncionHeuristica());
                double startHC = System.currentTimeMillis();
                SearchAgent agentHC = new SearchAgent(pHC,algHC);
                double finishHC = System.currentTimeMillis();
                Estado goalHC = (Estado)algHC.getGoalState();
                int centAHC = goalHC.getAsignacionesA(), centBHC = goalHC.getAsignacionesB(), centCHC = goalHC.getAsignacionesC();
                System.out.println(seed + " " + 25*i + " " + centAHC + " " + centBHC + " " + centCHC + " " + (int)goalHC.get_dinero() + " " + (int)(finishHC - startHC));
                System.out.println();
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
    
    private static void experimento7() {
        try {
            // Generamos configuraciones iniciales con la semilla del enunciado
            int seed = 1234;
            
            // Configuramos las centrales y los clientes
            int[] centrales = new int[]{5,10,25};
            double[] clientes = new double[]{0.25,0.3,0.45};
            
            // Escogemos usar Hill Climbing (opcion == 1)
            int opcion = 1;
            
            // Escogemos generar la solución inicial con asignar2 (asignacion == 2)
            int asignacion = 2;
            
            // Ejecutamos un mínimo de repeticiones
            for (int i = 0; i < 10; ++i) {
                // Creamos las varaibles para generar el Problema
                Centrales cent = new Centrales(centrales, seed);
                Clientes cli = new Clientes(1000,clientes,0.75, seed);
                Estado state = new Estado(cent, cli, asignacion);

                Search alg = new HillClimbingSearch();
                Problem p = new Problem(state,
                            new GetSuccessorsHillClimbing(),
                            new SolucionTest(),
                            new FuncionHeuristica());
                double start = System.currentTimeMillis();
                SearchAgent agent = new SearchAgent(p,alg);
                double finish = System.currentTimeMillis();
                Estado goal = (Estado)alg.getGoalState();
                System.out.println(seed + " " + (int)(finish - start));
                System.out.println(goal.printEstado());
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