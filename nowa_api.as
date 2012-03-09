package {
	public class nowa_api extends updateapi{
		public function nowa_api(log:logwin){
			super("nowa", "https://api.nowa.jp/status_message/update.json", log);
			this.basicAuth = true;
			this.method = "POST";
		}
	}
}