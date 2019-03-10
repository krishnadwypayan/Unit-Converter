import 'package:flutter/material.dart';
import 'package:unit_converter_app/category.dart';
import 'package:unit_converter_app/unit.dart';


class CategoryScreen extends StatefulWidget {
	const CategoryScreen();

	@override
	_CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
	final categories = <Category>[];

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
	void initState() {
		super.initState();
		for (var i = 0; i < _categoryNames.length; i++) {
			categories.add(Category(
				name: _categoryNames[i],
				color: _baseColors[i],
				icon: Icons.cake,
				units: _retrieveUnitList(_categoryNames[i]),
			));
		}
	}

	// Returns a list of mock [Unit]s.
	List<Unit> _retrieveUnitList(String categoryName) {
		return List.generate(10, (int i) {
			i += 1;
			return Unit(
				name: '$categoryName Unit $i',
				conversion: i.toDouble(),
			);
		});
	}

	Widget _buildCategoryWidgets(List<Widget> categories) {
		return ListView.builder(
			itemBuilder: (BuildContext context, int index) => categories[index],
			itemCount: categories.length,
		);
  	}

	@override
	Widget build(BuildContext context) {
		final listView = Container(
			color: Colors.green[100],
			padding: EdgeInsets.symmetric(horizontal: 8.0),
			child: _buildCategoryWidgets(categories),
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