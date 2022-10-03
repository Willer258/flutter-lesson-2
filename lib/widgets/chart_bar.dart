import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double spendingPctofTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctofTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('${spendingAmount.toStringAsFixed(0)}Fr')),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 255, 169, 169),
                        width: 1),
                    color: const Color.fromARGB(255, 204, 204, 204),
                    borderRadius: BorderRadius.circular(20))),
            FractionallySizedBox(
              heightFactor: spendingPctofTotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
