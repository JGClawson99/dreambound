// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Swiper from 'swiper/bundle';



const Hooks = {}

Hooks.Flip = {
  mounted() {
    this.initSwiper();
  },
  
  updated() {
    console.log("Swiper updated");
    
    // Destroy the existing swiper instance and reinitialize it
    if (this.swiperFlip) {
      this.swiperFlip.destroy();
    }

    this.initSwiper();  // Reinitialize Swiper after update
  },

  destroyed() {
    if (this.swiperFlip) {
      this.swiperFlip.destroy();  // Ensure we destroy swiper when the hook is removed
    }
  },

  initSwiper() {
    this.swiperFlip = new Swiper(this.el, {
      effect: 'flip',  // Reinitialize the flip effect
      grabCursor: true,
      // Add any other configuration you need
      flipEffect: {
        limitRotation: true,
      },
    });
  }
}

Hooks.Swiper = {
  mounted() {
    console.log("Swiper mounted")
    this.swiper = new Swiper(this.el, {
      effect: "cards",
      grabCursor: true,
      cardsEffect: {
        perSlideOffset: 10,
        perSlideRotate: 4,
        rotate: true,
        // slideShadows: true
      },
      on: {
        slideChange: () => {
          const currentIndex = this.swiper.realIndex;
          console.log("Current card index: ", currentIndex);
          this.pushEvent("card_swiped", { index: currentIndex });
        },
      },
    });
  },
  updated() {
    this.swiper.update();
  },
  destroyed() {
    this.swiper.destroy();
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

