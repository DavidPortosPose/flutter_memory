import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_memory/tarjeta.dart';

class Memory extends StatefulWidget{

  @override
  State createState() {
    return MemoryEstado();
  }
}

class MemoryEstado extends State<Memory>{
  List<Tarjeta> lista;
  int errores =0;
  int posicionAnterior; // <0 => no existe
  MemoryEstado(){
    this.construirLista();
  }


  tarjetaPulsada(int posicion) async{
        if (!lista[posicion].pulsado){
          lista[posicion].cambioEstado();
          if (posicionAnterior >= 0){
            if (lista[posicion].icono != lista[posicionAnterior].icono){
              await new Future.delayed(const Duration(seconds : 1));
              lista[posicion].cambioEstado();
              lista[posicionAnterior].cambioEstado();
              setState(() {
                errores++;
              });

            }
            posicionAnterior = -1;
          } else {
            posicionAnterior = posicion;
          }
        }
  }


  construirLista(){
    List<IconData> listaIconos= [
      Icons.star,Icons.star,
      Icons.add,Icons.add,
      Icons.phone,Icons.phone,
      Icons.stop,Icons.stop];
    listaIconos.shuffle();

    errores = 0;
    posicionAnterior = -1;
    lista = [];
    for(int i=0; i < 8; i++){
      lista.add(Tarjeta(icono: listaIconos[i],posicion: i, funcionPulsadoCb: tarjetaPulsada, key: GlobalKey<TarjetaEstado>()));
    }
  }

  resetClick(){
    setState(() {
      construirLista();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('metodo build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory'),
        actions: <Widget>[
          Center(
            child: Text('Errores: ' + errores.toString() + '  ',
            style: TextStyle(
              fontSize: 17
            ),)
          )

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              lista[0],
              lista[1],
              lista[2],
              lista[3],
            ],
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              lista[4],
              lista[5],
              lista[6],
              lista[7],
            ],
          )
        ],
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: resetClick,
      ),
    );
  }
}