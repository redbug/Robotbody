package idv.redbug.robotbody.util
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	
	public class SoundManager
	{
		private static var _instance		:SoundManager;
		
		private const DEFAULT_VOLUME_SOUND	:Number		= 1;
		private const DEFAULT_VOLUME_MUSIC	:Number		= 1;
		
		private var _soundTable			:Dictionary;
		private var _musicTable			:Dictionary;
		private var _soundChannelTable	:Dictionary;
		private var _musicChannelTable	:Dictionary;
        private var _musicPositionTable :Dictionary;
        
		private var _soundTransform		:SoundTransform;
		private var _musicTransform		:SoundTransform;
		
		private var _so					:SharedObject;
		
	 	public function SoundManager( enforcer:SingletonEnforcer )
		{

			_soundTable 			= new Dictionary(true);
			_musicTable				= new Dictionary(true);
			_soundChannelTable 		= new Dictionary(true);
			_musicChannelTable		= new Dictionary(true);
            _musicPositionTable     = new Dictionary(true);
            
			_so = SharedObject.getLocal( "SoundManager", "/" );
			
			if ( _so.data.isExist ){
				
				_musicTransform		= new SoundTransform( _so.data.musicVolume );
				_soundTransform		= new SoundTransform( _so.data.soundVolume );  	
				  
			} 
			else{
				
				_musicTransform 	= new SoundTransform( DEFAULT_VOLUME_MUSIC );	
				_soundTransform 	= new SoundTransform( DEFAULT_VOLUME_SOUND );						
				
			  	_so.data.isExist = true;
			  	_so.data.musicVolume = DEFAULT_VOLUME_MUSIC;
			  	_so.data.soundVolume = DEFAULT_VOLUME_SOUND;
			  	
			  	_so.flush();
			  	
			}			
			
		}		
		
	 	public static function get instance():SoundManager
		{
	 		if( SoundManager._instance == null ){
	 			SoundManager._instance = new SoundManager( new SingletonEnforcer() );
	 		}
	 		
	 		return SoundManager._instance;
	 	}

		public function registerSound( index:int, sound:Sound ):void
		{
			_soundTable[ index ] = sound;
		}
		
		
		public function registerMusic( index:int, music:Sound ):void
		{
			_musicTable[ index ] = music;
		}
		
		public function clearAll():void
		{
			for ( var keyA:Object in _soundTable ){
				delete _soundTable[ keyA ];
			}
			
			for ( var keyB:Object in _musicTable ){
				delete _musicTable[ keyB ];
			}
			
			for ( var keyC:Object in _soundChannelTable ){
				_soundChannelTable[ keyC ].stop();
				delete _soundChannelTable[ keyC ];
			}
			
			for ( var keyD:Object in _musicChannelTable ){
				_musicChannelTable[ keyD ].stop();
				delete _musicChannelTable[ keyD ];
                delete _musicPositionTable[ keyD ];
			}
			
			_soundTable 			= new Dictionary( true );
			_musicTable				= new Dictionary( true );
			_soundChannelTable 		= new Dictionary( true );
			_musicChannelTable		= new Dictionary( true );
            _musicPositionTable     = new Dictionary( true );
		}	
		
		public function playSound( index:int, startTime:int = 0, loops:int = 0 ):SoundChannel
		{			
			if( _soundTable[ index ] == null ){
				throw new Error( "Sound: " + index + " does not exist!" );		
			}
			else{
				_soundChannelTable[ index ] = _soundTable[ index ].play( startTime, loops, _soundTransform );
				return _soundChannelTable[ index ];
			}
		}

		public function playMusic( index:int, startTime:int = 0, loops:int = 0 ):SoundChannel
		{			
			if( _musicTable[ index ] == null ){
				throw new Error( "Music: " + index + " does not exist!" );		
			}
			else{
				_musicChannelTable[ index ] = _musicTable[ index ].play( startTime, loops, _musicTransform );
				return _musicChannelTable[ index ];
			}
		}

		public function getSoundAt( index:int ):Sound
		{
			if( _soundTable[ index ] == null ){
				throw new Error( "Sound: " + index + " does not exist!" );
			}
			else{
				return _soundTable[ index ];
			}
		}
		
		public function getMusicAt( index:int ):Sound
		{
			if( _musicTable[ index ] == null ){
				throw new Error( "Music: " + index + " does not exist!" );
			}
			else{
				return _musicTable[ index ];
			}
		}
		
		public function getPlayingSoundChannelPosition( index:int ):Number
		{
			if( _soundTable[ index ] == null ){
				throw new Error( "Sound: " + index + " does not exist!" );
			}
			else{
				var channel:SoundChannel = _soundChannelTable[ index ] as SoundChannel;
				return channel.position;
			}
		}
		
		public function getPlayingMusicChannelPosition( index:int ):Number
		{
			if( _musicTable[ index ] == null ){
				throw new Error( "Music: " + index + " does not exist!" );
			}
			else{
				var channel:SoundChannel = _musicChannelTable[ index ] as SoundChannel;
				return channel.position;
			}
		}

		//There is an known issue that channel.position may never get to sound.length when the bitrate of a MP3 file is less than 128kbps 
//		public function isEndOfSound( index:int ):Boolean
//		{
//			if( _soundTable[ index ] == null)
//			{
//				throw new Error( "Sound: " + index + " does not exist!");
//			}else
//			{
//				var sound:Sound = _soundTable[ index ] as Sound;
//				var channel:SoundChannel = _soundChannelTable[ index ] as SoundChannel;
//				if( channel.position == sound.length)
//				{
//					return true;
//				}else{
//					trace("position:", channel.position, " length: ", sound.length);
//					return false;
//				}
//			}
//		}
		
		public function isEndOfMusic( index:int ):Boolean
		{
			if( _musicTable[ index ] == null )
			{
				throw new Error( "Music: " + index + " does not exist!" );
			}
			else{
				var sound	:Sound			= _musicTable[ index ] as Sound;
				var channel	:SoundChannel	= _musicChannelTable[ index ] as SoundChannel;
				
				if( channel.position == sound.length ){
					return true;
				}
				else{
					return false;
				}
			}
		}
		
		public function stopSound( index:int ):void
		{
			if( _soundChannelTable[ index ] != null ){
				_soundChannelTable[ index ].stop();
			}
		}
		
		public function stopMusic( index:int ):void
		{
			if( _musicChannelTable[ index ] != null ){
                _musicPositionTable[ index ] = _musicChannelTable[ index ].position; 
				_musicChannelTable[ index ].stop();
			}
		}		
        
        public function resumeMusic( index:int ):void
        {
            if( _musicChannelTable[ index ] != null ){
                playMusic( index, _musicPositionTable[ index ] );
            }
        }
        
        public function isMusicResumable( index:int ):Boolean
        {
            if( _musicChannelTable[ index ] != null ){
                return _musicChannelTable[ index ] != 0;
            }
            
            return false;
        }
		
		public function stopAllMusic():void
		{
			for each( var music:SoundChannel in _musicChannelTable ){
				music.stop();
			}
		}
		
		public function flushSoundVolume():void
		{
			_so.data.soundVolume = _soundTransform.volume;
			_so.flush();
		}
		
		public function flushMusicVolume():void
		{
			_so.data.musicVolume = _musicTransform.volume;
			_so.flush();
		}
		
		public function restoreSoundVolume():void
		{
			soundVolume = _so.data.soundVolume;
		}
		
		public function restoreMusicVolume():void
		{
			musicVolume = _so.data.musicVolume;
		}
	 	
	 	public function get soundVolume():Number
	 	{ 
	 		return _soundTransform.volume; 
	 	}

		public function set soundVolume( volume:Number ):void
		{ 
			if( volume < 0 ){
				volume = 0;
			}
			
			_soundTransform.volume = volume; 
			
			for each( var channel:SoundChannel in _soundChannelTable ){
				channel.soundTransform = _soundTransform;
			}
		}
		
		public function get musicVolume():Number
		{ 
			return _musicTransform.volume; 
		}

		public function set musicVolume( volume:Number ):void
		{
			if( volume < 0 ){
				volume = 0;
			}

			_musicTransform.volume = volume;

			for each( var channel:SoundChannel in _musicChannelTable )
			{
				channel.soundTransform = _musicTransform;
			}
		}

	}
}

class SingletonEnforcer{}