package {
	import fl.controls.*;
	
	public class logwin extends TextArea{
		public function addLine(str:String){
			this.text = str + "\n" + this.text;
		}
	}
}