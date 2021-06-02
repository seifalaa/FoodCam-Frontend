import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

import 'Customize_drawer_listitem.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({ Key? key,
  required this.name,
  
   }) : super(key: key);
  final name;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data:Theme.of(context).copyWith(canvasColor:Colors.grey[200]),
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 150.0,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: KSecondaryColor,
                  ),
                  child: Row(
                    children: [
                       ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'lib/assets/avatar.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
                      Padding(
                        padding: EdgeInsets.only(left:15.0),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: KTextColor,
                          ),
                        ),
                         ),
                                          ],
                     
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50.0),
                  CustomDrawerListitem(
                    text: "Account",
                    icon: Icons.person_outline_rounded,
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  CustomDrawerListitem(
                    text: "Collections",
                    icon: Icons.collections_bookmark,
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  CustomDrawerListitem(
                    text: "Allergy",
                    icon: Icons.no_food_outlined,
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  CustomDrawerListitem(
                    text: "Settings",
                    icon: Icons.settings_outlined,
                    onTap: () {},
                  ),
                  
              
           
             
             Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,   
                       children: [
                         Text("Food Cam V1",style:TextStyle(

                           color: KTextColor,
                         ), ),
                            ElevatedButton(
                             
                             style:ElevatedButton.styleFrom(
                              primary: KPrimaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),  
                               )   ,
                             onPressed: () {}, child: Padding(
                               padding:EdgeInsets.all(10.0),
                               child: Text("Logout",style: TextStyle(
                                 fontSize: 15.0,
                               
      
                               ),),
                             ),
                             ),
                         
                       ],
                                    ),
             
                  
                 
                
                ],
              ),
              
              
              
            ],
          ),
        ),
      );
  }
}