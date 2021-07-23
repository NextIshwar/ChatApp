import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatelessWidget {
  final String? userName, email;
  const MyProfile({Key? key, this.userName, this.email}) : super(key: key);

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
          ProfileImage(),
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
  const ProfileImage({Key? key}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(100.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Image.asset(
                AllImages.defaultProfileImage,
                height: 150,
                fit: BoxFit.fill,
              ),
              radius: 100,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 40,
            child: IconButton(
              icon: Icon(
                Icons.camera_enhance,
                size: 40,
                color: ColorPalette.secondaryColor,
              ),
              onPressed: () async{
                var data=await upoadImage();
              },
            ),
          )
        ],
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

upoadImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  final imageBytes = await image?.readAsBytes();
  return imageBytes;
}
