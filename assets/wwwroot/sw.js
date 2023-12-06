const CACHE_NAME = "forge-disconnected-v1";
const STATIC_URLS = [
  "/",
  "/index.html",
  "/fonts/Artifakt_Element_Regular.woff2",
  "https://cdn.autodesk.io/logo/black/stacked.png",
  "/main.js",
  "/viewer.js",
  "/main.css",
  "https://developer.api.autodesk.com/modelderivative/v2/viewers/7.*/extensions/DocumentBrowser/DocumentBrowser.js",
  "https://developer.api.autodesk.com/modelderivative/v2/viewers/7.*/extensions/MixpanelProvider/MixpanelProvider.js",
  "https://developer.api.autodesk.com/modelderivative/v2/viewers/7.*/extensions/PDF/PDF.js",
];
self.addEventListener(
  "install",
  function (event) {
    console.log("Installing event!", event);
    event.waitUntil(installAsync(event));

    console.log("Files stored in cache");
  }
);
async function installAsync(event) {
  self.skipWaiting(); // Replace old service workers without waiting for them to wrap up
  const cache = await caches.open(CACHE_NAME);
  await cache.addAll(STATIC_URLS);
  // await cache.addAll(API_URLS); //after initializing the viewer

  //caching urns!!
}
self.addEventListener(
  "activate",
  function (event) {
    console.log("Activate event", event);

    //we need to delete previous cache!!
    event.waitUntil(activateAsync(event));

    console.log(
      "previous cache deleted if existed"
    );
  }
);

async function activateAsync(event) {
  const keys = await caches.keys();
  const oldCaches = keys.filter(
    (key) => key !== CACHE_NAME
  );
  if (oldCaches && oldCaches.length > 0) {
    oldCaches.map(
      async (key) => await caches.delete(key)
    );
  }

  self.clients.claim();
}

self.addEventListener("fetch", function (event) {
  console.log(
    "Fetching the following url: ",
    event.request.url
  );
  event.respondWith(fetchAsync(event));
});

async function fetchAsync(event) {
  // a). When requesting an access token, try getting a fresh one first
  if (event.request.url.endsWith("/api/token")) {
    try {
      const response = await fetch(event.request); //should we pass the url for the fetch request??
      return response;
    } catch (err) {
      console.log(
        "Could not fetch new token, falling back to cache.",
        err
      );
    }
  }

  //b). for all requests falling back mechanims
  const match = await caches.match(
    event.request.url,
    { ignoreSearch: true }
  );
  if (match) {
    // If this is a static asset or known API, try updating the cache as well??
    //¿¿but you are returning the match which is old file source!!
    // if (
    //   STATIC_URLS.includes(event.request.url) ||
    //   API_URLS.includes(event.request.url)
    // ) {
    //   caches
    //     .open(CACHE_NAME)
    //     .then((cache) => cache.add(event.request))
    //     .catch((err) =>
    //       console.log(
    //         "Cache not updated, but that's ok...",
    //         err
    //       )
    //     );
    // }
    return match;
  }

  //c).For first sw, we need to do a fetch
  try {
    return await fetch(event.request);
  } catch (error) {
    //derivates!! missing
    console.log("no internet connection");
  }
}
