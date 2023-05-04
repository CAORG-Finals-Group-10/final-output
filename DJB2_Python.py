def djb2_hash(s):                                       
    hash = 5381
    for x in s:
        # ord(x) simply returns the unicode rep of the
        # character x
        hash = (( hash << 5) + hash) + ord(x)
    # Note to clamp the value so that the hash is 
    # related to the power of 2
    return hash & 0xFFFFFFFF
