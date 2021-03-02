HELP_FUNC =                                                             \
    %help;                                                              \
    while( <> ) {                                                       \
        if( /^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/ ) {              \
            push(@{$$help{$$2}}, [$$1, $$3]);                           \
        }                                                               \
    };                                                                  \
    print "usage: make [target]\n\n";                                   \
    for ( sort keys %help ) {                                           \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}};  \
        print "\n";                                                     \
    }
