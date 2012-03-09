package {
	public class timelog_api extends updateapi{
		public function timelog_api(log:logwin){
			super("timelog", "http://api.timelog.jp/new.asp", log, "text");
			this.basicAuth = true;
			this.method = "POST";
			this.textlimit = 200;
		}
	}
}