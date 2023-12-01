async function getAccessToken(callback) {
  try {
    // const resp = await fetch("/api/auth/token");
    //...unwrapping endpoint:
    // const FORGE_CLIENT_ID =
    //   "itiZBuczIbM4PMPTRteAtGMvO4Q34cAK";
    // const FORGE_CLIENT_SECRET =
    //   "AM2UhaffSs8zcFOF";

    // let publicAuthClient =
    //   new AuthClientTwoLegged(
    //     FORGE_CLIENT_ID,
    //     FORGE_CLIENT_SECRET,
    //     ["viewables:read"],
    //     true
    //   );
    // if (!publicAuthClient.isAuthorized()) {
    //   await publicAuthClient.authenticate();
    // }
    // const resp =
    //   publicAuthClient.getCredentials();
    // //...

    // if (!resp.ok) {
    //   throw new Error(await resp.text());
    // }
    // const { access_token, expires_in } =
    //   await resp.json();
    const access_token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY0RE9XMnJoOE9tbjNpdk1NU0xlNGQ2VHEwUSIsInBpLmF0bSI6ImFzc2MifQ.eyJzY29wZSI6WyJ2aWV3YWJsZXM6cmVhZCJdLCJjbGllbnRfaWQiOiJpdGlaQnVjekliTTRQTVBUUnRlQXRHTXZPNFEzNGNBSyIsImlzcyI6Imh0dHBzOi8vZGV2ZWxvcGVyLmFwaS5hdXRvZGVzay5jb20iLCJhdWQiOiJodHRwczovL2F1dG9kZXNrLmNvbSIsImp0aSI6IkY3ZEdneHFUTGE0THFEVWx4R09YbHJvczk2WnBlSDBzcE1sTzhIQjRFNlo0ZERVR3dKNnZnM1ZhRTVNMnFlMlAiLCJleHAiOjE3MDEyODcwNjh9.dRTZN2axmQc0Zb9qE7Eg9Wdm9aocACXB0gdYMruqlomKDooICIX0U6p4OhyrDRga5sgi8oaFIpg9I6_OpVPUqgRS-1gs1TMtfot_AsFFa5Yi8tk0Qk_fBsCtwlc2ZZ8h-tZJqKze6hhKRME2WKXAya8qqI9tDD-VPH6KmwcDP2ilNkE9my1VttMeP_qjrEN9MOH5_zPP_-j828efU94XyTUVExsg9349bSmvVt6RDGfBTcIFv8IDAZHXF5mXEbB-wTtxYwz5vCTc3wOZynG_e1ipkzNPOK6sjbP1_7bulidjXqFD_X1zNFpOUG3K6HBvqIxyfDb9RSZ33ESVnv-3wg";
    const expires_in = "3599";
    callback(access_token, expires_in);
  } catch (err) {
    alert(
      "Could not obtain access token. See the console for more details."
    );
    console.error(err);
  }
}

function initViewer(container) {
  return new Promise(function (resolve, reject) {
    Autodesk.Viewing.Initializer(
      { getAccessToken },
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
        viewer.start();
        viewer.setTheme("light-theme");
        resolve(viewer);
      }
    );
  });
}

function loadModel(viewer, urn) {
  return new Promise(function (resolve, reject) {
    function onDocumentLoadSuccess(doc) {
      const bubbleRootGeo = doc
        .getRoot()
        .getDefaultGeometry();

      if (bubbleRootGeo) {
        resolve(
          viewer.loadDocumentNode(doc, defaultGeo)
        );
      } else {
        reject(
          "Could not find a default geometry"
        );
      }
    }
    function onDocumentLoadFailure(
      code,
      message,
      errors
    ) {
      // console.log(errors, message, code);
      reject({ code, message, errors });
    }
    viewer.setLightPreset(0);

    console.log("MIGUEL urn:" + urn);
    Autodesk.Viewing.Document.load(
      "urn:" + urn,
      onDocumentLoadSuccess,
      onDocumentLoadFailure
    );
  });
}

const sth = document.getElementById("preview");
sth.innerText = "miguel hola";

// const globalURN =
//   "dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6aXRpemJ1Y3ppYm00cG1wdHJ0ZWF0Z212bzRxMzRjYWstYmFzaWMtYXBwL3VuaXRSMTYyLnJ2dA";
// initViewer(
//   document.getElementById("preview")
// ).then((viewer) => {
//   // const urn = window.location.hash?.substring(1);
//   // setupModelSelection(viewer, urn);
//   // setupModelUpload(viewer);

//   loadModel(viewer, globalURN);
//   // console.log(globalURN);
// });
