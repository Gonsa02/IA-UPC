/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import IA.Energia.Central;
import IA.Energia.Centrales;
import IA.Energia.Cliente;
import IA.Energia.Clientes;
import java.util.Random;
import java.lang.Math;
import java.util.Arrays;
import IA.Energia.VEnergia;
/**
 *
 * @author jeremy
 */
public class Estado {
   private int[] asignacion_clientes;
   private int[] numero_clientes_central;
   private int dinero;
   private static Centrales ref_centrales;
   private static Clientes ref_clientes;
   
   private static double distancia_euclidiana(Cliente cl, Central c) {
       int pos_x_central = c.getCoordX();
       int pos_y_central = c.getCoordY();
       int pos_x_cliente = cl.getCoordX();
       int pos_y_cliente = cl.getCoordY();
       int distancia_x = Math.abs(pos_x_central - pos_x_cliente);
       int distancia_y = Math.abs(pos_y_central - pos_y_cliente);
       return Math.hypot((double)distancia_x, (double)distancia_y);
   }
   
   private static int[] getNCentrales(int k, int dist_cli, double[] distancias_manhattan) {
   		int l = distancias_manhattan.binarySearch(dist_cli);
   		int r = l + 1;
   		int count = 0;
   		int n = distancias_manhattan.size();
   		int sol = new int[k];
   		
   		while (l >= 0 && r < n && count < k) {
   			if (dist_cli - distancias_manhattan[l] < dist_cli - distancias_manhattan[r])
   				sol[count++] = l--;
   			else
   				sol[count++] = r++;
   		}
   		while (count < k && l >= 0)
   			sol[count++] = l--;
   		
   		while (count < k && r < n)
   			sol[count++] = r++;
   		
   		// Ordenem aleatòriament els elements
   		List<int> list = Arrays.asList(sol);
   		Collections.shuffle(list);
   		list.toArray(sol);
   		
   		return sol;
   	}
   	
   	private static boolean centralValida(int indice, Cliente cli) {
   		Central cent = ref_centrales.get(indice);
        
        double eucli_dist = distancia_euclidiana(cli, cent);
        // Calculamos la producción 
        double necesidad_cliente = cli.getConsumo();
        double porcentaje = VEnergia.getPerdida(eucli_dist);
        necesidad_cliente = necesidad_cliente/(1-porcentaje);
        return producciones_aseguradas[indice] + necesidad_cliente <= cent.getProduccion();
    }
   
	private static void asignar1(int[] clientes, int[] numero_clientes_central){
   		Random rand = new Random();
   	    int tam = clientes.length;
   	    double[] producciones_aseguradas = new double[ref_centrales.size()];
     	
     	// Primero asignamos centrales a los clientes asegurados
   	    for (int cliente = 0; cliente < tam; ++cliente) {
        	// Elegimos la central que va escoger [0 hasta num.centrales-1]
           	Cliente cli = ref_clientes.get(cliente);
           	if (cli.getTipo() == Cliente.GARANTIZADO) {
            	int indice_random = rand.nextInt(ref_centrales.size());
            	boolean buena_asignacion = false;
               	while (!buena_asignacion) {
               		if (centralValida(indice_random, cli) {
                		clientes[cliente] = indice_random;
                  		++numero_clientes_central[indice_random];
                  		producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + cli.getConsumo();
                  		buena_asignacion = true;
                	}
                	else indice_random = rand.nextInt(ref_centrales.size());
               	}
            }
        }
        
    	// Una vez todos los clientes asegurados tienen una central asignada hacemos la asignacion de los no asegurados
    	for (int cliente = 0; cliente < tam; ++cliente) {
    		// Elegimos la central que va escoger [0 hasta num.centrales-1]
        	Cliente cli = ref_clientes.get(cliente);
        	if (cli.getTipo() == Cliente.NOGARANTIZADO) {
        		int indice_random = rand.nextInt(ref_centrales.size());
            	if (centralValida(indice_random, cli) {
            		clientes[cliente] = indice_random;
              	  ++numero_clientes_central[indice_random];
              	  producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + cli.getConsumo();
           		}
           		else clientes[cliente] = -1;
        	}
    	}
	}
   
   private static void asignar2(int[] clientes, int[] numero_clientes_central) {
   		Random rand = new Random();
   		int tam = clientes.length;
   		double[] producciones_aseguradas = new double[ref_centrales.size()];
   		int k = 5;
       	
       	// Hacemos un vector con las distancias
       	int[] distancias_manhattan = new int[ref_centrales.size()];
       	for (int i = 0; i < ref_centrales.size(); ++i) {
       		Central cent = ref_centrales.get(i);
       		distancias_manhattan[i] = cent.getCoordX() + cent.getCoordY();
       	}
       	// Ordenamos las distancias crecientemente
     	distancias_manhattan.sort();
     	
     	// Primero asignamos centrales a los clientes asegurados
        for (int cliente = 0; cliente < tam; ++cliente) {
        	Cliente cli = ref_clientes.get(cliente);
           
           	if (cli.getTipo() == Cliente.GARANTIZADO) {
            	int dist_cli = cli.getCoordX() + cli.getCoordY();
               	boolean buena_asignacion = false;
               	// Obtenemos las k centrales más cercanas a cli
               	int[] centrales_mas_cercanas = getNCentrales(k, dist_cli, distancias_manhattan);
               
               	for (int indice = 0; indice < centrales_mas_cercanas.size() && !buena_asignacion; ++indice) {
               		int ind = centrales_mas_cercanas[indice];
               		if (centralValida(ind, cli)) {
               			clientes[cliente] = ind;
                 		++numero_clientes_central[ind];
                  		producciones_aseguradas[ind]  = producciones_aseguradas[ind] + cli.getConsumo();
                  		buena_asignacion = true;
                  	}
               	}
               
               	// Si no hemos podido asignar alguna de las k centrales más cercanas a cli entonces le asignamos una central aleatoriamente
               	int indice_random = rand.nextInt(ref_centrales.size());
               	while (!buena_asignacion) {
                	if (centralValida(indice_random, cli) {
                  		clientes[cliente] = indice_random;
                  		++numero_clientes_central[indice_random];
                  		producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + cli.getConsumo();
                  		buena_asignacion = true;
                	}
                	else indice_random = rand.nextInt(ref_centrales.size());
                }
            }
        }
        
    	// Una vez todos los clientes asegurados tienen una central asignada hacemos la asignacion de los no asegurados
    	for (int cliente = 0; cliente < tam; ++cliente) {
           	Cliente cli = ref_clientes.get(cliente);
           	boolean buena_asignacion = false;
           	
           	if (cli.getTipo() == Cliente.NOGARANTIZADO) {
           		int dist_cli = cli.getCoordX() + cli.getCoordY();
           		int[] centrales_mas_cercanas = getNCentrales(k, dist_cli, distancias_manhattan);
               	int indice_random = rand.nextInt(distancias_manhattan.size());
               	int ind = centrales_mas_cercanas[indice_random];
               	// Primero miramos de asignar aleatoriamente una de las k centrales más cercanas que tiene cli
               	if (centralValida(ind, cli)) {
               		clientes[cliente] = ind;
                 	++numero_clientes_central[ind];
                  	producciones_aseguradas[ind]  = producciones_aseguradas[ind] + cli.getConsumo();
                  	buena_asignacion = true;
                }
                // En caso que no funcione miramos de asignarle una central aleatoriamente (ahora no hace falta que esté entre las k más cercanas)
                else {
                	indice_random = rand.nextInt(ref_centrales.size());
                	if (centralValida(indice_random, cli)) {
                  		clientes[cliente] = indice_random;
                  		++numero_clientes_central[indice_random];
                  		producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + cli.getConsumo();
                  		buena_asignacion = true;
                	}
                }
                // Si en ninguno de los dos intentos no hemos podido asignarle una central a cli entonces no le asignamos ninguna central
                if (!buena_asignacion) clientes[cliente] = -1;
            }
        }
   }

   public Estado(Centrales centrales, Clientes clientes, int opcion) {
   		asignacion_clientes = new int[clientes.size()];
    	numero_clientes_central = new int[centrales.size()];
    	ref_centrales = centrales;
    	ref_clientes = clientes;
    	dinero = 0;
    	if (opcion == 1) asignar1(asignacion_clientes, numero_clientes_central);
    	else if (opcion == 2) asignar2(asignacion_clientes, numero_clientes_central);
   }

   public void move(int cliente, int central) {
   }

   public void swap(int cliente1, int cliente2){}
   
}
