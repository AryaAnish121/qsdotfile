import Quickshell
import Quickshell.Wayland
pragma Singleton

Singleton {
    readonly property list<string> pinnedApps: ["firefox", "code", "kitty"]
    readonly property list<Toplevel> runningApps: ToplevelManager.toplevels.values
    property var _entryCache: ({
    })
    readonly property var apps: {
        const _waitForApps = DesktopEntries.applications.values; // hack to fix ghost apps; 
        let seenApps = new Set();
        let pinnedList = [];
        let unPinnedList = [];
        runningApps.forEach((item) => {
            if (!seenApps.has(item.appId)) {
                if (pinnedApps.includes(item.appId))
                    pinnedList.push({
                    "entry": getEntry(item.appId),
                    "window": item,
                    "running": true
                });
                else
                    unPinnedList.push({
                    "entry": getEntry(item.appId),
                    "window": item,
                    "running": true
                });
                seenApps.add(item.appId);
            }
        });
        pinnedApps.forEach((item) => {
            if (!seenApps.has(item))
                pinnedList.push({
                "entry": getEntry(item),
                "window": null,
                "running": false
            });

        });
        return {
            "pinnedApps": pinnedList,
            "unPinnedApps": unPinnedList
        };
    }

    function getEntry(appId) {
        if (_entryCache[appId])
            return _entryCache[appId];

        const entry = DesktopEntries.byId(appId) ?? DesktopEntries.heuristicLookup(appId);
        _entryCache[appId] = entry;
        return entry;
    }

}
