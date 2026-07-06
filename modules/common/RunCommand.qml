import QtQml
import Quickshell
import Quickshell.Io
pragma Singleton

QtObject {
    property Process runProcess

    function run(command) {
        runProcess.command = command;
        runProcess.running = true;
    }

    runProcess: Process {
        running: false
    }

}
