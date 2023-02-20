import 'package:flutter/material.dart';

class TestimonialItem extends StatelessWidget {
  final String imageUrl;
  final String testimonialText;

  TestimonialItem({required this.imageUrl, required this.testimonialText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 498,
      height: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                testimonialText,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestimonialsList extends StatelessWidget {
  final List<TestimonialItem> items = [
    TestimonialItem(
        imageUrl: 'https://example.com/profile1.jpg',
        testimonialText:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus rhoncus dui id turpis condimentum, nec eleifend nisi blandit.'),
    TestimonialItem(
        imageUrl: 'https://example.com/profile2.jpg',
        testimonialText:
            'Ut eget lacus purus. Duis lacinia lorem nec turpis tincidunt, at ultrices turpis bibendum.'),
    TestimonialItem(
        imageUrl: 'https://example.com/profile3.jpg',
        testimonialText:
            'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 498,
      height: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
