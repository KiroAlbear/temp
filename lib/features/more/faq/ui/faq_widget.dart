import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/generated/l10n.dart';
import 'faq_bloc.dart';
class FaqWidget extends BaseStatefulWidget {
  final String backIcon;
  final String arrowDown;

  const FaqWidget({super.key, required this.backIcon, required this.arrowDown});

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends BaseState<FaqWidget> {
  final FaqBloc _bloc = FaqBloc();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() =>false;

  @override
  Widget getBody(BuildContext context) => _screenDesign;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop)  {
    changeSystemNavigationBarColor(secondaryColor);

  }

  // BlocProvider get _blocProvider =>
  //     BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => Column(
        children: [
          AppTopWidget(
            notificationIcon: '',
            homeLogo: '',
            scanIcon: '',
            searchIcon: '',
            supportIcon: '',
            hideTop: true,
            backIcon: widget.backIcon,
            title: S.of(context).faq,
          ),
          SizedBox(
            height: 20.h,
          ),
          _faqStreamBuilder,
          SizedBox(
            height: 20.h,
          ),
        ],
      );

  StreamBuilder<ApiState<List<FaqMapper>>> get _faqStreamBuilder =>
      StreamBuilder(
        stream: _bloc.faqStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ExpandedWidget(
                            answer:
                                snapshot.data?.response?[index].answer ?? '',
                            question:
                                snapshot.data?.response?[index].question ?? '',
                            arrow: widget.arrowDown),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 16.h,
                      ),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.response?.length ?? 0),
            )),
        initialData: LoadingState(),
      );
}
