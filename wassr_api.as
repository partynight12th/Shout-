package {
	public class wassr_api extends updateapi{
		public function wassr_api(log:logwin){
			super("wassr", "http://api.wassr.jp/statuses/update.json", log);
			this.basicAuth = true;
			this.method = "POST";
			this.setparam("source", "Shout");
			this.textlimit = 255;
		}
	}
}