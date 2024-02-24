% Declarar el predicado como dinámico
:- dynamic suciedad/2.
:- dynamic ubicacion_robot/1.

% Hechos para representar el estado inicial
suciedad(habitacion1, sucia).
suciedad(habitacion2, sucia).
ubicacion_robot(habitacion1).


% Reglas para representar las acciones del robot
cambiar_habitacion :-
    ubicacion_robot(HabitacionActual),
    retract(ubicacion_robot(HabitacionActual)),
    (HabitacionActual = habitacion1 -> assertz(ubicacion_robot(habitacion2));
                                      assertz(ubicacion_robot(habitacion1))).

limpiar_habitacion :-
    ubicacion_robot(Habitacion),
    suciedad(Habitacion, sucia),
    retract(suciedad(Habitacion, sucia)),
    assertz(suciedad(Habitacion, limpia)).

% Iniciar el sistema
iniciar_sistema :-
    imprimir_estado_actual,
    limpiar_habitaciones.

% Regla para imprimir el estado actual del sistema
imprimir_estado_actual :-
    write('Estado Actual:'), nl,
    suciedad(habitacion1, Estado1),
    suciedad(habitacion2, Estado2),
    ubicacion_robot(Ubicacion),
    write('Habitacion 1: '), write(Estado1), nl,
    write('Habitacion 2: '), write(Estado2), nl,
    write('Ubicacion del robot: '), write(Ubicacion), nl.

% Realizar acciones para limpiar las habitaciones
limpiar_habitaciones :-
    limpiar_habitacion,
    imprimir_estado_actual,
    cambiar_habitacion,
    limpiar_habitacion,
    imprimir_estado_actual.