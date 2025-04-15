import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vitas_clone/core/constants/app_colors.dart';
import 'package:vitas_clone/core/utils/Strings.dart';

import 'package:vitas_clone/common/widgets/card.dart';
import 'package:vitas_clone/models/form_data.dart';
import 'package:vitas_clone/pages/referral/notifier/referral_form_fields_notifier.dart';
import 'package:vitas_clone/pages/referral/referral_form.dart';
// import 'package:vitas_clone/pages/referral/referral_form.dart';

class ReferralContentWidget extends ConsumerStatefulWidget {
  // const ReferralContentWidget({super.key});

  const ReferralContentWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ReferralContentWidget> createState() {
    return new ReferralContentWidgetState();
  }
}

class ReferralContentWidgetState extends ConsumerState<ReferralContentWidget> {
  @override
  Widget build(BuildContext context) {
    //final dynamicForm = ref.watch(dynamicFormProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: _buildDefaultContent(dynamicForm),
    );
  //   return dynamicForm.when(
  //   data: (form) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 14),
  //       child: _buildDefaultContent(form),
  //     );
  //   },
  //   loading: () => Center(child: CircularProgressIndicator()),
  //   error: (error, stackTrace) => Center(child: Text('Error: $error')),
  // );
  }

  Widget _buildImageWithLabel(final String asset, final String text) =>
      Container(
        height: 350,
        constraints: BoxConstraints.loose(Size(90.0, 200.0)),
        child: Column(
          children: <Widget>[
            Spacer(),
            SvgPicture.asset(asset),
            SizedBox(height: 8.0),
            Expanded(
              flex: 2,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      );

  Widget _buildDefaultContent(DynamicForm dynamicForm1) {
    return Container(
      height: 350,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
                color: shadowColorHighElevation,
                offset: Offset.zero,
                blurRadius: 4.0)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            Strings.referYourHospiceEligiblePatientNow,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colorGrayscale[600],
                  fontWeight: FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: _buildImageWithLabel(
                  'assets/images/referral_empty_hipaa.svg',
                  "hipaaCompliant",
                ),
              ),
              SizedBox(width: 8.0),
              SvgPicture.asset(
                  'assets/images/referral_face_sheet_on_light.svg'),
              SizedBox(width: 8.0),
              Expanded(
                child: _buildImageWithLabel(
                  'assets/images/referral_empty_response_times.svg',
                  "quick ResponseTimes",
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 48),
            decoration: BoxDecoration(
              boxShadow: [shadowLowElevation],
              color: purple[600],
              borderRadius: BorderRadius.circular(25.0),
            ),
            alignment: Alignment.center,
            child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/icon_camera.svg',
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.captureFaceSheet,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 48),
            decoration: BoxDecoration(
              boxShadow: [shadowLowElevation],
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(25.0),
            ),
            alignment: Alignment.center,
            child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReferralForm(form: dynamicForm1)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/icon_form.svg",
                      colorFilter: ColorFilter.mode(grey6, BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.submitAForm,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
