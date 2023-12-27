import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:minisitewalkapp/modules/explorer_module/screens/explorer_screen.dart';
import 'package:minisitewalkapp/modules/unit_plans/bloc/unit_bloc.dart';
import 'package:minisitewalkapp/modules/unit_plans/bloc/unit_events.dart';
import 'package:minisitewalkapp/modules/unit_plans/bloc/unit_states.dart';

import 'package:minisitewalkapp/modules/unit_plans/constants/inspection_phase_const.dart';

import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

import 'package:path_provider/path_provider.dart';

class InitScreen extends StatefulWidget {
  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  // late InAppLocalhostServer localHostServer;
  @override
  void initState() {
    // TODO: implement initState

    // storeAsssetBytes();

    // readAppDocDirFiles();
    // getStoredFiles();
    // deleteFile();
    // store3dFiles();
    super.initState();
  }

  void store3dFiles() async {
    // String fileName = "0.pf";
    // List<String> fileNames = [
    //   "1.pf",
    //   "2.pf",
    //   "CameraDefinitions.bin",
    //   "CameraList.bin",
    //   "FragmentList.pack",
    //   "GeometryMetadata.pf",
    //   "InstanceTree.bin",
    //   "LightDefinitions.bin",
    //   "LightList.bin",
    //   "Materials.json.gz",
    //   "Set.bin"
    // ];
    List<String> fileNames = [
      "objects_attrs.json.gz",
      "objects_avs.json.gz",
      "objects_ids.json.gz",
      "objects_offs.json.gz",
      "objects_vals.json.gz",
      "objects_viewables.json.gz"
    ];
    for (var fileName in fileNames) {
      ByteData data1 =
          await rootBundle.load("assets/wwwroot/resource/$fileName");
      Uint8List byte1 = Uint8List.sublistView(data1);

      Directory directory = await getApplicationDocumentsDirectory();
      File file1 =
          await File('${directory.path}/$fileName').create(recursive: true);
      file1 = await file1.writeAsBytes(byte1);
      print(file1);
    }

    ///data/user/0/com.example.minisitewalkapp/app_flutter/46_HARRISON_SQUARE/3dview/{3D}.svf
    ///data/user/0/com.example.minisitewalkapp/app_flutter/46_HARRISON_SQUARE/3dview/0.pf
  }

  void storeAsssetBytes() async {
    ByteData pfData =
        await rootBundle.load("assets/wwwroot/resource/UnitFloorPlan.pdf");
    Uint8List bytes = Uint8List.sublistView(pfData);

    Directory directory = await getApplicationDocumentsDirectory();

    File pdfFile =
        await File('${directory.path}/Floor Plan/Unit Floor Plan1.pdf')
            .create(recursive: true);
    pdfFile = await pdfFile.writeAsBytes(bytes);
    print("successfully stored in app doc directory: ${directory.path}");
    print(pdfFile);
  }

  void readAppDocDirFiles() async {
    Directory directory = await getApplicationDocumentsDirectory();
    try {
      File pdfFile = File('${directory.path}/Floor Plan/Unit Floor Plan1.pdf');

      Uint8List bytesStored = await pdfFile.readAsBytes();
      print(pdfFile.path);
    } catch (e) {
      print(e.toString());
    }
  }

  void getStoredFiles() async {
    Directory directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileSystem = directory.listSync();
    for (FileSystemEntity entity in fileSystem) {
      if (entity is File) {
        print("Miguel: " + entity.path);
      }
      //get nested files!
      else if (entity is Directory) {
        Directory dirEnt = entity as Directory;
        List<FileSystemEntity> subFileSyst = dirEnt.listSync();
        for (FileSystemEntity subEntity in subFileSyst) {
          print("subfile: " + subEntity.path);
        }
      }
    }
  }

  void deleteFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    try {
      File pdfFile = File("${directory.path}/Unit Floor Plan1.pdf");
      if (await pdfFile.exists()) {
        await pdfFile.delete();
        print("successfully deleted");
      }
    } catch (e) {}
  }

  List<UnitPlan> units = [
    UnitPlan(projectName: "46_HARRISON SQUARE", assetPath: "46_HARRISON_SQUARE")
  ];

  @override
  Widget build(BuildContext context) {
    // return ExplorerScreen();
    return Scaffold(
      appBar: AppBarWithLeadingIcon(
        leadingWidget: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(AssetPaths.logo),
        ),
        trailingWidgets: [
          InkWell(
            onTap: () {},
            child: const IcProfile(),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) {
          return UnitBloc();
        },
        child: Center(
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
                Expanded(child: BlocBuilder<UnitBloc, UnitState>(
                  builder: (context, state) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //pass the unitplan selected!
                              UnitBloc unitbloc = context.read<UnitBloc>();
                              unitbloc.add(
                                  UnitSelectionStarted(unitplan: units[index]));

                              //pass the bloc to new screen, how is it done??
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: BlocProvider.of<UnitBloc>(context),
                                      child: ExplorerScreen(
                                        unitItem: units[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 30,
                              child: Row(children: [
                                TableBaseCell(
                                  flex: 6,
                                  cell: Text14grey500(units[index].projectName),
                                )
                              ]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return VSpace.h16();
                        },
                        itemCount: units.length);
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
