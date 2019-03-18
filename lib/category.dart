import 'package:flutter/material.dart';
import 'package:unit_converter_app/unit.dart';

class Category{
	final IconData icon;
	final String name;
	final ColorSwatch color;
	final List<Unit> units;

	const Category({
		@required this.icon,
		@required this.name,
		@required this.color,
		@required this.units,
		Key key
	}) : assert(icon != null),
		assert(name != null),
		assert(color != null),
		assert(units != null);
}