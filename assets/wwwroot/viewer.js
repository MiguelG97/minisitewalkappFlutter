export function initViewer(container) {
  const options = {
    env: "Local",
    document: "manifest1/output.svf",
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
        // viewer.start();
        try {
          const startedCode = viewer.start(
            options.document,
            options,
            () => {
              console.log("Success!! miguel");
            },
            (err) => {
              console.log(err);
              reject(err);
            }
          );
        } catch (error) {
          // console.log(error);
          reject(error);
        }
        // viewer.setTheme("light-theme");
        // viewer.setLightPreset(0);
        // resolve(viewer);
      }
    );
  });
}
