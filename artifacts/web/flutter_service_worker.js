'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "c2def1b05ab52233745306f5d68c25a7",
"manifest.json": "33d5e5768301cac2a5459a56dd793586",
"version.json": "cdc9e964bb9e7e40d5ea4bb5371a84d7",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"assets/FontManifest.json": "e63a3955bf8e064ced8fcc9d0883672a",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js": "18a956f0d88ee6ad4db46658c7c74631",
"assets/packages/amplify_secure_storage_dart/lib/src/worker/workers.min.js.map": "c3021044112f0ca842eef784d47a3789",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js": "3dae7056fe1070de56454048cc3586ee",
"assets/packages/amplify_auth_cognito_dart/lib/src/workers/workers.min.js.map": "3ff309507da25f3ec64917a2acb9cd42",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/amplify_authenticator/assets/social-buttons/google.png": "a1e1d65465c69a65f8d01226ff5237ec",
"assets/packages/amplify_authenticator/assets/social-buttons/SocialIcons.ttf": "1566e823935d5fe33901f5a074480a20",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "9cda082bd7cc5642096b56fa8db15b45",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b00363533ebe0bfdb95f3694d7647f6d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "0a94bab8e306520dc6ae14c2573972ad",
"assets/assets/images/designer_icon.svg": "81eb8281082a04131728936103bff60f",
"assets/assets/images/facebook.png": "5e3b26b028ad5d15df5dfd73b9713dec",
"assets/assets/images/profile_icon.png": "0532b20090d729173082f0bd4e780cd5",
"assets/assets/images/qa_icon.svg": "9ec9b68f919b49f2b1079ad3d6072223",
"assets/assets/images/arrow_forward_24px.svg": "07c890c2cf765c09e9d19c4361e41d48",
"assets/assets/images/pA_logo_white.svg": "12d9b0f5c818500a74e3d424bfa5a345",
"assets/assets/images/homepage_manager.png": "d3f10cbcbe8d1cdc257290feddb204d3",
"assets/assets/images/qa.png": "5a4960203c19c762bfd5dd31b462b2e1",
"assets/assets/images/paBackground.svg": "5a0f97bfff5c4ca17d4c605d951df30f",
"assets/assets/images/redirecting_logo.svg": "1196549f8d68c55f52c946e5cddb2dca",
"assets/assets/images/manager.png": "31e2b5bd4786e60040e0fe5226c5328d",
"assets/assets/images/product_arena_modal.png": "1869e0ae7cef193ed3de9a24fb50f3a8",
"assets/assets/images/homepage_uiux.png": "724108978c819ce2595a1a91934ffeb4",
"assets/assets/images/navbar_logo.svg": "05a00c4001fc224e2c33a09c78d293ee",
"assets/assets/images/check_circle.svg": "2a3264c72683a60f7d38d0df2cdd1064",
"assets/assets/images/logotop.png": "d2494a82ba829826f745a83cbdc4a95b",
"assets/assets/images/Homescreen.png": "6a48730217fa6426ea9b5ad29fd4cb15",
"assets/assets/images/designer_white.svg": "ca0ba103adfd04b54064f11451cb1109",
"assets/assets/images/check_circle_Onboard.svg": "9f9e31eb3102d79657586f84cd328aa5",
"assets/assets/images/footer_logo.svg": "1196549f8d68c55f52c946e5cddb2dca",
"assets/assets/images/illustrationHome.png": "8cb72f5f68f12d749e5eb31763bec03a",
"assets/assets/images/backend.png": "356aaf92e0b7b5778df271d5e4462408",
"assets/assets/images/fullstack.png": "8e5e6d596d0dab94fcb53ae5aa8538cc",
"assets/assets/images/qa_icon.png": "0319ea87a37b28dab02a918e48e2213d",
"assets/assets/images/picture2.png": "85bddb71c3ba811f06c9e9a639692101",
"assets/assets/images/backend_white.svg": "2020a7e3dae037b39248a99c8e7aada0",
"assets/assets/images/uiux.png": "f6439ca54efd9572296dd39f23231ce5",
"assets/assets/images/tech387.svg": "1e8ea5d438ad4372bd35cd21fb5feeec",
"assets/assets/images/homeBackground.svg": "0f83279a78d37597fa2e579befcc7c0e",
"assets/assets/images/manager_white.svg": "2b72fc716e7bbd8bd3c7d44a93a719f3",
"assets/assets/images/logo.svg": "a4f2fb903a7ec2b822484f7d65c44786",
"assets/assets/images/pa_logo_white.svg": "12d9b0f5c818500a74e3d424bfa5a345",
"assets/assets/images/PAlogoWhite.png": "323ab6062234d71a5611358416d80686",
"assets/assets/images/fullstack_developer.svg": "d37e56d779992f6c45881600c0ad6eee",
"assets/assets/images/logo.png": "47eeb47778e288c95ec1f9a395de3b95",
"assets/assets/images/mail_button.svg": "808040dea83f9c8f3d5c7ce07b90ad6a",
"assets/assets/images/contact_icon.png": "48db82fcff95d39971a1af328fc4aa4c",
"assets/assets/images/recent_icon.png": "223f9c9c57172c603175c0f122af3a08",
"assets/assets/images/managerBijela.png": "c6f981d47926ed551313d34559b8160a",
"assets/assets/images/fullstackBijela.png": "b5b4c0387e55c88d3de44c17f597ab61",
"assets/assets/images/mail.png": "cf647ab115025d3597038978fc28bbcf",
"assets/assets/images/pin.svg": "8e0c3e979a9abd235dcad564bfd7c5fe",
"assets/assets/images/illustration.svg": "ffac7c2415ec2824f8d857cfb608e6f3",
"assets/assets/images/fullstack_white.svg": "d70c3fe07a9be6c499d8f3ab7a42a83e",
"assets/assets/images/paBackground.png": "d3ce844aacf8f9f7f36b4e84f6ee375c",
"assets/assets/images/pin.png": "8ee319d5d8d59abc4cd00d12473bee72",
"assets/assets/images/facebook.svg": "6de5eb9f032a81eb299bdb7c6b5750c9",
"assets/assets/images/manager_icon.svg": "7ba386c3ae4775ed5eadfb41ecad01cc",
"assets/assets/images/homeBackground2.png": "4fed7db0e5e5576b10c0b5fa12a5fea2",
"assets/assets/images/tech387.png": "30cd3f63d8fdb166baab2f09d6fb4a33",
"assets/assets/images/qa_white.svg": "b3c97f9dd560e7803762646f3ebca6b6",
"assets/assets/images/footer_logo.png": "d19dcf55b9477074a2d303af23b60c66",
"assets/assets/images/fullsni.png": "41323712075946b55b6c7cf705945d9c",
"assets/assets/images/homeBackground2.svg": "fb6e85a4ca37091e7966ba8a8c0a5368",
"assets/assets/images/email.png": "cf647ab115025d3597038978fc28bbcf",
"assets/assets/images/homeBackground.png": "94d1d095bcb21477e7136d406f0f7c95",
"assets/assets/images/linkedin.svg": "ad53387525b917f636bf08e9c010ff88",
"assets/assets/images/homepageui.png": "c40398879c88611aa5904025a2f73f18",
"assets/assets/images/email.svg": "808040dea83f9c8f3d5c7ce07b90ad6a",
"assets/assets/images/instagram.png": "04553d8eb1d3e37fe9825a132d103ee5",
"assets/assets/images/homepage_qa.png": "854a1fff9858713d0ed997b3cd58d51e",
"assets/assets/images/qaBijela.png": "c704096bd54eb36e6880e280737545fe",
"assets/assets/images/linkedin.png": "c4559636180f6800928d27d60f7b9df8",
"assets/assets/images/homepageqa.png": "fd45aafa6adfcc42b8b87f9fb43ccf3c",
"assets/assets/images/check_circle.png": "d5fa5bf7e65182af09114868185710f3",
"assets/assets/images/instagram.svg": "e19cee36711f1edc0aa4d130ba842cba",
"assets/assets/images/Rectangle_5397.svg": "c18d9e35edfea24763dbc51edecabf01",
"assets/assets/images/uiuxBijela.png": "54da47034d7722d934c9850809a2ff70",
"assets/assets/images/backendBijela.png": "c8c152a7ad0486fd650487b35e749367",
"assets/assets/images/logotop.svg": "b66427f9ba3cdc3b8edc084b5f37e563",
"assets/assets/images/backend_icon.svg": "b74d5b8a33fd7a75fa461d7e5297bfcd",
"assets/assets/images/photo_1.png": "2809906a11c195b44709ed233596a076",
"assets/assets/images/sidebar_logo.png": "9c0bae832c917fe3fc3603b677edd8d3",
"assets/NOTICES": "38be25a6816bef8f00fbf23110901b88",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/AssetManifest.json": "088a6f8d5c4919befcde2dfd109a7608",
"index.html": "965266dd30876bf0f87d8371cbaaaec1",
"/": "965266dd30876bf0f87d8371cbaaaec1",
"main.dart.js": "356b88ebcf724003a9421f7c1f9ca2cd",
"icons/Icon-512.png": "2fcf984a64871d55d86f38754f1b88ec",
"icons/Icon-maskable-192.png": "d931b11685466ddd3c805b8a47a079e0",
"icons/Icon-maskable-512.png": "2fcf984a64871d55d86f38754f1b88ec",
"icons/Icon-192.png": "d931b11685466ddd3c805b8a47a079e0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
