package {
	public class piyo_api extends updateapi{
		public function piyo_api(log:logwin){
			super("piyo", "http://piyo.fc2.com/contents/api/?mode=send", log, "content");
			this.basicAuth = false;
			this.method = "POST";
			this.setparam("pid", "__username");
			this.setparam("key", "__passwd");
		}
		
		override public function retDataCheck(retdata:String){
			var retxml:XML = new XML(retdata);
			//_logwin.addLine("\t\t" + _sitename + " : " + retdata);
			//_logwin.addLine("\t\t" + _sitename + " : " + retxml.itemlist.errcode.text());
			if(retxml.itemlist.errcode.text() == "0"){
				_logwin.addLine("\t\t" + _sitename + " : OK.");
			}
			//_logwin.addLine("\t\t" + _sitename + " : " + retxml.elements("errcode")[0].text());
			
		}
	}
}