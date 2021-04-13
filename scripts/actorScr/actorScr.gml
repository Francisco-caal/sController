function actorMoveX(_value, _reminder, _colliders){
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

function actorMoveY(_value, _reminder, _colliders){
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
						speedY = 0;
						_reminder = 0;
				
						collision = true;
						_collision = true;
						break;
					}
				}
			}
			
			if(!_collision){
				y += _sign;
				_move -= _sign;
			}else{
				break;
			}
		}
	}
	
	return _reminder;
}

function onGround(_x, _y, _colliders){
	return place_meeting(_x, _y + 1, _colliders);
}

function onWall(_x, _y, _colliders, _side){
	var threshold = 1;
	if(_side != undefined){
		if(_side == "left"){
			return place_meeting(_x - threshold, _y, _colliders);
		}else if(_side == "right"){
			return place_meeting(_x + threshold, _y, _colliders);
		}
	}
	
	return place_meeting(_x + threshold, _y, _colliders) || place_meeting(_x - threshold, _y, _colliders);
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