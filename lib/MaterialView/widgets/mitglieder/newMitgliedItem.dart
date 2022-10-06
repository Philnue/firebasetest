import 'package:firebasetest/MaterialView/Views/mitgliedInfoView.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:flutter/material.dart';

class NewMitgliedItem extends StatelessWidget {
  const NewMitgliedItem(
      {Key? key,
      required this.padding,
      required this.fontsize,
      required this.mitglied})
      : super(key: key);

  final double padding;
  final double fontsize;
  final Member mitglied;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            try {
              Navigator.of(context)
                  .pushNamed(MitgliedInfoView.routeName, arguments: mitglied);
            } catch (_) {
              throw _.toString();
            }
          },
          child: Card(
            // elevation: 0,
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(
            //     color: Theme.of(context).colorScheme.outline,
            //   ),
            //   borderRadius: const BorderRadius.all(Radius.circular(12)),
            // ),
            child: SizedBox(
              width: 200,
              height: 100,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    mitglied.getName,
                    style: TextStyle(
                        fontSize: fontsize,
                        fontWeight: FontWeight.w700,
                        color: mitglied.isPassive == false
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),

        // return Padding(
        //   padding: const EdgeInsets.all(5),
        //   child: ActionChip(
        //     backgroundColor: Colors.black,
        //     avatar: CircleAvatar(
        //       child: Icon(Icons.person),
        //     ),
        //     label: Text(
        //       mitglied.getName,
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .pushNamed(MitgliedInfoView.routeName, arguments: mitglied);
        //     },
        //   ),
        // child: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context)
        //         .pushNamed(MitgliedPage.routeName, arguments: mitglied);
        //   },
        //   child: Card(
        //     elevation: 5,
        //     color: Colors.white,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //     child: Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child: SizedBox(
        //         //width: double.infinity,
        //         child: FittedBox(
        //           fit: BoxFit.contain,
        //           child: Text(
        //             mitglied.getName,
        //             style: TextStyle(
        //                 fontSize: fontsize,
        //                 fontWeight: FontWeight.w800,
        //                 color: mitglied.isPassive == false
        //                     ? Colors.black
        //                     : Colors.grey),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        // Card(
        //   child: Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: Text("test"),
        //   ),
        // ),
        // ListTile(
        //   title: Text("dawdawda"),
        // ),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: ListTile(
        //     title: Text(mitglied.getName),
        //   ),
        // ),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Padding(
        //     padding: EdgeInsets.all(5),
        //     child: SizedBox(
        //       child: FittedBox(
        //         fit: BoxFit.contain,
        //         child: Text(
        //           mitglied.getName,
        //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ),
    );
  }
}
