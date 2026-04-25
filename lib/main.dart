import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CalculatorDesignApp());
}

class CalculatorDesignApp extends StatelessWidget {
  const CalculatorDesignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator UI Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1C7D73),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.spaceGroteskTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF7F2E9),
      ),
      home: const CalculatorDesignPage(),
    );
  }
}

class CalculatorDesignPage extends StatelessWidget {
  const CalculatorDesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackdropShapes(),
          SafeArea(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 24 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'CALCULADORA',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            letterSpacing: 2.4,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B3A37),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.tune_rounded,
                          color: Color(0xFF1B3A37),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBF4),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: const Color(0xFFE8DDCC),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 28,
                                  offset: Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const _DisplayPanel(),
                                  const SizedBox(height: 14),
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        _KeyRow(['C', '+/-', '%', '÷']),
                                        SizedBox(height: 10),
                                        _KeyRow(['7', '8', '9', '×']),
                                        SizedBox(height: 10),
                                        _KeyRow(['4', '5', '6', '-']),
                                        SizedBox(height: 10),
                                        _KeyRow(['1', '2', '3', '+']),
                                        SizedBox(height: 10),
                                        _KeyRow([
                                          '0',
                                          '.',
                                          '=',
                                        ], wideFirstKey: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackdropShapes extends StatelessWidget {
  const _BackdropShapes();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -140,
            left: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFE5C89F), Color(0x00E5C89F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            right: -120,
            child: Container(
              width: 340,
              height: 340,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFF9BD6CC), Color(0x009BD6CC)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisplayPanel extends StatelessWidget {
  const _DisplayPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF233B39),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '128 + 37',
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF95C0BA),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '165',
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 52,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyRow extends StatelessWidget {
  const _KeyRow(this.labels, {this.wideFirstKey = false});

  final List<String> labels;
  final bool wideFirstKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            Expanded(
              flex: wideFirstKey && i == 0 ? 2 : 1,
              child: _CalcKey(label: labels[i]),
            ),
            if (i < labels.length - 1) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _CalcKey extends StatelessWidget {
  const _CalcKey({required this.label});

  final String label;

  static const _operators = {'÷', '×', '-', '+', '='};
  static const _softKeys = {'C', '+/-', '%'};

  @override
  Widget build(BuildContext context) {
    final bool isOperator = _operators.contains(label);
    final bool isSoftKey = _softKeys.contains(label);

    final Color background = isOperator
        ? const Color(0xFFE7795A)
        : isSoftKey
        ? const Color(0xFFEDE5D8)
        : const Color(0xFFF9F4EA);

    final Color foreground = isOperator
        ? Colors.white
        : isSoftKey
        ? const Color(0xFF5A5D61)
        : const Color(0xFF2E3135);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          color: foreground,
          fontSize: label == '+/-' ? 22 : 28,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
