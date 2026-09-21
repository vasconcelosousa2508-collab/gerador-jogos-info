import 'package:flutter/material.dart';

enum Esporte {
  volei('Vôlei', 'assets/esportes/1.png'),
  basquete('Basquete', 'assets/esportes/2.png'),
  futsal('Futsal', 'assets/esportes/3.png'),
  carimba('Carimba', 'assets/esportes/4.png'),
  handebol('Handebol', 'assets/esportes/5.png'),
  pingpong('Ping Pong', 'assets/esportes/6.png');

  final String nome;
  final String iconPath;
  const Esporte(this.nome, this.iconPath);
}

enum Genero {
  feminino('FEM'),
  masculino('MASC'),
  misto('MISTO');

  final String sigla;
  const Genero(this.sigla);
}

enum DiaSemana {
  segunda('Seg', 1),
  terca('Ter', 2),
  quarta('Qua', 3),
  quinta('Qui', 4),
  sexta('Sex', 5);

  final String sigla;
  final int ordem;
  const DiaSemana(this.sigla, this.ordem);
}

enum Horario {
  h0730('7h30', 7.5),
  h0800('8h', 8.0),
  h0900('9h', 9.0),
  h1000('10h', 10.0),
  h1100('11h', 11.0),
  h1200('12h', 12.0),
  h1300('13h', 13.0),
  h1400('14h', 14.0),
  h1500('15h', 15.0),
  h1600('16h', 16.0),
  h1700('17h', 17.0),
  h1800('18h', 18.0),
  h1900('19h', 19.0);

  final String texto;
  final double valorNumerico;
  const Horario(this.texto, this.valorNumerico);
}

enum TimeAdversario {
  meca('Meca', 'assets/escudos/1.png'),
  eletro('Eletro', 'assets/escudos/2.png'),
  quimica('Química', 'assets/escudos/3.png'),
  tele('Tele', 'assets/escudos/4.png'),
  edi('Edi', 'assets/escudos/5.png');

  final String nome;
  final String logoPath;
  const TimeAdversario(this.nome, this.logoPath);
}

enum ModeloFundo {
  modelo1('Modelo 1', 'assets/fundos/1.png', 4),
  modelo2('Modelo 2', 'assets/fundos/2.png', 4),
  modelo3('Modelo 3', 'assets/fundos/3.png', 4),
  modelo4('Modelo 4', 'assets/fundos/4.png', 4),
  modelo5('Modelo 5', 'assets/fundos/5.png', 3),
  modelo6('Modelo 6', 'assets/fundos/6.png', 3);

  final String nome;
  final String imagePath;
  final int capacidadeMaxima;

  const ModeloFundo(this.nome, this.imagePath, this.capacidadeMaxima);
}

class Jogo {
  Esporte esporte;
  Genero genero;
  DiaSemana dia;
  Horario horario;
  TimeAdversario adversario;

  Jogo({
    required this.esporte,
    required this.genero,
    required this.dia,
    required this.horario,
    required this.adversario,
  });
}