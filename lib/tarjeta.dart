import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';


class Tarjeta extends StatefulWidget{
  bool pulsado = false;
  IconData icono;
  int posicion;
  Function(int) funcionPulsadoCb;
  GlobalKey<TarjetaEstado> keyEstado;

  Tarjeta({Key key, this.icono,this.posicion,this.funcionPulsadoCb}): super(key: key){
    keyEstado = key;
  }


  @override
  State createState() {
    return TarjetaEstado();
  }
  cambioEstado(){
    this.keyEstado.currentState.cambiarEstado();
  }
}

class TarjetaEstadoOld extends State<Tarjeta>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:(){
          widget.funcionPulsadoCb(widget.posicion);
        },
        child: Container(
          color: widget.pulsado ? Colors.green : Colors.grey,
          child: widget.pulsado ? Icon(widget.icono) : null,
          height: 100,
          width: 100,
        )
    );
  }
}

class TarjetaEstado extends State<Tarjeta> {
  GlobalKey<FlipCardState> cardKey;

  cambiarEstado(){
    widget.pulsado = ! widget.pulsado;
    cardKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    cardKey = GlobalKey<FlipCardState>();
    return FlipCard(
        direction: FlipDirection.HORIZONTAL,
        key: cardKey,
        front: GestureDetector(
            onTap: () {
              widget.funcionPulsadoCb(widget.posicion);
            },
            child: Container(
              color: Colors.grey,
              height: 100,
              width: 100,
            )
        ),
        back: GestureDetector(
            onTap: () {
              widget.funcionPulsadoCb(widget.posicion);
            },
            child: Container(
              color: Colors.green,
              height: 100,
              width: 100,
              child: Icon(widget.icono),
            )
        )
    );
  }
}