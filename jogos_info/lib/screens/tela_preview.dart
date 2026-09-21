import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/jogo_models.dart';

class TelaPreview extends StatelessWidget {
  final ModeloFundo modeloSelecionado;
  final List<Jogo> jogos;

  const TelaPreview({
    super.key,
    required this.modeloSelecionado,
    required this.jogos,
  });

  @override
  Widget build(BuildContext context) {
    final bool isModelo3Jogos =
        modeloSelecionado.imagePath.endsWith('2.png') ||
            modeloSelecionado.imagePath.endsWith('3.png') ||
            modeloSelecionado.imagePath.endsWith('4.png');

    // topFractional levemente rebaixado para os fundos 2, 3 e 4
    final double topFractional = isModelo3Jogos
        ? 0.35
        : 0.26;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pré-visualização',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            // CANVAS DA IMAGEM FINAL (PROPORÇÃO 9:16)
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final canvasWidth = constraints.maxWidth;
                        final canvasHeight = constraints.maxHeight;

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            // 1. IMAGEM DE FUNDO DO MODELO
                            Image.asset(
                              modeloSelecionado.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey, size: 40),
                                ),
                              ),
                            ),

                            // 2. LISTA DE CARDS DE JOGO
                            Positioned(
                              top: canvasHeight * topFractional,
                              left: canvasWidth * 0.08,
                              right: canvasWidth * 0.08,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: jogos.map((jogo) {
                                  // Formatação do Dia + Horário (ex: "Seg. 12h")
                                  final diaFormatado = jogo.dia.sigla.isEmpty
                                      ? ''
                                      : '${jogo.dia.sigla[0].toUpperCase()}${jogo.dia.sigla.substring(1).toLowerCase()}';
                                  final textoDiaHora =
                                      '$diaFormatado. ${jogo.horario.texto}';

                                  return Container(
                                    height: canvasHeight * 0.12,
                                    margin: EdgeInsets.only(
                                        bottom: canvasHeight * 0.038),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: canvasWidth * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: [
                                        // ÍCONE DA BOLA DO ESPORTE
                                        Image.asset(
                                          jogo.esporte.iconPath,
                                          width: canvasWidth * 0.17,
                                          height: canvasWidth * 0.17,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Icon(
                                              Icons.sports,
                                              size: canvasWidth * 0.11,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: canvasWidth * 0.035),

                                        // TEXTOS: MODALIDADE + DIA E HORA
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  jogo.genero.sigla.toUpperCase(),
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: canvasWidth * 0.062,
                                                    height: 1.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  textoDiaHora,
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: canvasWidth * 0.042,
                                                    height: 1.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // ESCUDO INFORMÁTICA
                                        Image.asset(
                                          'assets/escudos/6.png',
                                          width: canvasWidth * 0.175,
                                          height: canvasWidth * 0.175,
                                          fit: BoxFit.fill, // Alterado para fill para tirar o espaço vazio interno
                                          errorBuilder: (_, __, ___) => Icon(
                                              Icons.shield,
                                              size: canvasWidth * 0.15,
                                              color: Colors.black),
                                        ),

                                        // TEXTO "VS"
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 0), // Zerado ou use um valor bem baixo como canvasWidth * 0.001
                                          child: Text(
                                            'VS',
                                            style: GoogleFonts.chauPhilomeneOne(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: canvasWidth * 0.042,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // ESCUDO ADVERSÁRIO
                                        Image.asset(
                                          jogo.adversario.logoPath,
                                          width: canvasWidth * 0.175,
                                          height: canvasWidth * 0.175,
                                          fit: BoxFit.fill, // Alterado para fill para tirar o espaço vazio interno
                                          errorBuilder: (_, __, ___) => Icon(
                                              Icons.shield_outlined,
                                              size: canvasWidth * 0.15,
                                              color: Colors.black),
                                        ),

                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // BOTÃO CONFIRMAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A017),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Confirmar Arte',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}