let audio = {}

function play(audioCoords, audioRot, audioSource, uid){
	audio[uid] = {}
	audio[uid] = new Howl({
		src: audioSource,
		onplay:function(){
			$.post('http://ultra-3dsound/onStart', JSON.stringify({
				isSongPlaying: true, uid: uid})
		)},
		onstop: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false, uid: uid})
		)},
		onend: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false, uid: uid})
		)},
		onloaderror: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false, uid: uid})
		)},
		onplayerror: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false, uid: uid})
		)}
	});
	
	audio[uid].pos(audioCoords.x,audioCoords.y,audioCoords.z);
	audio[uid].orientation(audioRot.x,audioRot.y,audioRot.z);
	audio[uid].volume(0.5);
	audio[uid].play();
	audio[uid].mute(true);
	audio[uid].pannerAttr({
			panningModel: 'equalpower',
			refDistance: 0.01,
			rolloffFactor: 40,
			distanceModel: 'linear'
	})	
}

function updateListerPos(pedCoord,pedRot){ 
	Howler.pos(pedCoord.x,pedCoord.y,pedCoord.z);
	Howler.orientation(pedRot.x ,pedRot.y,pedRot.z,0, 1, 0);
}

window.addEventListener('message', function(event) {
    if (event.data.transactionType == "start") {
    	play(event.data.audioCoord, event.data.audioRot, event.data.audioSource, event.data.uid);
    }
	
    if (event.data.transactionType == "update") {
		updateListerPos(event.data.pedCoord, event.data.pedRot);
    }
    
	if (event.data.transactionType == "stop") {
		audio[event.data.uid].stop()
    }
	
	if (event.data.transactionType == "mute") {
		audio[event.data.uid].mute(true)
    }

	if (event.data.transactionType == "unmute") {
		audio[event.data.uid].mute(false)
    }
})