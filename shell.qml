//@ pragma UseQApplication

import Quickshell

Scope {
    Dock {
        id: dock
    }

    Bar {
        onOpenPowerMenu: {
            dock.switchMode("powerMenu");
        }
    }

}
