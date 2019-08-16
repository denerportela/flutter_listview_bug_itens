import 'package:flutter/material.dart';

var orangePrimary = Color.fromRGBO(255, 179, 51, 1.0);

Color corPrimaria = Color.fromRGBO(41, 50, 60, 1.0);
Color corSecundaria = Color.fromRGBO(72, 85, 99, 1.0);


var gradientColorFundo = BoxDecoration(
    gradient: LinearGradient(
        colors: [corPrimaria, corSecundaria],
        stops: [0.0, 1.0],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft));

var gradientButton = BoxDecoration(
    gradient: LinearGradient(
        colors: [corPrimaria, corSecundaria],
        stops: [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight));