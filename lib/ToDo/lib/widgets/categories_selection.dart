import 'package:discover_training_location/ToDo/lib/providers/category_provider.dart';
import 'package:discover_training_location/ToDo/lib/utils/extensions.dart';
import 'package:discover_training_location/ToDo/lib/utils/task_category.dart';
import 'package:discover_training_location/ToDo/lib/widgets/circle_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CategoriesSelection extends ConsumerWidget {
  const CategoriesSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final List<TaskCategory> categories = TaskCategory.values.toList();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Category',
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final category = categories[index];

                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category;
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: CircleContainer(
                    color: const Color(0xFF2A2D3E).withOpacity(0.3),
                    borderColor: category.color,
                    child: Icon(
                      category.icon,
                      color: selectedCategory == category
                          ? const Color(0xFF2697FF)
                          : category.color.withOpacity(0.5),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Gap(8),
            ),
          ),
        ],
      ),
    );
  }
}
