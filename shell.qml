//@ pragma UseQApplication

import Quickshell

Scope {
    id: root

    property string dockMode: "dock"

    Dock {
        mode: dockMode
        onSwitchMode: (switchTo) => {
            if (switchTo != "audio")
                root.dockMode = root.dockMode == switchTo ? "dock" : switchTo;
            else
                root.dockMode = "audio";
        }
        onCloseDockMain: () => {
            root.dockMode = "dock";
        }
    }

    Bar {
    }

    ReserveWindow {
        mode: dockMode
    }

}
