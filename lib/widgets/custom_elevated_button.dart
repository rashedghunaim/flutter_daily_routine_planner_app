import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backGroundColor;
  final minimumSizeHeight;
  final minimumSizeWidth;
  final maximumSizeHeight;
  final maximumSizeWidth ;
  final String buttonTitle;
  final Function onTap;
  final double raduis ;
  final Widget child  ;

  CustomElevatedButton({
    required this.child ,
    required this.raduis ,
    required this.buttonTitle,
    required this.onTap,
    required this.backGroundColor ,
    required this.maximumSizeHeight ,
    required this.maximumSizeWidth ,
    required this.minimumSizeHeight ,
    required this.minimumSizeWidth ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            backGroundColor
        ),
        minimumSize: MaterialStateProperty.all(Size(minimumSizeWidth, minimumSizeHeight)),
        maximumSize: MaterialStateProperty.all(Size(minimumSizeWidth, maximumSizeHeight)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis),
          ),
        ),
      ),
      onPressed: () => onTap(),
      child:
      child ,



    );
  }
}
