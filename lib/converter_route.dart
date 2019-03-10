import 'package:flutter/material.dart';
import 'package:unit_converter_app/unit.dart';

class ConverterScreen extends StatefulWidget {
	final List<Unit> units;
	final ColorSwatch color;

	const ConverterScreen({
		@required this.units,
		@required this.color
	}) : assert(units != null),
		assert(color != null);

	@override
	_ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
	@override
	Widget build(BuildContext context) {
		final unitWeights = widget.units.map((Unit unit) {
			return Container(
				color: widget.color,
				margin: EdgeInsets.all(8.0),
				padding: EdgeInsets.all(16.0),
				child: Column(
					children: <Widget>[
						Text(
							unit.name,
							style: Theme.of(context).textTheme.headline,
						),
						Text(
							'Conversion: ${unit.conversion}',
							style: Theme.of(context).textTheme.subhead,
						),
					],
				),	
			);
		}).toList();

		return ListView(
			children: unitWeights,
		);
	}
}

