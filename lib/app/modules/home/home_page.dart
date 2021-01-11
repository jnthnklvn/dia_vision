import '../..//modules/home/domain/entities/module.dart';
import '../..//shared/utils/constants.dart';
import '../..//shared/utils/route_enum.dart';
import '../..//shared/utils/size_config.dart';
import '../..//shared/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo_name.png",
                  height: 60,
                ),
                InkWell(
                  onTap: () => Modular.to.pushNamed(RouteEnum.profile.name),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/icons/Settings.svg",
                      color: kSecondaryColor,
                      height: 35,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Seja bem-vindo, Jonathan",
              style: headingStyle,
            ),
            SizedBox(height: 10),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: modules.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF00778C),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 30, 5, 5),
                          child: modules[index].svg
                              ? SvgPicture.asset(
                                  modules[index].imageSrc,
                                  fit: BoxFit.fill,
                                  width: SizeConfig.screenWidth / 2.5,
                                  alignment: Alignment.centerRight,
                                )
                              : Image(
                                  image: AssetImage(modules[index].imageSrc),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.centerRight,
                                ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                          child: Text(
                            modules[index].name,
                            style: kTitleTextStyle.apply(
                              backgroundColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
