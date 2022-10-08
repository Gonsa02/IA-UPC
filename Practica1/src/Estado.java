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
import java.util.Collections;
/**
 *
 * @author jeremy
 */
public class Estado {
   private int[] asignacion_clientes;
   private int[] numero_clientes_central;
   private double dinero;
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
   private static double produccion_central(int central, int[]clientes){
       double produccion = 0.0;
       Central cent = ref_centrales.get(central);
       int tam = clientes.length;
       for(int i = 0; i < tam; ++i){
           if(clientes[i]== central){
               Cliente cli = ref_clientes.get(i);
               double distancia = distancia_euclidiana(cli,cent);
               double porcentaje = VEnergia.getPerdida(distancia);
       
               produccion += cli.getConsumo()/(1-porcentaje);
           }
       }
       return produccion;
   }
   
   private static int[] getNCentrales(int k, int dist_cli, double[] distancias_manhattan) {
   		int l = distancias_manhattan.binarySearch(dist_cli);
   		int r = l + 1;
   		int count = 0;
   		int n = distancias_manhattan.length;
   		int sol[] = new int[k];
   		
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
   	
    private boolean centralValida(int indice, Cliente cli) {
        Central cent = ref_centrales.get(indice);
        double produccion_cent = produccion_central(indice, asignacion_clientes);
        double eucli_dist = distancia_euclidiana(cli, cent);
        // Calculamos la producción 
        double necesidad_cliente = cli.getConsumo();
        double porcentaje = VEnergia.getPerdida(eucli_dist);
        necesidad_cliente = necesidad_cliente/(1-porcentaje);
        return produccion_cent + necesidad_cliente <= cent.getProduccion();
    }
   
   private void asignar1(int[] clientes){
       Random rand = new Random();
       int tam = clientes.length;
       
       
       // Primero asignamos centrales a los clientes asegurados
       for (int cliente = 0; cliente < tam; ++cliente) {
           // Elegimos la central que va a escoger [0 hasta num.centrales-1]
           Cliente cli = ref_clientes.get(cliente);
           if (cli.getContrato() == Cliente.GARANTIZADO) {
               int indice_random = rand.nextInt(ref_centrales.size());
               boolean buena_asignacion = false;
               while (!buena_asignacion) {
               		if (centralValida(indice_random, cli)) {
                		asignar_cliente_a_central(cliente, indice_random);
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
        	if (cli.getContrato() == Cliente.NOGARANTIZADO) {
        		int indice_random = rand.nextInt(ref_centrales.size());
            	if (centralValida(indice_random, cli)) {
                        asignar_cliente_a_central(cliente, indice_random);
           		}
           		else clientes[cliente] = -1;
        	}
    	}
	}
   
   private void asignar2(int[] clientes) {
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
     	Arrays.sort(distancias_manhattan);
     	
     	// Primero asignamos centrales a los clientes asegurados
        for (int cliente = 0; cliente < tam; ++cliente) {
        	Cliente cli = ref_clientes.get(cliente);
           
           	if (cli.getContrato() == Cliente.GARANTIZADO) {
            	int dist_cli = cli.getCoordX() + cli.getCoordY();
               	boolean buena_asignacion = false;
               	// Obtenemos las k centrales más cercanas a cli
               	int[] centrales_mas_cercanas = getNCentrales(k, dist_cli, distancias_manhattan);
               
               	for (int indice = 0; indice < centrales_mas_cercanas.length && !buena_asignacion; ++indice) {
               		int ind = centrales_mas_cercanas[indice];
               		if (centralValida(ind, cli)) {
               			asignar_cliente_a_central(cliente, ind);
                  		buena_asignacion = true;
                  	}
               	}
               
               	// Si no hemos podido asignar alguna de las k centrales más cercanas a cli entonces le asignamos una central aleatoriamente
               	int indice_random = rand.nextInt(ref_centrales.size());
               	while (!buena_asignacion) {
                	if (centralValida(indice_random, cli)) {
                  		asignar_cliente_a_central(cliente, indice_random);
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
           	
           	if (cli.getContrato() == Cliente.NOGARANTIZADO) {
           		int dist_cli = cli.getCoordX() + cli.getCoordY();
           		int[] centrales_mas_cercanas = getNCentrales(k, dist_cli, distancias_manhattan);
               	int indice_random = rand.nextInt(distancias_manhattan.length);
               	int ind = centrales_mas_cercanas[indice_random];
               	// Primero miramos de asignar aleatoriamente una de las k centrales más cercanas que tiene cli
               	if (centralValida(ind, cli)) {
               	asignar_cliente_a_central(cliente, ind);
                  	buena_asignacion = true;
                }
                // En caso que no funcione miramos de asignarle una central aleatoriamente (ahora no hace falta que esté entre las k más cercanas)
                else {
                	indice_random = rand.nextInt(ref_centrales.size());
                	if (centralValida(indice_random, cli)) {
                  		asignar_cliente_a_central(cliente, indice_random);
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
        for (int i = 0; i < clientes.size(); ++i) asignacion_clientes[i] = -1;
    	numero_clientes_central = new int[centrales.size()];
    	ref_centrales = centrales;
    	ref_clientes = clientes;
    	dinero = calcular_coste_centrales();
    	if (opcion == 1) asignar1(asignacion_clientes);
    	else if (opcion == 2) asignar2(asignacion_clientes);
   }

   public boolean move_efectivo(int cliente, int central){
       Cliente cli = ref_clientes.get(cliente);
       if(cli.getContrato() == Cliente.GARANTIZADO && central == -1) return false;
       if (asignacion_clientes[cliente]== central) return false;
       
       double capacidad_total = produccion_central(central, asignacion_clientes);
       
       Central cent = ref_centrales.get(central);
       double distancia = distancia_euclidiana(cli, cent);
       double porcentaje = VEnergia.getPerdida(distancia);
       double produccion  = cli.getConsumo()/(1-porcentaje);
       return capacidad_total + produccion <= cent.getProduccion();
   }
  

   
   private double calcular_coste_centrales() {
       double money = 0;
       for (int i = 0; i < ref_centrales.size(); ++i) {
           Central c = ref_centrales.get(i);
           try {
           if (central_activa(i)) dinero -=  VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() +VEnergia.getCosteMarcha(c.getTipo());
           else dinero -= VEnergia.getCosteParada(c.getTipo());
           } catch(Exception err) {
               System.out.println("Error calculando el coste de las centrales");
           }
       }
       return money;
   }
   
   private boolean central_activa(int id_central) {
       return numero_clientes_central[id_central] > 0;
   }
   
   private void parar_central(int id_central) {
       Central c = ref_centrales.get(id_central);
       try {
           dinero += VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() + VEnergia.getCosteMarcha(c.getTipo());
           dinero -= VEnergia.getCosteParada(c.getTipo());
       } catch(Exception err) {
           System.out.println("Error en parar_central");
       }
   }
   
      private void activar_central(int id_central) {
       Central c = ref_centrales.get(id_central);
       try {
       dinero -= VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() + VEnergia.getCosteMarcha(c.getTipo());
       dinero += VEnergia.getCosteParada(c.getTipo());
       } catch(Exception err) {
           System.out.println("Error en parar_central");
       }
   }
      
   public void asignar_cliente_a_central(int id_cliente, int id_central) {
       Cliente c = ref_clientes.get(id_cliente);
       int id_central_anterior = asignacion_clientes[id_cliente];
       asignacion_clientes[id_cliente] = id_central;
       if (id_central_anterior != -1) --numero_clientes_central[id_central_anterior];
       if (id_central_anterior == -1 && id_central >= 0) {
           try {
            dinero += VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo(); //Ya no pagamos indemnización
            if (!central_activa(id_central)) activar_central(id_central); //Si la central esta parada activamos la central
            ++numero_clientes_central[id_central];
            if (c.getContrato() == Cliente.GARANTIZADO) {
                dinero += c.getConsumo()*VEnergia.getTarifaClienteGarantizada(c.getTipo()); //El cliente nos paga la tarifa
            }  else {
                dinero += c.getConsumo()*VEnergia.getTarifaClienteNoGarantizada(c.getTipo());
            }
           } catch (Exception err) {
               System.out.println("Error al asignar_cliente a central");
           }
       }
       if (id_central_anterior >= 0 && id_central == -1) {  //Dejamos al cliente sin suministro
           try {
           dinero -= VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo(); //Pagamos la indemnización
           dinero -= c.getConsumo()*VEnergia.getTarifaClienteNoGarantizada(c.getTipo()); //No nos paga la tarifa
           --numero_clientes_central[id_central_anterior];
           if (!central_activa(id_central)) parar_central(id_central); //Si no hay clientes paramos la central
           } catch (Exception err) {
               System.out.println("Error al dejar a un cliente sin suministro");
           }
       }

   }

   public void swap(int cliente1, int cliente2){}
   
}
