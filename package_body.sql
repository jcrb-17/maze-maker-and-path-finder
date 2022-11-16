create or replace package body laberinto is
    function generarN return number is
    begin
        return round(dbms_random.value(1,2));
    end generarN;

    procedure crearGrafo (numero number) is
    begin
        laberinto.arr.delete;
        arr := arrC();
        for i in 1..((numero*numero)) loop
            --primera fila
            if i<=numero then
                if i=1 then
                    lista('numero') := i;
                    lista('arriba') := -1;
                    lista('derecha') := i+1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := -1;
                    lista('mensaje') := 1;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                elsif i = numero then
                    lista('numero') := i;
                    lista('arriba') := -1;
                    lista('derecha') := -1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 2;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                else
                    lista('numero') := i;
                    lista('arriba') := -1;
                    lista('derecha') := i+1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 3;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                end if;
            --ultima fila
            elsif i >= ((numero*numero) - numero+1) then
                if i = ((numero*numero) - numero+1) then
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := i+1;
                    lista('abajo') := -1;
                    lista('izquierda') := -1;
                    lista('mensaje') := 4;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                elsif i = numero*numero then
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := -1;
                    lista('abajo') := -1;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 5;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                else
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := i+1;
                    lista('abajo') := -1;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 6;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                end if;
            --otras filas
            else
                if (i-1) mod numero =0 then
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := i+1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := -1;
                    lista('mensaje') := 7;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                elsif i mod numero =0 then
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := -1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 8;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                else
                    lista('numero') := i;
                    lista('arriba') := i-numero;
                    lista('derecha') := i+1;
                    lista('abajo') := i+numero;
                    lista('izquierda') := i-1;
                    lista('mensaje') := 9;
                    laberinto.arr.extend;
                    laberinto.arr(i) := laberinto.lista;
                    continue;
                end if;
            end if;
        end loop;
    end crearGrafo;
    procedure crearLaberinto is
        temp number(38);
    begin
        laberinto.grafo.delete;
        for i in 1..laberinto.arr.count loop
            laberinto.grafo(i)(1) := -100;
        end loop;
        for i in 1..laberinto.arr.count loop
            dbms_output.put_line(laberinto.arr(i)('numero'));
            dbms_output.put_line('i vale ' || i);
            if laberinto.arr(i)('arriba') = -1 and laberinto.arr(i)('derecha')= -1 then
                continue;
            elsif laberinto.arr(i)('arriba') = -1 and laberinto.arr(i)('derecha') != -1 then
                dbms_output.put_line('msj1');
                temp := laberinto.grafo(i).count;
                dbms_output.put_line('msjXX'||temp);
                laberinto.grafo(i)(temp+1) := laberinto.arr(i)('derecha');
                laberinto.grafo(laberinto.arr(i)('derecha'))(laberinto.grafo(laberinto.arr(i)('derecha')).count + 1) := laberinto.arr(i)('numero');
                dbms_output.put_line('Se agrego' || laberinto.arr(i)('derecha') || ' en ' || i || ' y viceversa');
                continue;
            elsif laberinto.arr(i)('arriba') !=-1 and laberinto.arr(i)('derecha') !=-1 then
                temp := laberinto.generarN();
                if temp =1 then
                    laberinto.grafo(i)(laberinto.grafo(i).count + 1) := laberinto.arr(i)('derecha');
                    laberinto.grafo(laberinto.arr(i)('derecha'))(laberinto.grafo(laberinto.arr(i)('derecha')).count + 1) := laberinto.arr(i)('numero');
                    dbms_output.put_line('Se agrego' || laberinto.arr(i)('derecha') || ' en ' || i || ' y viceversa');
                    continue;
                elsif temp =2 then
                    laberinto.grafo(i)(laberinto.grafo(i).count + 1) := laberinto.arr(i)('arriba');
                    laberinto.grafo(laberinto.arr(i)('arriba'))(laberinto.grafo(laberinto.arr(i)('arriba')).count + 1) := laberinto.arr(i)('numero');
                    dbms_output.put_line('Se agrego' || laberinto.arr(i)('arriba') || ' en ' || i || ' y viceversa');
                    continue;
                end if;
            elsif laberinto.arr(i)('arriba') != -1 and laberinto.arr(i)('derecha') =-1 then
                laberinto.grafo(i)(laberinto.grafo(i).count + 1) := laberinto.arr(i)('arriba');
                laberinto.grafo(laberinto.arr(i)('arriba'))(laberinto.grafo(laberinto.arr(i)('arriba')).count + 1) := laberinto.arr(i)('numero');
                continue;
            end if;
        end loop;
    for j in 1..laberinto.grafo.count loop
        dbms_output.put_line (laberinto.grafo(j).first);
    end loop;
    end crearLaberinto;

    function contenidoEnVisitados (valor number) return number is
    begin
        for i in 1..laberinto.visitados.count loop
            if valor = laberinto.visitados(i) then
                return 1;
            end if;
        end loop;
        return 0;
    end contenidoEnVisitados;

    function contenidoEnRuta (valor number) return number is
    begin
        for i in 1..laberinto.ruta.count loop
            if valor = laberinto.ruta(i) then
                return 1;
            end if;
        end loop;
        return 0;
    end contenidoEnRuta;

    procedure imprimirGrafo is
    temp varchar2(4000) := '';
    begin
        for i in 1..laberinto.grafo.count loop
            temp:='';
            for j in 2..laberinto.grafo(i).count loop
                temp:= temp || laberinto.grafo(i)(j) || ' ';
            end loop;
            dbms_output.put_line('nodo '|| i || ' aristas ' || temp);
        end loop;
    end imprimirGrafo;

    procedure bfs is
        type filaC is table of number index by pls_integer;
        fila filaC;
        nodo number(38);
        temp varchar2(4000):='';
    begin
        laberinto.visitados.delete;
        laberinto.caminos.delete;
        fila(1) := 1;
        while fila.count >0 loop
            nodo := fila(fila.first);
            if laberinto.contenidoenvisitados(nodo) = 0 then
                laberinto.visitados(laberinto.visitados.count+1) := nodo;
                for i in 2..laberinto.grafo(nodo).count loop
                    if laberinto.contenidoenvisitados(laberinto.grafo(nodo)(i)) = 0 then
                        laberinto.caminos3('vieneDe') := nodo;
                        laberinto.caminos3('nodo') := laberinto.grafo(nodo)(i);
                        laberinto.caminos(laberinto.caminos.count+1) := laberinto.caminos3;
                        fila(fila.last+1) := laberinto.grafo(nodo)(i);
                    end if;
                end loop;
                continue;
            else
                fila.delete(fila.first);
                continue;
            end if;
        end loop;
    end bfs;
    procedure insertarGrafoEnTabla is
        temp varchar2(4000):='';
    begin
        delete from grafo;
        for i in 1..laberinto.grafo.count loop
            temp:='';
            for j in 2..laberinto.grafo(i).count loop
                temp:= temp || laberinto.grafo(i)(j) || ' ';
            end loop;
            insert into grafo (nodo,aristas) values(i,temp) ;
            commit;
            --dbms_output.put_line('nodo '|| i || ' aristas ' || temp);
        end loop;
    end insertarGrafoEnTabla;
    procedure imprimirArr is
    begin
        for i in 1..laberinto.arr.count loop
            dbms_output.put_line('Numero ' || laberinto.arr(i)('numero'));
            dbms_output.put_line('arriba ' || laberinto.arr(i)('arriba'));
            dbms_output.put_line('derecha ' || laberinto.arr(i)('derecha'));
            dbms_output.put_line('abajo ' || laberinto.arr(i)('abajo'));
            dbms_output.put_line('izquierda ' || laberinto.arr(i)('izquierda'));
            dbms_output.put_line('--------------');
        end loop;
    end imprimirArr;
    procedure imprimirRuta is
        temp varchar2(4000) := '';
    begin
        for i in 1..laberinto.ruta.count loop
            temp := temp || laberinto.ruta(i) || ' ';
        end loop;
        dbms_output.put_line('Ruta ' || temp);
    end imprimirRuta;
    procedure imprimirCaminos is
    begin
        for i in 1..laberinto.caminos.count loop
            dbms_output.put_line('Nodo ' || laberinto.caminos(i)('nodo'));
            dbms_output.put_line('VieneDe ' || laberinto.caminos(i)('vieneDe'));
            dbms_output.put_line('--------------');
        end loop;
    end imprimirCaminos;

    procedure mostrarCamino (nodoInicial number,nodoFinal number) is
        type filaC is table of number index by pls_integer;
        fila filaC;
        nodo number(38);
    begin
        laberinto.ruta.delete;
        fila(1):=nodoFinal;
        while fila.count>0 loop
            nodo := fila(fila.first);
            if nodo = nodoInicial then
                laberinto.ruta(laberinto.ruta.count + 1) := nodo;
                exit;
            end if;
            if laberinto.contenidoenruta(nodo) = 0 then
                laberinto.ruta(laberinto.ruta.count + 1) := nodo;
            end if;
            for i in 1..laberinto.caminos.count loop
                if laberinto.caminos(i)('nodo') = nodo then
                    fila(fila.last+1) := laberinto.caminos(i)('vieneDe');
                    exit;
                end if;
            end loop;
            fila.delete(fila.first);
        end loop;
    end mostrarCamino;
    procedure insertarRutaEnTabla is
    temp varchar2(4000) := '';
    begin
        delete from ruta;
        for i in 1..laberinto.ruta.count loop
            temp:=temp||laberinto.ruta(i) || ' ';
        end loop;
        insert into ruta values(temp);
    end insertarRutaEnTabla;
end laberinto;
