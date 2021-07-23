import 'dart:io';

import 'package:chat_app/common/chat_imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatelessWidget {
  final String? userName, email, imageUrl;
  const MyProfile({Key? key, this.userName, this.email, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        actions: [],
        title: Text(
          "Profile",
          style: TextStyle(
            color: ColorPalette.secondaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImage(
            email: email,
            imageUrl: imageUrl,
          ),
          AboutSection(
            icon: Icons.person,
            title: "Name",
            value: userName,
          ),
          AboutSection(
            icon: Icons.mail,
            title: "Email",
            value: email,
          ),
        ],
      ),
    );
  }
}

class ProfileImage extends StatefulWidget {
  final String? email, imageUrl;
  const ProfileImage({Key? key, this.email, this.imageUrl}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String imageUrl = '';
  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Query(
        options: QueryOptions(
          document: gql(Queries.getProfileImage),
          variables: {"id": widget.email},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(100.0),
                child: CircleAvatar(
                    backgroundColor: ColorPalette.secondaryColor,
                    radius: 100,
                    child: CircularProgressIndicator()),
              ),
            );
          }
          imageUrl = result
              .data?['User_users_aggregate']['nodes'].first['profileImage'];
          return Mutation(
            options: MutationOptions(
              document: gql(Queries.insertImage),
            ),
            builder: (insert, result) => Padding(
              padding: EdgeInsets.all(100.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: (imageUrl != '')
                          ? NetworkImage(
                              imageUrl,
                            )
                          : NetworkImage(Constants.defaultImageUrl),
                      backgroundColor: Colors.black,
                      radius: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 40,
                    child: IconButton(
                      icon: Icon(Icons.camera_enhance,
                          size: 40, color: ColorPalette.secondaryColor),
                      onPressed: () async {
                        Loader.of(context).show();
                        var data = await uploadImage(widget.email ?? "");

                        setState(() {
                          imageUrl = data;
                        });
                        Loader.of(context).hide();
                        insert({"id": widget.email, "url": imageUrl});
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final IconData? icon;
  final String? title, value;
  const AboutSection({Key? key, this.icon, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorPalette.secondaryColor,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value ?? "",
                style: TextStyle(
                    color: ColorPalette.secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<String> uploadImage(String imageName) async {
  final _firebaseStorage = FirebaseStorage.instance;

  //Select Image
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  var file = File(image?.path ?? "");

  if (image != null) {
    //Upload to Firebase
    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } else {
    return '';
  }
}
