package
{
	
	
	import fl.controls.Button;
	import fl.motion.Color;
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.ColorTransform;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class keypad2 extends MovieClip
	{
		
		var txt:TextField;
		var screen:int=1;
		var prev_screen:int=1;
		var dad:Category= Category (parent);
		var noteMaxChar:int = 50;
		var categMaxChar:int = 20;
		var charNum:int ;
		
		var myFont:Font = new btnFont();
		var myTextFormat:TextFormat = new TextFormat();
		
		
		
		public function keypad2(iTxt:TextField):void
		{
			
			super();
			
			//stop the clip on frame 1
			gotoAndStop(1);
			myTextFormat.font = myFont.fontName;
			addEventListenersFrame1();
			
			txt=iTxt;
			txt.text = "";
			//if this keypad corresponds to a category then make the edit btn non-visible
			if(this.parent is Category)
			{
				Category(this.parent).editBtn.visible = false;
				trace('edit btn not visible');
			}
			else{
				trace('edit btn visible');
			}
			addEventListenersGeneral();
			
		}
		
		function addEventListenersGeneral():void
		{
			lang_btn.addEventListener(MouseEvent.CLICK, languageKey);
			lang_btn.setStyle("embedFonts", true);
			lang_btn.setStyle("textFormat", myTextFormat);
			
			caps_btn.addEventListener(MouseEvent.CLICK, capsKey);
			caps_btn.setStyle("embedFonts", true);
			caps_btn.setStyle("textFormat", myTextFormat);
			
			shift_btn.addEventListener(MouseEvent.CLICK, shiftKey);
			shift_btn.setStyle("embedFonts", true);
			shift_btn.setStyle("textFormat", myTextFormat);
			
			space_btn.addEventListener(MouseEvent.CLICK, spaceKey);
			space_btn.setStyle("embedFonts", true);
			space_btn.setStyle("textFormat", myTextFormat);
			
			enter_btn.addEventListener(MouseEvent.CLICK, enterKey);
			enter_btn.setStyle("embedFonts", true);
			enter_btn.setStyle("textFormat", myTextFormat);
			
			min_btn.addEventListener(MouseEvent.CLICK, minKey);
			min_btn.setStyle("embedFonts", true);
			min_btn.setStyle("textFormat", myTextFormat);
			
			finish_btn.addEventListener(MouseEvent.CLICK, finishKey);
			finish_btn.setStyle("embedFonts", true);
			finish_btn.setStyle("textFormat", myTextFormat);
			//finish_btn.transform.colorTransform =new ColorTransform(0,1,0,1);
			
			backspace_btn.addEventListener(MouseEvent.CLICK, backspaceKey);
			backspace_btn.setStyle("embedFonts", true);
			backspace_btn.setStyle("textFormat", myTextFormat);
			
			clear_btn.addEventListener(MouseEvent.CLICK, clearKey);
			clear_btn.setStyle("embedFonts", true);
			clear_btn.setStyle("textFormat", myTextFormat);
			
			btn1.addEventListener(MouseEvent.CLICK, typeKey);
			btn1.setStyle("embedFonts", true);
			btn1.setStyle("textFormat", myTextFormat);
			
			btn2.addEventListener(MouseEvent.CLICK, typeKey);
			btn2.setStyle("embedFonts", true);
			btn2.setStyle("textFormat", myTextFormat);
			
			background.addEventListener(MouseEvent.MOUSE_DOWN, startDragPad);
			background.addEventListener(MouseEvent.MOUSE_UP, stopDragPad);
			
		}
		
		function addTxtKeyEventListeners(j:uint):void
		{
			for (var i:uint=1;i<=26;i++) 
			{
				trace("Gettingchild btn"+j+"_"+i+":"+getChildByName("btn"+j+"_"+i));
				getChildByName("btn"+j+"_"+i).addEventListener(MouseEvent.CLICK, typeKey);
				Button (getChildByName("btn"+j+"_"+i)).setStyle("embedFonts", true);
				Button (getChildByName("btn"+j+"_"+i)).setStyle("textFormat", myTextFormat);
			}
		}
		
		function addEventListenersFrame1():void
		{
			for (var i:uint=1;i<=26;i++) 
			{
				getChildByName("btn1_"+i).addEventListener(MouseEvent.CLICK, typeKey);
				Button (getChildByName("btn1_"+i)).setStyle("embedFonts", true);
				Button (getChildByName("btn1_"+i)).setStyle("textFormat", myTextFormat);
			} 
			
		}
		
		function addEventListenersFrame2():void
		{
			for (var i:uint=1;i<=26;i++) 
			{
				getChildByName("btn2_"+i).addEventListener(MouseEvent.CLICK, typeKey);
				Button (getChildByName("btn2_"+i)).setStyle("embedFonts", true);
				Button (getChildByName("btn2_"+i)).setStyle("textFormat", myTextFormat);
			} 
			
		}
		
		function addEventListenersFrame3():void
		{
			for (var i:uint=1;i<=26;i++) 
			{
				getChildByName("btn3_"+i).addEventListener(MouseEvent.CLICK, typeKey);
				Button (getChildByName("btn3_"+i)).setStyle("embedFonts", true);
				Button (getChildByName("btn3_"+i)).setStyle("textFormat", myTextFormat);
			} 
			
		}
		
		function shiftKey(e:MouseEvent):void
		{
			
			if(screen!=2)
			{
				prev_screen = screen;
				screen=2;
				gotoAndStop(screen);
				//addEventListenersFrame2();
			}
			else
			{
				screen=prev_screen;
				gotoAndStop(screen);
				/*
				if (screen == 1 )
					addEventListenersFrame1();
				else
					addEventListenersFrame3();
					*/
			}
			
			addTxtKeyEventListeners(screen);
			
		}
		
		function languageKey(e:MouseEvent):void
		{
			
			switch(screen)
			{
				case 1:
					screen = 4;
					break;
				case 3:
					screen = 5;
					break;
				case 4:
					screen = 1;
					break;
				case 5:
					screen = 3;
					break;
			}
			
			gotoAndStop(screen);
			addTxtKeyEventListeners(screen);
			
		}
		
		function capsKey(e:MouseEvent):void
		{
			switch(screen)
			{
				case 1:
					screen = 3;
					break;
				case 3:
					screen = 1;
					break;
				case 4:
					screen = 5;
					break;
				case 5:
					screen = 4;
					break;
			}
			
			gotoAndStop(screen);
			addTxtKeyEventListeners(screen);
			/*
			if(screen==1)
			{
				screen=3;
				gotoAndStop(screen);
				addEventListenersFrame3();
			}
			else
			{
				screen=1;
				gotoAndStop(screen);
				addEventListenersFrame1();
			}
			*/
			
		}
		
		function typeKey(e:MouseEvent):void
		{
			if(this.parent is Category)
			{
				
				if (txt.text.length<categMaxChar)
				{
					txt.appendText(e.target.label);
					charNum = categMaxChar-txt.text.length;
					Category(this.parent).charLeft.text =  charNum.toString();
				}
			}
			else if(this.parent is ManualNote)
			{
				if (txt.text.length<noteMaxChar)
				{
					txt.appendText(e.target.label);
					charNum = noteMaxChar-txt.text.length;
					ManualNote(this.parent).charLeft.text =  charNum.toString();

				}
			}
			
		}
		
		function spaceKey(e:MouseEvent):void
		{
			if(this.parent is Category)
			{
				if (txt.text.length<categMaxChar)
				{
					txt.appendText(" ");
					charNum = categMaxChar-txt.text.length;
					Category(this.parent).charLeft.text =  charNum.toString();
				}
			}
			else if (this.parent is ManualNote)
			{
				if (txt.text.length<noteMaxChar)
				{
					txt.appendText(" ");
					charNum = noteMaxChar-txt.text.length;
					ManualNote(this.parent).charLeft.text =  charNum.toString();
				}
			}
			
		}
		
		function enterKey(e:MouseEvent):void
		{
			//if category name not empty
			if(txt.text != "")
			{
				main(this.parent.parent).removeChild(main(this.parent.parent).screenDim);
			
				txt.type = TextFieldType.DYNAMIC;
				this.visible=false;
				
				if(this.parent is Category)
				{
					Category(this.parent).isSet=true;
					main(this.parent.parent).setChildIndex(Category(this.parent), main(this.parent.parent).CategoryArray.length);
					Category(this.parent).charLeft.text = "";
				}
				
				if(this.parent is ManualNote)
				{
					ManualNote(this.parent).isSet=true;
					ManualNote(this.parent).charLeft.text = "";
				}
				
			}
		}
		
		function backspaceKey(e:MouseEvent):void
		{
			txt.text= txt.text.substring(0, txt.text.length-1);
			if(this.parent is Category){
				
				if(txt.text.length<categMaxChar)
				{
					charNum = categMaxChar-txt.text.length;
					Category(this.parent).charLeft.text =  charNum.toString();
				}				
			}
			else if(this.parent is ManualNote){
				if(txt.text.length<noteMaxChar)
				{
					charNum = noteMaxChar-txt.text.length;
					ManualNote(this.parent).charLeft.text =  charNum.toString();
				}
			}
		}
		
		function clearKey(e:MouseEvent):void
		{
			txt.text="";
			if(this.parent is Category){
				charNum = categMaxChar;
				Category(this.parent).charLeft.text =  charNum.toString();
			}
			else if(this.parent is ManualNote){
				charNum = noteMaxChar;
				ManualNote(this.parent).charLeft.text =  charNum.toString();
			}
		}
		
		function minKey(e:MouseEvent):void
		{
			
			this.visible=false;
		}
		
		function finishKey(e:MouseEvent):void
		{
			e.target.setStyle("emphasizedPadding", 1);
			
			//Cancel Category creation
			main(this.parent.parent).removeChild(main(this.parent.parent).screenDim);
			this.visible=false;
			if(this.parent is Category)
				Category(this.parent).visible=false;
			
			if(this.parent is ManualNote)
				ManualNote(this.parent).visible=false;
			trace('Cancel category creation!');
			/*
			if(dad.finished==false)
			{
				//dad.finished=true;
				e.target.emphasized = true;
				finish_btn.transform.colorTransform =new ColorTransform(1,0,0,1);
				
			}
			else
			{
				//dad.finished=false;
				e.target.emphasized = false;
				finish_btn.transform.colorTransform =new ColorTransform(0,1,0,1);
			}
			*/
		}
		
		function startDragPad(e:MouseEvent)
		{
			this.startDrag();
		}
		
		function stopDragPad(e:MouseEvent)
		{
			this.stopDrag();
		}
		
		
	}
	

}