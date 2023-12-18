// document.getElementById("preview").innerText =
//   "holaa";
let options = {
  env: "Local",
  document: "Unit_Floor_Plan.pdf",
};
const config = {
  extensions: ["Autodesk.DocumentBrowser"],
};
Autodesk.Viewing.Initializer(options, () => {
  const viewer = new Autodesk.Viewing.GuiViewer3D(
    document.getElementById("preview"),
    config
  );

  viewer.start(options.document, options);
});
