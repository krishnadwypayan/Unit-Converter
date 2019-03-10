import 'package:flutter/material.dart';
import 'package:unit_converter_app/category.dart';

class CategoryRoute extends StatelessWidget {
	const CategoryRoute();

	static const _categoryNames = <String>[
		'Length',
		'Area',
		'Volume',
		'Mass',
		'Time',
		'Digital Storage',
		'Energy',
		'Currency',
	];

	static const _baseColors = <Color>[
		Colors.teal,
		Colors.orange,
		Colors.pinkAccent,
		Colors.blueAccent,
		Colors.yellow,
		Colors.greenAccent,
		Colors.purpleAccent,
		Colors.red,
	];

	@override
	Widget build(BuildContext context) {
		final categories = <Category>[];
		for (var i = 0; i < _categoryNames.length; i++) {
			categories.add(Category(
				name: _categoryNames[i],
				color: _baseColors[i],
				icon: Icons.cake,
			));
		}

		final listView = Container(
			color: Colors.green[100],
			padding: EdgeInsets.symmetric(horizontal: 8.0),
			child: ListView.builder(
				itemCount: _categoryNames.length,
				itemBuilder: (BuildContext context, int index) => categories[index],
			),
		);

		final appBar = AppBar(
			elevation: 0.0,
			backgroundColor: Colors.green[100],
			centerTitle: true, 
			title: Text(
				'Unit Converter',
				style: TextStyle(fontSize: 30.0, color: Colors.black),
			),
		);

		return Scaffold(
			appBar: appBar,
			body: listView,
		);
	}
}