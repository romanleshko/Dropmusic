var websocket = null;
var email = "";
var album = "";


window.onload = function() { // URI = ws://10.16.0.165:8080/WebSocket/ws
    connect('wss://' + window.location.host +'/ws/' + email);
};

function setEmail(email) {
    this.email = email;
}

function setAlbum(album) {
    this.album = album;
}


function connect(host) { // connect to the host websocket
    if ('WebSocket' in window)
        websocket = new WebSocket(host);
    else if ('MozWebSocket' in window)
        websocket = new MozWebSocket(host);
    else {
        writeNotification('Get a real browser which supports WebSocket.');
        return;
    }

    websocket.onclose   = onClose;
    websocket.onmessage = onMessage;
    websocket.onerror   = onError;
}


function onClose(event) {
    websocket.close();
    console.log("closing socket");
    websocket.close();
}



function onMessage(message) { // print the received message
    var msg = message.data;
    if (isNaN(msg.charAt(0)))
        writeNotification(msg);
    else
        writeRating(msg);
}

function onError(event) {
    websocket.close();
    writeNotification('WebSocket error.');
    websocket.close();
}

function writeNotification(text) {
    var history = document.getElementById('notifications');
    var line = document.createElement('p');
    line.style.wordWrap = 'break-word';
    line.innerHTML = text;
    history.appendChild(line);
    history.scrollTop = history.scrollHeight;
}

function writeRating(message) {
    var result = message.split('#'); // Message comes as [rating]#[albumName]#[newRating]#[reviewerEmail]#[reviewText]

    if (result[1] === album) {
        var rating = document.getElementById('avgRating');
        var reviewByUser = document.getElementById('review'+result[3]);

        var rawHTML = '<b>Rating: </b>' + result[2] + '<br/>' +
                        '<b>Email: </b>' + result[3] + '<br/>' +
                        '<b>Review: </b>' + result[4] + '<br/>';

        if (reviewByUser == null) { // i.e. if there is no review then create one
            var reviews = document.getElementById('reviews');
            var rev = document.createElement('p');
            rev.setAttribute('id', 'review'+email);
            rev.innerHTML = rawHTML;
            reviews.appendChild(rev);
        } else {
            reviewByUser.innerHTML = rawHTML;
        }
        rating.innerText = result[0];
    }
}

window.onbeforeunload = function (ev) {
    console.log("Closing socket ... unload");
    websocket.close();
}