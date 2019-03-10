import 'package:flutter/material.dart';

class Category extends StatelessWidget {
	final IconData icon;
	final String name;
	final ColorSwatch color;

	const Category({
		@required this.icon,
		@required this.name,
		@required this.color,
		Key key
	}) : assert(icon != null),
			assert(name != null),
			assert(color != null),
			super(key : key);

	@override
	Widget build(BuildContext context) {
		return Material(
			color: Colors.transparent,
			child: Container(
				height: 100.0,
				child: InkWell(
					borderRadius: BorderRadius.circular(50.0),
					onTap: () {
						print("I was tapped!");
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