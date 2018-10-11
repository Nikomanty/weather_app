import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget{
	final Color color;

	PlaceHolderWidget(this.color);



	@override
	Widget build(BuildContext context) {
		return new Container(
			color: Theme.of(context).backgroundColor,
		);
	}

}