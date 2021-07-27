import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddStatus extends StatefulWidget {
  final String? id, userName;
  const AddStatus({Key? key, this.id, this.userName}) : super(key: key);

  @override
  _AddStatusState createState() => _AddStatusState();
}

class _AddStatusState extends State<AddStatus> {
  late TextEditingController controller;

  bool showUpdateButton = false;
  @override
  void initState() {
    super.initState();
    controller = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.height;
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Mutation(
        options: MutationOptions(
          document: gql(Queries.setStatus),
        ),
        builder: (runMutation, result) => Scaffold(
          floatingActionButton: showUpdateButton
              ? FloatingActionButton(
                  backgroundColor: ColorPalette.primaryColor,
                  onPressed: () {
                    runMutation(<String, dynamic>{
                      "id": widget.id,
                      "textStatus": controller.text,
                      "isUrl": false
                    });
                    // Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.send,
                    color: ColorPalette.secondaryColor,
                  ),
                )
              : null,
          backgroundColor: Colors.yellow,
          body: Center(
            child: SizedBox(
              width: width * 0.3,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 100,
                controller: controller,
                cursorColor: Colors.white,
                cursorWidth: 4,
                autofocus: true,
                onChanged: (val) {
                  if (!val.trim().isEmpty) {
                    setState(() {
                      showUpdateButton = true;
                    });
                  } else {
                    setState(() {
                      showUpdateButton = false;
                    });
                  }
                },
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type a status",
                  hintStyle: TextStyle(
                      fontSize: 40,
                      color: ColorPalette.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
