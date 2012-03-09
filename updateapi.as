package {

	import fl.controls.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.events.*;
	import com.hurlant.util.Base64;
	import flash.data.EncryptedLocalStore;	
	import com.adobe.serialization.json.JSON;
	import flash.display.MovieClip;

	public class updateapi extends MovieClip{
		/* ************************************************ */
		//
		//  コンストラクタ
		//
		/* ************************************************ */
		public function updateapi(sitename:String, updateurl:String, log:logwin, postkey:String = "status"){
			_sitename = sitename;
			req.url = updateurl;
			_postkey = postkey;
			_postarray[_postkey] = "";
			_logwin = log;
			
			loader.addEventListener(Event.COMPLETE, onComp);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoErr);
			req.authenticate = false;
			req.userAgent = "Mozilla/5.0 (Shout)";
		}
		
		/* ************************************************ */
		//
		//  Basic認証か否かのプロパティGetter/Setter
		//
		/* ************************************************ */
		
		protected function set basicAuth(ba:Boolean):void{
			_basicauth = ba;
		}
		
		protected function get basicAuth():Boolean{
			return _basicauth;
		}
		
		/* ************************************************ */
		//
		//  URLRequestのメソッド（POST/GET） Getter/Setter
		//
		/* ************************************************ */
		
		protected function set method(mth:String):void{
			if(mth.toUpperCase() == "POST" || mth.toUpperCase() == "GET"){
				req.method = mth.toUpperCase();
			}
		}
		
		protected function get method():String{
			return req.method;
		}
		
		/* ************************************************ */
		//
		// 投稿するパラメータの設定
		//
		/* ************************************************ */
		
		protected function setparam(key:String, value:String):void{
			_postarray[key] = value;
		}
		
		
		/* ************************************************ */
		//
		//  ユーザーアカウントのGetter/Setter
		//
		/* ************************************************ */
		
		public function set username(un:String):void{
			EncryptedLocalStore.removeItem(_sitename + "_id");
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(un);
			EncryptedLocalStore.setItem(_sitename + "_id", ba);
		}
		
		public function set passwd(pw:String):void{
			EncryptedLocalStore.removeItem(_sitename + "_pw");
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(pw);
			EncryptedLocalStore.setItem(_sitename + "_pw", ba);
		}
		
		public function get username():String{
			//_logwin.addLine("read username : ");
			var storedValue:ByteArray = EncryptedLocalStore.getItem(_sitename + "_id");
			if(storedValue != null){
				return storedValue.readUTFBytes(storedValue.length);
			}else{
				return "";
			}
		}
		
		public function get passwd():String{
			var storedValue:ByteArray = EncryptedLocalStore.getItem(_sitename + "_pw");
			if(storedValue != null){
				return storedValue.readUTFBytes(storedValue.length);
			}else{
				return "";
			}
		}
		
		public function set_account(user:String, pass:String){
			this.username = user;
			this.passwd = pass;
		}
		
		/* ************************************************ */
		//
		//  文字数制限設定
		//
		/* ************************************************ */
		
		public function set textlimit(tl:int):void{
			this.statuslimit = tl;
		}
		
		public function get textlimit():int{
			return this.statuslimit;
		}
		
		/* ************************************************ */
		//
		//  投稿フロー
		//
		/* ************************************************ */
		
		public function update(txt:String = ""):Boolean{
			
			if(txt.length == 0){
				_logwin.addLine("\t\t" + _sitename + " : error, no update text. ");
				return false;
			}
			
			if(this.username.length == 0 || this.passwd.length == 0){
				_logwin.addLine("\t\t" + _sitename + " : error, no accont information. ");
				return false;
			}

			_postarray[_postkey] = txt;
			
			req.contentType = "application/x-www-form-urlencoded";
			if(_basicauth){
				var headeropt:Array = new Array();
				var ba:ByteArray = new ByteArray();
				ba.writeUTFBytes(this.username + ":" + this.passwd);
				//_logwin.addLine(ba.toString());
				headeropt.push(new URLRequestHeader("Authorization" , "Basic " + Base64.encodeByteArray(ba)));
				req.requestHeaders = headeropt;
			}

			req.data = "";
			for ( var i in _postarray){
				if(req.data.length != 0){
					req.data += "&";
				}
				var val:String = "";
				if(_postarray[i] == "__username"){
					val = this.username;
				}else if(_postarray[i] == "__passwd"){
					val = this.passwd;
				}else{
					val = _postarray[i];
				}
					
				req.data += i + "=" + escapeMultiByte(val);
			}
			
			//_logwin.addLine("\t\t" + _sitename + " : " + req.data);
			
			//_logwin.addLine("\t\t" + _sitename + " : " + req.userAgent);
			
			loader.load(req);
			return true;
		}
		
		private function onComp(e:Event){
			//_logwin.addLine(e.target.data);
			//_logwin.addLine("\t\t" + _sitename + " : OK.");
			retDataCheck(e.target.data);
		}
		
		private function onIoErr(e:Event){
			_logwin.addLine("\t\t" + _sitename + " : " + e["text"]);
		}
		
		public function retDataCheck(retdata:String){
			_logwin.addLine("\t\t" + _sitename + " : OK.");
		}

		protected var _sitename:String;
		private var _postkey:String;
		private var _postarray:Object = new Object();
		private var req:URLRequest = new URLRequest();
		private var _ret:Array;
		private var _basicauth:Boolean = false;
		private var loader:URLLoader = new URLLoader();
		protected var _logwin:logwin;
		private var statuslimit:int = 0;

	}
}