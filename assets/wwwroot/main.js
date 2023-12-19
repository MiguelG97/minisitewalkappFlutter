//a)variables
var isFlutterInAppWebViewReady = false;
// var docPath = "resource/Unit_Floor_Plan.pdf";
var topViewer = null;
var bottomViewer = null;

//b) handlers!
const onGeometryLoaded = (props) => {};

const onTopBottomSelectionChanged = () => {
  const id = dbi.dbIdArray[0];
  console.log(id);
};

const onFirstSelectionChanged = async (dbi) => {
  const id = dbi.dbIdArray[0];

  if (!isFlutterInAppWebViewReady) return;

  //a) receive the views to display from flutter side
  const viewElv =
    await window.flutter_inappwebview.callHandler(
      "roomSelected",
      id
    );
  console.log(viewElv);

  //b) display 2 viewers
  const topContainer =
    document.getElementById("topViewer");
  const bottomContainer = document.getElementById(
    "bottomViewer"
  );
  if (
    bottomContainer.classList.contains(
      "viewer"
    ) === false
  ) {
    bottomContainer.classList.add("viewer");
    console.log("bottom viewer added!");
  }
  // bottomContainer.className = "viewer";

  topViewer.unloadModel(topViewer.model);
  topViewer.finish();
  initTopViewer(
    topContainer,
    "resource/46_HARRISON_SQUARE/KITCHEN/KITCHEN_Level_1_-_ELEVATION_1.pdf",
    onTopBottomSelectionChanged
  );
  initBottomViewer(
    bottomContainer,
    "resource/46_HARRISON_SQUARE/KITCHEN/KITCHEN_Level_1_-_FLOOR_PLAN.pdf",

    onTopBottomSelectionChanged
  );
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
function initTopViewer(
  container,
  docPath,
  onselCallback
) {
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
        //we are passing topviewer from the flutter side!
        topViewer =
          new Autodesk.Viewing.Private.GuiViewer3D(
            container,
            config
          ); //I used private since a github repo placed that word and it works with the local js files stored too

        topViewer.start(
          options.document,
          options
        );
        topViewer.addEventListener(
          Autodesk.Viewing.GEOMETRY_LOADED_EVENT,
          onGeometryLoaded
        );
        topViewer.addEventListener(
          Autodesk.Viewing
            .SELECTION_CHANGED_EVENT,
          onselCallback
        );
        // viewer.setTheme("light-theme");
        topViewer.setLightPreset(0);
        resolve(topViewer);
      }
    );

    // document.getElementById("nextview").onclick =
    // viewNavigationHandler;
  });
}
function initBottomViewer(
  container,
  docPath,
  onselCallback
) {
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
        //we are passing topviewer from the flutter side!
        bottomViewer =
          new Autodesk.Viewing.Private.GuiViewer3D(
            container,
            config
          ); //I used private since a github repo placed that word and it works with the local js files stored too

        bottomViewer.start(
          options.document,
          options
        );
        bottomViewer.addEventListener(
          Autodesk.Viewing.GEOMETRY_LOADED_EVENT,
          onGeometryLoaded
        );
        bottomViewer.addEventListener(
          Autodesk.Viewing
            .SELECTION_CHANGED_EVENT,
          onselCallback
        );
        // viewer.setTheme("light-theme");
        bottomViewer.setLightPreset(0);
        resolve(bottomViewer);
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
