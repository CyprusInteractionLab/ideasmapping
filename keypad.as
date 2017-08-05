package
{
	
	
	import fl.controls.Button;
	import fl.motion.Color;
	
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
	
	public class keypad extends MovieClip
	{
		
		
		var txt:TextField;
		var screen:int=1;
		var dad:Category= Category (parent);
		var noteMaxChar:int = 50;
		var categMaxChar:int = 20;
		var charNum:int ;
		
		var myFont:Font = new btnFont();
		var myTextFormat:TextFormat = new TextFormat();
		
		
		
		public function keypad(iTxt:TextField):void
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
		
		function shiftKey(e:MouseEvent):void
		{
			
			if(screen==1)
			{
				screen=2;
				gotoAndStop(screen);
				addEventListenersFrame2();
			}
			else
			{
				screen=1;
				gotoAndStop(screen);
				addEventListenersFrame1();
				
			}
			
			
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
				if (main(this.parent.parent).screenDimActive==true)
				{
					main(this.parent.parent).removeChild(main(this.parent.parent).screenDim);
					main(this.parent.parent).screenDimActive=false;
					trace('screen dim exists and must be removed!');
				}
				txt.type = TextFieldType.DYNAMIC;
				this.visible=false;
				
				if(this.parent is Category)
				{
					Category(this.parent).isSet=true;
					main(this.parent.parent).setChildIndex(Category(this.parent), main(this.parent.parent).CategoryArray.length);
					Category(this.parent).charLeft.text = "";
					Category(this.parent).categoryName = Category(this.parent).catName.text;
					Category(this.parent).editBtn.visible = true;
					Category(this.parent).editBtn.addEventListener(TouchEvent.TOUCH_TAP,Category(this.parent).editCategoryTitle);
					
					//log event
					main(this.parent.parent).log('Category "'+Category(this.parent).categoryName+'" added.');
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
			if(main(this.parent.parent).screenDimActive==false)
			{
				Category(this.parent).catName.text = Category(this.parent).categoryName;
				this.visible=false;
				//log event
				main(this.parent.parent).log('Category "'+Category(this.parent).categoryName+'" added.');
			}
			else
			{
				e.target.setStyle("emphasizedPadding", 1);
			
				//Cancel Category creation
				main(this.parent.parent).removeChild(main(this.parent.parent).screenDim);
				main(this.parent.parent).screenDimActive==false;
				this.visible=false;
				if(this.parent is Category)
				{
					Category(this.parent).visible=false;
					Category(this.parent).catState = "Cancelled";
				}
				if(this.parent is ManualNote)
					ManualNote(this.parent).visible=false;
				trace('Cancel category creation!');
				
				//log event
				main(this.parent.parent).log('Category Addition Cancelled.');
			}
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