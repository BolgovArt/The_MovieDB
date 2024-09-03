import 'package:flutter/material.dart';


class FilmPageMainScreenCastWidget extends StatelessWidget {
  const FilmPageMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Список актёров',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              ),
          ),
          SizedBox(
            height: 240,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 20,
                itemExtent: 120, 
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              color: Colors.yellow,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'data',
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  SizedBox(height: 7),
                                  Text(
                                    'data',
                                    maxLines: 4,
                                    ),
                                  SizedBox(height: 7),
                                  Text(
                                    'data',
                                    maxLines: 1,
                                    ),
                                ],
                              ),
                              )                            
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: Text('data')
              ),
          ),
        ],
      ),
      );
  }
}