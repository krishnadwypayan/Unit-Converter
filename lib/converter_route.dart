import 'package:flutter/material.dart';
import 'package:unit_converter_app/unit.dart';
import 'category.dart';

class UnitConverter extends StatefulWidget {
	final Category category;

	const UnitConverter({
		@required this.category
	}) : assert(category != null);

	@override
	_UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {

	Unit _fromVal, _toVal;
	double _inputVal;
	String _convertedVal = '';
	List<DropdownMenuItem> _unitMenuItems;
	bool _validate = false;

	@override
	void initState() {
		super.initState();

		_createDropDownMenuList();
		_setDefaults();
  	}

	@override
	void didUpdateWidget(UnitConverter old) {
		super.didUpdateWidget(old);
		if (old.category !=widget.category) {
			_createDropDownMenuList();
			_setDefaults();
		}
	}

	_createDropDownMenuList() {
		var newItems = <DropdownMenuItem>[];
		for (var unit in widget.category.units) {
			newItems.add(DropdownMenuItem(
				value: unit.name,
				child: Container(
					child: Text(
						unit.name,
						softWrap: true,
					),
				),
			));
		}

		setState(() {
			_unitMenuItems = newItems;
		});
	}

	_setDefaults() {
		setState(() {
			_fromVal = widget.category.units[0];
			_toVal = widget.category.units[1];
		});
	}

	_updateInputValue(String input) {
		setState(() {
			if (input == null || input.isEmpty) {
				_convertedVal = '0';
			} else {
				try {
					final inputDouble = double.parse(input);
					_validate = false;
					_inputVal = inputDouble;
					_updateConversion();
				} on Exception catch (e) {	
					print('Error : $e');
					_validate = true;
				}
			}
		});
	}

	// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
	_format(double conversion) {
		var outputNum =conversion.toStringAsPrecision(7);
		if (outputNum.contains('.') && outputNum.endsWith('0')) {
			var i = outputNum.length - 1;
			while (outputNum[i] == '0') {
				i -= 1;
			}
			outputNum = outputNum.substring(0, i + 1);
		}
		if (outputNum.endsWith('.')) {
			return outputNum.substring(0, outputNum.length - 1);
		}
		return outputNum;
	}

	_updateConversion() {
		setState(() {
			_convertedVal = _format(_inputVal * (_toVal.conversion/_fromVal.conversion));
		});
	}

	Unit _getUnit(String unitName) {
		return widget.category.units.firstWhere(
			(Unit unit) {
				return unit.name == unitName;
			},
			orElse: null,
		);
	}

	_updateFromConversion(dynamic unitName) {
		setState(() {
			_fromVal = _getUnit(unitName);
		});
		if (_inputVal != null) {
			_updateConversion();
		}
	}

	_updateToConversion(dynamic unitName) {
		setState(() {
			_toVal = _getUnit(unitName);
		});
		if (_inputVal != null) {
			_updateConversion();
		}
	}

	Widget _createDropDown(String currentVal, ValueChanged<dynamic> onChanged) {
		return Container(
			margin: EdgeInsets.only(top: 16.0),
			decoration: BoxDecoration(
				color: Colors.grey[50],
				border: Border.all(
					color: Colors.grey[400],
					width: 1.0,
				),
			),
			padding: EdgeInsets.symmetric(vertical: 8.0),
			child: Theme(
				data: Theme.of(context).copyWith(
					canvasColor: Colors.grey[50],
				),
				child: DropdownButtonHideUnderline(
					child: ButtonTheme(
						alignedDropdown: true,
						child: DropdownButton(
							value: currentVal,
							items: _unitMenuItems,
							onChanged: onChanged,
							style: Theme.of(context).textTheme.title,
						),
					),
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		final input = Padding(
			padding: const EdgeInsets.all(16.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: <Widget>[
					TextField(
						style: Theme.of(context).textTheme.display1,
						decoration: InputDecoration(
							border: OutlineInputBorder(
								borderRadius: BorderRadius.circular(0.0),
							),
							hintText: "0",
							labelText: "Input",
							alignLabelWithHint: true,
							errorText: _validate ? "Incorrect input" : null,
						),
						keyboardType: TextInputType.number,
						onChanged: _updateInputValue,
					),
					_createDropDown(_fromVal.name, _updateFromConversion),
				],
		  	),
		);

		final arrow = RotatedBox(
				quarterTurns: 1,
				child: Icon(
					Icons.compare_arrows,
					size: 40.0,
			),
		);

		final output = Padding(
			padding: const EdgeInsets.all(16.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: <Widget>[
					InputDecorator(
						child: Text(
							_convertedVal,
							style: Theme.of(context).textTheme.display1,	
						),
						decoration: InputDecoration(
							border: OutlineInputBorder(
								borderRadius: BorderRadius.circular(0.0),
							),
							labelText: "Output",
							labelStyle: Theme.of(context).textTheme.display1,
						),
					),
					_createDropDown(_toVal.name, _updateToConversion),
				],
		  	),
		);

		return Scaffold(
			body: Container(
				padding: EdgeInsets.all(16.0),
				child: Column(
					children: <Widget>[
						input,
						arrow,
						output,
					],
			  	),
			),
		);
	}
}

