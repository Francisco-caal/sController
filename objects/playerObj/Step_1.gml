/// @description Player input
if(dead){
	instance_destroy();
}

if(active){
	var right = keyboard_check(rightButton);
	var left = keyboard_check(leftButton);
	var jump = keyboard_check_pressed(jumpButton);
	
	var directionX = right - left;
	
	
	var directionUnlocked = true;
	//If we are using wall jump we lock the direction controls while the player is going up
	//We do this to avoid wall jumping on one wall, this can be deactivated to modify the behaviour
	if(useWallJump){
		if(wallJumpUsed && speedY < 0){
			directionUnlocked = false;
		}
	}
	
	if(directionUnlocked){
		if(directionX != 0){
			speedX += directionX * acceleration;
			speedX = clamp(speedX, -maxSpeed, maxSpeed);
		}else{
			if(!wallJumpUsed || (wallJumpUsed && speedY > 0)){
				if(abs(speedX) > acceleration){
					speedX -= sign(speedX) * acceleration;
				}else{
					speedX = 0;
				}
			}
		}
	}
	
	var executeJump = false;
	if(jump){
		if(actorOnGround || coyoteIsActive){ //If useCoyoteTime is off this should never be true
			executeJump = true;
		}else if(wallJumpAvailable){
			executeJump = true;
			wallJumpUsed = true;
			wallJumpAvailable = false;
			
			if(onWall(x, y, solidObj, "left")){
				speedX = wallJumpSpeed;
			}else{
				speedX = -wallJumpSpeed;
			}
		}else if(jumpBufferAvailable){ //If useJumpBuffer is off this should never be true
			jumpBufferAvailable = false;
			jumpBufferActive = true;
			alarm_set(1, jumpBufferDurationInSeconds);
		}
	}else if(jumpBufferActive && actorOnGround){ //If useJumpBuffer is off this should never be true
		executeJump = true;
		
		jumpBufferActive = false;
		jumpBufferAvailable = true;
		alarm_set(1, -1);
	}
	
	if(executeJump){
		jumping = true;
		speedY = actorJumpSpeed;
	}
	
	moveX = speedX;
	//Use limited gravity when falling touching a wall
	if(wallFrictionFactor > 0 && actorOnWall && speedY > 0){
		speedY += actorGravity * wallFrictionFactor;
	}else{ //Normal gravity
		speedY += actorGravity;
	}
	moveY = speedY;
}