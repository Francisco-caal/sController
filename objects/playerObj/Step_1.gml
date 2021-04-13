/// @description Player input
if(dead){
	instance_destroy();
}

if(active){
	var right = keyboard_check(vk_right);
	var left = keyboard_check(vk_left);
	var jump = keyboard_check_pressed(ord("X"));
	
	var directionX = right - left;
	
	if(directionX != 0){
		speedX += directionX * acceleration;
		speedX = clamp(speedX, -maxSpeed, maxSpeed);
	}else{
		if(abs(speedX) > acceleration){
			speedX -= sign(speedX) * acceleration;
		}else{
			speedX = 0;
		}
	}
	
	var executeJump = false;
	if(jump){
		if(actorOnGround || coyoteActive){		
			executeJump = true;
		}else if(wallJumpAvailable){
			executeJump = true;
			wallJumpUsed = true;
			wallJumpAvailable = false;
			
			if(onWall(x, y, solidObj, "left")){
				speedX = wallJumpSpeed;;
			}else{
				speedX = -wallJumpSpeed;
			}
		}else if(jumpBufferAvailable){
			jumpBufferAvailable = false;
			jumpBufferActive = true;
			alarm_set(1, jumpBufferTime);
		}
	}else if(jumpBufferActive && actorOnGround){
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
	
	if(actorOnWall && speedY > 0){
		speedY += actorGravity * wallSlideFactor;
	}else{
		speedY += actorGravity;
	}
	moveY = speedY;
}