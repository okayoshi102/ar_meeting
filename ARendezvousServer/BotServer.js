const express = require('express');
const line = require('@line/bot-sdk');
const PORT = process.env.PORT || 5000;
// const PORT = 5000;

const config = {
	channelSecret: '',
	channelAccessToken: ''
};
class BotServer{
	//サーバ起動
	static run(){
		this.express=express();
		this.http=require("http").Server(this.express)
		this.express.post('/webhook', line.middleware(config), (req, res) => {
			console.log(req.body.events);
			console.log(BotServer.handleEvent);
			console.log("Bot Server に Post された");
			Promise
			.all(req.body.events.map(BotServer.handleEvent))
			.then((result) => res.json(result));
		});

		this.client = new line.Client(config);

		console.log("BotServer起動");
		this.http.listen(PORT, () => {
			console.log(`listening on *:${PORT}`);
		});
	}
	//LINEに送信されたメッセージを受信
	static handleEvent(event) {
		console.log("get message");
		if(event.message.type == "location"){
			//位置情報が送信された
			BotServer.notifyDestinationUpdate({latitude:event.message.latitude,longitude:event.message.longitude})
			return BotServer.client.replyMessage(event.replyToken, {
				type: 'text',
				text: "arendezvous://?"
			})
		}
		if (event.type !== 'message' || event.message.type !== 'text') {
			return Promise.resolve(null);
		}
		console.log(event.message.text);
		if(event.message.text != ".gt" && event.message.text != "．gt"){
			// return BotServer.client.replyMessage(event.replyToken, {
			// 	type: 'text',
			// 	text: event.message.text
			// })
			return Promise.resolve(null)
		}
		//キーワードが送信された
		return BotServer.client.replyMessage(event.replyToken, {
			type: 'text',
			text: "集まりますか？",
			"quickReply": {
				"items": [
					{
						"type": "action",
						"action": {
							"type":"location",
							"label":"はい"
						}
					},
					{
						"type": "message",
						"action": {
							"type": "message",
							"label": "いやです",
							"text": "いやです"
						}
					}
				]
			}
		});
	}
	//目的地が更新された時の通知先を設定
	static setDestinationObserver(aObserver){
		this.destinationObserver=aObserver
	}
	//目的地更新を通知
	static notifyDestinationUpdate(aDestination){
		console.log("目的地更新通知");
		this.destinationObserver(aDestination)
	}
}
module.exports = BotServer;
