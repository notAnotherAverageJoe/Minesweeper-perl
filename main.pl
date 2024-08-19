use strict;
use warnings;
use Tk;
use List::Util 'shuffle';

my $size = 10;           # Size of the grid
my $num_mines = 10;      # Number of mines
my @grid;                # The game grid
my %buttons;             # Button references for revealing

my $mw = MainWindow->new;
$mw->title("Minesweeper");

# Frame for the game grid
my $frame = $mw->Frame->pack(-side => 'top', -padx => 10, -pady => 10);

# Status bar
my $status_bar = $mw->Label(
    -text    => 'Welcome to Minesweeper!',
    -relief  => 'sunken',
    -anchor  => 'w',
    -padx    => 5,
    -pady    => 2,
)->pack(-side => 'bottom', -fill => 'x');

# Initialize the grid with hidden cells
for my $row (0 .. $size-1) {
    for my $col (0 .. $size-1) {
        $grid[$row][$col] = 0;
    }
}

# Randomly place mines
my @cells = shuffle map { $_ } 0 .. $size*$size-1;
for my $i (0 .. $num_mines-1) {
    my $cell = $cells[$i];
    my ($row, $col) = ($cell / $size, $cell % $size);
    $grid[$row][$col] = 'M';
    # Update adjacent cells
    for my $r ($row-1 .. $row+1) {
        for my $c ($col-1 .. $col+1) {
            next if $r < 0 || $r >= $size || $c < 0 || $c >= $size;
            $grid[$r][$c]++ unless $grid[$r][$c] eq 'M';
        }
    }
}

# Create the grid of buttons
for my $row (0 .. $size-1) {
    for my $col (0 .. $size-1) {
        my $button = $frame->Button(
            -text    => '',
            -width   => 2,
            -height  => 1,
            -command => [\&reveal, $row, $col],
            -background => 'lightgrey',
            -font    => ['Arial', 10],
        )->grid(-row => $row, -column => $col, -padx => 1, -pady => 1);
        $buttons{"$row,$col"} = $button;
    }
}

# Function to reveal a cell
my %revealed; # Track revealed cells to avoid recursion issues

sub reveal {
    my ($row, $col) = @_;
    
    # Check boundaries and if cell is already revealed
    return if $row < 0 || $row >= $size || $col < 0 || $col >= $size;
    return if $buttons{"$row,$col"}->cget(-text) ne '' || $revealed{"$row,$col"};
    
    $revealed{"$row,$col"} = 1; # Mark this cell as revealed

    if ($grid[$row][$col] eq 'M') {
        $buttons{"$row,$col"}->configure(-text => "'M'", -background => 'red');
        $status_bar->configure(-text => "Game Over! You hit a mine.");
        $mw->messageBox(
            -message => "Game Over! You hit a mine.",
            -type    => 'ok',
            -icon    => 'info',
        );
        exit;
    } else {
        my $text = $grid[$row][$col];
        my $bg_color = $text == 0 ? 'white' : 'lightblue';
        $buttons{"$row,$col"}->configure(-text => $text, -background => $bg_color);
        if ($text == 0) {
            # ADDED TO avoid deep recursion issues!!!!
            my @stack = ([$row, $col]);
            while (my $current = shift @stack) {
                my ($r, $c) = @$current;
                next if $r < 0 || $r >= $size || $c < 0 || $c >= $size;
                next if $buttons{"$r,$c"}->cget(-text) ne '' || $revealed{"$r,$c"};
                
                $revealed{"$r,$c"} = 1;
                my $cell_text = $grid[$r][$c];
                my $cell_bg = $cell_text == 0 ? 'white' : 'lightblue';
                $buttons{"$r,$c"}->configure(-text => $cell_text, -background => $cell_bg);
                
                if ($cell_text == 0) {
                    push @stack, [$r-1, $c-1], [$r-1, $c], [$r-1, $c+1],
                                 [$r, $c-1],               [$r, $c+1],
                                 [$r+1, $c-1], [$r+1, $c], [$r+1, $c+1];
                }
            }
        }
    }
}

MainLoop;
