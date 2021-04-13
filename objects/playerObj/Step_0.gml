/// @description Movement (inherited) & collisions
var falling = false;

if(speedY > 0 && !actorOnGround){
	falling = true;
}

var wasOnWall = actorOnWall;

//Movement code
event_inherited();

//Jump
if(actorOnGround){
	jumping = false;
}
if(actorOnGround && falling){
	//Coyote
	coyoteActive = false;
	coyoteAvailable = true;
	alarm_set(0, -1);
	//Wall jumping
	wallJumpUsed = false;
	wallJumpAvailable = false;
}else{
	//Coyote
	if(!coyoteActive && coyoteAvailable){
		coyoteActive = true;
		coyoteAvailable = false;
		
		alarm_set(0, coyoteTime);
	}
	//Jump buffer
	if(!jumpBufferActive && !jumpBufferAvailable){
		jumpBufferAvailable = true;
	}
	//Wall jumping
	if(actorOnWall){
		wallJumpAvailable = true;
	}else{
		wallJumpAvailable = false;
	}
}