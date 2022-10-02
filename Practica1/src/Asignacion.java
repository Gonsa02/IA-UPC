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
public class Asignacion {
   private int[] asignacion_clientes;
   private double[] megavatios_hechos;
   private static Centrales ref_centrales;
   private static Clientes ref_clientes;
   
   private static void asignar1(int[] clientes, double[] megavatios_hechos){
       Random rand = new Random();
       int tam = clientes.length;
       double[] producciones_aseguradas = new double[ref_centrales.size()];
     
       for(int cliente = 0; cliente < tam; ++cliente){
           //elegimos la central que va escoger [0 hasta num.centrales-1]
           Cliente cli = ref_clientes.get(cliente);
           if(cli.getTipo() == Cliente.GARANTIZADO){
               int indice_random = rand.nextInt(ref_centrales.size());
               boolean buena_asignacion = false;
               while (!buena_asignacion){
                Central cent = ref_centrales.get(indice_random);
        
                //hacemos el calculo de la distancia euclidiana
                int pos_x_central = cent.getCoordX();
                int pos_x_cliente = cli.getCoordX();
                int pos_y_central = cent.getCoordY();
                int pos_y_cliente = cli.getCoordY();
                int distancia_x = Math.abs(pos_x_central- pos_x_cliente);
                int distancia_y = Math.abs(pos_y_central - pos_y_cliente);
                double eucli_dist = Math.hypot((double)distancia_x, (double)distancia_y);
                //calculamos la produccion 
                double necesidad_cliente = cli.getConsumo();
                double porcentaje = VEnergia.getPerdida(eucli_dist);
                necesidad_cliente = necesidad_cliente/(1-porcentaje);
                if(producciones_aseguradas[indice_random] + necesidad_cliente <= cent.getProduccion()){
                  clientes[cliente] = indice_random;
                  megavatios_hechos[cliente] = necesidad_cliente;
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
           if(cli.getTipo() == Cliente.NOGARANTIZADO){
               int indice_random = rand.nextInt(ref_centrales.size());
               
                Central cent = ref_centrales.get(indice_random);
        
                //hacemos el calculo de la distancia euclidiana
                int pos_x_central = cent.getCoordX();
                int pos_x_cliente = cli.getCoordX();
                int pos_y_central = cent.getCoordY();
                int pos_y_cliente = cli.getCoordY();
                int distancia_x = Math.abs(pos_x_central- pos_x_cliente);
                int distancia_y = Math.abs(pos_y_central - pos_y_cliente);
                double eucli_dist = Math.hypot((double)distancia_x, (double)distancia_y);
                //calculamos la produccion 
                double necesidad_cliente = cli.getConsumo();
                double porcentaje = VEnergia.getPerdida(eucli_dist);
                necesidad_cliente = necesidad_cliente/(1-porcentaje);
                if(producciones_aseguradas[indice_random] + necesidad_cliente <= cent.getProduccion()){
                  clientes[cliente] = indice_random;
                  megavatios_hechos[cliente] = necesidad_cliente;
                  producciones_aseguradas[indice_random]  = producciones_aseguradas[indice_random] + necesidad_cliente;
                 
                }
                
                else clientes[cliente] = -1;
                
            }
        }
   }
   public Asignacion(Centrales centrales, Clientes clientes ,int opcion){
    asignacion_clientes = new int[clientes.size()];
    megavatios_hechos = new double[clientes.size()];
    ref_centrales = centrales;
    ref_clientes = clientes;
    if(opcion == 1) asignar1(asignacion_clientes, megavatios_hechos);
    
   }
   public void move(int cliente, int central){}
   public void swap(int cliente1, int cliente2){}
   
}
