/// @description Movement features
//Was the player falling
var falling = false;
if(speedY > 0 && !actorOnGround){
	falling = true;
}
//Was on wall before moving
var wasOnWall = actorOnWall;
//Movement code
event_inherited();
//Jump flag
if(actorOnGround){
	jumping = false;
}
if(actorOnGround){ //We are on ground
	//Coyote
	if(useCoyoteTime){
		coyoteIsActive = false;
		coyoteIsAvailable = true;
		alarm_set(0, -1);
	}	
	//Wall jumping
	if(useWallJump){
		wallJumpUsed = false;
		wallJumpAvailable = false;
	}
}else{ //We are in the air
	//Coyote
	if(useCoyoteTime && falling){
		if(!coyoteIsActive && coyoteIsAvailable){
			coyoteIsActive = true;
			coyoteIsAvailable = false;
		
			alarm_set(0, coyoteDurationInSeconds * room_speed);
		}
	}
	//Jump buffer
	if(useJumpBuffer){
		if(!jumpBufferActive && !jumpBufferAvailable){
			jumpBufferAvailable = true;
		}
	}
	//Wall jumping
	if(useWallJump){
		if(actorOnWall){
			wallJumpUsed = false;
			wallJumpAvailable = true;
		}else{
			wallJumpAvailable = false;
		}
	}
}