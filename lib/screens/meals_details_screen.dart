import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function toggleFavorite;
  final Function isMealFavorite;
  MealDetailsScreen(this.toggleFavorite, this.isMealFavorite);

  Widget textBuilder(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget detailsBuilder({Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15)),
      height: 150,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealDetails =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealId = mealDetails['id'];
    final mealTitle = mealDetails['title'];
    final mealChosen = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(mealTitle),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
              child: Image.network(
                mealChosen.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            textBuilder(context, 'Ingrediants'),
            detailsBuilder(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        mealChosen.ingredients[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                itemCount: mealChosen.ingredients.length,
              ),
            ),
            textBuilder(context, 'Steps'),
            detailsBuilder(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(mealChosen.steps[index]),
                  );
                },
                itemCount: mealChosen.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
