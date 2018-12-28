module fifteen.game.game;

import fifteen.puzzle.puzzle;

private enum MoveDirection {
	up,
	down,
	left,
	right,
	none
}

class Game {
	private Puzzle puzzle;

	this() {
		this.puzzle = new Puzzle(15);
	}

	void play() {
		import std.stdio : writeln;

		puzzle.render();

		while (!puzzle.isSolved) {
			MoveDirection moveDir = getMoveInput();
			processInput(moveDir);

			puzzle.render();
		}
		writeln("You solved the puzzle!");
	}

	private void processInput(MoveDirection dir) {
		final switch (dir) {
			case MoveDirection.up:
				if (!(puzzle.emptyTile.position > (puzzle.dim^^2) - puzzle.dim)) {
					puzzle.swapEmptyTile(puzzle.emptyTile.position + puzzle.dim);
				}
				break;
			case MoveDirection.down:
				if (!(puzzle.emptyTile.position < puzzle.dim)) {
					puzzle.swapEmptyTile(puzzle.emptyTile.position - puzzle.dim);
				}
				break;
			case MoveDirection.left:
				if (puzzle.emptyTile.position % puzzle.dim != 0) {
					puzzle.swapEmptyTile(puzzle.emptyTile.position - 1);
				}
				break;
			case MoveDirection.right:
				if ((puzzle.emptyTile.position + puzzle.dim + 1) % puzzle.dim != 0) {
					puzzle.swapEmptyTile(puzzle.emptyTile.position + 1);
				}
				break;
			case MoveDirection.none:
				return;
		}
	}

	private MoveDirection getMoveInput() {
		import std.stdio : readln;
		import std.string : strip;

		string rawInput = readln().strip();

		switch (rawInput) {
			case "\033[A":
			case "k":
				return MoveDirection.up;

			case "\033[B":
			case "j":
				return MoveDirection.down;

			case "\033[C":
			case "l":
				return MoveDirection.left;

			case "\033[D":
			case "h":
				return MoveDirection.right;

			default:
				return MoveDirection.none;
		}
	}
}
