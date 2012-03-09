package {
	public class haiku_api extends updateapi{
		public function haiku_api(log:logwin){
			super("haiku", "http://h.hatena.ne.jp/api/statuses/update.json", log);
			this.basicAuth = true;
			this.method = "POST";
			this.setparam("source", "Shout");
			this.setparam("keyword", "ひとりごと");
		}
	}
}