let titleInput = document.getElementById("titleInput");
let textInput = document.getElementById("textInput")
let createButton = document.getElementById("createButton");
let inShell = document.getElementById("inShellCheck");
let stylesCheckbox = document.getElementById("stylesCheckbox");
let stylesOptions = document.getElementById("stylesOptions");
let stylesOptionDiv = document.getElementById("stylesOptionDiv");
let messagingCheckbox = document.getElementById("messagingCheckbox");

document.querySelectorAll("textarea").forEach(x=>x.placeholder="Input Here...");
document.querySelector("#output").placeholder = "";

createButton.addEventListener("click", () => {
  let command = "cmd notification post ";
  if (!inShell.checked) {
    command = "adb shell " + command;
  }
  if (titleInput.value) {
    command += "-t \"" + titleInput.value.replace(/ /g, "\\ ") + "\" ";
  }
  if (stylesCheckbox.checked) {
    if (messagingCheckbox.checked) {
      let messagingInput = document.getElementById("messagingInput");
      let messagesRaw = messagingInput.value.split("\n");
      let messages = [];
      messagesRaw.forEach(message => {
        let [before, after] = message.split(/(?<!\\):/, 2)
        messages.push([before, after]);
      });
      command += "-S messaging ";
      messages.forEach(message => {
        let person = message[0];
        let text = message[1];
        command += `--message "${person}":"${text}" `
      })
    }
  }

  command += `b "${textInput.value.replace(/ /g, "\\ ")}"`;
  output.value = command;
});

stylesCheckbox.addEventListener("change", () => {
  if (stylesCheckbox.checked) {
    stylesOptions.style.display = "initial";
  } else {
    stylesOptions.style.display = "none";
  }
});



bigpictureCheckbox.addEventListener("change", () => {
  if (bigpictureCheckbox.checked) {
    bigpictureDiv.appendChild(Object.assign(document.createElement("textarea"), {style:"resize:none;",id:"bigpictureInput"}));
  } else {
    let textarea = bigpictureDiv.querySelector("textarea");
    bigpictureDiv.removeChild(textarea);
  }
});

messagingCheckbox.addEventListener("change", () => {
  if (messagingCheckbox.checked) {
    let messagingTitle = document.createElement("p");
    let messagingInput = Object.assign(document.createElement("textarea"), { id: "messagingInput" });

    messagingTitle.innerHTML = "For each line, name, :, text. name is the name of the person that sent the message, then you have the colon, then the text they sent. Use \\: to have a literal colon.";

    messagingTitle.id = "messagingTitle";

    messagingDiv.appendChild(messagingTitle);
    messagingDiv.appendChild(messagingInput);
  } else {
    let textarea = messagingDiv.querySelector("textarea");
    messagingDiv.removeChild(textarea);
    let messagingTitle = messagingDiv.querySelector("#messagingTitle");
    messagingDiv.removeChild(messagingTitle);
    
  }
});

