import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moadaly_app/data/schema.dart';
import 'package:moadaly_app/screens/partial/year_button.dart';

class SpecialitiesArea extends StatelessWidget {
  const SpecialitiesArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: all_specialities.length,
        itemBuilder: (context, index) {
          var specialityKey = all_specialities.keys.toList()[index];
          var specialitiesYear = all_specialities[specialityKey];
          var departmenName = all_specialities_dep[specialityKey];

          return YearsArea(specialitiesYear!, departmenName!);
        },
      ),
    );
  }
}

class YearsArea extends StatelessWidget {
  const YearsArea(this.specialitiesYear, this.departmenName, {super.key});
  final Map<String, List<String>> specialitiesYear;
  final String departmenName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Departement name
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            color: const Color.fromARGB(255, 193, 193, 193),
            child: Text(departmenName,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: const Color.fromARGB(255, 46, 44, 58),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 5),
          // Departement Years
          if (specialitiesYear['licence']!.isNotEmpty)
          YearGrade("Licence", specialitiesYear['licence']!),

          if (specialitiesYear['master']!.isNotEmpty)
          YearGrade("Master Bouira", specialitiesYear['master']!),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //   child: Wrap(
            //     spacing: 12,
            //     crossAxisAlignment: WrapCrossAlignment.center,
            //     children: [
            //       for (var speciality in specialitiesYear['master']!)
            //         YearButton(speciality)
            //     ],
            //   ),
            // ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}


class YearGrade extends StatelessWidget {
  const YearGrade(this.yearGradeName,this.yearGradeData,{super.key});
  final String yearGradeName;
  final List<String> yearGradeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(yearGradeName,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ),
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (var speciality in yearGradeData)
                    YearButton(speciality)
                ],
              ),
            ),
      ],
    );
  }
}