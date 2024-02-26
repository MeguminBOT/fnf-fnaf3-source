Please refrain from doing unofficial MOD FOLDER PORTS for atleast 2 months.
Doing it for private use is totally fine, but wait a bit with the public. 

You can fork as you please and help contributing to fix bugs or port to other OSes and devices.

Official VS FNAF 3 Source:
https://github.com/MeguminBOT/fnf-fnaf3-source

---------------------------------------------------------------------------

If you're trying to port, please don't hog the credits for yourself.
You can contact @AutisticLulu on Discord and we'll work your port out as a official version.

Mod uses a lot of custom lua conditions and several hardcoded + half-hardcoded things.

------ Things to expect for mod folder ports ------ 
* Videos will be broken. 
	- We are using ".webm" with the "vp9" and "opus" codecs instead of ".mp4" which uses "avc" and "aac" codecs.
	- We are using the hxvlc library instead of hxcodec.
	- Custom camera objects being used for some videos.

* Stages will be broken. 
	- Some stages has videos as their background sprite, this is not officially supported on official Psych Engine.
	- Custom camera objects being used for some sprites.

* Mangle Event, Tablet Event and Red Flashing Event are hardcoded.


------ Things to expect for HTML5 web browser ports ------
* Videos MAY be broken. 
	- We are using ".webm" with the "vp9" and "opus" codecs instead of ".mp4" which uses "avc" and "aac" codecs.
		- This should actually be helpful for HTML5 ports if you manage to get videos properly working on HTML5.
	- We are using the hxvlc library instead of hxcodec.

* Mod relies on savefiles and sys libs to be able to access stuff.
	- Like the FreeplayState for example. It wont work without fixes.

* Game will likely be laggy.
	
--------------------------------------------------------------
