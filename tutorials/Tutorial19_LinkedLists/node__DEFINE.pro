; define a linked list node with short integer data
pro node__DEFINE
    node = {Node, data: 0, next: ptr_new()}
end
