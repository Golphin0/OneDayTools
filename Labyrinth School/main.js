function sleep(ms) { return new Promise((resolve) => setTimeout(resolve, ms)) };
let startButton = document.getElementById("startButton");
let transitionDark = document.getElementById("transitionDark");
let startMusic = document.getElementById("startMusic");
let startMusicPlay = document.getElementById("startMusicPlay");
let menucontainer = document.getElementById("menucontainer");
let preScreen = document.getElementById("preScreen");
let body = document.body;

async function startGame() {
    transitionDark.style.opacity = "100%";
    fadeMusicOut("startMusic", 2000);
    await sleep(2000);
    startup();
    transitionDark.style.opacity = "0%";
}

async function showGameMenu() {
    startMusic.muted = false;
    startMusic.play();
    if (shutTheFuckUp) {startMusic.pause()}
    preScreen.style.display = "none";
    transitionDark.style.transition = "none";
    transitionDark.style.opacity = "100%";
    await sleep(1000);
    transitionDark.style.transition = "";
    transitionDark.style.transitionDuration = "4s";
    transitionDark.style.opacity = "0%";
    await sleep(2000);
    transitionDark.style.transitionDuration = "";
    transitionDark.style.pointerEvents = "none";
}

async function showGameMenuNOW() {
    preScreen.style.display = "none";
    transitionDark.style.transition = "none";
    transitionDark.style.opacity = "0%";
    transitionDark.style.transition = "";
    transitionDark.style.pointerEvents = "none";
}

function fadeMusicOut(id, duration) {
    let audio = document.getElementById(id);
    startMusic.volume = 1;
    const intervalTime = 50; // Update every 50ms for smooth fading
    const steps = duration / intervalTime;
    const volumeStep = 1 / steps;

    const fadeInterval = setInterval(() => {
    if (startMusic.volume > volumeStep) {
        startMusic.volume -= volumeStep;
    } else {
        startMusic.volume = 0;
        clearInterval(fadeInterval);
    }
    }, intervalTime);
}

function fadeMusicIn(id, duration) {
    let audio = document.getElementById(id);
    startMusic.volume = 0;
    const intervalTime = 50; // Update every 50ms for smooth fading
    const steps = duration / intervalTime;
    const volumeStep = 1 / steps;

    const fadeInterval = setInterval(() => {
    if (startMusic.volume < 1) {
        startMusic.volume += volumeStep;
    } else {
        startMusic.volume = 1;
        clearInterval(fadeInterval);
    }
    }, intervalTime);
}

async function startup() {
    body.removeChild(menucontainer);
    body.classList.remove("bodymenu");
    body.classList.add("");
    
}

function toggleMusic(element, aggregator, changetext, textplay, textpause) {

    let paused = element.paused;

    if (aggregator && changetext && textplay && textpause) {
        if (paused) {
            aggregator.textContent = textpause;
        } else {
            aggregator.textContent = textplay;
        }
    }

    if (paused) {
        element.play();
    } else {
        element.pause();
    }
}

let dev = 0;
let shutTheFuckUp = 0;

if (dev) {
    showGameMenuNOW();
}

startMusicPlay.addEventListener("click", () => toggleMusic(startMusic, startMusicPlay, true, ">", "||"));

startButton.addEventListener("click", () => startGame(), {once:true});
transitionDark.addEventListener("click", () => showGameMenu(), {once:true});