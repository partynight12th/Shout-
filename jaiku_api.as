package {
	public class jaiku_api extends updateapi{
		public function jaiku_api(log:logwin){
			super("jaiku", "http://api.jaiku.com/json", log, "message");
			this.basicAuth = false;
			this.method = "POST";
			this.setparam("user", "__username");
			this.setparam("personal_key", "__passwd");
			this.setparam("method", "presence.send");
			this.textlimit = 140;
		}
	}
}