import 'package:flutter/material.dart';
import 'package:test1/error_page.dart';
import 'package:test1/models/space.dart';
import 'package:test1/theme.dart';
import 'package:test1/widgets/facility_item.dart';
import 'package:test1/widgets/rating_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPage extends StatelessWidget {
  final Space space;
  const DetailPage(this.space, {Key? key}) : super(key: key);

  // String _url;
  // final _url = space.mapUrl;

  //final _url = space.mapUrl;
  //final Uri _url2 = Uri.parse('tel:${space.phone}');
  //DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl() async {
      if (await canLaunchUrlString(space.mapUrl)) {
        launchUrlString(space.mapUrl);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
          ),
        );
      }
    }

    _launchTel() async {
      if (!await launchUrlString('tel:${space.phone}')) {
        throw 'Could not launch ${space.phone}';
      }
    }

    return Scaffold(
      backgroundColor: whiteCol,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              space.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                SizedBox(
                  height: 328,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteCol,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: TITLE
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  space.name,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '\$${space.price}',
                                    style: purpleTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' / month',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: 2,
                                  ),
                                  child: RatingItem(
                                    index: index,
                                    rating: space.rating,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: MAIN FACILITIES
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Main Facilities',
                          style: regulerTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(
                              name: 'kitchen',
                              imageUrl: 'assets/images/icon_kitchen.png',
                              total: space.numberOfKitchens,
                            ),
                            FacilityItem(
                              name: 'bedroom',
                              imageUrl: 'assets/images/icon_bedroom.png',
                              total: space.numberOfBedrooms,
                            ),
                            FacilityItem(
                              name: 'Cupboard',
                              imageUrl: 'assets/images/icon_cupboard.png',
                              total: space.numberOfCupboards,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: PHOTOS
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Photos',
                          style: regulerTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 88,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: space.photos.map((item) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: 24,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item,
                                  width: 110,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: LOCATION
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Location',
                          style: regulerTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${space.address}\n${space.city}',
                              style: greyTextStyle.copyWith(fontSize: 14),
                            ),
                            InkWell(
                              onTap: _launchUrl,
                              child: Image.asset(
                                'assets/images/btn_map.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: edge),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: ElevatedButton(
                          onPressed: _launchTel,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: purpleCol,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/btn_back.png',
                      width: 40,
                    ),
                  ),
                  Image.asset(
                    'assets/images/btn_wishlist.png',
                    width: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
