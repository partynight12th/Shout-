package {
	public class mogo2_api extends updateapi{
		public function mogo2_api(log:logwin){
			super("mogo2", "http://api.mogo2.jp/statuses/update.json", log);
			this.basicAuth = true;
			this.method = "POST";
		}
	}
}