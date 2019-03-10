import 'package:flutter/material.dart';
import 'package:unit_converter_app/unit.dart';
import 'package:unit_converter_app/converter_route.dart';

class Category extends StatelessWidget {
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
		assert(units != null),
		super(key : key);

	// Navigates to the converter route
	_navigateToConverter(BuildContext context) {
		if (Navigator.of(context).canPop()) {
			Navigator.of(context).pop();
		}
		Navigator.of(context).push(MaterialPageRoute(
			builder: (BuildContext context) {
				return Scaffold(
					appBar: AppBar(
						elevation: 1.0,
						backgroundColor: this.color[100],
						centerTitle: true, 
						title: Text(
							this.name,
							style: Theme.of(context).textTheme.display1,
						),
					),
					body: ConverterScreen(
						color: this.color,
						units: this.units,
					),
					resizeToAvoidBottomPadding: false,
				);	
			}
		));
	}

	@override
	Widget build(BuildContext context) {
		return Material(
			color: Colors.transparent,
			child: Container(
				height: 100.0,
				child: InkWell(
					borderRadius: BorderRadius.circular(50.0),
					onTap: () {
						_navigateToConverter(context);
					},
					splashColor: color,
					highlightColor: color,
					child: Row(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: <Widget>[
							Padding(
								child: Icon(icon, size: 60.0,),
								padding: const EdgeInsets.all(16.0),
							),
							Center(
								child: Text(
									name,
									textAlign: TextAlign.center,
									style: Theme.of(context).textTheme.headline,
								),
							),
						],
					),
				),
			),
		);
	}
}