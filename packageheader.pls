create or replace package laberinto is
    type listaC is table of number index by VARCHAR2(100);
    lista listaC;
    type arrC is varray(50000) of listaC;
    arr arrC := arrC();

    type aristasC is table of number index by PLS_INTEGER;
    aristas aristasC;

    type grafoC is table of aristasC index by PLS_INTEGER;
    grafo grafoC;

    type caminos1 is table of number index by varchar2(100);
    caminos3 caminos1; --se cambia dinamicamente
    type caminos2 is table of caminos1 index by pls_integer;
    caminos caminos2;
    type visitadosC is table of number index by pls_integer;
    visitados visitadosC;

    type rutaC is table of number index by pls_integer;
    ruta rutaC;

    function generarN return number;
    procedure crearGrafo (numero number);
    procedure crearLaberinto;
    procedure bfs;
    function contenidoEnVisitados (valor number) return number;
    procedure mostrarCamino(nodoInicial number,nodoFinal number);
    function contenidoEnRuta(valor number) return number;
    procedure imprimirGrafo;
    procedure insertarGrafoEnTabla;
    procedure imprimirArr;
    procedure imprimirRuta;
    procedure imprimirCaminos;
    procedure insertarRutaEnTabla;
end laberinto;
