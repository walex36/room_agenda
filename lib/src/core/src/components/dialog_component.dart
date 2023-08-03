import 'package:flutter/material.dart';

class DialogComponent extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget footer;
  DialogComponent({
    super.key,
    required this.title,
    required this.body,
    required this.footer,
  });

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _keyForm,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  height: 2,
                ),
                const SizedBox(
                  height: 8,
                ),
                body,
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  height: 2,
                ),
                const SizedBox(
                  height: 8,
                ),
                footer,
              ],
            ),
          )),
    );
  }
}
