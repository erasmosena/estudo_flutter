import 'package:flutter/material.dart';
import 'package:xlo/screens/create/widget/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  ImagesField({this.onSaved, this.initialValue});

  final FormFieldSetter<List> onSaved;
  final List initialValue;

  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      onSaved: onSaved,
      initialValue: initialValue,
      validator: (images) {
        if (images.isEmpty) return 'Campo obrigatório';
        return null;
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 140,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == state.value.length) {
                    return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => ImageSourceSheet(
                                    onImageSelected: (imagem) {
                                      state.didChange(state.value..add(imagem));
                                      Navigator.of(context).pop();
                                    },
                                  ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 52,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text('+ Inserir',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ));
                  } else {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.file(state.value[index]),
                                      FlatButton(
                                        child: const Text('Excluir'),
                                        textColor: Colors.red,
                                        onPressed: () {
                                          state.didChange(
                                              state.value..removeAt(index));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: FileImage(state.value[index]),
                          ),
                        ));
                  }
                },
                scrollDirection: Axis.horizontal,
                itemCount: state.value.length + 1,
              ),
            ),
            state.hasError
                ? Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      state.errorText,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                : Container()
          ],
        );
      },
    );
  }
}
