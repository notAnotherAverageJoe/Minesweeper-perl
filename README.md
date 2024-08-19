# 🚀 Minesweeper Game

Welcome to Minesweeper, the classic puzzle game built with Perl and Tk! Test your logic and reflexes as you uncover cells in a grid, avoiding hidden mines. 💣

# 🌟 Features

Customizable Grid Size: The game allows you to define the size of the grid and the number of mines.
Intuitive Gameplay: Click on the cells to reveal them. If you hit a mine, it's game over!
Recursive Cell Reveal: Zero-adjacent cells automatically reveal their neighbors, making gameplay smooth and challenging.
Beautiful UI: A clean and simple user interface using Tk for a delightful gaming experience.

# 🛠️ Installation

Make sure you have Perl installed on your system. Then, install the necessary Tk module if you haven't already:

```bash

cpan install Tk
🚀 Getting Started
Clone the repository:

bash
git clone https://github.com/notAnotherAverageJoe/minesweeper-perl.git
cd minesweeper-perl
Run the game:

bash
perl main.pl
```

Enjoy playing Minesweeper! 🎮

# 🎮 How to Play

Start the Game: Upon running the script, a 10x10 grid will appear with 10 hidden mines.
Click on Cells: Click on any cell to reveal its contents.
If the cell contains a number, it indicates how many mines are adjacent.
If the cell is empty, all adjacent empty cells will be automatically revealed.
If you hit a mine, the game is over! 💥
Win the Game: Reveal all cells without mines to win the game! 🎉

# 💡 Customization

Grid Size and Mines: You can change the size of the grid and the number of mines by modifying the $size and $num_mines variables at the beginning of the script.

```perl

my $size = 10; # Size of the grid
my $num_mines = 10; # Number of mines
```

🧑‍💻 Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue if you have any suggestions or find bugs.

📜 License
This project is licensed under the MIT License. See the LICENSE file for details.

🙏 Acknowledgments
Thanks to the Perl and Tk communities for their fantastic tools and libraries.
Inspired by the classic Minesweeper game that we all know and love and of course ATGTG.
Enjoy the game! 🚀✨
