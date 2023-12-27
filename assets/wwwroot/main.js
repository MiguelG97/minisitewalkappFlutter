//a)variables
var isFlutterInAppWebViewReady = false;
var topViewer = null;
var bottomViewer = null;
let currentViewIndex = 0;
let elevsPaths = [];

//b) handlers!
const onGeometryLoaded = (props) => {
  //for first page, we gotta paint the rooms!
};

const onTopBottomSelectionChanged = (dbi) => {
  //here we gotta display an item in the right panel on selection
  const id = dbi.dbIdArray[0];
  //get element id!
  if (id === null) return; //in case it was picked to the blank space!

  window.flutter_inappwebview.callHandler(
    "itemSelected",
    id
  );
};

const onFirstSelectionChanged = async (dbi) => {
  let id = null;
  if (typeof dbi === "object") {
    id = dbi.dbIdArray[0];
  } else if (typeof dbi === "number") {
    id = dbi;
  } else if (
    dbi === null ||
    dbi.dbIdArray[0] === null
  ) {
    return; //for picking to the blank space!
  }

  if (!isFlutterInAppWebViewReady) return;

  //for 3D view:
  if (id === -1) {
    topViewer.unloadModel(topViewer.model);
    topViewer.finish();
    const container3D =
      document.getElementById("topViewer");
    const viewElv =
      await window.flutter_inappwebview.callHandler(
        "roomSelected",
        id
      );
    initTopViewer(
      container3D,
      `data/user/0/com.example.minisitewalkapp/app_flutter/46_HARRISON_SQUARE/3dview/{3D}.svf`,
      onTopBottomSelectionChanged
    );
    return;
  }

  //a) receive the views to display from flutter side
  const viewElv =
    await window.flutter_inappwebview.callHandler(
      "roomSelected",
      id
    );
  if (viewElv === "isnotaroom") return;

  //b) parse the data
  const jsonData = JSON.parse(viewElv);
  let roomName = jsonData["roomName"];
  roomName = roomName.replace(/ /g, "_");

  const floorPlan = JSON.parse(
    jsonData["floorPlan"]
  );
  const floorPlanName = floorPlan["name"]; //floorPlan.name  works too!

  const floorPlanNamePath = floorPlanName.replace(
    / /g,
    "_"
  );

  const elevsArray = JSON.parse(
    jsonData["elevations"]
  );

  //c) display 2 viewers
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
  }

  //d) show arrows and set handlers
  elevsPaths = elevsArray.map((elv) => {
    let elvName = elv["name"];
    elvName = elvName.replace(/ /g, "_");
    return `resource/46_HARRISON_SQUARE/${roomName}/${elvName}.pdf`;
  });

  const leftClassList = document.getElementById(
    "arrow-left-container"
  ).classList;
  if (leftClassList.contains("hide-arrow")) {
    leftClassList.remove("hide-arrow");
    leftClassList.add("show-arrow");
  }
  document.getElementById(
    "arrow-left-container"
  ).onclick = () => {
    topViewer.unloadModel(topViewer.model);
    topViewer.finish();

    if (currentViewIndex === 0) {
      currentViewIndex = elevsPaths.length - 1;
    } else {
      currentViewIndex = currentViewIndex - 1;
    }
    const topPath = elevsPaths[currentViewIndex];
    initTopViewer(
      topContainer,
      topPath,
      onTopBottomSelectionChanged
    );
  };

  const rightClassList = document.getElementById(
    "arrow-right-container"
  ).classList;
  if (rightClassList.contains("hide-arrow")) {
    rightClassList.remove("hide-arrow");
    rightClassList.add("show-arrow");
  }
  document.getElementById(
    "arrow-right-container"
  ).onclick = () => {
    topViewer.unloadModel(topViewer.model);
    topViewer.finish();

    //when it's 0 pick 1, when it's 1 pick 2, ... when it's penultimate pick the last one, when it's the last pick the first!
    if (
      currentViewIndex <
      elevsPaths.length - 1
    ) {
      currentViewIndex++;
    } else {
      currentViewIndex = 0;
    }
    const topPath = elevsPaths[currentViewIndex];
    initTopViewer(
      topContainer,
      topPath,
      onTopBottomSelectionChanged
    );
  };

  //e) unload initial viewer
  topViewer.unloadModel(topViewer.model);
  topViewer.finish();

  //f) initialize the 2 viewers
  try {
    // let elvName = elevsArray[0]["name"];
    // const topPath = `resource/46_HARRISON_SQUARE/${roomName}/${elvName}.pdf`;
    const topPath = elevsPaths[currentViewIndex];
    initTopViewer(
      topContainer,
      topPath,
      onTopBottomSelectionChanged
    );

    if (bottomViewer !== null) {
      //for selections from the left panel!
      bottomViewer.unloadModel(
        bottomViewer.model
      );
      bottomViewer.finish();
    }
    const bottomPath = `resource/46_HARRISON_SQUARE/${roomName}/${floorPlanNamePath}.pdf`;
    initBottomViewer(
      bottomContainer,
      bottomPath,
      onTopBottomSelectionChanged
    );
  } catch (error) {
    console.log(error);
  }
};

//c) triggers!
function initTopViewer(
  container,
  docPath,
  onselCallback
) {
  // document.getElementById("imgmiguel").src =
  //   "./data/user/0/com.example.minisitewalkapp/app_flutter/assets/google-76517_1280.png";

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
        try {
          viewer.setTheme("light-theme");
        } catch (error) {
          console.log(error);
        }
        topViewer.setLightPreset(0);
        resolve(topViewer);
      }
    );
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
