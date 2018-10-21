var socketio = require('socket.io');
var http = require("http")
var io /*= socketio.listen(server)*/;
var fs = require('fs');
const PORT = process.env.PORT || 4000;
// const PORT = 4000;

class AppServer{
	//サーバ起動
	static run(aHttp){
		//サーバを起動
		console.log("AppServerを結合");
		io=require('socket.io')(aHttp);
		// server = http.createServer(function(req, res) {
		// 	// res.writeHead(200, {'Content-Type' : 'text/html'});
		// 	res.end(fs.readFileSync(__dirname, 'utf-8'));
		// }).listen(PORT);
		// console.log(`App Server running at ${PORT}`);

		//受信時の処理を定義
		//ユーザが接続
		io.on('connection', (socket)=>{
			console.log("「"+socket.id+"」が接続しました");
			//メッセージ受信クロージャ設定
			this.setEvents(socket)
			//接続が成功したことを通知
			io.to(socket.id).emit("connected")
			console.log("connect connect connect");
			if(AppServer.destination != null){
				console.log("目的地通知");
				console.log(AppServer.destination);
				io.to(socket.id).emit("updateLocation",AppServer.destination)
			}else{
				console.log("目的地未設定");
			}
		});
	}

	//集合場所を設定
	static setDestination(aDestination){
		console.log("App側　目的地更新");
		AppServer.destination=aDestination
		io.sockets.emit("updateLocation",AppServer.destination)
	}
	//メッセージ受信クロージャ設定
	static setEvents(aSocket){

	}
}
module.exports = AppServer;
