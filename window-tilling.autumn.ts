/**
 * Welcome to Autumn!
 * Here's some sample code to get you started.
 * Click the Play button to try it out!
 */
// console.log(11)
// alert('Running Autumn!');

// Modifier keys are strongly typed to prevent typos
const cmdOptCtrl: ModString[] = ['command', 'option', 'control']
const STEP_SIZE = 20;
let moveToRightActive = false;
let moveToLeftActive = false;

enum Direction {
  Right = "RIGHT",
  Left = "LEFT",
  Middle = "MIDDLE",
}

interface SplitScreen {
  left?: Window,
  right?: Window,
 }

Hotkey.activate(cmdOptCtrl, '.', () => {
  if (!moveToLeftActive) {
    moveToLeftActive = true;
    moveSideBySideWindowsToLeft();
      moveToLeftActive = false;
  }
});

Hotkey.activate(cmdOptCtrl, '/', () => {
  if (!moveToRightActive) {
    moveToRightActive = true; 
    moveSideBySideWindowsToRight();
    moveToRightActive = false; 
  }
});

function moveSideBySideWindowsToLeft() { 
  const { left, right } = getLeftAndRightWindow();

  if (left) { 
    const size = left.size();
    if ((size.width - STEP_SIZE) <= 501) return;
  
    left.setSize({
      height: size.height,
      width: size.width - STEP_SIZE,
    });
    console.log('left')
  }

  if (right) {
    const size = right.size()
    if (size.width + STEP_SIZE >= 1175) return;

    const position = right.position();
    right.setPosition({
      y: position.y,
      x: position.x - STEP_SIZE
    });
    right.setSize({
      height: size.height,
      width: size.width + STEP_SIZE,
    });
  }
}

function moveSideBySideWindowsToRight() {
  const { left, right } = getLeftAndRightWindow();

  if (left) {
    const size = left.size()
    if ((size.width + STEP_SIZE) >= 1175) return;

    const position = left.position();
    left.setSize({
      height: size.height,
      width: size.width + STEP_SIZE,
    });
  }

  if (right) {
    const size = right.size();
    if ((size.width - STEP_SIZE) <= 500) return;
    right.setSize({
      height: size.height,
      width: size.width - STEP_SIZE,
    });
    const position = right.position();
    right.setPosition({
      y: position.y,
      x: position.x + STEP_SIZE
    });
  }
}

function getLeftAndRightWindow(): SplitScreen {
  const splitScreen: SplitScreen = {};
  let allWindows = Window.allWindows();
  // last window is always fake
  allWindows = Window.allWindows().splice(0, allWindows.length - 1);

  allWindows.forEach((window) => {
    const hasLeftMostWindow = !splitScreen.left && window.position().x === 0;
    if (hasLeftMostWindow) {
      splitScreen.left = window;
      return;
    }

    const hasRightMostWindow =
      !splitScreen.right &&
      (window.size().width + window.position().x) === 1680 &&
      window.isVisible();
    if (hasRightMostWindow) {
      splitScreen.right = window;
      return;
    }
  });

  return splitScreen;
}