#include <cstdlib>
#include <iostream>
#include <vector>
using namespace std;


typedef vector<vector<bool>> Matrix;

void i_es_connex(const Matrix &M, vector<bool> &v, int n) {
    if (not v[n]) { v[n] = true;
	for (int i = 0; i < M.size(); ++i) if (M[n][i]) i_es_connex(M, v, i);
    }
}

bool es_connex(const Matrix &M) {
    vector<bool> v = vector<bool>(M.size(), false);
    i_es_connex(M, v, 0);
    for (int i = 0; i < v.size(); ++i) if (not v[i]) return false;
    return true;
}

int main() {
    
    int num_rovers, num_asentamientos, num_almacen, num_suministros, num_personal, semilla;
    int num_psuministro, num_ppersonal;
    cout << "Introduce una semilla: ";
    cin >> semilla;
    srand(semilla);
    cout << "Introduce el número de rovers: ";
    cin >> num_rovers;
    cout << "Introduce el número de asentamientos: ";
    cin >> num_asentamientos;
    cout << "Introduce el número de almacenes: ";
    cin >> num_almacen;
    cout << "Introduce el número de suministros: ";
    cin >> num_suministros;
    cout << "Introduce el número de personal: ";
    cin >> num_personal;
    cout << "Introduce el número de peticiones de suministro: ";
    cin >> num_psuministro;
    cout << "Introduce el número de peticiones de personal: ";
    cin >> num_ppersonal;
   
 
    // Vamos a generar el grafo del mapa
    Matrix M(num_almacen+num_asentamientos, vector<bool>(num_almacen+num_asentamientos, false));
    
    //Primero vamos a asegurarnos de que el grafo es conexo
    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
		for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
	    	if (i == j-1 and j-1 >= 0) M[i][j] = true;
	    	if (i == j+1 and j+1 < M.size()) M[i][j] = true;
		}
    }

    //Escribo grafo
    /*
    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
	for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
	    cout << M[i][j] << " ";
	}
	cout << endl;
    }
    cout << endl;
    */

    //Añadimos aristas random con una probabilidad del 35%
    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
	for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
	    if (i != j and rand()%100 <= 35) {
		M[i][j] = true;
		M[j][i] = true;
	    }
	}
    }

    //Quitamos aristas random con una probabilidad del 10% de forma que el grafo sigue siendo connexo
    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
	for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
	    if (i != j) {
		if (rand()%100 <= 0) {
		    M[i][j] = false;
		    M[j][i] = false;
		}
		if (not es_connex(M)) {
		    M[i][j] = true;
		    M[j][i] = true;
		}
	    }
	}
    }

    //Escribo grafo
    /*
    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
	for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
	    cout << M[i][j] << " ";
	}
	cout << endl;
    }
    cout << endl;
    */

    cout << "(define (problem problemaRover" << num_rovers << ")" << endl;
    cout << "(:domain dominio1)" << endl << endl;

    // OBJECTS
    cout << "(:objects" << endl;
    cout << "		";
    for (int i = 0; i < num_rovers; ++i) cout << "r" << i+1 << " ";
    cout << "- Rover" << endl;
    cout << "		";
    for (int i = 0; i < num_asentamientos; ++i) cout << "as" << i+1 << " ";
    cout << "- Asentamiento" << endl;
    cout << "		";
    for (int i = 0; i < num_almacen; ++i) cout << "al" << i+1 << " ";
    cout << "- Almacen" << endl;
    cout << "		";
    for (int i = 0; i < num_suministros; ++i) cout << "s" << i+1 << " ";
    cout << "- Suministro" << endl;
    cout << "		";
    for (int i = 0; i < num_personal; ++i) cout << "pers" << i+1 << " ";
    cout << "- Personal" << endl;
    cout << "		";
    for (int i = 0; i < num_psuministro; ++i) cout << "p" << i + 1 << " ";
    cout << "- pSuministro" << endl;
    cout << "		";
    for (int i = 0; i < num_ppersonal; ++i) cout << "p" << num_psuministro + i + 1 << " ";
    cout << "- pPersonal" << endl;
    cout << ")" << endl;
    cout << endl;

    // INIT
    cout << "(:init" << endl;
    for (int i = 0; i < num_rovers; ++i) cout << "		" << "(= (capacidad r" << i+1 << ") 2)" << endl;
    cout << endl;

    for (int i = 0; i < num_rovers; ++i) {
		cout << "		" << "(aparcado r" << i+1 << " ";
		int aux = rand()%M.size();
		if (aux < num_asentamientos) cout << "as" << aux+1;
		else cout << "al" << aux-num_asentamientos+1;
		cout << ")" << endl;
    }
    cout << endl;

    for (int i = 0; i < num_almacen+num_asentamientos; ++i) {
    	cout << "		";
		for (int j = 0; j < num_almacen+num_asentamientos; ++j) {
			if (M[i][j]) {
				cout << "(accesible ";
				if (i < num_asentamientos) cout << "as" << i+1;
				else cout << "al" << i-num_asentamientos+1;
				cout << " ";
				if (j < num_asentamientos) cout << "as" << j+1;
				else cout << "al" << j-num_asentamientos+1;
				cout << ") ";
			}
		}
		cout << endl;
    }
    cout << endl;

    for (int i = 0; i < num_personal; ++i) cout << "		" << "(esta pers" << i+1 << " as" << (rand()%num_asentamientos)+1 << ")" << endl;
    for (int i = 0; i < num_suministros; ++i) cout <<  "		" << "(esta s" << i+1 << " al" << (rand()%num_almacen)+1 << ")" << endl;
    cout << endl;
	
	
    
    for (int i = 0; i < num_psuministro + num_ppersonal; ++i) {
        int a = (rand()%num_asentamientos) + 1;
        if (i % 2 == 0) cout << "		";
        cout << "(objetivo p" << i + 1 << " as" << a << ") ";
        if (i % 2 != 0) cout << endl;
    }
    cout << endl << ")" << endl << endl;

    // GOAL
    cout << "(:goal (forall (?c - Carga) (entregada ?c)))" << endl;
    cout << endl << ')' << endl;
}
