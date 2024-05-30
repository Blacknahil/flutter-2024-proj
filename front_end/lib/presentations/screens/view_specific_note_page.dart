import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/presentations/screens/edit_notes.dart';

class ViewNotesPage extends StatelessWidget {
  const ViewNotesPage({Key? key}) : super(key: key);

  final String noteTitle =
      "This the title of the page jhdbjfh ijksdbhjfl dvijkb jf ikbdhsafj ijbasdfibj  ikadsbhjb";
  final String noteBody =
      "This is the body of a specific note to be displayed after sensing the gesture from the home paLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            noteTitle,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ), // Removed const
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Text(
                noteBody,
                style: const TextStyle(fontSize: 15),
              ),
            ), // Removed const and changed to noteBody
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditNoteScreen()),
            );
          },
          child: const Icon(Icons.edit),
        ));
  }
}
