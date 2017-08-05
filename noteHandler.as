﻿package{import flash.display.MovieClip;import flash.display.Stage;import flash.events.Event;import flash.events.IOErrorEvent;import flash.net.URLLoader;import flash.net.URLRequest;import flash.net.navigateToURL;public class noteHandler extends MovieClip{		var notes:Array;	var sounds:Array;	var images:Array;	var loading:Array;	var onstage:Array;	var xmlURL:String="http://andriioannou.com/inter_lab/posts.xml";	var xmlLoader = new URLLoader(); 	var flag:int =0;		public function noteHandler()	{		super();		notes = new Array();		sounds = new Array();		images = new Array();		loading = new Array();		onstage = new Array();	}		public function loadNodes(newURL:String)	{		main (this.parent).startLoading();		xmlURL=newURL;				main (this.parent).log("Loading notes from: "+newURL);					xmlLoader.load(new URLRequest(xmlURL)); 				xmlLoader.addEventListener(Event.COMPLETE, this.xmlReady);		xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.LoaderError);			}		public function LoaderError(e:Event)	{		main(this.parent).loaderMsg("Error loading: "+xmlURL);	}		public function xmlReady(e:Event):void	{		xmlLoader.removeEventListener(Event.COMPLETE, this.xmlReady);		//txt.text="1";						var xml:XML = new XML(xmlLoader.data);		xml.ignoreWhitespace = true; 		var newNote:Note;		var newSound:SoundClass;		var newImage:ImageClass;		var itemData:XML;				for each( itemData in xml.elements() ) 		{			trace(itemData.name());						if(itemData.name() == "post")			{				newNote= new Note(itemData.attribute("note").toString(),itemData.attribute("name").toString(),false);				newNote.handler = this;				newNote.Initialize(itemData.attribute("note").toString(),itemData.attribute("name").toString(),false);				notes.push(newNote);			}			else if(itemData.name() == "sound")			{				newSound = new SoundClass(itemData.attribute("url").toString(),itemData.attribute("name").toString());				newSound.handler = this;				newSound.InitializeSound();				sounds.push(newSound);				loading.push(newSound);			}			else if(itemData.name() == "image")			{				var url:Array = xmlURL.split("[");								newImage = new ImageClass(itemData.attribute("url").toString(),itemData.attribute("name").toString());				newImage.handler = this;				newImage.InitializeImage(url[0]);				images.push(newImage);				loading.push(newImage);								trace("Added Image");			}		}				// add the first note on the stage if we are not waiting for something to load		if(loading.length == 0)		{			trace("From here");			main (this.parent).stopLoading();			addOnStage();		}	}		public function loadedNote(note:Note)	{		var i:int = loading.indexOf(note);				if(i>=0)loading.splice(i,1);				//everything loaded		if(loading.length == 0)		{			main (this.parent).stopLoading();			addOnStage();		}			}		public function addOnStage()	{		flag = 0;		while(flag==0 &&(notes.length>0 || sounds.length>0 || images.length>0))		{			var randomNumber : int = Math.floor(Math.random()*(3));			if(randomNumber==1 && notes.length>0) // || sounds.length>0 || images.length>0)			{				var rndNote : int = Math.floor(Math.random()*notes.length);				var tmp:Note=notes[rndNote];				notes.splice(rndNote,1);				onstage.push(tmp);								flag = 1;				addChild(tmp);				tmp.scaleX*=2;				tmp.scaleY*=2;				tmp.addEvents();						}			else if(randomNumber==2 && sounds.length>0)			{				var rndSound : int = Math.floor(Math.random()*sounds.length);				var tmpSound:SoundClass=sounds[rndSound];				sounds.splice(rndSound, 1);				onstage.push(tmpSound);								flag = 1;				tmpSound.scaleX*=2;				tmpSound.scaleY*=2;				addChild(tmpSound);				tmpSound.addEventsSound();			}					else if(randomNumber==0 && images.length>0)			{				flag = 1;				var rndImg : int = Math.floor(Math.random()*images.length);				var tmpImage:ImageClass=images[rndImg];				images.splice(rndImg,1);				onstage.push(tmpImage);								trace("Placing Image:"+tmpImage.name);								tmpImage.centerOnStage(stage.width,stage.height);								addChild(tmpImage);												tmpImage.addEventsImage();			}		}				// no more notes to choose from		if(onstage.length == 0) 		{			main (this.parent).endOfStage2();			trace("no more notes");		}	}}	}