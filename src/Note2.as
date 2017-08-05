package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Note2 extends MovieClip
	{
		public var myCategory:Category;
		
		public function Note()
		{
			super();
			
		}
		
		function addEvents(){
			addEventListener(MouseEvent.MOUSE_DOWN, startDragNote );
			addEventListener(MouseEvent.MOUSE_UP,main(this.parent).stopDragNote);
		}
		
		function startDragNote(e:MouseEvent)
		{
			trace('drag note');
			this.startDrag();
		}
		
		/*
		function stopDragNote(e:MouseEvent)
		{
			e.target.stopDrag();
			if (true) //this.hitTestObject()==true)    //this.hitTestObject(myDropbox))
			{
				this.alpha = 0.5 ;
				this.scaleX = this.scaleX / 1.5;
				this.scaleY = this.scaleY / 1.5;
				removeEventListener(MouseEvent.MOUSE_DOWN, startDragNote);
				removeEventListener(MouseEvent.MOUSE_UP, stopDragNote);
			}
		}
		*/
	}
}