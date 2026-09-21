import 'package:flutter/material.dart';
import '../models/jogo_models.dart';
import 'tela_cards.dart';

class TelaSelecao extends StatefulWidget {
  const TelaSelecao({super.key});

  @override
  State<TelaSelecao> createState() => _TelaSelecaoState();
}

class _TelaSelecaoState extends State<TelaSelecao> {
  int quantidadeJogos = 1;
  ModeloFundo modeloSelecionado = ModeloFundo.modelo1;

  void _alterarQuantidade(int novaQtd) {
    setState(() {
      quantidadeJogos = novaQtd;
      if (modeloSelecionado.capacidadeMaxima < novaQtd) {
        modeloSelecionado = ModeloFundo.modelo1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fundosValidos = ModeloFundo.values
        .where((f) => f.capacidadeMaxima >= quantidadeJogos)
        .toList();

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
          'Jogos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),

            // QUANTIDADE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final numero = index + 1;
                final estaSelecionado = quantidadeJogos == numero;

                return GestureDetector(
                  onTap: () => _alterarQuantidade(numero),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          estaSelecionado
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: estaSelecionado
                              ? const Color(0xFFD4A017)
                              : Colors.grey[500],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$numero',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            Divider(color: Colors.grey[800], thickness: 1),

            const SizedBox(height: 12),

            // MODELOS
            const Text(
              'Modelos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.52,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: fundosValidos.length,
                itemBuilder: (context, index) {
                  final modelo = fundosValidos[index];
                  final estaSelecionado = modeloSelecionado == modelo;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        modeloSelecionado = modelo;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: estaSelecionado
                            ? Colors.grey[850]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          // CARD COM IMAGEM DE FUNDO
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                modelo.imagePath,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey[900],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          Icon(
                            estaSelecionado
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: estaSelecionado
                                ? const Color(0xFFD4A017)
                                : Colors.grey[600],
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaCards(
                          quantidadeJogos: quantidadeJogos,
                          modeloSelecionado: modeloSelecionado,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Próximo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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