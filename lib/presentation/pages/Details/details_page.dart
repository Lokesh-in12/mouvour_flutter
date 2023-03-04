import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailsPage extends StatelessWidget {
  final String? id;
  const DetailsPage({super.key, @required this.id});

  @override
  Widget build(BuildContext context) {
    return Text("details page param is $id");
  }
}
