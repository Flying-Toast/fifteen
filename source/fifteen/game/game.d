module fifteen.game.game;

import fifteen.puzzle.puzzle;

class Game {
	private Puzzle puzzle;

	this() {
		this.puzzle = new Puzzle(15);
	}

	void play() {
		import std.stdio : readln;

		puzzle.render();

		while (readln()) {//TODO: check if puzzle is solved instead of looping blindly
			puzzle.render();
		}
	}
}
