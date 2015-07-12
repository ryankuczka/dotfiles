// GLOBAL CONFIGS
slate.configAll({
    'defaultToCurrentScreen': true
});

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
var throwToScreen = function(direction) {
    return function() {
        var nextScreenId = slate.screen().id() + direction * 1;
        slate.log(nextScreenId);
        if (nextScreenId < 0) {
            nextScreenId = 0;
        } else if (nextScreenId > slate.screenCount()) {
            nextScreenId = slate.screenCount();
        }
        slate.operation('sequence', {
            'operations': [
                slate.operation('throw', {'screen': nextScreenId}),
                fullScreen
            ]
        }).run();
    };
};

slate.bindAll({
    'left:cmd,ctrl': throwToScreen(-1),
    'right:cmd,ctrl': throwToScreen(1)
});

// APP SWITCHING
var focusApp = function(app) {
    return slate.operation('focus', {'app': app});
};

var toggleMacvimIterm = function(winObj) {
    if (winObj && winObj.app().name() === 'MacVim') {
        focusApp('iTerm2').run();
    } else {
        focusApp('MacVim').run();
    }
};

var switchItermWins = function(winObj) {
    if (winObj && winObj.app().name() === 'iTerm2') {
        if (winObj.screen().id() === 2) {
            slate.operation('focus', {'direction': 'left'}).run();
        } else {
            slate.operation('focus', {'direction': 'right'}).run();
        }
    } else {
        focusApp('iTerm2').run();
    }
};


slate.bindAll({
    'm:space,ctrl': focusApp('MacVim'),
    'i:space,ctrl': focusApp('iTerm2'),
    'space:space,ctrl': toggleMacvimIterm,
    'c:space,ctrl': focusApp('Google Chrome'),
    's:space,ctrl': focusApp('Slack'),
    'f:space,ctrl': focusApp('Finder'),
    'g:space,ctrl': focusApp('Radiant Player'),
    'r:space,ctrl': slate.operation('relaunch'),
    'h:space,ctrl': slate.operation('hint', {'characters': 'asdfghjkl'})
});
