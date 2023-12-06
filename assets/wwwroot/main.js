import {
  initViewer,
  loadModel,
} from "./viewer.js";

// const sth = document.getElementById("preview");
// sth.innerText = "miguel hola";

initViewer(document.getElementById("preview"))
  .then(async (viewer) => {
    // const globalUrn =
    //   "dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6aXRpemJ1Y3ppYm00cG1wdHJ0ZWF0Z212bzRxMzRjYWstYmFzaWMtYXBwL3VuaXRSMTYyLnJ2dA";
    // loadModel(viewer, globalUrn);
  })
  .catch((err) => {
    console.log(err);
  });
