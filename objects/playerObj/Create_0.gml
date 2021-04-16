/// @description Initialize features & controls
event_inherited();
//Death flag
dead = false;
//Controls
//E.g. you could assign the buttons from a global settings object
rightButton = vk_right;
leftButton = vk_left;
jumpButton = ord("X");
//Jump
jumping = false;
//@variable jumpCornerCorrection in pixels
//Jump buffer
//@variable useJumpBuffer defines if it's active
//@variable jumpBufferDurationInSeconds defines the duration
jumpBufferAvailable = false
jumpBufferActive = false;
//Coyote time: we give the player some time after falling from the ledge to still execute a jump
//@variable useCoyoteTime defines if it's active
//@variable coyoteDurationInSeconds defines the duration
coyoteIsAvailable = false;
coyoteIsActive = false;
//Wall jump
//@variable useWallJump defines if it's active
wallJumpAvailable = false;
wallJumpUsed = false;
wallJumpSpeed = maxSpeed;
//Wall friction/slide
//@variable wallFrictionFactor defines the reduction of gravity when falling touching a wall
//Values between 0-1