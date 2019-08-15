import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/viewmodels/detail_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:flutter_firebase_template/ui/widgets/loading_overlay.dart';

class DetailView extends StatelessWidget {
  final Item item;

  const DetailView({@required this.item});

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailModel>(
      onModelReady: (model) {
        model.item = this.item;
      },
      builder: (context, model, child) => Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(model.item.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Delete Item?'),
                          actions: <Widget>[
                            FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  model.dismissAlert();
                                }),
                            FlatButton(
                              child: Text(
                                'DELETE',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                model.deleteItem();
                              },
                            )
                          ],
                        );
                      });
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(model.item.body),
          ),
        ),
          model.state == ViewState.Busy ? LoadingOverlay() : Container(),
      ]),
    );
  }
}
