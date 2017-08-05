﻿package  {	import flash.display.Loader;	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.net.URLRequestMethod;	import flash.events.TouchEvent;	import flash.events.Event;		public class ImageClass extends Note	{		public var myLoader:Loader = new Loader();		public var maxHeight:int = 500;		public var maxWidth:int = 900;		public var imgURL:String;				public function ImageClass(textS:String, usrS:String) {			super(textS, usrS, false);		}				function InitializeImage(url:String)		{			imgURL = url;						//myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);			var fileRequest:URLRequest = new URLRequest(imgURL+"uploads/" + txt.text);						myLoader.load(fileRequest);			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);		}					function addEventsImage()		{ 			addEventListener(TouchEvent.TOUCH_ROLL_OVER, startDragNote );			addEventListener(TouchEvent.TOUCH_ROLL_OUT, main(this.parent.parent).stopDragImage);		}				function removeEventsImage()		{			this.removeEventListener(TouchEvent.TOUCH_ROLL_OVER, startDragNote );			this.removeEventListener(TouchEvent.TOUCH_ROLL_OUT,main(this.parent.parent).stopDragImage);				}				function imageLoaded(evt:Event):void		{			trace("Loaded "+imgURL+"uploads/" + txt.text);			main(handler.parent).loaderMsg("Loaded Image: "+imgURL+"uploads/" + txt.text);			addChild(myLoader); 						handler.loadedNote(this);			//main (this.parent.parent).log("Loaded http://andriioannou.com/ideasmapping/uploads/" + txt.text);						//trace(myLoader.parent.parent.name);									//scaleImage();						//if(maxWidth!=100 && maxHeight!=100)			//{			//	this.x = 1920/2; //- myLoader.width/2;			//	this.y = 1080/2; //- myLoader.height/2;			//}									//myLoader.x = this.x;			//myLoader.y = this.y;			//addEventsImage();				/*			if (user=="player2")				this.rotation = 90;			else if(user=="player3")				this.rotation = 180;			else if(user=="player4")				this.rotation = -90;			else				this.rotation = 0;				*/		}				function scaleImage()		{			myLoader.scaleX = 1;			myLoader.scaleY = 1;						if(myLoader.width > maxWidth)			{				myLoader.width = maxWidth;				myLoader.scaleY = myLoader.scaleX;			}			if(myLoader.height > maxHeight)			{				myLoader.height = maxHeight;				myLoader.scaleX = myLoader.scaleY;			}					}				function centerOnStage(stagewidth:Number, stageheight:Number)		{			//myLoader.scaleX = 1;			//myLoader.scaleY = 1;						//arrange size of the image			//the longest side of the image to take 20% of the stage			var ratio : Number = myLoader.height/myLoader.width;			if(myLoader.width > myLoader.height)			{				//vertical allignment				if(user == "player2" || user == "player4") 					myLoader.width = stageheight*30/100 //20% of the stage				else //horizontal allignment					myLoader.width = stagewidth*20/100 //20% of the stage								myLoader.height = myLoader.width*ratio;			}			else			{				if(user == "player2" || user == "player4")					myLoader.height = stagewidth*30/100 //20% of the stage				else					myLoader.height = stageheight*20/100 //20% of the stage								myLoader.width = myLoader.height/ratio;			}										if (user=="player2")			{				this.rotation = 90;				//arrange postition of the image for p2				this.x= stagewidth/2 + myLoader.height/2; //center of the stage				this.y= stageheight/2 - myLoader.width/2; //center of the stage			}			else if(user=="player3")			{				this.rotation = 180;								//arrange postition of the image for p3				this.x= stagewidth/2 + myLoader.width/2; //center of the stage				this.y= stageheight/2 + myLoader.height/2; //center of the stage			}			else if(user=="player4")			{				this.rotation = -90;				//arrange postition of the image for p4				this.x= stagewidth/2 - myLoader.height/2; //center of the stage				this.y= stageheight/2 + myLoader.width/2; //center of the stage			}			else			{				this.rotation = 0;								//arrange postition of the image for p1				this.x= stagewidth/2 - myLoader.width/2; //center of the stage				this.y= stageheight/2 - myLoader.height/2; //center of the stage			}		}				/*		public function onLoaderReady(e:Event)		{           	// the image is now loaded, so let's add it to the display tree!           	addChild(myLoader);		}		*/	}	}