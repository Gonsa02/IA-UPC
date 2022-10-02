/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */

/**
 *
 * @author jeremy
 */
import IA.Energia.*;

public class main {
 
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int[] vector = new int[]{1,2,3};
        
        try{
           Centrales mycentrales = new Centrales(vector, 1234);
           Central a = mycentrales.get(4);
           System.out.print(a.getCoordX());
        } 
        catch(Exception e){
        System.out.println("errror");
        }
        
    }
    
}
