module fifteen.puzzle.tile;

class Tile {
	immutable uint number;

	uint position;

	this(uint number, uint position) {
		this.number = number;
		this.position = position;
	}
}
