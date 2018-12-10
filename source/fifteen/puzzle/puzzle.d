module fifteen.puzzle.puzzle;

import fifteen.puzzle.tile;

class Puzzle {
	private immutable uint size;///the maximum tile number

	private immutable uint dim;///the length of a side of the puzzle

	private Tile[] tiles;///the tiles on the puzzle. index represents the tile number. tiles[0] is the empty tile/hole
	private Tile emptyTile;

	this(uint size) {
		import std.math;
		import std.conv;

		this.size = size;
		this.dim = (size + 1.0).sqrt.to!uint;

		this.emptyTile = new Tile(0, size + 1);

		foreach (i; 1 .. size + 1) {
			tiles ~= new Tile(i, i - 1);
		}
	}

	void shuffle() {
		import std.random;

		int[] locations;

		foreach (i; 0 .. size + 2) {
			locations ~= i;
		}

		locations.randomShuffle();

		foreach (i; 0 .. tiles.length) {
			tiles[i].position = locations[i];
		}

		emptyTile.position = locations[$ - 1];
	}
}
