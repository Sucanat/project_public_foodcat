
import 'package:flutter/material.dart';
import 'package:public_foodcat/models/foodcat.dart';

import 'package:public_foodcat/screens/home/add_foodcat.dart';
import 'package:public_foodcat/screens/home/list_foodcat.dart';

import 'package:public_foodcat/repositories/foodcat_reposoty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Foodcat>? _foodcat;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getFoodcat();
  }

  getFoodcat() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var foodcats = await FoodcatRepository().getFoodcat();
      debugPrint('Number of foodcat: ${foodcats.length}');

      setState(() {
        _foodcat = foodcats;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getFoodcat, child: Text('Retry'))
            ])));

    buildList() => ListView.builder(
        itemCount: _foodcat!.length,
        itemBuilder: (ctx, i) {
          Foodcat foodcat = _foodcat![i];
          return FoodcatList(foodcat: foodcat);
        });

    handleClickAdd() {
      Navigator.pushNamed(context, AddfoodcatPage.routeName).whenComplete(() {
        getFoodcat();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Public Foodcat'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: handleClickAdd, child: Icon(Icons.add)),
        body: Stack(
          children: [
            if (_foodcat?.isNotEmpty ?? false) buildList(),
            if (_errorMessage != null) buildError(),
            if (_isLoading) buildLoadingOverlay()
          ],
        ));
  }
}
