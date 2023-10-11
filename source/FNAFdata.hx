package;

#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

typedef FNAFfile =
{
	// JSON variables
	var songs:Array<Dynamic>;
	var unlockProgress:Array<Int>;
	var needSecretCode:Bool;
	var secretCode:String;
}

class FNAFdata 
{
	public static var fnafFilesLoaded:Map<String, FNAFdata> = new Map<String, FNAFdata>();
	public static var fnafList:Array<String> = [];
	public var folder:String = '';
  
	// JSON variables
	public var songs:Array<Dynamic>;
	public var unlockProgress:Array<Int>;
	public var needSecretCode:Bool;
	public var secretCode:String;
	public var fileName:String;
  
	public function new(fnafFile:FNAFfile, fileName:String) 
	{
		songs = fnafFile.songs;
		unlockProgress = fnafFile.unlockProgress;
		needSecretCode = fnafFile.needSecretCode;
		secretCode = fnafFile.secretCode;
		this.fileName = fileName;
	}

	public static function createFNAFfile():FNAFfile 
	{
	  	var fnafFile:FNAFfile = {
			songs: [
				["taken-apart"],
				["retribution"],
				["fear-forever"],
				["everlasting"],
				["brain-damage"],
				["party-room"],
				["totally-real"],
				["last-hour"],
				["waffles"],
				["leantrap"],
				["endo-revengo"],
				["misconception"],
				["out-of-bounds"],
				["until-next-time"]
			],
			unlockProgress: [],
			needSecretCode: false,
			secretCode: ""
		};
	 	return fnafFile;
	}
  
	public static function formatSong(song:String, diff:Int):String 
	{
		return Paths.formatToSongPath(song) + CoolUtil.getDifficultyFilePath(diff);
	}
	
	public static function getProgress(song:String, diff:Int):Int 
	{
		var daSong:String = formatSong(song, diff);
		if (!unlockProgress.exists(daSong))
			setProgress(daSong, 0);
	
		return unlockProgress.get(daSong);
	}

	public static function saveProgress(song:String, ?diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		setProgress(daSong, 0);
		unlockNextSong(song, diff);
	}

	public static function setProgress(song:String):Void
	{
		unlockProgress.set(song, 0);
		FlxG.save.data.unlockProgress = unlockProgress;
		FlxG.save.flush();
	}

	public static function unlockNextSong(song:String, diff:Int):Void
	{
		var daSong:String = formatSong(song, diff);
		var currentIndex:Int = -1;

		// Find the index of the current song
		for (i in 0...songs.length) {
			var songArray:Array<String> = songs[i];
			if (songArray.length > 0 && songArray[0] == daSong) {
				currentIndex = i;
				break;
			}
		}

		// If the current song is found and its progress is sufficient, unlock the next song
		if (currentIndex >= 0 && currentIndex < songs.length - 1) {
			var nextSongArray:Array<String> = songs[currentIndex + 1];
			var nextSong:String = nextSongArray[0];
			if (!unlockProgress.exists(formatSong(nextSong, diff))) {
				setProgress(formatSong(nextSong, diff), 0);
			}
		}
	}

	public static function load():Void
	{
		if (FlxG.save.data.unlockProgress != null)
		{
			unlockProgress = FlxG.save.data.unlockProgress;
		}
	}
}