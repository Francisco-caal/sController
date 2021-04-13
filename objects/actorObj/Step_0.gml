/// @description Insert description here
collision = false;
actorHasMoved = false;

reminderX = actorMoveX(moveX, reminderX, entityObj);
reminderY = actorMoveY(moveY, reminderY, entityObj);

actorOnGround = onGround(x, y, entityObj);
actorOnWall = onWall(x, y, solidObj);

if(xprevious != x){
	actorHasMoved = true;
}