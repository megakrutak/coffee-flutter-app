import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onSubmit;
  final bool autoFocus;

  PhoneTextField({@required this.onSubmit, this.controller, this.autoFocus});

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.subtitle;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: SizedBox(
        width: 230,
        height: 66,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Form(
            child: Row(
              children: <Widget>[
                Text("+7 | ", style: textStyle),
                Expanded(
                  child: TextFormField(
                    autofocus: widget.autoFocus ?? false,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    controller: this.widget.controller,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '### ###-##-##',
                        filter: {"#": RegExp(r'[0-9]')},
                      )
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.0)),
                    onChanged: (String text) {},
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      if (this.widget.controller.text.length == 13) {
                        this.widget.onSubmit();
                      }
                    },
                    child: Center(
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
