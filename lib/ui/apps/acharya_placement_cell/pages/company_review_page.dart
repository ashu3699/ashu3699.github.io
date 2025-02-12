import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/review_model.dart';
import '../services/api_service.dart';

class CompanyReviewPage extends StatefulWidget {
  const CompanyReviewPage({super.key, required this.slug});
  final String slug;
  @override
  State<CompanyReviewPage> createState() => _CompanyReviewPageState();
}

class _CompanyReviewPageState extends State<CompanyReviewPage> {
  bool isLoading = false;
  bool isEmpy = true;

  Review? review;

  @override
  void initState() {
    super.initState();
    getReview();
  }

  Future<void> getReview() async {
    setState(() => isLoading = true);
    review = await ApiService.getReviewsByCompany(slug: widget.slug);
    if (review == null) {
      isEmpy = true;
    } else {
      isEmpy = false;
    }
    if (review!.data.company.reviews!.isEmpty) {
      isEmpy = true;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.achBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: ColorConstants.achBlue,
        title: const Text(
          'Company Review',
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isEmpy
              ? const Center(
                  child: Text(
                    'No Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  review!.data.company.logoUrl,
                                ),
                              ),
                              title: Text(
                                review!.data.company.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      for (var i = 0;
                                          i < review!.data.company.rating!;
                                          i++)
                                        const Icon(
                                          Icons.star,
                                          color: ColorConstants.achOrange,
                                        ),
                                      for (var i = 0;
                                          i < 5 - review!.data.company.rating!;
                                          i++)
                                        const Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                        ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${review!.data.company.rating}/5',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Based on ${review!.data.company.reviews!.length} reviews',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            //positive reviews
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(223, 247, 231, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromRGBO(0, 128, 0, 1),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Positive Reviews',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(0, 128, 0, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  //reviews list
                                  for (var i = 0;
                                      i <
                                          min(review!.data.company.pros!.length,
                                              5);
                                      i++)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review!.data.company.pros![i],
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 242, 200, 200),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 212, 45, 29),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Negative Reviews',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 212, 45, 29),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  //reviews list
                                  for (var i = 0;
                                      i <
                                          min(review!.data.company.cons!.length,
                                              5);
                                      i++)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review!.data.company.cons![i],
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                ],
                              ),
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
