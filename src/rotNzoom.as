package
{
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.system.TouchscreenType;
	
	public class rotNzoom extends MovieClip
	{
		
		var touchPoints:int = 0;
		var touchIDs:Array = new Array();
		var distance:Number = 0;
		var touchPointArray:Array = new Array();
		var s:Boolean=true;
		
		var PI:Number=3.14159265;
		var rot:Number = 0;
		var a:int;
		var b:int;
		var mDif:Number=1.1;
		
		public function rotNzoom()
		{
			super();
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			this.addEventListener(TouchEvent.TOUCH_MOVE, this.handleTouchMove);
			//this.addEventListener(TouchEvent.TOUCH_ROLL_OUT, this.handleStopTouch);
			//this.addEventListener(TouchEvent.TOUCH_ROLL_OVER, this.handleTouch);
		}
		
		function handleTouch(e:TouchEvent)
		{
			var tempPoint:Point;
			switch(touchPoints)
			{
				case 0:
				{
					touchIDs[0]= e.touchPointID;
					tempPoint = new Point(e.stageX,e.stageY);
					touchPointArray[0] = tempPoint;
					startTouchDrag(e.touchPointID);
					break;
				}
				case 1:
				{
					touchIDs[1]= e.touchPointID;
					tempPoint = new Point(e.stageX,e.stageY);
					touchPointArray[1] = tempPoint;
					distance = getDistance (touchPointArray[0].x, touchPointArray[0].y,touchPointArray[1].x, touchPointArray[1].y );
					
					preRotation();
					
					break;
				}
				case 2:
				{
					//do nothing
					
				}
			}
			touchPoints++;
		}
		
		
		function handleTouchMove(e:TouchEvent)
		{
			
			var reCalc:Boolean=false;
			
			//If there are two touch points on the object
			if (this.touchPoints == 2)
			{		
				//if it is the first touch point, we update it
				if (e.touchPointID == this.touchIDs[0])
				{
					if(Math.abs(touchPointArray[0].x-e.stageX) > mDif || Math.abs(touchPointArray[0].y-e.stageY) > mDif )
					{
						touchPointArray[0].x = e.stageX;
						touchPointArray[0].y = e.stageY;
						reCalc=true;
					}
					
					
				}
				
				//if it is the second touch point, we update it
				if (e.touchPointID == this.touchIDs[1])
				{
					if(Math.abs(touchPointArray[1].x-e.stageX) > mDif || Math.abs(touchPointArray[1].y-e.stageY) > mDif)
					{
						touchPointArray[1].x = e.stageX;
						touchPointArray[1].y = e.stageY;
						reCalc=true;
					}
					
				}
				if(reCalc)
					handleGesture(e);
			}
			
		}
		
		function handleStopTouch(e:TouchEvent)
		{
			
			stopTouchDrag(e.touchPointID);
			this.touchPoints--;
			if(this.touchPoints<0)
				this.touchPoints=0;
		}
		
		function handleGesture(e:TouchEvent)
		{
			
			if(s)
			{
				zoom();	
				rotationf();
				s=false;
			}
			else
				s=true;
		}
		
		function zoom()
		{
			
			var tempD = getDistance (touchPointArray[0].x, touchPointArray[0].y,touchPointArray[1].x, touchPointArray[1].y );
			
			if(distance!=0)
			{
				this.scaleX = this.scaleX * (tempD/distance);
				this.scaleY = this.scaleY * (tempD/distance);
			}
			
			if(this.scaleY<0.7)
			{
				this.scaleY=0.7;
				this.scaleX=0.7;
			}
			
			if(this.scaleY>2.5)
			{
				this.scaleY=2.5;
				this.scaleX=2.5;
			}
					
			distance = tempD;
		}
		
		
		function preRotation()
		{
			var sl:Number; 	//Line slope
			
			if(touchPointArray[1].x!=touchPointArray[0].x)
			{
				sl =(touchPointArray[1].y-touchPointArray[0].y)/(touchPointArray[1].x-touchPointArray[0].x);
				rot=Math.atan(sl)*180/PI;
				if(touchPointArray[1].x>touchPointArray[0].x)
				{
					b=-180;
					a=0;
				}
				else
				{
					a=-180;
					b=0;
				}
			}
			else
			{
				if(touchPointArray[1].y-touchPointArray[0].y)
					rot=90;
				else
					rot=-90;
			}
		}
		
		function rotationf()
		{
			//Rotate...
			
			var m:Number;		//Line slope
			var tmpRot:Number;	//Angles of rotation
			
			if(touchPointArray[1].x!=touchPointArray[0].x)
			{
				if((touchPointArray[1].y-touchPointArray[0].y)/(touchPointArray[1].x-touchPointArray[0].x))
				{ 
					m =(touchPointArray[1].y-touchPointArray[0].y)/(touchPointArray[1].x-touchPointArray[0].x);
					
					if(touchPointArray[1].x>touchPointArray[0].x)
					{
						tmpRot=Math.atan(m)*(180/PI) - rot-a;
					}
					else
					{
						tmpRot=Math.atan(m)*(180/PI) - rot-b;
					}
					//tmpRot=Math.atan(m)*180/PI - rot;
					//myTextBox.text=" "+tmpRot;
					this.rotation+=tmpRot;
				}
				else
				{
					tmpRot=0;
				}
			}
			else
			{
				//this.rotation+=90-rot;
				tmpRot=0;
			}
			
			
			//Update rotation angle
			rot=tmpRot+rot;
		}
		
		function getDistance(x1:int,y1:int,x2:int,y2:int):Number
		{
			var tempD:Number;
			tempD = Math.sqrt( Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
			//myTextBox.text =  myTextBox.text + "Distance is: "  + tempD+ "\n";
			return tempD;
		}
		
		
		
	}
}






















