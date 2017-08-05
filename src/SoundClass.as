package
{
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLRequestMethod;
import flash.media.Sound;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import fl.controls.Label; 

public class SoundClass extends Note
{
	
	//This variable keeps track of whether you want to play or stop the sound
	var fl_ToPlay:Boolean = true;
	var sndChannel:SoundChannel=new SoundChannel();
	var soundClip:Sound=new Sound();
			
	
	public function SoundClass(textS:String, usrS:String)
	{
		super(textS, usrS, false);
	}
	
	function InitializeSound()
	{
		soundClip.load(new URLRequest("http://helpmetest.net46.net/ideasmapping/uploads/" + txt.text));
		this.x = 1920/2;
		this.y = 1080/2;
		//addEventsSound();
		
		if (user=="player2")
		{
			this.rotation = 90;
		}
		else if(user=="player3")
			this.rotation = 180;
		else if(user=="player4")
			this.rotation = -90;
		else
			this.rotation = 0;
			
		myTextFormat.font = myFont.fontName;
				
		txt.embedFonts=true;
		txt.setTextFormat(myTextFormat);
		txt.wordWrap = false;
		txt.width=4;
		
		addChild(txt);
		
		txt.x = 0;
		txt.y = 10;
					
		//txt.border = true;
		txt.autoSize=TextFieldAutoSize.LEFT;
		txt.selectable=false;
		
		
		
		}



	function addEventsSound()
	{
		trace("Events added");
		addEventListener(TouchEvent.TOUCH_TAP, fl_ClickToPlayStopSound);
		addEventListener(TouchEvent.TOUCH_ROLL_OVER, startDragNote );
		addEventListener(TouchEvent.TOUCH_ROLL_OUT, main(this.parent.parent).stopDragSound);
	}
	
	override function addEventsInCategory()
	{
		super.addEventsInCategory();
		addEventListener(TouchEvent.TOUCH_TAP, fl_ClickToPlayStopSound);
	}


	function fl_ClickToPlayStopSound(e:TouchEvent):void
	{
		if(fl_ToPlay)
		{
			trace("Playing Sound" );
			sndChannel=soundClip.play();
		}
		else
		{
			sndChannel.stop();
			trace("Stop sound");
		}
		fl_ToPlay = !fl_ToPlay;
	}
}
}