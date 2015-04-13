// GLOBAL CONFIGS
slate.configAll({
    'defaultToCurrentScreen': true
});
var monLaptop = '1440x900',
    monDell = '1920x1200';

// WINDOW RESIZING
var fullScreen = slate.operation('corner', {
    'direction': 'top-left',
    'height': 'screenSizeY',
    'width': 'screenSizeX'
});
var topHalf = fullScreen.dup({'height': 'screenSizeY/2'}),
    leftHalf = fullScreen.dup({'width': 'screenSizeX/2'}),
    rightHalf = leftHalf.dup({'direction': 'top-right'}),
    bottomHalf = topHalf.dup({'direction': 'bottom-left'});

var topMost = topHalf.dup({'height': 'screenSizeY*2/3'}),
    bottomLeast = bottomHalf.dup({'height': 'screenSizeY/3 - 5'});

slate.bindAll({
    'right:cmd,alt': rightHalf,
    'up:cmd,alt': topHalf,
    'left:cmd,alt': leftHalf,
    'down:cmd,alt': bottomHalf,
    'f:cmd,alt': fullScreen,
    'up:ctrl,alt': topMost,
    'down:ctrl,alt': bottomLeast
});

// WINDOW MOVEMENT
var throwToScreen = function(screen) {
    return slate.operation('sequence', {
        'operations': [
            slate.operation('throw', {'screen': screen}),
            fullScreen
        ]
    });
};

slate.bindAll({
    'left:cmd,ctrl': throwToScreen(monLaptop),
    'right:cmd,ctrl': throwToScreen(monDell)
});

// APP SWITCHING
var focusApp = function(app) {
    return slate.operation('focus', {'app': app});
};

slate.bindAll({
    'm:space,ctrl': focusApp('MacVim'),
    'i:space,ctrl': focusApp('iTerm'),
    'c:space,ctrl': focusApp('Google Chrome'),
    'f:space,ctrl': focusApp('Finder'),
    'r:space,ctrl': slate.operation('relaunch'),
    'h:space,ctrl': slate.operation('hint', {'characters': 'asdfghjkl'})
});
