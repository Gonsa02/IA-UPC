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
import IA.Energia.VEnergia;
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
   
   private void asignar1(int[] clientes, int[] numero_clientes_central){
       Random rand = new Random();
       int tam = clientes.length;
       double[] producciones_aseguradas = new double[ref_centrales.size()];
     
       for(int cliente = 0; cliente < tam; ++cliente){
           //elegimos la central que va escoger [0 hasta num.centrales-1]
           Cliente cli = ref_clientes.get(cliente);
           if(cli.getContrato() == Cliente.GARANTIZADO){
               int indice_random = rand.nextInt(ref_centrales.size());
               boolean buena_asignacion = false;
               while (!buena_asignacion){
                Central cent = ref_centrales.get(indice_random);
        
                double eucli_dist = distancia_euclidiana(cli, cent);
                //calculamos la produccion 
                double necesidad_cliente = cli.getConsumo();
                double porcentaje = VEnergia.getPerdida(eucli_dist);
                necesidad_cliente = necesidad_cliente/(1-porcentaje);
                if(producciones_aseguradas[indice_random] + necesidad_cliente <= cent.getProduccion()){
                  asignar_cliente_a_central(cliente, indice_random);
                  producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + necesidad_cliente;
                  buena_asignacion = true;
                }
                
                else indice_random = rand.nextInt(ref_centrales.size());
                }
            }
        }
    //hacemos la asignacion de los no asegurados
    for(int cliente = 0; cliente < tam; ++cliente){
           //elegimos la central que va escoger [0 hasta num.centrales-1]
           Cliente cli = ref_clientes.get(cliente);
           if(cli.getContrato() == Cliente.NOGARANTIZADO){
               int indice_random = rand.nextInt(ref_centrales.size());
               
                Central cent = ref_centrales.get(indice_random);
        
                double eucli_dist = distancia_euclidiana(cli, cent);
                //calculamos la produccion 
                double necesidad_cliente = cli.getConsumo();
                double porcentaje = VEnergia.getPerdida(eucli_dist);
                necesidad_cliente = necesidad_cliente/(1-porcentaje);
                if(producciones_aseguradas[indice_random] + necesidad_cliente <= cent.getProduccion()){
                  asignar_cliente_a_central(cliente, indice_random);
                  producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + necesidad_cliente;
                 
                }
                
                else clientes[cliente] = -1;
                
            }
        }
   }

   public Estado(Centrales centrales, Clientes clientes ,int opcion){
    asignacion_clientes = new int[clientes.size()];
    numero_clientes_central = new int[centrales.size()];
    ref_centrales = centrales;
    ref_clientes = clientes;
    dinero = calcular_coste_centrales();
    if(opcion == 1) asignar1(asignacion_clientes, numero_clientes_central);
    
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
