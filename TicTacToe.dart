import 'dart:io';

class TicTacToe {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
  bool gameWon = false;

  TicTacToe() {
    board = List.filled(9, ' ');
    currentPlayer = 'X';
    gameWon = false;
  }

  void printBoard() {
    print(' ${board[0]} | ${board[1]} | ${board[2]} ');
    print('-----------');
    print(' ${board[3]} | ${board[4]} | ${board[5]} ');
    print('-----------');
    print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  }

  bool isMoveValid(int move) {
    return move >= 1 && move <= 9 && board[move - 1] == ' ';
  }

  void makeMove(int move) {
    board[move - 1] = currentPlayer;
  }

  bool checkWin() {
    // Check rows, columns, and diagonals for a win
    for (var i = 0; i < 3; i++) {
      if (board[i] != ' ' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return true; // Check columns
      }
      if (board[i * 3] != ' ' &&
          board[i * 3] == board[i * 3 + 1] &&
          board[i * 3] == board[i * 3 + 2]) {
        return true; // Check rows
      }
    }
    if (board[0] != ' ' && board[0] == board[4] && board[0] == board[8]) {
      return true; // Check diagonal (top-left to bottom-right)
    }
    if (board[2] != ' ' && board[2] == board[4] && board[2] == board[6]) {
      return true; // Check diagonal (top-right to bottom-left)
    }
    return false;
  }

  bool isBoardFull() {
    return !board.contains(' ');
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void playGame() {
    print('Welcome to Tic-Tac-Toe!');
    printBoard();

    while (!gameWon && !isBoardFull()) {
      print('\n$currentPlayer\'s turn. Enter your move (1-9):');
      int move;

      try {
        move = int.parse(stdin.readLineSync()!);
      } catch (e) {
        print('Invalid input. Please enter a number between 1 and 9.');
        continue;
      }

      if (isMoveValid(move)) {
        makeMove(move);
        printBoard();
        gameWon = checkWin();
        if (!gameWon) {
          switchPlayer();
        }
      } else {
        print('Invalid move. Please choose an empty cell (1-9).');
      }
    }

    if (gameWon) {
      print('\nCongratulations! $currentPlayer wins!');
    } else {
      print('\nIt\'s a draw! The game ends in a tie.');
    }
  }
}


bool playAgain() {
  while (true) {
    stdout.write('Do you want to play again? (y/n): ');
    String input = stdin.readLineSync()?.toLowerCase() ?? '';
    if (input == 'y') {
      return true;
    } else if (input == 'n') {
      return false;
    } else {
      print('Invalid input. Please enter \'y\' or \'n\'.');
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.playGame();

  if (playAgain()) {
    main(); // Restart the game
  } else {
    print('Thanks for playing!');
  }
}
