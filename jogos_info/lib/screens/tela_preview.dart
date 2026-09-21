import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import '../models/jogo_models.dart';

class TelaPreview extends StatefulWidget {
  final ModeloFundo modeloSelecionado;
  final List<Jogo> jogos;

  const TelaPreview({
    super.key,
    required this.modeloSelecionado,
    required this.jogos,
  });

  @override
  State<TelaPreview> createState() => _TelaPreviewState();
}

class _TelaPreviewState extends State<TelaPreview> {
  final GlobalKey _globalKey = GlobalKey();
  String _textoBotao = 'Download';

  Future<void> _salvarImagem() async {
    try {
      final boundary = _globalKey.currentContext?.findRenderObject()
      as RenderRepaintBoundary?;

      if (boundary == null) return;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        if (kIsWeb) {
          final blob = html.Blob([pngBytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", "jogos_da_semana.png")
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          await Gal.putImageBytes(pngBytes);
        }

        if (mounted) {
          setState(() => _textoBotao = 'Ok');
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final bool isModelo3Jogos =
        widget.modeloSelecionado.imagePath.endsWith('2.png') ||
            widget.modeloSelecionado.imagePath.endsWith('3.png') ||
            widget.modeloSelecionado.imagePath.endsWith('4.png');

    final double topFractional = isModelo3Jogos ? 0.35 : 0.26;

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
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: _globalKey,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final canvasWidth = constraints.maxWidth;
                          final canvasHeight = constraints.maxHeight;

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                widget.modeloSelecionado.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey[900],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey, size: 40),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: canvasHeight * topFractional,
                                left: canvasWidth * 0.08,
                                right: canvasWidth * 0.08,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: widget.jogos.map((jogo) {
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
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    jogo.genero.sigla
                                                        .toUpperCase(),
                                                    maxLines: 1,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize:
                                                      canvasWidth * 0.062,
                                                      height: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    textoDiaHora,
                                                    maxLines: 1,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize:
                                                      canvasWidth * 0.042,
                                                      height: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/escudos/6.png',
                                            width: canvasWidth * 0.175,
                                            height: canvasWidth * 0.175,
                                            fit: BoxFit.fill,
                                            errorBuilder: (_, __, ___) => Icon(
                                                Icons.shield,
                                                size: canvasWidth * 0.15,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Text(
                                              'VS',
                                              style:
                                              GoogleFonts.chauPhilomeneOne(
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontSize: canvasWidth * 0.042,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            jogo.adversario.logoPath,
                                            width: canvasWidth * 0.175,
                                            height: canvasWidth * 0.175,
                                            fit: BoxFit.fill,
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
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A017),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _salvarImagem,
                child: Text(
                  _textoBotao,
                  style: const TextStyle(
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