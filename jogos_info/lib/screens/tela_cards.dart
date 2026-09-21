import 'package:flutter/material.dart';
import '../models/jogo_models.dart';
import 'tela_preview.dart';

class TelaCards extends StatefulWidget {
  final int quantidadeJogos;
  final ModeloFundo modeloSelecionado;

  const TelaCards({
    super.key,
    required this.quantidadeJogos,
    required this.modeloSelecionado,
  });

  @override
  State<TelaCards> createState() => _TelaCardsState();
}

class _TelaCardsState extends State<TelaCards> {
  late List<Jogo> jogos;
  int? jogoAbertoIndex;

  @override
  void initState() {
    super.initState();
    jogos = List.generate(
      widget.quantidadeJogos,
          (index) => Jogo(
        esporte: Esporte.volei,
        genero: Genero.masculino,
        dia: DiaSemana.segunda,
        horario: Horario.h0800,
        adversario: TimeAdversario.meca,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Jogos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: jogos.length,
              separatorBuilder: (_, __) =>
              const Divider(color: Colors.white24, height: 1),
              itemBuilder: (context, index) {
                final jogo = jogos[index];
                final estaAberto = jogoAbertoIndex == index;

                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    key: Key('jogo_$index'),
                    initiallyExpanded: estaAberto,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        jogoAbertoIndex = expanded ? index : null;
                      });
                    },
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    title: Text(
                      'Jogo ${index + 1}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ESPORTE
                            _buildLabel('esporte'),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 75,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Esporte.values.length,
                                itemBuilder: (context, idx) {
                                  final esporte = Esporte.values[idx];
                                  final estaSelecionado =
                                      jogo.esporte == esporte;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() => jogo.esporte = esporte);
                                    },
                                    child: Container(
                                      width: 65,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: estaSelecionado
                                                    ? Colors.white.withOpacity(0.18)
                                                    : Colors.transparent,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                esporte.iconPath,
                                                fit: BoxFit.contain,
                                                errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.sports,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            esporte.nome,
                                            style: TextStyle(
                                              color: estaSelecionado
                                                  ? Colors.white
                                                  : Colors.grey[500],
                                              fontSize: 10,
                                              fontWeight: estaSelecionado
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            // MODALIDADE E HORÁRIO
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('Modalidade'),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<Genero>(
                                        value: jogo.genero,
                                        dropdownColor: const Color(0xFF222222),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: _inputDecoration(),
                                        items: Genero.values.map((genero) {
                                          return DropdownMenuItem(
                                            value: genero,
                                            child: Text(genero.sigla),
                                          );
                                        }).toList(),
                                        onChanged: (novoValor) {
                                          if (novoValor != null) {
                                            setState(
                                                    () => jogo.genero = novoValor);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('Horário'),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<Horario>(
                                        value: jogo.horario,
                                        dropdownColor: const Color(0xFF222222),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: _inputDecoration(),
                                        items: Horario.values.map((horario) {
                                          return DropdownMenuItem(
                                            value: horario,
                                            child: Text(horario.texto),
                                          );
                                        }).toList(),
                                        onChanged: (novoValor) {
                                          if (novoValor != null) {
                                            setState(
                                                    () => jogo.horario = novoValor);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // ADVERSÁRIO
                            _buildLabel('Adversário'),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 75,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: TimeAdversario.values.length,
                                itemBuilder: (context, idx) {
                                  final adv = TimeAdversario.values[idx];
                                  final estaSelecionado =
                                      jogo.adversario == adv;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() => jogo.adversario = adv);
                                    },
                                    child: Container(
                                      width: 65,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: estaSelecionado
                                                    ? Colors.white.withOpacity(0.18)
                                                    : Colors.transparent,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                adv.logoPath,
                                                fit: BoxFit.contain,
                                                errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.shield,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            adv.nome,
                                            style: TextStyle(
                                              color: estaSelecionado
                                                  ? Colors.white
                                                  : Colors.grey[500],
                                              fontSize: 10,
                                              fontWeight: estaSelecionado
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // BOTÃO
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                      builder: (context) => TelaPreview(
                        modeloSelecionado: widget.modeloSelecionado,
                        jogos: jogos,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Finalizar',
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
    );
  }

  Widget _buildLabel(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF333333),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}