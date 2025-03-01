import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';
import 'package:my_map/pages/insideApp/bus/map_screen.dart';

class BusdirectionScreen extends StatelessWidget {
  const BusdirectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Take the screen sizes
    final Size deviceSize = MediaQuery.of(context).size;
    final double widthScreen = deviceSize.width;
    final double heightScreen = deviceSize.height;

    // variable for mobile and tablet
    final isMobile = widthScreen < 600; // Adjust for tablet or mobile
    final isMobileRotate = heightScreen < 600;
    final isRotate =
        isMobileRotate && widthScreen > heightScreen; // Adjust for rotate
    final appBarHeight = isRotate ? widthScreen / 10 : heightScreen / 10;
    // final textFieldHeight = isRotate ? widthScreen / 4.5 : heightScreen / 4.5;
    final screenPaddingTop =
        MediaQuery.of(context).padding.top; // Take the elevation size
    // final formHeight = heightScreen - appBarHeight - textFieldHeight;
    // final formHeightRotate = widthScreen - (screenPaddingTop * 5);
    // final textFormHeight = isMobile
    //     ? formHeight / 9
    //     : isRotate
    //         ? formHeightRotate / 10
    //         : formHeight / 10; // Adjust the textheight

    return Scaffold(
        backgroundColor: whiteColor,
        //AppBar
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight -
              screenPaddingTop), // Height of the AppBar with added space
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Bus Directions',
              style: TextStyle(
                color: myMainColor,
                fontSize: 40.0,
                fontWeight: FontWeight.w400,
                letterSpacing: isMobile ? 0 : 0.5,
              ),
            ),
            backgroundColor: transparentColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: myMainColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Container(
          // color: const Color(0xFFDC143C), // Crimson color code
          height: heightScreen - appBarHeight,
          padding: const EdgeInsets.all(14.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Calculate the available height inside the container
              double availableHeight = constraints.maxHeight;
              double availableWidth = constraints.maxWidth;

              // Define the number of rows and columns
              int crossAxisCount = 2;
              int rowCount = (10 / crossAxisCount).ceil();

              // Calculate the height for each grid item
              double itemHeight =
                  (availableHeight - (rowCount - 1) * 14.0) / rowCount;
              double itemWidth =
                  (availableWidth - (crossAxisCount - 1) * 14.0) /
                      crossAxisCount;

              // Use the calculated aspect ratio
              return GridView.count(
                crossAxisCount: crossAxisCount, // Creates 2 columns
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 14.0,
                childAspectRatio: itemWidth /
                    itemHeight, // Dynamically calculated aspect ratio
                children: List.generate(10, (index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromRGBO(121, 9, 31, 1), backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Rectangular shape
                      ), // Text color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(routeIndex: index + 1)),
                      );
                    },
                    child: Text(index == 0 ? 'Lefkoşa 1'
                        : index == 1
                        ? 'Lefkoşa 2'
                        : index == 2
                        ? 'Kızılbaş'
                        : index == 3
                        ? 'Gönyeli 1'
                        : index == 4
                        ? 'Gönyeli 2'
                        : index == 5
                        ? 'Gönyeli / Metehan'
                        : index == 6
                        ? 'Ortaköy / Yenikent'
                        : index == 7
                        ? 'Campus - Kyrenia'
                        : index == 8
                        ? 'Campus - Güzelyurt'
                        : index == 9
                        ? 'Campus - Famagusta'
                        :'Route ${index + 1}'),
                  );
                }),
              );
            },
          ),
        ));
  }
}
