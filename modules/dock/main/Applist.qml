import Quickshell
import Quickshell.Io
import Quickshell.Wayland
pragma Singleton

Singleton {
    property var pinnedApps: jsonFile.adapter.pinnedApps
    readonly property list<Toplevel> runningApps: ToplevelManager.toplevels.values
    readonly property var apps: {
        const _waitForApps = DesktopEntries.applications.values; // hack to fix ghost apps;
        let seenApps = new Set();
        let pinnedList = [];
        let unPinnedList = [];
        runningApps.forEach((item) => {
            if (!seenApps.has(item.appId)) {
                if (pinnedApps.includes(item.appId))
                    pinnedList.push({
                    "appId": item.appId,
                    "entry": getEntry(item.appId),
                    "window": item,
                    "running": true
                });
                else
                    unPinnedList.push({
                    "appId": item.appId,
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
                "appId": item,
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
        return DesktopEntries.byId(appId) ?? DesktopEntries.heuristicLookup(appId);
    }

    function pinApp(appId) {
        if (pinnedApps.includes(appId)) {
            const newList = pinnedApps.filter((item) => {
                return item !== appId;
            });
            jsonFile.adapter.pinnedApps = newList;
        } else {
            jsonFile.adapter.pinnedApps.push(appId);
        }
    }

    FileView {
        id: jsonFile

        path: Quickshell.shellPath("pinnedApps.json")
        blockLoading: true
        onAdapterUpdated: jsonFile.writeAdapter()

        adapter: JsonAdapter {
            property list<string> pinnedApps
        }

    }

}
