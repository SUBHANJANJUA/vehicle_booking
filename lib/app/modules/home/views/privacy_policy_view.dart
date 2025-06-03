import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_booking/app/data/util/custom_appbar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("1. Purpose of the Platform"),
              sectionText(
                  "Our application provides a platform that connects customers seeking transport services "
                  "and vehicle owners (drivers) who wish to offer their vehicles for booking (either loader or passenger vehicles). "
                  "We do not participate in, manage, or guarantee any interactions, agreements, or transactions between users."),
              sectionTitle("2. Information We Collect"),
              sectionSubtitle("a. User-Provided Information"),
              sectionText(
                  "- Account Information: Name, contact number, email address, password.\n"
                  "- Vehicle Owner Details: Vehicle type, registration number, city, etc.\n"
                  "- Location Data: Used for vehicle sorting by city."),
              sectionSubtitle("b. Device Information"),
              sectionText(
                  "- Device model, OS, and identifiers (for analytics)."),
              sectionTitle("3. How We Use Your Information"),
              sectionText("- To manage accounts.\n"
                  "- To allow customer-driver communication.\n"
                  "- To show relevant vehicles sorted by city.\n"
                  "- To improve app experience.\n"
                  "- To respond to support inquiries."),
              sectionTitle("4. User Responsibility and Disclaimer"),
              sectionText(
                  "- The platform only connects customers and drivers.\n"
                  "- We are not responsible for any transaction, pricing, or disputes.\n"
                  "- We are not liable for accidents or losses arising from booked rides.\n"
                  "- Users are responsible for verifying vehicle and driver safety."),
              sectionTitle("5. Data Sharing"),
              sectionText(
                  "We do not sell or trade your information. Data may be shared:\n"
                  "- When required by law.\n"
                  "- To protect platform or user safety.\n"
                  "- With operational service providers."),
              sectionTitle("6. Data Security"),
              sectionText(
                  "We use encryption and secure storage, but no method is 100% secure. We do our best to protect your data."),
              sectionTitle("7. User Rights"),
              sectionText("- Access and update personal data.\n"
                  "- Delete your account and all stored information."),
              sectionTitle("8. Children’s Privacy"),
              sectionText(
                  "Our app is not for children under 13. We do not knowingly collect data from minors."),
              sectionTitle("9. Changes to This Policy"),
              sectionText(
                  "We may update this policy. Changes will be posted with a new effective date inside the app."),
              // sectionTitle("10. Contact Us"),
              // sectionText("If you have any questions:\n"
              //     "📧 your@email.com\n"
              //     "📞 +123 456 7890"),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 4.h),
        child: Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      );

  Widget sectionSubtitle(String title) => Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 2.h),
        child: Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      );

  Widget sectionText(String text) => Text(
        text,
        style: TextStyle(fontSize: 14.sp, height: 1.5),
      );
}
