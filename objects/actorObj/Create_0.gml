/// @description Insert description here
// You can write your code in this editor
moveX = 0;
speedX = 0;
reminderX = 0;

moveY = 0;
speedY = 0;
reminderY = 0;

//This game runs at 15fps, our original values are thought for 60
maxSpeed = 1;
wallJumpSpeed = 1 * 2.5; //1 == maxSpeed
acceleration = .4;

active = true;
collision = false;

var tile = 8;
var maxWidth = tile * 4;
var maxHeight = tile * 3;
actorGravity = defineGravity(maxWidth, maxSpeed, maxHeight);
actorJumpSpeed = defineJumpSpeed(maxWidth, maxSpeed, maxHeight, actorGravity);

actorOnGround = onGround(x, y, entityObj);
actorOnWall = onWall(x, y, solidObj);
actorHasMoved = false;