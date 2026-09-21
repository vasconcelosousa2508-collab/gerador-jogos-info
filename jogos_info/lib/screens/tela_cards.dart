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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informações',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                final jogo = jogos[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161616),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jogo ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _buildLabel('Esporte'),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Esporte.values.length,
                          itemBuilder: (context, idx) {
                            final esporte = Esporte.values[idx];
                            final estaSelecionado = jogo.esporte == esporte;

                            return GestureDetector(
                              onTap: () {
                                setState(() => jogo.esporte = esporte);
                              },
                              child: Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: estaSelecionado
                                        ? const Color(0xFFD4A017)
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset(
                                          esporte.iconPath,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.sports,
                                              color: Colors.white,
                                              size: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        esporte.nome,
                                        style: TextStyle(
                                          color: estaSelecionado
                                              ? const Color(0xFFD4A017)
                                              : Colors.grey[400],
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Modalidade'),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<Genero>(
                                  value: jogo.genero,
                                  dropdownColor: const Color(0xFF222222),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration(),
                                  items: Genero.values.map((genero) {
                                    return DropdownMenuItem(
                                      value: genero,
                                      child: Text(genero.sigla),
                                    );
                                  }).toList(),
                                  onChanged: (novoValor) {
                                    if (novoValor != null) {
                                      setState(() => jogo.genero = novoValor);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Dia'),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<DiaSemana>(
                                  value: jogo.dia,
                                  dropdownColor: const Color(0xFF222222),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration(),
                                  items: DiaSemana.values.map((dia) {
                                    return DropdownMenuItem(
                                      value: dia,
                                      child: Text(dia.sigla),
                                    );
                                  }).toList(),
                                  onChanged: (novoValor) {
                                    if (novoValor != null) {
                                      setState(() => jogo.dia = novoValor);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      _buildLabel('Horário'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<Horario>(
                        value: jogo.horario,
                        dropdownColor: const Color(0xFF222222),
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration(),
                        items: Horario.values.map((horario) {
                          return DropdownMenuItem(
                            value: horario,
                            child: Text(horario.texto),
                          );
                        }).toList(),
                        onChanged: (novoValor) {
                          if (novoValor != null) {
                            setState(() => jogo.horario = novoValor);
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      _buildLabel('Adversário'),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: TimeAdversario.values.length,
                          itemBuilder: (context, idx) {
                            final adv = TimeAdversario.values[idx];
                            final estaSelecionado = jogo.adversario == adv;

                            return GestureDetector(
                              onTap: () {
                                setState(() => jogo.adversario = adv);
                              },
                              child: Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: estaSelecionado
                                        ? const Color(0xFFD4A017)
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset(
                                          adv.logoPath,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.shield,
                                              color: Colors.white,
                                              size: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        adv.nome,
                                        style: TextStyle(
                                          color: estaSelecionado
                                              ? const Color(0xFFD4A017)
                                              : Colors.grey[400],
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                );
              },
            ),
          ),

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
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF222222),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD4A017)),
      ),
    );
  }
}