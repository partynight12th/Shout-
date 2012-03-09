package {
	public class twitter_api extends updateapi{
		public function twitter_api(log:logwin){
			super("twitter", "http://twitter.com/statuses/update.json", log);
			this.basicAuth = true;
			this.method = "POST";
			this.setparam("source", "Shout");
			this.textlimit = 140;
		}
	}
}