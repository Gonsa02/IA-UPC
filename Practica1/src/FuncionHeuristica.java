/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author jeremy
 */
import aima.search.framework.HeuristicFunction;
public class FuncionHeuristica implements HeuristicFunction {
    public double getHeuristicValue(Object n){

        return -((Estado) n).get_dinero();
    }
}
