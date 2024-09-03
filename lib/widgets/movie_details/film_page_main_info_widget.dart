
import 'package:flutter/material.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopPosterWidget(),
          Padding(
            padding: EdgeInsets.all(10),
            child: _MovieTextWidget(),
          ),
          _ScoreWidget(),
          _SummeryWidget(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: _OverViewWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: _DescriptionWidget(),
          ),
          SizedBox(height: 30),
          _PeopleWidgets(),
        ],
    );
  }


}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'some text some text some text some text some text some text some text some text some text some text some text some text',
      style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.red, width: 420, height: 200,),
        Positioned(
          top: 20,
          left: 20,
          child: Container(color: Colors.purple, width: 100, height: 150,)
          ),
      ],
    );
  }
}


class _MovieTextWidget extends StatelessWidget {
  const _MovieTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Film name',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              )
          ),
          TextSpan(
            text: '(2020)', 
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ))
        ]
      )
    );
  }
}


class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {}, 
          child: const Row(
            children: [
              Icon(Icons.rotate_left_outlined), // ! del
              // SizedBox(
              //   width: 40,
              //   height: 40,
              //   child: RadialPrecentWidget(
              //     precent: 0.72,
              //     fillColor: Color.fromARGB(255, 10, 23, 25),
              //     lineColor: Color.fromARGB(255, 37, 203, 103),
              //     freeColor: Color.fromARGB(255, 25, 54, 31),
              //     lineWidth: 3,
              //   ),
              // ),
              SizedBox(width: 10),
              Text('Score'),
            ],
          )
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        TextButton(
          onPressed: () {}, 
          child: const Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          )
        )

      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          'summery text summery text summery text summery text',
          maxLines: 3, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}


class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}


class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    final roleStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name of person',
                  style: nameStyle,
                  ),
                  Text(
                  'his role',
                  style: roleStyle,
                  )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name of person',
                  style: nameStyle,
                  ),
                Text(
                  
                  'his role',
                  style: roleStyle,
                  ),
              ]
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name of person',
                  style: nameStyle,
                  ),
                  Text(
                  'his role',
                  style: roleStyle,
                  )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name of person',
                  style: nameStyle,
                  ),
                Text(
                  
                  'his role',
                  style: roleStyle,
                  )
              ],
            ),
          ],
        ),
      ],
    );
  }  
  }
