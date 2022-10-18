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
   private double[] consumo_centrales;
   private double dinero;
   private static Centrales ref_centrales;
   private static Clientes ref_clientes;
   
      public Estado(Centrales centrales, Clientes clientes, int opcion) {
   	asignacion_clientes = new int[clientes.size()];
        for (int i = 0; i < clientes.size(); ++i) asignacion_clientes[i] = -1;
    	numero_clientes_central = new int[centrales.size()];
    	ref_centrales = centrales;
    	ref_clientes = clientes;
        consumo_centrales = new double[centrales.size()];
        for (int i = 0; i < ref_centrales.size(); ++i) consumo_centrales[i] = 0.0;
    	inicializar_dinero();
    	if (opcion == 1) asignar1();
    	else if (opcion == 2) asignar2();
   }
   
   private Estado(int[] asignacion, int[] num_cli, double[] cons_cent, double dinero, Clientes clientes, Centrales centrales) {
       asignacion_clientes = new int[asignacion.length];
       for (int i = 0; i < asignacion_clientes.length; ++i) {
           asignacion_clientes[i] = asignacion[i];
       }
       numero_clientes_central = new int[num_cli.length];
       for (int i = 0; i < num_cli.length; ++i) {
           numero_clientes_central[i] = num_cli[i];
       }
       consumo_centrales = new double[cons_cent.length];
       for (int i = 0; i < cons_cent.length; ++i) {
           consumo_centrales[i] = cons_cent[i];
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
   
    private void asignar1() {
        List<Integer> clientes_asegurados = new ArrayList<>();
        List<Integer> centrales = new ArrayList<>();
        // Añadimos todas las centrales a la lista
        for (int i = 0; i < ref_centrales.size(); ++i) centrales.add(i);
        // Por cada cliente, si es asegurado lo metemos a nuestra lista de clientes asegurados, sino le asignamos inicialmente
        for (int i = 0; i < asignacion_clientes.length; ++i) {
            Cliente cli = ref_clientes.get(i);
            if (cli.getContrato() == Cliente.GARANTIZADO) clientes_asegurados.add(i);
            //else asignacion_clientes[i] = -1; // Esto ya lo hacemos al crear el estado
        }
       
        // Mezclamos los clientes
        Collections.shuffle(clientes_asegurados);
        // Ordenamos las centrales de más grande a más pequeña por capacidad
        Collections.sort(centrales, new SortSystem());
       
        // Por cada central la vamos llenando hasta que no pueda más con clientes_asegurados random
        // Si asignamos un cliente lo quitamos de la lista
        for (int i = 0; i < ref_centrales.size(); ++i) {
            int index = centrales.get(i);
            boolean encontrado = true;
            while (encontrado) {
                encontrado = false;
                for (int j = 0; j < clientes_asegurados.size(); ++j) {
                   int cli = clientes_asegurados.get(j);
                    if (centralValida(index, cli)) {
                        asignar_cliente_a_central(cli,index);
                        clientes_asegurados.remove(j);
                        encontrado = true;
                    }  
                }
            }
            Collections.shuffle(clientes_asegurados);
        }
        // Si hay un clientes asegurados, quitaremos tantas asignaciones hechas a clientes garantizados en la lista haya
        while (!clientes_asegurados.isEmpty()) {
            System.out.println("Hay " + clientes_asegurados.size() + " no inicializados");
            int tam_inicial = clientes_asegurados.size();
            Random rand = new Random();
            for (int i = 0; i < tam_inicial; ++i) {
                int indice = rand.nextInt(asignacion_clientes.length);
                while (!(ref_clientes.get(indice).getContrato() == Cliente.GARANTIZADO && asignacion_clientes[indice] != -1))
                    indice = rand.nextInt(asignacion_clientes.length);
                
                asignar_cliente_a_central(indice,-1);
                clientes_asegurados.add(indice);
            }
            // Repetimos el mismo proceso descrito anteriormente
            Collections.shuffle(clientes_asegurados);
            for (int i = 0; i < ref_centrales.size(); ++i) {
                int index = centrales.get(i);
                boolean encontrado = true;
                while (encontrado) {
                    encontrado = false;
                    for (int j = 0; j < clientes_asegurados.size(); ++j) {
                        int cli = clientes_asegurados.get(j);
                     
                        if (centralValida(index, cli)) {
                            asignar_cliente_a_central(cli,index);
                            clientes_asegurados.remove(j);
                            encontrado = true;
                        }  
                    }
                }
                Collections.shuffle(clientes_asegurados);
            }
        }
    }
   
   private void asignar2() {
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
                clientesNoGarantizados.remove(minPos);
            }
            else { // No hemos encontrado un cliente que quepa en la central, por tanto avanzamos a la siguiente central
                ++i;
            }
        }
        printEstado();
    }
   	
    // Coste: O(1)
    private boolean centralValida(int central, int cli) {
        if (central == -1) return true;
        Central cent = ref_centrales.get(central);
        return consumo_centrales[central] + consumo_real_cliente(cli, central) <= cent.getProduccion();
    }
    
    // Coste: O(1)
    private double consumo_real_cliente(int cliente, int central) {
        if (central == -1)  return 0.0; // Si el cliente se compara con una central de índice -1 quiere decir que no consume de una central "no existente"
        
        Cliente cli = ref_clientes.get(cliente);
        Central cent = ref_centrales.get(central);
        double distancia = distancia_euclidiana(cli, cent);
        double porcentaje = VEnergia.getPerdida(distancia);
        return cli.getConsumo()/(1 - porcentaje);
    }
    
    // Coste: O(1)
    private boolean central_con_clientes(int id_central) {
        return numero_clientes_central[id_central] > 0;
    }
   
    // Coste: O(1)
    private void parar_central(int id_central) {
        Central c = ref_centrales.get(id_central);
        try {
            dinero += VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() + VEnergia.getCosteMarcha(c.getTipo());
            dinero -= VEnergia.getCosteParada(c.getTipo());
        } catch(Exception err) {
            System.out.println("Error en parar_central");
        }
    }
    
    // Coste: O(1)
    private void activar_central(int id_central) {
        Central c = ref_centrales.get(id_central);
        try {
            dinero -= VEnergia.getCosteProduccionMW(c.getTipo())*c.getProduccion() + VEnergia.getCosteMarcha(c.getTipo());
            dinero += VEnergia.getCosteParada(c.getTipo());
        } catch(Exception err) {
            System.out.println("Error en activar_central");
        }
    }
    
    // Coste: O(|Clientes| + |Centrales|)
    private void inicializar_dinero() {
        dinero = 0;
         for (int i = 0; i < ref_centrales.size(); ++i) {
            Central c = ref_centrales.get(i);
             try {
                // Todas las centrales empiezan paradas
                dinero -= VEnergia.getCosteParada(c.getTipo());
            } catch(Exception err) {
                System.out.println("Error en inicializar_dinero() calculando el coste de las centrales");
            }
        }
        for (int i = 0; i < ref_clientes.size(); ++i) {
            Cliente c = ref_clientes.get(i);
            try {
                // Todos los clientes empiezan sin central
                dinero -= VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo();
            } catch(Exception err) {
                System.out.println("Error en inicializar_dinero() calculando el coste de los clientes");
            }
        }
    }
    
    // Coste: O(1)
    public boolean move_efectivo(int cliente, int central) {
        Cliente cli = ref_clientes.get(cliente);
        if (cli.getContrato() == Cliente.GARANTIZADO && central == -1) return false;
        if (asignacion_clientes[cliente] == central) return false;
        return centralValida(central, cliente);
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
           return (consumo_centrales[id_central2] - consumo_cliente2_central_actual+consumo_cliente1_central_futura) <= central2.getProduccion();
       }
       else if (id_central2 == -1) {
           Central central1 = ref_centrales.get(id_central1);
           return (consumo_centrales[id_central1] - consumo_cliente1_central_actual+consumo_cliente2_central_futura) <= central1.getProduccion();
       }
       
       Central central1 = ref_centrales.get(id_central1), central2 = ref_centrales.get(id_central2);
       //A continuación comprobamos si las centrales tienen suficiente produccion disponible como para servir a los clientes una vez se haya hecho el swap
       return (((consumo_centrales[id_central1] - consumo_cliente1_central_actual+consumo_cliente2_central_futura) <= central1.getProduccion()) && ((consumo_centrales[id_central2] - consumo_cliente2_central_actual+consumo_cliente1_central_futura) <= central2.getProduccion()));
   }
      
    public void asignar_cliente_a_central(int id_cliente, int id_central) {
        Cliente c = ref_clientes.get(id_cliente);
        int id_central_anterior = asignacion_clientes[id_cliente];
        asignacion_clientes[id_cliente] = id_central;
        
        if (id_central_anterior == -1 && id_central >= 0) { // Damos suministro al cliente
            try {
                dinero += VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo(); // Ya no pagamos la indemnización
                if (!central_con_clientes(id_central)) activar_central(id_central); // Si la central esta parada activamos la central
                ++numero_clientes_central[id_central];
                consumo_centrales[id_central] += consumo_real_cliente(id_cliente, id_central);
                if (c.getContrato() == Cliente.GARANTIZADO) {
                    dinero += c.getConsumo()*VEnergia.getTarifaClienteGarantizada(c.getTipo()); //El cliente nos paga la tarifa
                }  else {
                    dinero += c.getConsumo()*VEnergia.getTarifaClienteNoGarantizada(c.getTipo());
                }
                double consumo = consumo_real_cliente(id_cliente, id_central);
                Central cent = ref_centrales.get(id_central);
                double din = (consumo - c.getConsumo()) * VEnergia.getCosteProduccionMW(cent.getTipo());
                dinero -= din;
            } catch (Exception err) {
                System.out.println("Error al asignar_cliente a central");
            }
        }
        
        else if (id_central_anterior >= 0 && id_central == -1) {  //Dejamos al cliente sin suministro
            try {
                dinero -= VEnergia.getTarifaClientePenalizacion(c.getTipo())*c.getConsumo(); //Pagamos la indemnización
                dinero -= c.getConsumo()*VEnergia.getTarifaClienteNoGarantizada(c.getTipo()); //No nos paga la tarifa
                --numero_clientes_central[id_central_anterior];
                consumo_centrales[id_central_anterior] -= consumo_real_cliente(id_cliente, id_central_anterior);
                if (!central_con_clientes(id_central_anterior)) parar_central(id_central_anterior); //Si no hay clientes paramos la central
                double consumo = consumo_real_cliente(id_cliente, id_central_anterior);
                Central cent = ref_centrales.get(id_central_anterior);
                double din = (consumo - c.getConsumo()) * VEnergia.getCosteProduccionMW(cent.getTipo());
                dinero += din;
            } catch (Exception err) {
                System.out.println("Error al dejar a un cliente sin suministro");
            }
        }
        
        else if (id_central_anterior >= 0 && id_central >= 0) {
          try{
              --numero_clientes_central[id_central_anterior];
            if (!central_con_clientes(id_central_anterior)) parar_central(id_central_anterior);
             ++numero_clientes_central[id_central];
            if (!central_con_clientes(id_central)) activar_central(id_central);
            
            consumo_centrales[id_central_anterior] -= consumo_real_cliente(id_cliente, id_central_anterior);
            consumo_centrales[id_central] += consumo_real_cliente(id_cliente, id_central);
            
            double consumo1 = consumo_real_cliente(id_cliente, id_central_anterior);
            double consumo2 = consumo_real_cliente(id_cliente, id_central);
            Central cent1 = ref_centrales.get(id_central_anterior);
            Central cent2 = ref_centrales.get(id_central);
            double din1 = (consumo1 - c.getConsumo()) * VEnergia.getCosteProduccionMW(cent1.getTipo());
            double din2 = (consumo2 - c.getConsumo()) * VEnergia.getCosteProduccionMW(cent2.getTipo());
            dinero = dinero + din1 - din2;
          }catch(Exception err){
              System.out.println("Error al dejar a un cliente sin suministro");
          }
            
        }
    }
    
    // Coste:
    public void swap(int cliente1, int cliente2) {
        int aux = asignacion_clientes[cliente1];
        asignar_cliente_a_central(cliente1, asignacion_clientes[cliente2]);
        asignar_cliente_a_central(cliente2, aux);
    }
   
    // Coste: O(|Clientes|)
    public String printEstado() {
        int c1 = 0, c2 = 0, c3 = 0, c4 = 0;
        for (int i = 0; i < ref_clientes.size(); ++i) {
            if (asignacion_clientes[i] == -1) {
                if (ref_clientes.get(i).getContrato() == Cliente.GARANTIZADO) ++c1;
                else ++c2;
            }
            else {
                if (ref_clientes.get(i).getContrato() == Cliente.GARANTIZADO) ++c3;
                else ++c4;
            }
        }
        String s1 = (c1 + " clientes garantizados sin central y " + c2 + " clientes no garantizados sin central.");
        String s2 = (c3 + " clientes garantizados con central y " + c4 + " clientes no garantizados con central");
        return s1 + "\n" + s2;
    }
    
    // Coste: O(1)
    public int get_n_clientes() {
        return ref_clientes.size();
    }
    
    // Coste: O(1)
    public int get_n_centrales() {
        return ref_centrales.size();
    }
   
   public Estado clonar() {
       return new Estado(asignacion_clientes, numero_clientes_central, consumo_centrales, dinero, ref_clientes, ref_centrales);
   }
   
    public double get_dinero() {
        return dinero;
    }
    
    class SortSystem implements Comparator<Integer> {
       public int compare(Integer a, Integer b) {
           int index1 = a;
           int index2 = b;
           Central cent1 = ref_centrales.get(index1);
           Central cent2 = ref_centrales.get(index2);
           return (int)cent2.getProduccion() - (int)cent1.getProduccion();
       }
   }
}
