sub init()

    m.top.functionName = "getLink"

end sub

sub getLink()

    xfer = CreateObject("roUrlTransfer")

    xfer.SetUrl("https://raw.githubusercontent.com/Golphin0/OneDayTools/main/rokupirates/link.txt")

    link = xfer.GetToString()

    m.top.link = link.Trim()

end sub