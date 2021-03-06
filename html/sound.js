var audio;

function play(audioCoords, audioRot, audioSource){
	
	audio = new Howl({
		src: audioSource,
		onplay:function(){
			$.post('http://ultra-3dsound/onStart', JSON.stringify({
				isSongPlaying: true})
		)},
		onstop: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false})
		)},
		onend: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false})
		)},
		onloaderror: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false})
		)},
		onplayerror: function(){
			$.post('http://ultra-3dsound/onEnd', JSON.stringify({
				isSongPlaying: false})
		)}
	});
	
	audio.pos(audioCoords.x,audioCoords.y,audioCoords.z);
	audio.orientation(audioRot.x,audioRot.y,audioRot.z)
	audio.volume(0.5);
	audio.play();
	audio.pannerAttr({
			panningModel: 'equalpower',
			refDistance: 0.01,
			rolloffFactor: 40,
			distanceModel: 'linear'
	})	
}

function updateListerPos(pedCoord,pedRot,isMute){ 
	audio.mute(isMute)
	Howler.pos(pedCoord.x,pedCoord.y,pedCoord.z);
	Howler.orientation(pedRot.x ,pedRot.y,pedRot.z,0, 1, 0);	
}

window.addEventListener('message', function(event) {
    if (event.data.transactionType == "start") {
    	play(event.data.audioCoord, event.data.audioRot, event.data.audioSource);
    }
	
    if (event.data.transactionType == "update") {
	    updateListerPos(event.data.pedCoord, event.data.pedRot,event.data.mute);
    }
    
	if (event.data.transactionType == "stop") {
		audio.stop()
    }
	
	if (event.data.transactionType == "mute") {
		audio.mute(true)
    }
})