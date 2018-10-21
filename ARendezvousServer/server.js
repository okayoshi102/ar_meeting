const gAppServer=require("./AppServer.js")
const gBotServer=require("./BotServer.js")
gBotServer.run()
gAppServer.run(gBotServer.http)
gBotServer.setDestinationObserver(gAppServer.setDestination)
console.log("起動完了");
