import { useEffect } from "react";
import {
  app,
  storage,
  events,
  window as neutralinoWindow,
} from "@neutralinojs/lib";

const setTitle = async () => {
  try {
    const appName = await storage.getData("app_name");
    if (appName) {
      await neutralinoWindow.setTitle(appName);
    }
  } catch {
    await neutralinoWindow.setTitle("Five9 Cyber Tooling");
  }
};

function App() {
  useEffect(() => {
    setTitle();
    return () => {
      events.on("windowClose", async () => {
        try {
          await app.exit();
        } catch (error) {
          console.error(
            "Graceful exit failed, forcefully killing process:",
            error
          );
          app.killProcess();
        }
      });
    };
  }, []);

  return <div>hi neutralino</div>;
}

export default App;
