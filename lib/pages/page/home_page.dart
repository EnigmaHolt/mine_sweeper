import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeping/blocs/game_board_bloc.dart';
import 'package:mine_sweeping/data/state/game_board_state.dart';
import 'package:mine_sweeping/pages/widget/home_top_bar.dart';
import 'package:mine_sweeping/pages/widget/main_game_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GameBoardBloc bloc = GameBoardBloc();

  int position = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBoardBloc, GameBoardState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is BoardDisplayChangeState) {
            position = state.position;
          }

          return Padding(
            padding: EdgeInsets.only(left: position == 0 ? 200 : 10, top: 30),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HomeTopBar(bloc),
                    MainGameWidget(bloc),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
