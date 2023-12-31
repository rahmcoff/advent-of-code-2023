let input = """
#.###########################################################################################################################################
#.....###...###...#...###...#...###...#...###...###...#...#.........###...###...#.......#...###...#...#...###.....#...#.....#...#...#...#...#
#####.###.#.###.#.#.#.###.#.#.#.###.#.#.#.###.#.###.#.#.#.#.#######.###.#.###.#.#.#####.#.#.###.#.#.#.#.#.###.###.#.#.#.###.#.#.#.#.#.#.#.#.#
#.....#...#...#.#.#.#.#...#.#.#.#...#.#.#...#.#...#.#.#.#.#.#.......#...#...#.#.#.#.....#.#.#...#.#.#...#...#...#.#.#.#...#.#.#.#.#.#.#.#.#.#
#.#####.#####.#.#.#.#.#.###.#.#.#.###.#.###.#.###.#.#.#.#.#.#.#######.#####.#.#.#.#.#####.#.#.###.#.#######.###.#.#.#.###.#.#.#.#.#.#.#.#.#.#
#.#...#...#...#.#.#.#.#...#.#.#.#...#.#.#...#...#.#.#.#.#.#.#.#...###.....#.#.#...#...#...#.#...#.#.....#...#...#.#.#.#...#...#.#.#.#.#.#.#.#
#.#.#.###.#.###.#.#.#.###.#.#.#.###.#.#.#.#####.#.#.#.#.#.#.#.#.#.#######.#.#.#######.#.###.###.#.#####.#.###.###.#.#.#.#######.#.#.#.#.#.#.#
#.#.#.#...#...#.#...#.#...#...#.#...#.#.#.>.>.#.#.#.#.#.#.#.#...#.>.>.#...#.#.#.......#.#...#...#.#.>.>.#.....#...#.#.#.#.......#.#.#.#.#.#.#
#.#.#.#.#####v#.#####.#.#######.#.###.#.###v#.#.#.#.#.#.#.#.#######v#.#.###.#.#.#######.#.###.###.#.#v#########.###.#.#.#.#######.#.#.#.#.#.#
#...#.#.#...#.>.#.....#.....#...#.#...#.#...#...#.#.#.#.#.#.#.....#.#.#...#...#.#...#...#.....###.#.#.#.....###.....#.#.#.....###.#.#.#.#.#.#
#####.#.#.#.#v###.#########.#.###.#.###.#.#######.#.#.#.#.#.#.###.#.#.###.#####.#.#.#.###########.#.#.#.###.#########.#.#####.###.#.#.#.#.#.#
#...#...#.#.#...#...#...#...#...#.#.#...#.......#.#.#.#.#.#.#...#...#.#...###...#.#.#.....#...###...#...###.........#.#.#...#...#.#.#.#.#.#.#
#.#.#####.#.###.###.#.#.#.#####.#.#.#.#########.#.#.#.#.#.#.###.#####.#.#####.###.#.#####.#.#.#####################.#.#.#.#.###.#.#.#.#.#.#.#
#.#...###.#.....#...#.#.#...###...#.#.#.........#...#.#.#...###.....#...#...#.....#.....#...#.......#.......#.......#...#.#.....#.#.#.#.#.#.#
#.###.###.#######.###.#.###.#######.#.#.#############.#.###########.#####.#.###########.###########.#.#####.#.###########.#######.#.#.#.#.#.#
#...#...#...#...#.....#.#...#.......#.#.#.......#...#...###.........#.....#.............#.........#.#.....#...#...#...###.#.....#.#.#.#.#.#.#
###.###.###.#.#.#######.#.###.#######.#.#.#####.#.#.#######.#########.###################.#######.#.#####.#####.#.#.#.###.#.###.#.#.#.#.#.#.#
###...#.###...#.....###.#...#.........#...#...#...#...#.....#.......#.....#.....#...>.>.#.......#...#...#...#...#...#...#.#.###...#...#...#.#
#####.#.###########.###.###.###############.#.#######.#.#####.#####.#####.#.###.#.###v#.#######.#####.#.###.#.#########.#.#.###############.#
#...#.#...........#...#.....###...#.........#.......#.#.......#...#.#.....#.#...#.#...#...#...#...#...#.....#.#.......#.#.#.#.............#.#
#.#.#.###########.###.#########.#.#.###############.#.#########.#.#.#.#####.#.###.#.#####.#.#.###.#.#########.#.#####.#.#.#.#.###########.#.#
#.#...#.........#.#...#.....#...#.#...............#.#.#.........#...#.......#.#...#.#...#.#.#.#...#.......#...#.....#.#.#.#.#...#...#...#...#
#.#####.#######.#.#.###.###.#.###.###############.#.#.#.#####################.#.###.#.#.#.#.#.#.#########.#.#######.#.#.#.#.###.#.#.#.#.#####
#.#...#.#.......#...###...#.#...#.#...............#...#.........#.....#.....#...#...#.#.#...#.#.#.........#.#.......#...#...###...#...#.....#
#.#.#.#.#.###############.#.###.#.#.###########################.#.###.#.###.#####.###.#.#####.#.#.#########.#.#############################.#
#...#...#.....#...#...#...#.....#.#...........#...###...###.....#.#...#.#...#...#.....#.....#.#.#...#.......#.............###...###...#.....#
#############.#.#.#.#.#.#########.###########.#.#.###.#.###.#####.#.###.#.###.#.###########.#.#.###.#.###################.###.#.###.#.#.#####
#.............#.#.#.#.#...#.......#...#.......#.#...#.#...#.......#.....#.#...#.............#...###...#...................#...#.#...#.#.....#
#.#############.#.#.#.###.#.#######.#.#.#######.###.#.###.###############.#.###########################.###################.###.#.###.#####.#
#.........#...#.#.#.#.###.#.#...###.#.#.....###.#...#...#.#...#...........#.#...#...###...#...###.....#.....#.......#...#...#...#...#.#...#.#
#########.#.#.#.#.#.#.###.#.#.#.###.#.#####v###.#.#####.#.#.#.#v###########.#.#.#.#.###.#.#.#.###.###.#####.#.#####.#.#.#.###.#####.#.#v#.#.#
#.........#.#.#.#...#...#.#.#.#...#.#.....>.>.#.#...#...#.#.#.>.>.........#...#...#.....#...#...#...#.#...#...#.....#.#.#...#.#.....#.>.#...#
#.#########.#.#.#######.#.#.#.###.#.#######v#.#.###.#.###.#.###v#########.#####################.###.#.#.#.#####.#####.#.###.#.#.#######v#####
#.#...#...#.#.#...#.....#.#...###...#.......#.#.###.#...#...#...#.........#...#...#...#.........#...#.#.#.#...#...###.#.###.#...###...#.#...#
#.#.#.#.#.#.#.###.#.#####.###########.#######.#.###.###.#####.###.#########.#.#.#.#.#.#.#########.###.#.#.#.#.###.###.#.###.#######.#.#.#.#.#
#.#.#.#.#.#.#.#...#.....#.....###...#.......#.#...#.#...#.....#...###.......#...#...#...#...#...#...#.#.#.#.#.#...#...#.#...#.....#.#.#...#.#
#.#.#.#.#v#.#.#.#######.#####.###.#.#######.#.###.#.#.###.#####.#####.###################.#.#.#.###.#.#.#.#.#.#.###.###.#.###.###.#.#.#####.#
#.#.#...#.>.#.#.#.......#.....#...#...#...#.#...#.#.#.###.....#.#...#...#...........#...#.#.#.#.###.#.#.#.#.#.#...#...#.#.###...#.#.#...#...#
#.#.#####v###.#.#.#######.#####.#####.#.#.#.###.#.#.#.#######.#.#.#.###.#.#########.#.#.#.#.#.#.###.#.#.#.#.#.###v###.#.#.#####.#.#.###.#.###
#...###...#...#.#.....#...#.....#...#...#.#...#.#.#.#.#.......#...#...#...#...#...#.#.#.#.#.#.#...#.#.#.#.#.#.#.>.>...#...#.....#.#.###.#...#
#######.###.###.#####.#.###.#####.#.#####.###.#.#.#.#.#.#############.#####.#.#.#.#v#.#.#.#.#.###.#.#.#.#.#.#.#.#v#########.#####.#.###.###.#
#...#...###...#.#.....#...#...#...#.#...#.....#...#.#.#.#...###...###...#...#.#.#.>.>.#.#.#.#...#.#.#.#.#...#...#.......#...#...#.#...#.#...#
#.#.#.#######.#.#.#######.###.#.###.#.#.###########.#.#.#.#.###.#.#####.#.###.#.###v###.#.#.###.#.#.#.#.###############.#.###.#.#.###.#.#.###
#.#...#.....#...#.........#...#.#...#.#.....#.....#...#...#...#.#.......#.###...#...###.#.#.#...#...#...###...........#.#...#.#.#.....#.#...#
#.#####.###.###############.###.#.###.#####.#.###.###########.#.#########.#######.#####.#.#.#.#############.#########.#.###.#.#.#######.###.#
#.#...#.#...#.......#.....#.....#.....#...#...#...#...........#...#.....#.#...#...#...#...#...#.....#.....#.........#...###...#.....###.....#
#.#.#.#.#.###.#####.#.###.#############.#.#####.###.#############.#.###.#.#.#.#.###.#.#########.###.#.###.#########.###############.#########
#...#...#...#.....#.#...#.....#.........#.....#...#...........###...###.#.#.#.#.....#...#...###.#...#...#.........#.......#.........#...#####
###########.#####.#.###.#####.#.#############.###.###########.#########.#.#.#.#########.#.#.###.#.#####.#########.#######.#.#########.#.#####
#...#.......#...#.#.###...#...#.............#.#...#...........#...#...#.#.#.#.#...#.....#.#.#...#.#...#.........#.........#...........#.....#
#.#.#.#######.#.#.#.#####.#.###############.#.#.###.###########.#.#.#.#.#.#.#.#.#.#.#####.#.#.###.#.#.#########.###########################.#
#.#...#.....#.#.#.#.#...#.#.#...#...........#...###.............#.#.#.#...#.#...#...###...#.#...#.#.#.###...#...#...###...#.....#...........#
#.#####.###.#.#.#.#.#.#.#.#.#.#.#.###############################.#.#.#####.###########.###.###.#.#.#.###.#.#v###.#.###.#.#.###.#.###########
#.#...#...#.#.#.#.#.#.#.#.#.#.#.#...#####...#.....#...#...........#.#.###...#.....#...#...#...#.#.#.#.#...#.>.>.#.#.###.#.#...#.#...........#
#.#.#.###.#.#.#.#.#.#.#.#.#.#.#.###v#####.#.#.###.#.#.#.###########.#.###.###.###.#.#.###.###.#.#.#.#.#.#####v#.#.#.###.#.###v#.###########.#
#.#.#.#...#.#.#.#.#.#.#...#.#.#...>.>.###.#.#.#...#.#.#...........#.#...#...#...#.#.#.#...###...#.#.#.#...#...#...#...#.#.#.>.#.............#
#.#.#v#.###.#.#.#.#.#.#####.#.#####v#.###.#.#.#.###.#.###########.#.###.###v###.#.#.#.#.#########.#.#.###.#.#########.#.#.#.#v###############
#...#.>.#...#.#.#.#.#.....#.#...#...#...#.#.#.#...#.#.#.........#.#...#...>.>.#.#...#.#.###.......#.#...#.#.....#...#.#.#.#.#.........#...###
#####v###.###.#.#.#.#####.#.###.#.#####.#.#.#.###.#.#.#.#######.#.###.#####v#.#.#####.#.###.#######.###.#.#####.#.#.#.#.#.#.#########.#.#.###
#.....###...#.#.#.#.#...#.#.....#.....#...#.#.#...#.#.#.....###...#...###...#...#...#.#...#.#.....#.#...#.#.....#.#.#...#.#.#.........#.#...#
#.#########.#.#.#.#.#.#.#.###########.#####.#.#.###.#.#####.#######.#####.#######.#.#.###.#.#.###.#.#.###.#.#####.#.#####.#.#.#########.###.#
#.....#...#...#...#.#.#.#.#...........###...#.#...#.#...#...#...###.....#.#...###.#.#.....#...#...#.#.#...#.......#.#...#.#.#.....#...#.#...#
#####.#.#.#########.#.#.#.#.#############.###.###.#.###.#.###.#.#######.#.#.#.###.#.###########.###.#.#.###########.#.#.#.#.#####.#.#.#.#.###
#...#...#.......#...#.#...#.....#...#...#.#...#...#.#...#...#.#.#...#...#.#.#.....#...........#.....#...#...#.....#...#.#.#.#.....#.#...#...#
#.#.###########.#.###.#########.#.#.#.#.#.#.###.###.#.#####v#.#.#.#.#.###.#.#################.###########.#.#.###.#####.#.#.#.#####.#######.#
#.#.............#.....#.........#.#...#.#.#.#...#...#.....>.>.#.#.#...###.#.#.......#.....#...#...........#...###.#.....#...#.....#.#.......#
#.#####################.#########.#####.#.#.#.###.#########v###.#.#######.#.#.#####.#.###.#.###.#################.#.#############.#.#.#######
#.#...#...#...#####...#...#...#...###...#.#.#...#.#.....#...###.#.#.....#...#.....#.#...#...#...#...#...........#.#.....#.......#...#.......#
#.#.#.#.#.#.#.#####.#.###.#.#.#.#####.###.#.###.#.#.###.#.#####.#.#.###.#########.#.###.#####.###.#.#.#########.#.#####.#.#####.###########.#
#.#.#.#.#.#.#...#...#...#...#...#...#...#...#...#.#...#...#...#...#.#...#...###...#.#...#...#.....#...#.........#.......#.#...#.............#
#.#.#.#.#.#.###.#.#####.#########.#.###.#####.###.###.#####.#.#####.#.###.#.###.###.#.###.#.###########.#################.#.#.###############
#...#...#...#...#.#.....#...#...#.#...#.....#.#...#...#...#.#.#...#.#.#...#.#...###...###.#.#...#...###.................#...#...............#
#############.###.#.#####.#.#.#.#.###.#####.#.#.###.###.#.#.#.#.#.#.#.#.###.#.###########.#.#.#.#.#.###################.###################.#
#.............#...#.....#.#.#.#.#...#.#.....#...###.....#.#.#.#.#.#.#.#.#...#...#####...#.#.#.#.#.#.#...#...............###...#.............#
#.#############.#######.#.#.#.#.###.#.#.#################.#.#.#.#.#.#.#.#.#####v#####.#.#.#.#.#.#.#.#.#.#.#################.#.#.#############
#.....#.....###.#.......#.#.#.#...#.#.#...#...#...#...#...#.#...#.#.#.#.#.#...>.>.###.#.#.#...#.#.#.#.#.#.....#...#...#...#.#.#.............#
#####.#.###.###.#.#######.#.#.###.#.#.###.#.#.#.#.#.#.#.###.#####.#.#.#.#.#.###v#.###.#.#.#####.#.#.#.#.#####.#.#.#.#.#.#.#.#.#############.#
#.....#.###...#.#.#...###.#.#...#.#.#.#...#.#.#.#.#.#.#...#.....#.#.#.#.#...#...#...#.#.#.....#.#.#.#.#.#...#.#.#...#.#.#.#.#.#.............#
#.#####.#####v#.#.#.#.###.#.###.#.#.#.#v###.#.#.#.#.#.###v#####.#.#.#.#.#####.#####.#.#.#####.#.#.#.#.#.#.#.#v#.#####.#.#.#.#.#.#############
#.#...#.#...#.>.#...#.#...#...#.#.#.#.>.>...#.#.#.#.#.#.>.>.....#.#.#.#...#...#####.#.#.#.....#.#.#.#.#.#.#.>.>.#.....#.#.#.#.#.........#####
#.#.#.#.#.#.#v#######.#.#####.#.#.#.###v#####.#.#.#.#.#.#v#######.#.#.###.#.#######.#.#.#.#####.#.#.#.#.#.###v###.#####.#.#.#.#########.#####
#.#.#...#.#...#...#...#.....#...#...#...#...#...#...#.#.#.#####...#.#.#...#.....#...#.#.#...#...#.#.#.#.#.###.#...#...#.#.#.#.#...#...#.....#
#.#.#####.#####.#.#.#######.#########.###.#.#########.#.#.#####.###.#.#.#######.#.###.#.###.#.###.#.#.#.#.###.#.###.#.#.#.#.#.#.#.#.#.#####.#
#...###...#...#.#.#...#...#.#.......#...#.#.......###...#.....#.....#.#.#.......#.....#.#...#...#.#...#...#...#...#.#...#.#.#.#.#.#.#.#...#.#
#######.###.#.#.#.###.#.#.#.#.#####.###.#.#######.###########.#######.#.#.#############.#.#####.#.#########.#####.#.#####.#.#.#.#.#.#.#v#.#.#
#.....#.....#.#.#...#.#.#.#.#.#...#...#...#...#...#...........###...#...#.........#...#.#.#.....#.#.........#.....#.....#.#.#.#.#...#.>.#.#.#
#.###.#######.#.###.#.#.#.#.#.#.#.###.#####.#.#.###.#############.#.#############.#.#.#.#.#.#####.#.#########.#########.#.#.#.#.#######v#.#.#
#...#.....#...#.#...#.#.#...#.#.#...#...#...#.#.#...#.....#.....#.#...#...........#.#.#...#.....#.#...#.....#...#...#...#.#.#.#.#.......#...#
###.#####.#.###.#.###.#.#####.#.###.###.#.###.#.#.###.###.#.###.#.###.#.###########.#.#########.#.###.#.###.###.#.#.#.###.#.#.#.#.###########
###.....#...#...#...#.#.....#...###...#.#...#.#.#...#...#...###...#...#.............#.#.....###...###...###...#.#.#.#.#...#.#...#...........#
#######.#####.#####.#.#####.#########.#.###.#.#.###.###.###########.#################.#.###.#################.#.#.#.#.#.###.###############.#
#.......#...#.#.....#.......###...#...#.#...#...#...#...#.....#.....#...#.......#.....#...#.#.........#.......#...#...#.....#.....###.......#
#.#######.#.#.#.###############.#.#.###.#.#######.###.###.###.#.#####.#.#.#####.#.#######.#.#.#######.#.#####################.###.###.#######
#...#.....#...#...........#.....#...###...###...#.....###...#...###...#.#.....#.#.....#...#.#.#.......#.....#####...###...###...#.#...#######
###.#.###################.#.#################.#.###########.#######.###.#####.#.#####.#.###.#.#.###########.#####.#.###.#.#####.#.#.#########
#...#.###...###.........#.#...#.....###.....#.#.#...#.....#.......#.#...###...#...#...#.#...#.#.#...#...###...#...#...#.#.....#.#.#.........#
#.###.###.#.###.#######.#.###.#.###.###.###.#.#.#.#.#.###.#######.#.#.#####.#####.#.###.#.###.#.#.#.#.#.#####.#.#####.#.#####.#.#.#########.#
#.....#...#...#...#...#...###...###...#...#.#.#.#.#.#...#.#...#...#.#.#...#.#####...#...#.#...#.#.#.#.#.#.....#...#...#.#.....#.#.###.......#
#######.#####.###v#.#.###############.###.#.#.#.#.#.###.#.#.#.#v###.#.#.#.#v#########.###.#.###.#.#.#.#.#.#######.#.###.#.#####.#.###v#######
#.......#...#...#.>.#...#...###...#...###.#.#.#.#.#.#...#...#.>.>.#.#.#.#.>.>.###...#...#.#.#...#.#.#.#.#...#...#.#...#.#...#...#...>.#...###
#.#######.#.###.#v#####.#.#.###.#.#.#####.#.#.#.#.#.#.#########v#.#.#.#.###v#.###.#.###.#.#.#.###.#.#.#.###v#.#.#.###.#.###.#.#######v#.#.###
#.........#...#...#.....#.#.###.#...###...#...#.#.#.#.#.........#...#.#...#.#...#.#.#...#.#.#...#.#.#.#.#.>.>.#.#...#.#...#...#.....#...#...#
#############.#####.#####.#.###.#######.#######.#.#.#.#.#############.###.#.###.#.#.#.###.#.###.#.#.#.#.#.#v###.###.#.###.#####.###.#######.#
#...#...#...#...#...#...#.#...#.....#...#.......#.#...#...........#...#...#...#.#.#.#.#...#.#...#.#...#...#.###...#.#.#...#...#...#.#.....#.#
#.#.#.#.#.#.###.#.###.#.#.###.#####.#.###.#######.###############.#.###.#####.#.#.#.#.#.###.#.###.#########.#####.#.#.#.###.#.###.#.#.###.#.#
#.#...#...#.....#...#.#.#.#...#...#.#...#...#...#.#...............#...#...###.#...#...#...#.#.....#...#...#.#...#.#.#...#...#.....#.#...#.#.#
#.#################.#.#.#.#.###.#.#v###.###.#.#.#.#.#################.###.###.###########.#.#######.#.#.#.#.#.#.#.#.#####.#########.###.#.#.#
#.......#.....#...#.#.#...#...#.#.>.>.#...#.#.#...#.#.............#...#...#...#...###...#.#.#.....#.#.#.#.#...#.#.#...#...#.......#...#.#.#.#
#######.#.###.#.#.#.#.#######.#.###v#.###.#.#.#####.#.###########.#.###.###.###.#.###.#.#.#.#.###.#.#.#.#.#####.#.###.#.###.#####.###.#.#.#.#
#.......#.#...#.#.#...#...###.#.#...#...#.#...#.....#.#...........#.#...###.....#.....#.#...#...#...#...#...#...#...#.#.....#.....###...#...#
#.#######.#.###.#.#####.#.###.#.#.#####.#.#####.#####.#.###########.#.#################.#######.###########.#.#####.#.#######.###############
#.#...#...#.....#...#...#...#...#.....#.#.....#.......#.....#.....#...###...#.........#.....###...........#...#...#...###...#...###.........#
#.#.#.#.###########.#.#####.#########.#.#####.#############.#.###.#######.#.#.#######.#####.#############.#####.#.#######.#.###.###.#######.#
#.#.#.#.#...........#.#.....###.......#...#...#...#.........#.#...###.....#...#...###.......#.............#...#.#.###.....#...#.....#...#...#
#.#.#.#.#.###########.#.#######.#########.#.###.#.#.#########.#.#####.#########.#.###########.#############.#.#.#.###.#######.#######.#.#.###
#...#...#.............#...#...#.#.....###...#...#.#...........#.....#.#.........#.......#.....#.....#.......#...#...#...#...#.........#...###
#########################.#.#.#.#.###.#######.###.#################.#.#.###############.#.#####.###.#.#############.###.#.#.#################
#.........#.....#...#...#...#.#.#.#...#...#...#...#.................#...#...#...........#.......###...###.......#...###...#.........#...#...#
#.#######.#.###.#.#.#.#.#####.#.#.#.###.#.#.###.###.#####################.#.#.###########################.#####.#.#################.#.#.#.#.#
#.......#.#...#...#...#.#...#.#...#.....#...#...###.................###...#...#...#...#...###.............#...#...#...#...........#...#...#.#
#######.#.###.#########.#.#.#.###############.#####################.###.#######.#.#.#.#.#.###.#############.#.#####.#.#.#########.#########.#
#.......#...#.........#.#.#.#...#...#.........#...#...........#...#.#...#.......#.#.#.#.#...#.....#...#...#.#.#...#.#.#.........#.#...#.....#
#.#########.#########.#.#.#.###.#.#.#.#########.#.#.#########.#.#.#.#.###.#######.#.#.#.###.#####.#.#.#.#.#.#.#.#.#.#.#########.#.#.#.#.#####
#.........#...........#...#.....#.#...###...###.#.#.........#.#.#.#.#.....###.....#.#.#.#...#...#.#.#.#.#...#.#.#.#.#...#...#...#.#.#.#.....#
#########.#######################.#######.#.###.#.#########.#.#.#.#.#########v#####.#.#.#.###.#.#.#.#.#.#####.#.#.#.###.#.#.#.###.#.#.#####.#
#...#...#...............#.........#.......#...#.#.#...#.....#...#...#.......>.>.#...#...#...#.#.#...#...#.....#.#.#.#...#.#.#...#...#.......#
#.#.#.#.###############.#.#########.#########.#.#.#.#.#.#############.#########.#.#########.#.#.#########.#####.#.#.#.###.#.###v#############
#.#...#.................#...........#...#.....#.#...#.#.......#...#...#.....#...#...#.......#.#...#...#...#...#.#...#.#...#...>.###...#...###
#.###################################.#.#.#####.#####.#######.#.#.#.###.###.#.#####.#.#######.###.#.#.#.###.#.#.#####.#.#######v###.#.#.#.###
#.#...#.....#...###.....#...#...#.....#.#...###.#...#.#...#...#.#.#.....#...#...#...#...#...#.#...#.#.#...#.#.#...#...#.###...#.###.#.#.#.###
#.#.#.#.###.#.#.###.###.#.#.#.#.#.#####.###.###.#.#.#.#.#.#.###.#.#######.#####.#.#####.#.#.#.#.###.#.###v#.#.###.#.###.###.#.#.###.#.#.#.###
#...#...###.#.#...#.#...#.#.#.#.#.....#...#.#...#.#...#.#.#.#...#.###...#.....#.#.#####.#.#.#.#...#.#.#.>.>.#.#...#...#.#...#...#...#.#.#.###
###########.#.###.#.#.###.#.#.#.#####.###.#.#.###.#####.#.#.#.###.###.#.#####.#.#.#####.#.#.#.###.#.#.#.#####.#.#####.#.#.#######.###.#.#.###
#...........#...#...#.....#.#.#.#.....###...#...#.#...#.#.#.#...#.#...#.#...#.#...#.....#.#.#...#.#.#.#.....#.#.....#...#...#...#...#.#.#...#
#.#############.###########.#.#.#.#############.#.#.#.#.#.#v###.#.#.###.#.#.#.#####.#####.#.###.#.#.#.#####.#.#####.#######.#.#.###.#.#.###.#
#.#...#.....#...###.........#.#.#.....#...#...#.#.#.#...#.>.>.#.#.#.###.#.#.#.....#.....#.#...#.#.#.#.#...#.#.......#.......#.#...#.#.#...#.#
#.#.#.#.###.#.#####.#########.#.#####v#.#.#.#.#.#.#.#########.#.#.#.###.#.#.#####.#####.#.###.#.#.#.#.#.#.#.#########.#######.###.#.#.###.#.#
#.#.#.#.#...#.#.....#...#...#.#.#...>.>.#.#.#.#.#.#.......#...#.#.#.#...#.#.#...#...#...#...#.#.#.#.#.#.#.#.......#...#...#...#...#.#...#.#.#
#.#.#.#.#.###.#.#####.#.#.#.#.#.#.#######.#.#.#.#.#######.#.###.#.#.#.###.#.#.#.###.#.#####.#.#.#.#.#.#.#.#######.#.###.#.#.###.###.###.#.#.#
#...#...#.....#.......#...#...#...#######...#...#.........#.....#...#.....#...#.....#.......#...#...#...#.........#.....#...###.....###...#.#
###########################################################################################################################################.#
"""
