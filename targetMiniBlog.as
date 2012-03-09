package {
	import fl.controls.*;
	import flash.display.*;
	import flash.data.EncryptedLocalStore;	
	import flash.utils.ByteArray;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	
	public class targetMiniBlog extends CheckBox{
		public function targetMiniBlog(){
			super();
			this.addEventListener(MouseEvent.CLICK, onCheck);
			this.addEventListener(Event.ACTIVATE , onComp);
		}
		
		private function onCheck(e:MouseEvent){
			var bytes:ByteArray = new ByteArray();
			bytes.writeBoolean(this.selected);
			EncryptedLocalStore.setItem(this.name + "_cb", bytes);
		}

		private function onComp(e:Event){
			//MovieClip(stage.getChildAt(0)).log.addLine(this.label + "is Active.");
			var storedValue:ByteArray = EncryptedLocalStore.getItem(this.name + "_cb");
			if(storedValue != null){
				this.selected = storedValue.readBoolean();
			}
			this.width = 16;
			
			var ld:Loader = new Loader();
			var url = File.applicationDirectory.url + File.separator + "icons" + File.separator + this.name + "_icon.png";
			trace(url);
			var ur:URLRequest = new URLRequest(url);
			ld.load(ur);
			addChild(ld);
			ld.x = 5;
			ld.y = 3;
			this.swapChildren(ld, getChildAt(0));
			this.removeEventListener(Event.ACTIVATE, onComp);
		}
	}
}