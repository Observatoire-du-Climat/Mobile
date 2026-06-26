import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../models/enum/bird_specie.dart';

class SpecieDropdown extends StatelessWidget {
  final BirdSpecie selected;
  final ValueChanged<BirdSpecie?> onChanged;

  const SpecieDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(
              "Espèce :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<BirdSpecie>(
                value: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: BirdSpecie.swallow,
                    child: Text("Hirondelles"),
                  ),
                  DropdownMenuItem(
                    value: BirdSpecie.swift,
                    child: Text("Martinets"),
                  ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}