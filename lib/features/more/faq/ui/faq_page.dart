import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/generated/l10n.dart';
import 'faq_bloc.dart';
class FaqPage extends BaseStatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends BaseState<FaqPage> {
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
    // super.onPopInvoked(didPop);
  }

  // BlocProvider get _blocProvider =>
  //     BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => Column(
        children: [
          AppTopWidget(
            isHavingBack: true,
            title: S.of(context).faq,
          ),
          SizedBox(
            height: 20.h,
          ),
          _faqStreamBuilder,
          SizedBox(
            height: 20.h,
          ),
          AppConstants.isHavingBottomPadding?SizedBox(height: 32,):SizedBox()
        ],
      );

  StreamBuilder<ApiState<List<FaqMapper>>> get _faqStreamBuilder =>
      StreamBuilder(
        stream: _bloc.faqStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            showError: false,
            onSuccess: Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ExpandedWidget(
                            answer:
                                snapshot.data?.response?[index].answer ?? '',
                            question:
                                snapshot.data?.response?[index].question ?? '',
                            arrow:Assets.svg.icArrowDownBlue),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 16.h,
                      ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: snapshot.data?.response?.length ?? 0),
            )),
        initialData: LoadingState(),
      );
}
