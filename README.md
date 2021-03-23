# ultra-3dsound
Template resource for setting spatial audio in FiveM GTA5 mod

#Preview 
- Uses player camera rotation for spatial effect: [Video 1](https://www.youtube.com/watch?v=Asoa9LmcTs4) 
- Uses ped rotation for spatial effect: [Video 2](https://www.youtube.com/watch?v=Ng7Bn20WuKQ) 

#Performance
![image](https://user-images.githubusercontent.com/43913907/112118752-b0340100-8be2-11eb-86a6-4f76e19c1d69.png)
0.00ms when audio is not playing

#Usage
The resource comes with server exports so that you can have the taste of spatial audio.
**Export 1:**
exports['ultra-3dsound']:playSound(source,audioSource,audioCoords,audioRotation)
This :arrow_up: export is used to play audio at specified coord and accepts 4 parameters.
-source is the player source on which action needs to be performed on.
-audioSource being the path of the audio file. You can either pass ./audio.mp3 and it will play a local file stored in html folder of project directory or you can pass a RAW URL of mp3, mpeg, opus, ogg, oga, wav, aac, caf, m4a, m4b, mp4, weba, webm, dolby or flac file. Example: If your file is hosted on localhost:8080/file.mp3 you will pass https://localhost:8080/file.mp3
-audioCoords being vector3 coords at which the audio will be played
-audioRotation being vector3 rotation of the audio

**Export 2:**
exports['ultra-3dsound']:stopSound(source)
This :arrow_up: export stops the playing sound
I’ve added a distance check to limit the audio range in this version. You can modify the range in 3dsound:playSound client event

## Please read the LICENSE carefully before using it.
