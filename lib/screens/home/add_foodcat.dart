import 'package:flutter/material.dart';
import 'package:public_foodcat/repositories/foodcat_reposoty.dart';

class AddfoodcatPage extends StatefulWidget {
  static const routeName = 'add_foodcat';

  const AddfoodcatPage({Key? key}) : super(key: key);

  @override
  State<AddfoodcatPage> createState() => _AddfoodcatPageState();
}

class _AddfoodcatPageState extends State<AddfoodcatPage> {
  var _isLoading = false;
  String? _errorMessage;

  final _foodcatNameController = TextEditingController();
  final _priceController = TextEditingController();

  validateForm() {
    return _foodcatNameController.text.isNotEmpty && _priceController.text.isNotEmpty;
  }

  saveFoodcat() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var foodcatName = _foodcatNameController.text;
      var price = double.parse(_priceController.text);

      await FoodcatRepository().AddFoodcat(name: foodcatName, price: price);

      if (mounted) Navigator.pop(context);
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
      child: Center(child: CircularProgressIndicator()),
    );

    handleClickSave() {
      if (validateForm()) {
        saveFoodcat();
      }
    }

    buildForm() => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _foodcatNameController,
                decoration: InputDecoration(
                  hintText: 'Foodcat name',
                  prefixIcon: Icon(Icons.fastfood),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Price',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: handleClickSave,
                child: Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('ADD FOODCAT')),
      body: Stack(
        children: [
          buildForm(),
          if (_isLoading) buildLoadingOverlay(),
        ],
      ),
    );
  }
}
