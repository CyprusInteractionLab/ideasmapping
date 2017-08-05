﻿package{	import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.events.TouchEvent;	import flash.text.Font;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFieldType;	import flash.text.TextFormat;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode;		public class Category extends rotNzoom	{				var keyboard:MultiLangKeypad;//= new keypad(catName);		var myFont:Font = new btnFont();		var myTextFormat:TextFormat = new TextFormat();		var isSet:Boolean = false;		var catState:String = "Active";		var catTrash:Boolean = false;		var numOfChildrenOnInitialization;		var kidSelected:Boolean =  false;		var categoryName:String = new String();		//var noteList[]:Note;				public function Category()		{			super();			trace('Create category');						// attach a keyboard to the category			attachKeyboard();						myTextFormat.font = myFont.fontName;						this.addEvents();						numOfChildrenOnInitialization=this.numChildren;		}				public function attachKeyboard()		{			keyboard= new MultiLangKeypad(catName);			keyboard.txt=catName;			addChild(keyboard);			keyboard.scaleX*=2;			keyboard.scaleY*=2;		}				public function editCategoryTitle()		{			// it is editable 			this.editBtn.visible = false;			this.editBtn.addEventListener(TouchEvent.TOUCH_TAP, function(e:TouchEvent){editCategoryTitle();});			this.editBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){editCategoryTitle();});						// add the dim screen to the parent			main(this.parent).addScreenDim();			parent.setChildIndex(this, parent.numChildren-1);						// show keyboard			keyboard.startType();						setChildIndex(this.keyboard,numChildren-1);		}				public function doneTyping()		{			this.isSet=true;						this.charLeft.text = "";			this.categoryName = this.catName.text;						// show edit button			this.editBtn.visible = true;								this.parent.setChildIndex(this, main(this.parent).CategoryArray.length);			main(this.parent).removeScreenDim();						//log event			main(this.parent).log('Category "'+this.categoryName+'" edited.');		}				public function cancelTyping()		{			// show edit button			this.editBtn.visible = true;						if(this.categoryName == "")			{				this.visible = false;			}						main(this.parent).removeScreenDim();		}				function addEvents()		{			addEventListener(TouchEvent.TOUCH_BEGIN, startDragCateg );			addEventListener(TouchEvent.TOUCH_ROLL_OUT, stopDragCateg);		}				public function startDragCateg(e:TouchEvent)		{			trace('drag category');						if (this == e.target || this.bg==e.target || this.catName == e.target)				handleTouch(e);				//startTouchDrag(e.touchPointID);								if(isSet)			{				trace('is set');				main(this.parent).setChildIndex(this, main(this.parent).CategoryArray.length);			}					}				public function stopDragCateg(e:TouchEvent)		{			trace('stop drag category');			if (this == e.target|| this.bg==e.target || this.catName == e.target){				handleStopTouch(e);								if(!(this is Trash)&& isSet && !kidSelected)				{										if(main(this.parent).trashCan.visible==true && this.numChildren==numOfChildrenOnInitialization)					{						if(main(this.parent).trashCan.hitTestPoint(e.stageX,e.stageY,true)==true)						{							this.catState = "Removed";							this.parent.removeChild(this);							main (this.parent).log('Category "'+this.categoryName+'"Removed.');						}						else if(main(this.parent).trashCan2.hitTestPoint(e.stageX,e.stageY,true)==true)						{							this.catState = "Removed";							this.parent.removeChild(this);							main (this.parent).log('Category "'+this.categoryName+'"Removed.');						}					}				}				this.kidSelected = false;							}						}				//TODO: arrange children in a grid		public function arrangeChildren()		{			var xCord,yCord:int;						xCord = this.x;			yCord = this.y;						for(var i:int=0; i<this.numChildren; i++)			{				this.getChildAt(i).x = xCord;				this.getChildAt(i).y = yCord;								xCord = xCord+this.getChildAt(i).width;				if(xCord>this.bg.width)				{					xCord = this.x;					yCord = yCord +100;				}			}		}				// set category placement on canvas		public function setPlacement(cx:int, cy:int, r:int = 0)		{			this.rotation=r;			this.x = cx;			this.y = cy;		}			}}