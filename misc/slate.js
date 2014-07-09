// Global configs
S.configAll({
    'defaultToCurrentScreen': true
});

var fullScreen = S.operation('move', {
    'x': 'screenOriginX',
    'y': 'screenOriginY',
    'width': 'screenSizeX',
    'height': 'screenSizeY'
});
var halfTop = fullScreen.dup({'height': 'screenSizeY/2'});
var halfLeft = fullScreen.dup({'width': 'screenSizeX/2'});
var halfBottom = halfTop.dup({'y': 'screenOriginY+(screenSizeY/2)'});
var halfRight = halfLeft.dup({'x': 'screenOriginX+(screenSizeX/2)'});

var topMost = fullScreen.dup({'height': 'screenSizeY*2/3'});
var bottomLeast = fullScreen.dup({'y': 'screenOriginY+(screenSizeY*2/3)', 'height': 'screenSizeY/3 - 5'});

S.bindAll({
    'right:cmd,alt': halfRight,
    'up:cmd,alt': halfTop,
    'left:cmd,alt': halfLeft,
    'down:cmd,alt': halfBottom,
    'f:cmd,alt': fullScreen,
    'up:ctrl,alt': topMost,
    'down:ctrl,alt': bottomLeast
});
