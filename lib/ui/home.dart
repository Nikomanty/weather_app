import 'package:flutter/material.dart';
import './placeholder_widget.dart';
import './location.dart';
import './search.dart';


class Home extends StatefulWidget{
	@override
	State<StatefulWidget> createState() {
		return new HomeState();
	}

}

class HomeState extends State<Home> {

	int bottomNavBarIndex = 0;

	final List<Widget> _childrenWidgets = [
		Location(),
		PlaceHolderWidget(Colors.green),
		Search()
	];

	void onTabTabbed(int index){
		setState(() {
			bottomNavBarIndex = index;
		});
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			backgroundColor: Theme.of(context).backgroundColor,


			body: _childrenWidgets[bottomNavBarIndex],

			bottomNavigationBar: new Theme(
				data: Theme.of(context).copyWith(
					canvasColor: Theme.of(context).primaryColor,
					primaryColor: Colors.black,
					textTheme: Theme
						.of(context)
						.textTheme
						.copyWith(caption: new TextStyle(color: Colors.white))),

				child: new BottomNavigationBar(
					onTap: onTabTabbed,
					currentIndex: bottomNavBarIndex,
					iconSize: 25.0,
					items: [
						BottomNavigationBarItem(
							icon: new Icon(Icons.home),
							title: new Text("Location"),
						),
						BottomNavigationBarItem(
							icon: new Icon(Icons.camera),
							title: new Text("Coutry"),
						),
						BottomNavigationBarItem(
							icon: new Icon(Icons.search),
							title: new Text("Search"),
						),




					],
				),
			),





		);



	}

}

