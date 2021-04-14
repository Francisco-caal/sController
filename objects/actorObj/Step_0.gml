/// @description Insert description here
//Is the actor falling before we move it
var falling = false;
if(speedY > 0 && !actorOnGround){
	falling = true;
}
//Was on wall before moving
var wasOnWall = actorOnWall;
//
collision = false;
actorHasMoved = false;

reminderX = actorMoveX(moveX, reminderX, entityObj);
reminderY = actorMoveY(moveY, reminderY, entityObj, jumpCornerCorrection);

actorOnGround = onGround(x, y, entityObj);
actorOnWall = onWall(x, y, solidObj);

if(xprevious != x){
	actorHasMoved = true;
}

//Jump
if(actorOnGround){
	jumping = false;
}

if(actorOnGround){
	//Coyote
	if(useCoyoteTime){
		coyoteIsActive = false;
		coyoteIsAvailable = true;
		alarm_set(0, -1);
	}
	
	
	//Wall jumping
	wallJumpUsed = false;
	wallJumpAvailable = false;
}else{
	//Coyote
	if(useCoyoteTime && falling){
		if(!coyoteIsActive && coyoteIsAvailable){
			coyoteIsActive = true;
			coyoteIsAvailable = false;
		
			alarm_set(0, coyoteDurationInSeconds * room_speed);
		}
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