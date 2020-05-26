import 'package:flutter/material.dart';
import 'package:xlo/models/filter.dart';
import 'package:xlo/screens/filter/widget/animated_button.dart';
import 'package:xlo/screens/filter/widget/order_by_field.dart';
import 'package:xlo/screens/filter/widget/price_range_filter.dart';
import 'package:xlo/screens/filter/widget/section_title.dart';
import 'package:xlo/screens/filter/widget/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Filter _filter = Filter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(elevation: 0, title: const Text("Filtar busca")),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                const SectionTitle(title: "Ordernar Por"),
                OrderByField(
                    initialValue: _filter.orderBy,
                    onSaved: (v) {
                      _filter.orderBy = v;
                    }),
                const SectionTitle(title: "Preço(R\$)"),
                PriceRangeFields(filter: _filter),
                const SectionTitle(title: "Tipo de anunciante"),
                VendorTypeField(
                  initialValue: _filter.vendorType,
                  onSaved: (v) {
                    _filter.vendorType = v;
                  },
                ),
                const SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
          AnimatedButton(
              scrollController: _scrollController,
              onTap: () {
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  if( _filter.maxPrice != null &&  _filter.minPrice != null ){
                    if( _filter.minPrice >  _filter.maxPrice ){
                      _scaffoldState.currentState.showSnackBar(
                        SnackBar(
                          content: const Text('Faixa de preço inválida'),
                          backgroundColor: Colors.pink,
                        )
                      );
                      return ;
                    }
                  }
                  // Salvar e
                }
              }),
        ],
      ),
    );
  }
}
