; print each element in a linked list
; head is a POINTER to a current_ptr
pro print_ll,head
    current_ptr = head
    while (current_ptr ne !null) do begin
        print,(*current_ptr).data
        current_ptr = (*current_ptr).next
    endwhile
end

