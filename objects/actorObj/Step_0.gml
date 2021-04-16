/// @description Movement & collisions
collision = false;
actorHasMoved = false;

reminderX = actorMoveX(moveX, reminderX, entityObj, self);
reminderY = actorMoveY(moveY, reminderY, entityObj, self);

actorOnGround = onGround(x, y, entityObj);
actorOnWall = onWall(x, y, solidObj);

if(xprevious != x){
	actorHasMoved = true;
}