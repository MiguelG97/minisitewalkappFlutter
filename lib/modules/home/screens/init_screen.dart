import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/asset_paths.dart';
import 'package:minisitewalkapp/core/presentation/atoms/icons/ic_profile.dart';
import 'package:minisitewalkapp/core/presentation/atoms/icons/ic_sort.dart';
import 'package:minisitewalkapp/core/presentation/atoms/texts/text_14_grey_500.dart';
import 'package:minisitewalkapp/core/presentation/atoms/v_space.dart';
import 'package:minisitewalkapp/core/presentation/molecules/app_bars/app_bar_with_leading_icon.dart';
import 'package:minisitewalkapp/core/presentation/molecules/dialogue/dialogue_markdown.dart';
import 'package:minisitewalkapp/core/presentation/molecules/search_with_filter/search_bar_with_filter.dart';
import 'package:minisitewalkapp/core/presentation/molecules/table_base.dart';
import 'package:minisitewalkapp/core/presentation/molecules/text_14_grey_500_icon.dart';
import 'package:minisitewalkapp/modules/forge_viewer/forge_viewerOffline.dart';
import 'package:minisitewalkapp/modules/forge_viewer/forge_viewerOnline.dart';
import 'package:minisitewalkapp/modules/forge_viewer/pwa_viewerOffline.dart';
import 'package:minisitewalkapp/modules/home/bloc/init_bloc.dart';
import 'package:minisitewalkapp/modules/home/bloc/init_states.dart';
import 'package:minisitewalkapp/modules/home/constants/inspection_phase_const.dart';
import 'package:minisitewalkapp/modules/home/screens/login_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InitScreen extends StatefulWidget {
  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late WebViewController controller;
  late InAppWebViewController webViewController;
  String urlLocal =
      "https://minisitewalkapp.vercel.app/"; //"http://localhost:8080/"; //"http://127.0.0.1:8080/";
  // late InAppLocalhostServer localHostServer;
  @override
  void initState() {
    // TODO: implement initState
    // localHostServer = InAppLocalhostServer(port: 8080);
    // localHostServer.start();

    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onPageStarted: (url) {
    //         print("Hola miguel 1");
    //       },
    //       onPageFinished: (url) {
    //         print("miguel is: " + url);
    //         if (url.endsWith("index.html")) {
    //           // controller.runJavaScript('''console.log("\Miguel\")''');
    //           // controller.loadFlutterAsset(AssetPaths.indexHtml);
    //           // controller.runJavaScript(
    //           //     'javascript:start(`${urn}`,`$token`,`$ttlSeconds`)');
    //         }
    //       },
    //       onWebResourceError: (WebResourceError error) {},
    //     ),
    //   )
    //   ..loadFlutterAsset(AssetPaths.indexHtml);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBloc(),
      child: BlocBuilder(
        bloc: InitBloc(),
        builder: (context, state) {
          InitBloc initBloc = context.read<InitBloc>();

          if (state is NotLoggedInState || state is LoadingState) {
            //loggedin screen
            // print("Miguel not print");
            return LogginScreen();
          } else if (state is LoggedInState) {
            //the dashboard project screen
            return dashboard();
            // return ForgeViewer();
            // WebViewWidget(controller: controller)
          } else {
            return const Scaffold(
              body: Center(child: Text("WHAT HAPPENED??")),
            );
          }
        },
      ),
    );
  }

  // InAppWebView WebForgeViewer() {
  //   return InAppWebView(
  //       initialOptions: InAppWebViewGroupOptions(
  //           crossPlatform: InAppWebViewOptions(
  //               allowFileAccessFromFileURLs: true,
  //               clearCache: false,
  //               useShouldInterceptFetchRequest: true,
  //               useShouldOverrideUrlLoading: false)),
  //       initialUrlRequest: URLRequest(url: Uri.parse(urlLocal)),
  //       onWebViewCreated: (controller) {
  //         webViewController = controller;
  //         webViewController.clearCache();
  //         webViewController.webStorage.localStorage.clear();
  //       });
  // }
}

class dashboard extends StatelessWidget {
  const dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      "Public Web Addres",
      "Local Http Web Addres",
      "Public Web Addres with Offline Mode Support"
    ];

    return Scaffold(
      appBar: AppBarWithLeadingIcon(
        leadingWidget: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(AssetPaths.logo),
        ),
        trailingWidgets: [
          InkWell(
            onTap: () {
              final mediaQuery = MediaQuery.of(context);
              //icon profile ...
            },
            child: const IcProfile(),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [
                const Text(
                  "My Projects",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                )
              ]),
              const SizedBox(
                height: 24,
              ),
              SearchBarWithFilter(
                searchBarHintText: 'Seach by project name',
                filterFields: InspectionPhaseConst.filterSearch,
                onFilterSelected: (data) {
                  //                   BlocProvider.of<InspectionPhaseBloc>(context).add(
                  //   InspectionPhaseFilterSelected(
                  //     InspectionPhaseUtil.getFilterSearchModel(data),
                  //   ),
                  // );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const TableBaseCell(
                      flex: 6,
                      cell: Text(
                        "Project name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      )),
                  TableBaseCell(
                      flex: 3,
                      cell: Text(
                        "Organization",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      )),
                  TableBaseCell(
                    flex: 4,
                    cell: Text14grey500Icon(
                      'Inspection Phase',
                      icon: InkWell(
                        onTap: () {
                          DialogueMarkdown.show(
                            context,
                            title: 'How to use ?',
                            body: InspectionPhaseConst.howToUse,
                          );
                        },
                        child: const Icon(
                          Icons.info_outline,
                          color: AppColors.greyIcon,
                        ),
                      ),
                    ),
                  ),
                  TableBaseCell(
                    flex: 4,
                    cell: InkWell(
                      onTap: () {
                        // BlocProvider.of<InspectionPhaseBloc>(context).add(
                        //   InspectionPhaseFilterSelected(
                        //     InspectionPhaseUtil.getFilterSearchModel(
                        //       InspectionPhaseConst.inspectionDueDate,
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text14grey500Icon(
                        'Due date',
                        icon: IcSort(),
                      ),
                    ),
                  ),
                  TableBaseCell(
                    flex: 2,
                    cell: InkWell(
                      onTap: () {
                        // BlocProvider.of<InspectionPhaseBloc>(context).add(
                        //   InspectionPhaseFilterSelected(
                        //     InspectionPhaseUtil.getFilterSearchModel(
                        //       InspectionPhaseConst.inspectionStatus,
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text14grey500Icon(
                        'Status',
                        icon: IcSort(),
                      ),
                    ),
                  ),
                  const TableBaseCell(
                    cell: Text14grey500('Notes'),
                  ),
                ],
              ),
              VSpace.h16(),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ForgeViewerOnline();
                                },
                              ));
                            } else if (index == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ForgeViewer();
                                },
                              ));
                            } else if (index == 2) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return PWAViewer();
                                },
                              ));
                            }
                          },
                          child: Container(
                            height: 30,
                            child: Row(children: [
                              TableBaseCell(
                                flex: 6,
                                cell: Text14grey500(names[index]),
                              )
                            ]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return VSpace.h16();
                      },
                      itemCount: names.length))
            ],
          ),
        ),
      ),
    );
  }
}
