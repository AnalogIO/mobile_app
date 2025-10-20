import 'package:cafe_analog_app/core/widgets/analog_app_bar.dart';
import 'package:cafe_analog_app/core/widgets/components/section_title.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalogAppBar(title: 'Statistics'),
      body: ListView(
        children: [
          const SectionTitle('Quick stats'),
          Container(),
          const SectionTitle('Leaderboards'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: index < 2 ? 4 : 0),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        ['This month', 'This semester', 'All time'][index],
                      ),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() {
                            _value = index;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//           ListTile(
     
