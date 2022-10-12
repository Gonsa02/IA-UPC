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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Comparator;
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
    	if (opcion == 1) asignar1();
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
   
   private  int[] getNCentrales(int k, int dist_cli, int[] distancias_manhattan, int cli) {
                
   		int l = Arrays.binarySearch(distancias_manhattan, dist_cli);
                if (l < 0) l = Math.abs(l) - 1;
                if (l == distancias_manhattan.length) l--;
   		int r = l + 1;

   		int count = 0;
   		int n = distancias_manhattan.length;
   		int sol[] = new int[k];

   		while (l >= 0 && r < n && count < k) {
   			if ((dist_cli - distancias_manhattan[l] < dist_cli - distancias_manhattan[r])) {
                           /* if  (centralValida(l, cli))*/ sol[count++] = l;
                            --l;
                        }
   				
                        else {
                            /*if (centralValida(l, cli))*/ sol[count++] = r;
                            r++;
                        }	
   		}
   		while (count < k && l >= 0)
   			sol[count++] = l--;
   		
   		while (count < k && r < n)
   			sol[count++] = r++;
   		
   		// Ordenem aleatòriament els elements
   		List<Integer> list = new ArrayList<>();
                for (int i : sol) list.add(i);
   		Collections.shuffle(list);
   		sol = list.stream().mapToInt(i -> i).toArray();

   		return sol;
   	}
   
   private void asignar1(){
       List<Integer> clientes_asegurados = new ArrayList<>();
       List<Integer> centrales = new ArrayList<>();
        //añadimos todas las centrales a la lista
       for(int i =0; i < ref_centrales.size();++i)centrales.add(i);
      //por cada cliente, si es asegurado lo metemos a nuestra lista de clientes asegurados, sino le asignamos inicialmente
       for(int i = 0; i < asignacion_clientes.length;++i){
            Cliente cli = ref_clientes.get(i);
            if(cli.getContrato() == Cliente.GARANTIZADO) clientes_asegurados.add(i);
            else asignacion_clientes[i] = -1;
       }
       
      //mezclamos los clientes
       Collections.shuffle(clientes_asegurados);
       //ordenamos las centrales de más grande a más pequeña por capacidad
       Collections.sort(centrales,new SortSystem());
       
       //por cada central la vamos llenando hasta que no pueda más con clientes asegurados_random
       //si asignamos un cliente lo quitamos de la lista
       for(int i = 0; i < ref_centrales.size(); ++i){
           int index = centrales.get(i);
           boolean encontrado = true;
           while(encontrado){
               encontrado = false;
               for(int j = 0; j < clientes_asegurados.size();++j){
                   int cli = clientes_asegurados.get(j);
                   
                        
                    if(centralValida(index,cli)){
                        asignacion_clientes[cli] = index;
                        //asignar_cliente_a_central(cli,index);
                        clientes_asegurados.remove(j);
                        encontrado = true;
                    }  
                }
            }
           Collections.shuffle(clientes_asegurados);
        }
       
       //si hay un clientes asegurados, quitaremos tantas asignaciones hechas a clientes garantizados en la lista haya
       while(! clientes_asegurados.isEmpty()){
           System.out.println("Hay " + clientes_asegurados.size() + " no inicializados");
           int tam_inicial = clientes_asegurados.size();
           Random rand = new Random();
           for(int i = 0; i < tam_inicial;++i){
               int indice = rand.nextInt(asignacion_clientes.length);
               while(!(ref_clientes.get(indice).getContrato() == Cliente.GARANTIZADO && asignacion_clientes[indice] != -1)) indice = rand.nextInt(asignacion_clientes.length);
               
               asignacion_clientes[indice] = -1;
               clientes_asegurados.add(indice);
           }
           //repetimos el mismo proceso descrito anteriormente
           Collections.shuffle(clientes_asegurados);
           for(int i = 0; i < ref_centrales.size(); ++i){
           int index = centrales.get(i);
           boolean encontrado = true;
           while(encontrado){
               encontrado = false;
               for(int j = 0; j < clientes_asegurados.size();++j){
                   int cli = clientes_asegurados.get(j);
                   
                        
                    if(centralValida(index,cli)){
                        asignacion_clientes[cli] = index;
                        //asignar_cliente_a_central(cli,index);
                        clientes_asegurados.remove(j);
                        encontrado = true;
                    }  
                }
            }
           Collections.shuffle(clientes_asegurados);
        }
       }
       
       //una vez hecha la asignacion parcial, tenemos que formalizarla con la aplicacion de asignar_cliente_a_central
       //nos ayudamos con un vector auxiliar donde copiamos la asignacion parcial y dejamos el vector de asignaciones todo a -1
       int[] vector_parcial = new int[asignacion_clientes.length];
       for(int i = 0; i < asignacion_clientes.length; ++i){
           vector_parcial[i] = asignacion_clientes[i];
           asignacion_clientes[i] = -1;
       }
       //aplicamos los cambios
       for(int i = 0; i < asignacion_clientes.length; ++i){
           if(move_efectivo(i, vector_parcial[i])){
               asignar_cliente_a_central(i,vector_parcial[i]);
           }
       }
       //imprimimos todo por si acaso 
       //este paso se puede quitar
       for(int i = 0; i < asignacion_clientes.length; ++i){
          Cliente cli = ref_clientes.get(i);
          if(cli.getContrato() == Cliente.GARANTIZADO){
              System.out.println("El cliente garantizado "+ i + " tiene la central" + asignacion_clientes[i]);
          }
       }
    }
   
   private void asignar2(int[] clientes) {
        // Hacemos una array desordenada con los índices de todas las centrales
   	List<Integer> centrales = new ArrayList<>();
        for (int i = 0; i < ref_centrales.size(); ++i) centrales.add(i);
        Collections.shuffle(centrales);
        
        // Hacemos una lista desordenada con los índices de todos los clientes garantizados
        // y otra con los índices de todos los clientes no garantizados
        List<Integer> clientesGarantizados = new ArrayList<>();
        List<Integer> clientesNoGarantizados = new ArrayList<>();
        for (int i = 0; i < ref_clientes.size(); ++i) {
            if (ref_clientes.get(i).getContrato() == Cliente.GARANTIZADO)
                clientesGarantizados.add(i);
            else clientesNoGarantizados.add(i);
        }
        Collections.shuffle(clientesGarantizados);
        Collections.shuffle(clientesNoGarantizados);
        
        // Para cada central asignamos con prioridad a los clientes garantizados con menor consumo_real_cliente
        for (int i = 0; i < centrales.size();) {
            int cent = centrales.get(i);
            double min = Double.POSITIVE_INFINITY;
            int minPos = -1;
            for (int j = 0; j < clientesGarantizados.size(); ++j) {
                int cli = clientesGarantizados.get(j);
                if (asignacion_clientes[cli] == -1) {
                    double prod = consumo_real_cliente(cli, cent);
                    if (prod < min && centralValida(cent, cli)) {
                        min = prod;
                        minPos = j;
                    }
                }
            }
            if (minPos != -1) {
                int minCli = clientesGarantizados.get(minPos);
                asignar_cliente_a_central(minCli, cent);
                //System.out.println("Asignamos al cliente _" + minCli + "_ con la central " + cent);
                clientesGarantizados.remove(minPos);
            }
            else { // No hemos encontrado un cliente que quepa en la central, por tanto avanzamos a la siguiente central
                ++i;
            }
        }
        /*
        // Intentamos que todos los clientes garantizados tengan central
        while (!clientesGarantizados.isEmpty()) {
            System.out.println("Hay " + clientesGarantizados.size() + " no inicializados");
            int tam_inicial = clientesGarantizados.size();
            Random rand = new Random();
            for (int i = 0; i < tam_inicial;++i) {
                int indice = rand.nextInt(asignacion_clientes.length);
                while(!(ref_clientes.get(indice).getContrato() == Cliente.GARANTIZADO && asignacion_clientes[indice] != -1))
                    indice = rand.nextInt(asignacion_clientes.length);
                asignacion_clientes[indice] = -1;
                clientesGarantizados.add(indice);
            }
            //repetimos el mismo proceso descrito anteriormente
            Collections.shuffle(clientesGarantizados);
            for (int i = 0; i < ref_centrales.size(); ++i) {
                int index = centrales.get(i);
                boolean encontrado = true;
                while (encontrado) {
                    encontrado = false;
                    for (int j = 0; j < clientesGarantizados.size();++j) {
                        int cli = clientesGarantizados.get(j);  
                        if (centralValida(index,cli)) {
                            asignacion_clientes[cli] = index;
                            //asignar_cliente_a_central(cli,index);
                            clientesGarantizados.remove(j);
                            encontrado = true;
                        }  
                    }
                }
                Collections.shuffle(clientesGarantizados);
            }
        }*/
        
        // Una vez asignamos a todos los clientes garantizados una central miramos de asignar centrales a los no garantizados
        for (int i = 0; i < centrales.size();) {
            int cent = centrales.get(i);
            double min = Double.POSITIVE_INFINITY;
            int minPos = -1;
            for (int j = 0; j < clientesNoGarantizados.size(); ++j) {
                int cli = clientesNoGarantizados.get(j);
                if (asignacion_clientes[cli] == -1) {
                    double prod = consumo_real_cliente(cli, cent);
                    if (prod < min && centralValida(cent, cli)) {
                        min = prod;
                        minPos = j;
                    }
                }
            }
            if (minPos != -1) {
                int minCli = clientesNoGarantizados.get(minPos);
                asignar_cliente_a_central(minCli, cent);
                //System.out.println("Asignamos al cliente no garantizado _" + minCli + "_ con la central " + cent);
                clientesNoGarantizados.remove(minPos);
            }
            else { // No hemos encontrado un cliente que quepa en la central, por tanto avanzamos a la siguiente central
                ++i;
            }
        }
        
        int c1 = 0, c2 = 0;
        for (int i = 0; i < ref_clientes.size(); ++i) {
            if (asignacion_clientes[i] == -1) {
                if (ref_clientes.get(i).getContrato() == Cliente.GARANTIZADO) ++c1;
                else ++c2;
            }
        }
        System.out.println(c1 + " clientes garantizados sin central y " + c2 + " clientes no garantizados sin central");
   }
    private int asignacion_cliente_central(int tipo_cliente){
        if(tipo_cliente == Cliente.CLIENTEG) return Central.CENTRALC;
        else if(tipo_cliente == Cliente.CLIENTEMG) return Central.CENTRALB;
        return Central.CENTRALA;
    }
    private double consumo_real_central(int central) {
       double consumo_real = 0.0;
       for(int i = 0; i < asignacion_clientes.length; ++i){
           if(asignacion_clientes[i]== central) consumo_real += consumo_real_cliente(i, central);
       }
       return consumo_real;
   }
   	
    private boolean centralValida(int indice, int cli) {
        Central cent = ref_centrales.get(indice);
        return consumo_real_central(indice) + consumo_real_cliente(cli, indice) <= cent.getProduccion();
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
       if (central == -1) return true;
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
       if (c1.getContrato() != c2.getContrato())  return false; //Comprobamos que el swap se haga con clientes del mismo tipo
       
       int id_central1 = asignacion_clientes[cliente1], id_central2 = asignacion_clientes[cliente2];
       double consumo_cliente1_central_actual = consumo_real_cliente(cliente1, id_central1);
       double consumo_cliente2_central_actual = consumo_real_cliente(cliente2, id_central2);
       double consumo_cliente1_central_futura = consumo_real_cliente(cliente1, id_central2);
       double consumo_cliente2_central_futura = consumo_real_cliente(cliente2, id_central1);
       
       if (id_central1 == id_central2 && id_central1 == -1) return false;
       else if (id_central1 == -1) {
           Central central2 = ref_centrales.get(id_central2);
           return (consumo_real_central(id_central2)-consumo_cliente2_central_actual+consumo_cliente1_central_futura) <= central2.getProduccion();
       }
       else if (id_central2 == -1) {
           Central central1 = ref_centrales.get(id_central1);
           return (consumo_real_central(id_central1)-consumo_cliente1_central_actual+consumo_cliente2_central_futura) <= central1.getProduccion();
       }
       
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
           if (!central_con_clientes(id_central_anterior)) parar_central(id_central_anterior); //Si no hay clientes paramos la central
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
   public double get_dinero() {
       double produccion = 0.0;
       for (int i = 0; i < ref_clientes.size(); ++i) {
           produccion += consumo_real_cliente(i, asignacion_clientes[i]);
       }
       return dinero - produccion;
   }
    class SortSystem implements Comparator<Integer>{
       public int compare(Integer a, Integer b){
           int index1 = a;
           int index2 = b;
           Central cent1 = ref_centrales.get(index1);
           Central cent2 = ref_centrales.get(index2);
           return (int)cent2.getProduccion()-(int) cent1.getProduccion();
       }
   }
}
