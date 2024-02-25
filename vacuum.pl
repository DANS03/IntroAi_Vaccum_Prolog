%Varibles del sistema iniciales 

habitacion(izq,sucia).
habitacion(der,sucia).
robot(der).

%nodos posibles del sistema
%nodo(habitacion1, habitacion2, robot)

nodo1(sucia,sucia,der).   %(0,0,2)
nodo2(sucia,sucia,izq).   %(0,0,1)
nodo3(limpia,sucia,izq).  %(1,0,1)
nodo4(limpia,sucia,der).  %(1,0,2)
nodo5(sucia,limpia,der).  %(0,1,2)
nodo6(sucia,limpia,izq).  %(0,1,1)
nodo7(limpia,limpia,izq). %(1,1,1)
nodo8(limpia,limpia,der). %(1,1,2)

%Definir un grafo dirigido con costos en las aristas ( del 2-4 camino izq, del 5-7 camino der)

arista(nodo1, nodo2, 10). %Cambio de habitacion
arista(nodo2, nodo3, 5).  %Limpia
arista(nodo3, nodo4, 10). %Cambio de habitacion
arista(nodo4, nodo8, 5).  %Limpia

arista(nodo1, nodo5, 5).  %Limpia
arista(nodo5, nodo6, 10). %Cambio de habitacion
arista(nodo6, nodo7, 5).  %Limpia
arista(nodo7, nodo8, 10). %Cambio de habitacion

costo_arista(X, Y, Costo) :- arista(X, Y, Costo).

%PARTE DEL ALGORITMO BFS sin costo
% Definición del grafo como una lista de adyacencia:

grafo([nodo1-[nodo2, nodo5], nodo2-[nodo3], nodo3-[nodo4], nodo4-[nodo8], nodo5-[nodo6], nodo6-[nodo7], nodo7-[nodo8], nodo8]).

% Regla para imprimir un recorrido en amplitud (BFS) desde un nodo fuente
bfs(Inicio) :-
    grafo(Grafo),
    bfs_aux([Inicio], [], Grafo).

% Regla auxiliar para el recorrido en amplitud
bfs_aux([], _, _).
bfs_aux([Nodo|Cola], Visitados, Grafo) :-
    write(Nodo), write(' '),
    agregar_no_visitados(Grafo, Nodo, Visitados, NuevosNodos),
    append(Cola, NuevosNodos, NuevaCola),
    bfs_aux(NuevaCola, [Nodo|Visitados], Grafo).

% Regla para agregar nodos no visitados a la cola
agregar_no_visitados(Grafo, Nodo, Visitados, NuevosNodos) :-
    findall(Adyacente, (member(Nodo-Adyacentes, Grafo), member(Adyacente, Adyacentes), \+ member(Adyacente, Visitados)), NuevosNodos).

%ALGORITMO
