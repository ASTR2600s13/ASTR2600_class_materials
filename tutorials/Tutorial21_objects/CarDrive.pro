pro drive_car_pro,self,distance
    if self.gas gt 0 then begin
        self.location += distance
        self.gas -= distance
    endif
end

; drive_car,car,distance

pro CarClass::drive, distance
    if self.gas gt 0 then begin
        self.location += distance
        self.gas -= distance
    endif
end

; how-to:
; car.drive,distance

function CarClass::init,gas,location
    ; initialize the clas with optional gas,location
    ; parameters
    if n_elements(gas) gt 0 then self.gas = gas
    if n_elements(location) gt 0 then self.location = location
    return,1
end

pro CarClass::set_location,loc
    self.location=loc
end

pro CarClass::fill_gas,amount
    self.gas += amount
end

function CarClass::location
    return,self.location
end

function CarClass::gas
    return,self.gas
end


pro drive_car_procedural,distance,gas,location
    ; Need to error-check; have to make sure there are 
    ; the same number of distances & gas numbers
    if n_elements(gas) ne n_elements(distance) $
        or n_elements(gas) ne n_elements(location) then stop

    for carnum = 0,n_elements(distance)-1 do begin
        location[carnum] += distance[carnum]
        gas[carnum] -= distance[carnum]
    endfor
end

; drive_car,car,distance
