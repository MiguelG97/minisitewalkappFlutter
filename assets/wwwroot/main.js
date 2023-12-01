import { initViewer } from "./viewer.js";

// const sth = document.getElementById("preview");
// sth.innerText = "miguel hola";

initViewer(document.getElementById("preview"))
  .then(() => {})
  .catch((err) => {
    console.log(err);
  });
// const globalUrn =
//     "dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6aXRpemJ1Y3ppYm00cG1wdHJ0ZWF0Z212bzRxMzRjYWstYmFzaWMtYXBwL3VuaXRSMTYyLnJ2dA";
