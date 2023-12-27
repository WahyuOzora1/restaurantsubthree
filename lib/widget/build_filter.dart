import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsubthree/provider/filter_restaurant_provider.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return PopupMenuButton(
      icon: const Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          const PopupMenuItem(
            value: 'Semua',
            child: Text('Semua'),
          ),
          const PopupMenuItem(
            value: 'Rating Terbaik',
            child: Text('Rating Terbaik'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'Rating Terbaik') {
          filterProvider.setFilter(FilterOptions.ratingTerbaik);
        } else if (value == 'Semua') {
          filterProvider.setFilter(FilterOptions.semua);
        }
      },
    );
  }
}
