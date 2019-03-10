import 'package:flutter/material.dart';
import 'package:unit_converter_app/category_route.dart';

void main() => runApp(UnitConverter());

class UnitConverter extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Unit Converter',
			home: Scaffold(
				backgroundColor: Colors.green[100],
				body: CategoryScreen()
			),
		);
	}
}