function actorMoveX(_value, _reminder, _colliders, _caller){
	var _move = _value + _reminder;
	_reminder = _move - floor(_move);
	
	_move = floor(_move);
	
	if(abs(_move) > 0){
		var _sign = sign(_move);
		
		while(abs(_move) > 0){
			var _list = ds_list_create();
			var _n = instance_place_list(x + _sign, y, _colliders, _list, true);
			var _collision = false;
			if(_n > 0){
				for(var _i = 0; _i < _n; _i++){
					if(ds_list_find_value(_list, _i).collide){
						speedX = 0;
						_reminder = 0;
				
						collision = true;
						_collision = true;
						break;
					}
				}
			}
			
			if(!_collision){
				x += _sign;
				_move -= _sign;
			}else{
				break;
			}
		}
	}
	
	return _reminder;
}

function actorMoveY(_value, _reminder, _colliders, _caller){
	var _correction = is_undefined(_caller.jumpCornerCorrection) ? 0 : _caller.jumpCornerCorrection;
	var _move = _value + _reminder;
	_reminder = _move - floor(_move);
	
	_move = floor(_move);
	
	if(abs(_move) > 0){
		var _sign = sign(_move);
		
		while(abs(_move) > 0){
			var _list = ds_list_create();
			var _n = instance_place_list(x, y + _sign, _colliders, _list, true);
			var _collision = false;
			if(_n > 0){
				for(var _i = 0; _i < _n; _i++){
					if(ds_list_find_value(_list, _i).collide){
						var _right = 0;
						var _left = 0;
						//We correct corner when defined and we are going up only
						if(_sign < 0 && _correction != 0){ 
							//Loop to find the closest corner
							for(var _j = 0; _j < _correction; _j++){ 
								if(place_empty(x + _j, y + _sign, _colliders)) _right = _j;
								if(place_empty(x - _j, y + _sign, _colliders)) _left = -_j;
								//if we have found the closest corner exit the loop
								if(_right != 0 && _left != 0) break;
							}
						}
						//If we haven't found a corner or corner correction is not active, exit the loop and stop the actor
						if(_right == 0 && _left == 0){
							_collision = true;
							break;
						}else{
							//Otherwise correct the position to the closest corner
							x += (_right != 0) ? _right : _left;
						}
					}
				}
			}
			
			if(!_collision){ //Not collided, keep moving
				y += _sign;
				_move -= _sign;
			}else{ //Collided, stop the actor & exit the loop
				speedY = 0;
				_reminder = 0;
				collision = true;
				break;
			}
		}
	}
	
	return _reminder;
}

function onGround(_x, _y, _colliders){
	return place_meeting(_x, _y + 1, _colliders);
}

function onWall(_x, _y, _colliders){
	return place_meeting(_x + 1, _y, _colliders) || place_meeting(_x - 1, _y, _colliders);
}

function wallJumpLeft(_x, _y, _colliders, _caller){
	var _threshold = -(_caller.wallJumpDistance > 0 ? _caller.wallJumpDistance + 1 : 1);
	return onWallWithThreshold(_x, _y, _colliders, _threshold);
}
function wallJumpRight(_x, _y, _colliders, _caller){
	var _threshold = _caller.wallJumpDistance > 0 ? _caller.wallJumpDistance + 1 : 1;
	return onWallWithThreshold(_x, _y, _colliders, _threshold);
}
function onWallWithThreshold(_x, _y, _colliders, _threshold){
	for(var _i = 1; _i <= abs(_threshold); _i++){
		if(place_meeting(_x + sign(_threshold) * _i, _y, _colliders)){
			return true;
		}
	}
	
	return false;
}

function defineGravity(maxDistance, maxSpeed, maxHeight){
	var timeToMaxHeight = (maxDistance/ maxSpeed) / 2; //time to reach the highest point
	var grv = (2 * maxHeight) / power(timeToMaxHeight, 2); //gravity based on the height and time
	return grv
}

function defineJumpSpeed(maxDistance, maxSpeed, maxHeight, grv){
	//the amount of accumalated gravity force during the time to max height
	var grvSummation = 0;
	var timeToMaxHeight = (maxDistance/ maxSpeed) / 2; //time to reach the highest point
	for(var i = 1; i <= timeToMaxHeight; i++){
		grvSummation += grv * i;
	}
	//initial speed required
	return -(maxHeight + grvSummation) / timeToMaxHeight;
}