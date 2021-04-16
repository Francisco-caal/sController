/// @description Initialize movement&flags
//Flags
active = true;
collision = false;
actorOnGround = onGround(x, y, entityObj);
actorOnWall = onWall(x, y, solidObj);
actorHasMoved = false;
//Movement in X&Y
moveX = 0;
speedX = 0;
reminderX = 0;

moveY = 0;
speedY = 0;
reminderY = 0;

maxSpeed = 2;
acceleration = .5;
//@variable maxJumpLength what's the maximum the player should be able to jump horizontally in a flat surface, I use a formula of N tiles * tile width
//@variable maxJumpHeight what's the maximum the player should be able to jump vertically, I use a formula of N tiles * tile height
actorGravity = defineGravity(maxJumpLength, maxSpeed, maxJumpHeight);
actorJumpSpeed = defineJumpSpeed(maxJumpLength, maxSpeed, maxJumpHeight, actorGravity);