//a)variables
var isFlutterInAppWebViewReady = false;
var docPath = "resource/Unit_Floor_Plan.pdf";
var topViewer = null;
var bottomViewer = null;

//
document.getElementById("start").onclick =
  async () => {
    const args = [
      "hello miguel x2 from js side!",
    ];
    const resVal =
      await window.flutter_inappwebview.callHandler(
        "test1",
        ...args
      );
    console.log(resVal);
  };

//b) handlers!
const onGeometryLoaded = (props) => {};

const onSelectionChanged = (dbi) => {
  console.log(dbi);
};

const viewNavigationHandler = (
  viewer,
  container
) => {
  const viewPaths = [
    // "./ResourceCharles3DTest/3D View/{3D} 360672/{3D}.svf",
    "./ResourceCharles3DTest/Unit Floor Plan.pdf",
    "./ResourceCharles3DTest/LIVING Level 1 - FLOOR PLAN.pdf",
    "./ResourceCharles3DTest/LAUNDRY Level 1 - FLOOR PLAN.pdf",
    "./ResourceCharles3DTest/KITCHEN Level 1 - ELEVATION 3.pdf",
  ];

  if (currentViewIndex < viewPaths.length - 1) {
    currentViewIndex++;
  } else {
    currentViewIndex = 0;
  }

  options = {
    ...options,
    document: viewPaths[currentViewIndex],
  };

  viewer.unloadModel(viewer.model);
  viewer.finish();
  Autodesk.Viewing.Initializer(options, () => {
    viewer =
      new Autodesk.Viewing.Private.GuiViewer3D(
        container,
        config
      );
    viewer.start(options.document, options);
    //add event listeners again!
    viewer.addEventListener(
      Autodesk.Viewing.GEOMETRY_LOADED_EVENT,
      onGeometryLoaded
    );
    viewer.addEventListener(
      Autodesk.Viewing.SELECTION_CHANGED_EVENT,
      onSelectionChanged
    );
  });
};

//c) triggers!
function initViewer(container, docPath, viewer) {
  const options = {
    env: "Local",
    document: docPath,
  };

  return new Promise(function (resolve, reject) {
    Autodesk.Viewing.Initializer(
      options,
      function () {
        const config = {
          extensions: [
            // "Autodesk.DocumentBrowser",
          ],
        };
        viewer =
          new Autodesk.Viewing.Private.GuiViewer3D(
            container,
            config
          );

        viewer.start(options.document, options);
        viewer.addEventListener(
          Autodesk.Viewing.GEOMETRY_LOADED_EVENT,
          onGeometryLoaded
        );
        viewer.addEventListener(
          Autodesk.Viewing
            .SELECTION_CHANGED_EVENT,
          onSelectionChanged
        );
        // viewer.setTheme("light-theme");
        viewer.setLightPreset(0);
        resolve(viewer);
      }
    );

    // document.getElementById("nextview").onclick =
    // viewNavigationHandler;
  });
}

//flutter event listener
window.addEventListener(
  "flutterInAppWebViewPlatformReady",
  function (event) {
    isFlutterInAppWebViewReady = true;
  }
);
