import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmit;
  final bool autoFocus;

  PhoneTextField({@required this.onSubmit, this.controller, this.autoFocus});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.subtitle;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: SizedBox(
        width: 230,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            children: <Widget>[
              Text("+7", style: textStyle),
              Text(" | ", style: textStyle),
              Expanded(
                child: TextFormField(
                  autofocus: autoFocus ?? false,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: this.controller,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '### ###-##-##',
                      filter: {"#": RegExp(r'[0-9]')},
                    )
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  onChanged: (String text) {},
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  onPressed: () {},
                  child: Center(
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
