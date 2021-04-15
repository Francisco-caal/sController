/// @description 
//Flags
active = true;
dead = false;
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
//Jump
jumping = false;
//@variable jumpCornerCorrection in pixels
//Jump buffer
jumpBufferAvailable = false
jumpBufferActive = false;
jumpBufferTime = 3;
//Coyote time: we give the player some time after falling from the ledge to still execute a jump
//@variable useCoyoteTime defines if it's active
//@variable coyoteDurationInSeconds defines the duration
coyoteIsAvailable = false;
coyoteIsActive = false;
//Wall jump
wallJumpSpeed = 1 * 2.5; //1 == maxSpeed
wallJumpAvailable = false;
wallJumpUsed = false;
wallJumpSpeed = maxSpeed * 2.5;
//Wall slide
wallSlideFactor = .1;