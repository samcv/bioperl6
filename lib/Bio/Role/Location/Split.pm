use v6;
use Bio::Role::Location;

role Bio::Role::Location::Split does Bio::Role::Location {

has @!subLocations;
    
method add_sub_Location(*@locations){
    for @locations -> $loc {
        if ($loc !~~ Bio::Role::Location ) {
            #old bioperl5 msg
	    #self.throw("Trying to add $loc as a sub Location but it doesn't implement Bio::LocationI!");
	    next;
	}
        push @!subLocations,$loc;
    }
    return @!subLocations.elems;
}

method each_Location($order?){
    my @locs;
    for self.sub_Location($order) -> $subloc {
	# Recursively check to get hierarchical split locations:
	push @locs, $subloc.each_Location($order);
    }
    return @locs;    
}

method sub_Location($order? = 0) {
    # if( defined($order) && ($order !~ /^-?\d+$/) ) {
    #     $self->throw("value $order passed in to sub_Location is $order, an invalid value");
    # } 
    # $order = 1 if($order > 1);
    # $order = -1 if($order < -1);
    # my @sublocs = defined $self->{'_sublocations'} ? @{$self->{'_sublocations'}} : ();
    my @sublocs = @!subLocations;
    return @sublocs;
    
    # return the array if no ordering requested
    #    return @sublocs if ( ($order == 0) || !(defined @sublocs) );
    	
    # # sort those locations that are on the same sequence as the top (`master')
    # # if the top seq is undefined, we take the first defined in a sublocation
    # my $seqid = $self->seq_id();
    # my $i = 0;
    # while((! defined($seqid)) && ($i <= $#sublocs)) {
    #     	$seqid = $sublocs[$i++]->seq_id();
    # }
    # if((! $self->seq_id()) && $seqid) {
    #     	$self->warn("sorted sublocation array requested but ".
    #     			"root location doesn't define seq_id ".
    #     			"(at least one sublocation does!)");
    # }
    # my @locs = ($seqid ?
    #     	grep { $_->seq_id() eq $seqid; } @sublocs :
    #     	@sublocs);
    # if(@locs) {
    #     	if($order == 1) {
    #     		# Schwartzian transforms for performance boost	  
    #     		@locs = map { $_->[0] }
    #     		sort {
    #     			(defined $a && defined $b) ? $a->[1] <=> $b->[1] :
    #             $a                         ?  -1                 : 1
    #     			}
    #     		map {
    #     			[$_, (defined $_->start ? $_->start : $_->end)]
    #     			} @locs;;
    #     	} else { # $order == -1
    #     		@locs = map { $_->[0]}
    #     		sort { 
    #     			(defined $a && defined $b) ? $b->[1] <=> $a->[1] :
    #     			$a                         ? -1                  : 1
    #     			}
    #     		map {
    #     			[$_, (defined $_->end ? $_->end : $_->start)]
    #     			} @locs;
    #     	}
    # }
    # # push the rest unsorted
    # if($seqid) {
    #     	push(@locs, grep { $_->seq_id() ne $seqid; } @sublocs);
    # }
    # # done!

    # return @locs;
}


method to_FTstring(){
    return 'NYI';
}

method min_start() {
    return 'NYI';
}

method max_start() {
    return 'NYI';
}

method max_end() {
    return 'NYI';
}

method min_end() {
    return 'NYI';
}


}