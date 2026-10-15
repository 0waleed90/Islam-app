import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/manger/tasbih_cubit/tasbih_cubit.dart';
import 'package:islam/features/home/presentation/manger/tasbih_cubit/tasbih_state.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbihCubit, TasbihState>(
      builder: (context, state) {
        if (state is TasbihSuccess) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                context.read<TasbihCubit>().increaseCounter();
              },
              child: Stack(
                children: [
                  Image.asset(
                    'assets/photos/athkar_Background (1).png',
                    fit: BoxFit.cover,
                  ),

                  Align(
                    alignment: .xy(0.01, 0.68),
                    child: Transform.rotate(
                      angle: state.counter * 0.2,
                      origin: const Offset(0, 35),
                      child: Image.asset(
                        'assets/photos/Sebha (1).png',color:
                      state.counter >=
                          state.tasbih[state.currentZkr].goal
                          ? Colors.green
                          : null,
                        height: MediaQuery.of(context).size.height * 0.5,
                        fit: .contain,
                      ),
                    ),
                  ),
                  Align(
                    alignment: .center,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        LogoImage(),
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.read<TasbihCubit>().previousZkr();
                              },
                              child: Text(
                                '<',
                                style: Styles.textStyle36.copyWith(
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  state.tasbih[state.currentZkr].title,
                                  style: Styles.textStyle36,
                                  textDirection: .rtl,
                                  textAlign: .center,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<TasbihCubit>().nextZkr();
                              },
                              child: Text(
                                '>',
                                style: Styles.textStyle36.copyWith(
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Text(
                            'الهدف ${state.tasbih[state.currentZkr].goal}\n${state.tasbih[state.currentZkr].zkr} ',
                            style: Styles.textStyle36.copyWith(color:
                              state.counter >=
                              state.tasbih[state.currentZkr].goal
                              ? Colors.green
                                  : Colors.white,),
                            textAlign: .center,
                          ),
                        ),
                        Text(
                          state.counter.toString(),
                          style: Styles.textStyle36.copyWith(
                            color:
                                state.counter >=
                                    state.tasbih[state.currentZkr].goal
                                ? Colors.green
                                : Colors.amber,
                          ),
                        ),
                        Spacer(flex: 1,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is TasbihFailure) {
          return Text(state.errorMessage);
        } else {
          return Center(child: LinearProgressIndicator());
        }
      },
    );
  }
}
