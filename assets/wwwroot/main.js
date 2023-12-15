// const sth = document.getElementById("preview");
// sth.innerText = "hello from the main js file!!";

function miguelfunction() {
  console.log("hellor!!");
}

initViewer(document.getElementById("preview"));

function initViewer(container) {
  const options = {
    env: "Local",
    document: "resource/Unit_Floor_Plan.pdf",
  };

  return new Promise(function (resolve, reject) {
    Autodesk.Viewing.Initializer(
      options,
      function () {
        const config = {
          extensions: [
            "Autodesk.DocumentBrowser",
          ],
        };
        const viewer =
          new Autodesk.Viewing.GuiViewer3D(
            container,
            config
          );

        try {
          //START: it initialize the viewer and loads extensions
          //It also loads any model if passed any!
          const startedCode = viewer.start(
            options.document,
            options,
            async () => {},
            (err) => {
              console.log(err);
              reject(err);
            }
          );
        } catch (error) {
          // console.log(error);
          reject(error);
        }
        viewer.setTheme("light-theme");
        viewer.setLightPreset(0);
        resolve(viewer);
      }
    );
  });
}
