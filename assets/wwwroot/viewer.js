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
        viewer.setTheme("light-theme");
        viewer.setLightPreset(0);
        resolve(viewer);
      }
    );
  });
}

// export function initViewer(container) {
//   const options = {
//     env: "AutodeskProduction",
//     getAccessToken: async function (onSuccess) {
//       //   // const resp = await fetch(
//       //   //   "https://minisitewalkappapi.onrender.com/auth/token"
//       //   // );
//       //   // const { access_token, expires_in } =
//       //   //   await resp.json(); //1hour time life
//       //   // console.log(access_token, expires_in);

//       const access_token =
//         "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY0RE9XMnJoOE9tbjNpdk1NU0xlNGQ2VHEwUSIsInBpLmF0bSI6ImFzc2MifQ.eyJzY29wZSI6WyJ2aWV3YWJsZXM6cmVhZCJdLCJjbGllbnRfaWQiOiJpdGlaQnVjekliTTRQTVBUUnRlQXRHTXZPNFEzNGNBSyIsImlzcyI6Imh0dHBzOi8vZGV2ZWxvcGVyLmFwaS5hdXRvZGVzay5jb20iLCJhdWQiOiJodHRwczovL2F1dG9kZXNrLmNvbSIsImp0aSI6ImhETUExQnVDZXI0b2dxamgzeGNERllueGE5MGVMOXB0cFRmMmFRbWZaTjBwRkUwU3VMSEZrSDUzZjBBWENISlIiLCJleHAiOjE3MDE3MTQ2Nzh9.Wo9cUWEl1kGwropaEv_pMfOnclQTcui1eQLtkdLz8C4IrsiJcfj-ERIVsc1ZiAlTsdr_J2EKBXsi2kBnRk0VcC4nC2XElR5fPat2aLM7daMGqVc2jQ_esK2Ji7Zh0W76cUubaauoSF9hmQ-JO65i8Li9qSH1xaGHG67DbkA1-cr5zr6AsjkNYIMZ1m36zwW6VEoQp_UIqbn2CeCNdmuOEtLzitRu9CRKpT353YD_-iIh0n_tZB_hPfHnL3L2VVLk4rDDO-sGZRrb0T776iQg0uIT4mndx4tt5Lc7leayjTbspshIDTCN1RurHrnEHXU-B_G2AJto2NNA6ixmLxwQTg";
//       const expires_in = "3599";
//       onSuccess(access_token, expires_in);
//     },
//   }; //in production we should root absolut path which means not include public!

//   return new Promise(function (resolve, reject) {
//     Autodesk.Viewing.Initializer(
//       options,

//       //callback when initialization finished
//       async function () {
//         const config = {
//           extensions: [
//             "Autodesk.DocumentBrowser",
//           ],
//         };
//         //at this point we can access the guiViewer3D

//         const viewer =
//           new Autodesk.Viewing.GuiViewer3D(
//             container,
//             config
//           );
//         const startedCode = viewer.start();
//         if (startedCode > 0) {
//           console.error(
//             "Failed to create a viewer: webgl not supported"
//           );
//           reject(
//             "Failed to create a viewer: webgl not supported"
//           );
//         }
//         viewer.setTheme("light-theme");
//         if ("serviceWorker" in navigator) {
//           await navigator.serviceWorker.register(
//             "./sw.js"
//           );
//         }
//         resolve(viewer);
//       }
//     );
//   });
// }

export function loadModel(viewer, urn) {
  return new Promise(async function (
    resolve,
    reject
  ) {
    viewer.setLightPreset(0);

    try {
      Autodesk.Viewing.Document.load(
        "urn:" + urn,
        onDocumentLoadSuccess,
        onDocumentLoadFailure
      );
    } catch (error) {
      console.log("MIGUEL STH WENT WRONG X2!!");
      console.log(error);
    }

    function onDocumentLoadSuccess(doc) {
      console.log("MIGUEL STH WENT ok!!");
      resolve(
        viewer.loadDocumentNode(
          doc,
          doc.getRoot().getDefaultGeometry()
        )
      );
    }
    function onDocumentLoadFailure(
      code,
      message,
      errors
    ) {
      console.log("MIGUEL STH WENT WRONG!!");
      console.log(code, message, errors);
      reject({ code, message, errors });
    }
  });
}
