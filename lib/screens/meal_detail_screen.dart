import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function(String val) toggleFavorite;
  final Function(String val) isFavorite;

  const MealDetailScreen({
    Key? key,
    required this.toggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(child: Text('# ${index + 1}')),
                  title: Text(selectedMeal.steps[index]),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavorite(mealId);
        },
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
