/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import IA.Energia.Central;
import IA.Energia.Centrales;
import IA.Energia.Cliente;
import IA.Energia.Clientes;
import java.util.Random;
import java.util.Arrays;
import IA.Energia.VEnergia;
import java.util.Collections;
import java.util.List;
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
   
   private Estado(int[] asignacion, int[] num_cli, double dinero, Clientes clientes, Centrales centrales){
       asignacion_clientes = new int[asignacion.length];
       for(int i = 0; i < asignacion_clientes.length; ++i){
           asignacion_clientes[i] = asignacion[i];
       }
       numero_clientes_central = new int[num_cli.length];
       for(int i = 0; i < num_cli.length; ++i){
           numero_clientes_central[i] = num_cli[i];
       }
       this.dinero = dinero;
       ref_clientes = clientes;
       ref_centrales = centrales;   
   }
   
   private static double distancia_euclidiana(Cliente cl, Central c) {
       int pos_x_central = c.getCoordX();
       int pos_y_central = c.getCoordY();
       int pos_x_cliente = cl.getCoordX();
       int pos_y_cliente = cl.getCoordY();
       int distancia_x = Math.abs(pos_x_central - pos_x_cliente);
       int distancia_y = Math.abs(pos_y_central - pos_y_cliente);
       return Math.hypot((double)distancia_x, (double)distancia_y);
   }
   private double consumo_real_central(int central){
       double consumo_real = 0.0;
       for(int i = 0; i < asignacion_clientes.length; ++i){
           if(asignacion_clientes[i]== central) consumo_real += consumo_real_cliente(i, central);
       }
       return consumo_real;
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
   	
    private boolean centralValida(int indice, int cli) {
        Central cent = ref_centrales.get(indice);
        return consumo_real_central(indice) + consumo_real_cliente(cli, indice) <= cent.getProduccion();
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
               		if (centralValida(indice_random, cliente)) {
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
                        if (centralValida(indice_random, cliente)) asignar_cliente_a_central(cliente, indice_random);
           		else clientes[cliente] = -1;
        	}
    	}
    }
   
   private void asignar2(int[] clientes) {
   		Random rand = new Random();
   		int tam = clientes.length;
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
               		if (centralValida(ind, cliente)) {
               			asignar_cliente_a_central(cliente, ind);
                  		buena_asignacion = true;
                  	}
               	}
               
               	// Si no hemos podido asignar alguna de las k centrales más cercanas a cli entonces le asignamos una central aleatoriamente
               	int indice_random = rand.nextInt(ref_centrales.size());
               	while (!buena_asignacion) {
                	if (centralValida(indice_random, cliente)) {
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
               	if (centralValida(ind, cliente)) {
               	asignar_cliente_a_central(cliente, ind);
                  	buena_asignacion = true;
                }
                // En caso que no funcione miramos de asignarle una central aleatoriamente (ahora no hace falta que esté entre las k más cercanas)
                else {
                	indice_random = rand.nextInt(ref_centrales.size());
                	if (centralValida(indice_random, cliente)) {
                  		asignar_cliente_a_central(cliente, indice_random);
                  		buena_asignacion = true;
                	}
                }
                // Si en ninguno de los dos intentos no hemos podido asignarle una central a cli entonces no le asignamos ninguna central
                if (!buena_asignacion) clientes[cliente] = -1;
            }
        }
   }
   
   private double consumo_real_cliente(int cliente, int central) {
       if (central != -1) {
        Cliente cli = ref_clientes.get(cliente);
        Central cent = ref_centrales.get(central);
        double distancia = distancia_euclidiana(cli, cent);
        double porcentaje = VEnergia.getPerdida(distancia);
        return cli.getConsumo()/(1-porcentaje);
       }
       else return 0.0; //Si el cliente se compara con una central de índice -1 quiere decir que no consume de una central "no existente"
   }
   
   private boolean capacidad_suficiente_para_cliente(int cliente, int central) {
       Central cent = ref_centrales.get(central);
       double capacidad_consumida_por_central = consumo_real_central(central);
       double capacidad_real_consumida_por_cliente  = consumo_real_cliente(cliente, central);
       return capacidad_consumida_por_central + capacidad_real_consumida_por_cliente <= cent.getProduccion();
   }
   
      private boolean central_con_clientes(int id_central) {
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

   private double calcular_coste_centrales() {
       double money = 0;
       for (int i = 0; i < ref_centrales.size(); ++i) {
           Central c = ref_centrales.get(i);
           try {
           if (central_con_clientes(i)) dinero -=  VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() +VEnergia.getCosteMarcha(c.getTipo());
           else dinero -= VEnergia.getCosteParada(c.getTipo());
           } catch(Exception err) {
               System.out.println("Error calculando el coste de las centrales");
           }
       }
       return money;
   }
   
   public boolean move_efectivo(int cliente, int central){
       Cliente cli = ref_clientes.get(cliente);
       if(cli.getContrato() == Cliente.GARANTIZADO && central == -1) return false;
       if (asignacion_clientes[cliente]== central) return false;
       return capacidad_suficiente_para_cliente(cliente, central);
   }
   
   public boolean swap_efectivo(int cliente1, int cliente2) {
       Cliente c1 = ref_clientes.get(cliente1), c2 = ref_clientes.get(cliente2);
       if (!(c1.getContrato() == c2.getContrato() && c2.getContrato() == Cliente.GARANTIZADO))  return false; //Comprobamos que el swap se haga con clientes del mismo tipo
       if (!(c1.getContrato() == c2.getContrato() && c2.getContrato() == Cliente.NOGARANTIZADO)) return false;
       double consumo_cliente1_central_actual = consumo_real_cliente(cliente1, asignacion_clientes[cliente1]);
       double consumo_cliente2_central_actual = consumo_real_cliente(cliente2, asignacion_clientes[cliente2]);
       double consumo_cliente1_central_futura = consumo_real_cliente(cliente1, asignacion_clientes[cliente2]);
       double consumo_cliente2_central_futura = consumo_real_cliente(cliente2, asignacion_clientes[cliente1]);
       int id_central1 = asignacion_clientes[cliente1], id_central2 = asignacion_clientes[cliente2];
       Central central1 = ref_centrales.get(id_central1), central2 = ref_centrales.get(id_central2);
       //A continuación comprobamos si las centrales tienen suficiente produccion disponible como para servir a los clientes una vez se haya hecho el swap
       return (((consumo_real_central(id_central1)-consumo_cliente1_central_actual+consumo_cliente2_central_futura) <= central1.getProduccion()) && ((consumo_real_central(id_central2)-consumo_cliente2_central_actual+consumo_cliente1_central_futura) <= central2.getProduccion()));
   }
      
   public void asignar_cliente_a_central(int id_cliente, int id_central) {
       Cliente c = ref_clientes.get(id_cliente);
       int id_central_anterior = asignacion_clientes[id_cliente];
       asignacion_clientes[id_cliente] = id_central;
       if (id_central_anterior == -1 && id_central >= 0) { //Damos suministro al cliente
           try {
            dinero += VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo(); //Ya no pagamos indemnización
            if (!central_con_clientes(id_central)) activar_central(id_central); //Si la central esta parada activamos la central
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
           if (!central_con_clientes(id_central)) parar_central(id_central); //Si no hay clientes paramos la central
           } catch (Exception err) {
               System.out.println("Error al dejar a un cliente sin suministro");
           }
       }
      if (id_central_anterior >= 0 && id_central >= 0) {
          --numero_clientes_central[id_central_anterior];
          if (!central_con_clientes(id_central_anterior)) parar_central(id_central_anterior);
          if (!central_con_clientes(id_central)) activar_central(id_central);
          ++numero_clientes_central[id_central];
      }
   }

   public void swap(int cliente1, int cliente2){
       int aux = asignacion_clientes[cliente1];
       asignar_cliente_a_central(cliente1, asignacion_clientes[cliente2]);
       asignar_cliente_a_central(cliente2, aux);
   }
   
   public int get_n_clientes(){
       return ref_clientes.size();
   }
   public int get_n_centrales(){
       return ref_centrales.size();
   }
   public Estado clonar(){
       return new Estado(asignacion_clientes, numero_clientes_central, dinero, ref_clientes, ref_centrales);
   }
}