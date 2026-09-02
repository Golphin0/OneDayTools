sub init()

    m.menu = m.top.findNode("menu")
    m.video = m.top.findNode("video")
    m.keyboard = m.top.findNode("keyboard")

    root = CreateObject("roSGNode","ContentNode")

    item = root.createChild("ContentNode")
    item.title = "My First Video"
    item.url = "https://raw.githubusercontent.com/Golphin0/OneDayTools/main/rokupirates/me.mp4"

    item = root.createChild("ContentNode")
    item.title = "Piracy"
    item.url = "https://tmpfiles.org/dl/1788381055.f6fd51b483571608/wSwxhQo5ngcl/22.mp4"

    item = root.createChild("ContentNode")
    item.title = "Keyboard"
    item.url = ""

    item = root.createChild("ContentNode")
    item.title = "Exit"
    item.url = ""

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

end sub


sub onSelected()

    item = m.menu.content.getChild(m.menu.itemSelected)

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

    ' Otherwise it's a video
    if item.title = "Piracy" then
        link = getPiracyLink()

        print "Got link: "; link

        m.keyboard.text = link
    end if

    content = CreateObject("roSGNode","ContentNode")
    content.url = item.url
    content.streamFormat = "mp4"

    m.video.content = content
    m.menu.visible = false
    m.video.visible = true
    m.video.control = "play"
    m.video.setFocus(true)
    print item.url

end sub

function getPiracyLink() as String

    xfer = CreateObject("roUrlTransfer")
    xfer.SetUrl("https://raw.githubusercontent.com/Golphin0/OneDayTools/main/rokupirates/link.txt")

    link = xfer.GetToString()

    return link.Trim()

end function


function onKeyEvent(key as String, press as Boolean) as Boolean

    if not press then
        return false
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