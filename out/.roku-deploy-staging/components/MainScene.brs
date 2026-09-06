sub init()

    m.menu = m.top.findNode("menu")
    m.video = m.top.findNode("video")
    m.keyboard = m.top.findNode("keyboard")
    m.getLinkTask = CreateObject("roSGNode", "GetLinkTask")
    m.getLinkTask.observeField("link", "onPiracyLink")
    m.linksLoaded = false

    ' Main menu
    root = CreateObject("roSGNode", "ContentNode")

    item = root.createChild("ContentNode")
    item.title = "My First Video"
    item.url = "https://raw.githubusercontent.com/Golphin0/OneDayTools/main/rokupirates/me.mp4"

    item = root.createChild("ContentNode")
    item.title = "Piracy"
    item.url = ""

    item = root.createChild("ContentNode")
    item.title = "Keyboard"
    item.url = ""

    item = root.createChild("ContentNode")
    item.title = "Exit"
    item.url = ""

    m.mainMenu = root
    m.menu.content = root

    m.menu.observeField("itemSelected", "onSelected")

    m.top.setFocus(true)
    m.menu.setFocus(true)

    ' Center keyboard
    rect = m.keyboard.boundingRect()
    centerx = (1280 - rect.width) / 2
    centery = (720 - rect.height) / 2
    m.keyboard.translation = [centerx, centery]

    m.keyboard.visible = false
    m.inPiracyMenu = false

end sub


sub onSelected()

    item = m.menu.content.getChild(m.menu.itemSelected)

    ' -------------------------
    ' PIRACY MENU
    ' -------------------------
    if m.inPiracyMenu then

        if item.title = "Back" then
            m.inPiracyMenu = false
            m.menu.content = m.mainMenu
            m.menu.setFocus(true)
            return
        end if

        ' Selected piracy link
        if item.url <> "" then

            ' Put selected URL into keyboard
            m.keyboard.text = item.url

            print "Selected piracy link: "; item.url

            ' Load video
            content = CreateObject("roSGNode", "ContentNode")
            content.url = item.url
            content.streamFormat = "mp4"

            m.video.content = content
            m.menu.visible = false
            m.video.visible = true
            m.video.control = "play"
            m.video.setFocus(true)

            m.inPiracyMenu = false

        end if

        return
    end if


    ' -------------------------
    ' MAIN MENU
    ' -------------------------

    if item.title = "Exit" then
        m.top.close = true
        return
    end if


    if item.title = "Keyboard" then
        m.menu.visible = false
        m.keyboard.visible = true
        m.keyboard.setFocus(true)
        return
    end if

    if item.title = "Piracy" then

        if m.linksLoaded then
            onPiracyLink()
        else
            print "Downloading link.txt..."
            m.getLinkTask.control = "RUN"
        end if

        return
    end if


    ' Normal video
    if item.url <> "" then

        m.keyboard.text = item.url

        content = CreateObject("roSGNode", "ContentNode")
        content.url = item.url
        content.streamFormat = "mp4"

        m.video.content = content
        m.menu.visible = false
        m.video.visible = true
        m.video.control = "play"
        m.video.setFocus(true)

        print "Playing: "; item.url

    end if

end sub


sub onPiracyLink()

    text = m.getLinkTask.link

    print "Got links:"
    print text

    piracyRoot = CreateObject("roSGNode", "ContentNode")

    ' Split link.txt into individual lines
    lines = text.Tokenize(chr(10))

    number = 1

    for each line in lines

        link = line.Trim()

        if link <> ""

            item = piracyRoot.createChild("ContentNode")

            ' What the user sees
            item.title = number.ToStr() + ". " + link

            ' Actual URL
            item.url = link

            number = number + 1

        end if

    end for

    ' Back option
    item = piracyRoot.createChild("ContentNode")
    item.title = "Back"
    item.url = ""

    m.inPiracyMenu = true

    m.menu.content = piracyRoot
    m.menu.visible = true
    m.menu.setFocus(true)
    m.linksLoaded = true

end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    if not press then
        return false
    end if

    ' Piracy menu -> main menu
    if key = "back" and m.inPiracyMenu then
        m.inPiracyMenu = false
        m.menu.content = m.mainMenu
        m.menu.itemSelected = 0
        m.menu.visible = true
        m.menu.setFocus(true)
        return true
    end if

    ' Video -> menu
    if key = "back" and m.video.visible then
        m.video.control = "stop"
        m.video.visible = false
        m.menu.visible = true
        m.menu.setFocus(true)
        return true
    end if

    ' Keyboard -> menu
    if key = "back" and m.keyboard.visible then
        m.keyboard.visible = false
        m.menu.visible = true
        m.menu.setFocus(true)
        return true
    end if

    return false

end function