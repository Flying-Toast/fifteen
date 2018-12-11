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

		shuffle();
	}

	void shuffle() {
		import std.random;

		int[] locations;

		foreach (i; 0 .. size + 1) {
			locations ~= i;
		}

		locations.randomShuffle();

		foreach (i; 0 .. tiles.length) {
			tiles[i].position = locations[i];
		}

		emptyTile.position = locations[$ - 1];
	}

	void render() {
		import std.conv;
		import std.stdio;

		clearScreen();

		wstring[] renderString = new wstring[size + 1];//the rendered puzzle, as an array of the tiles rendered individually

		foreach (i; 1 .. size + 1) {
			renderTile(i, tiles[i - 1].position);
		}
	}

	private void clearScreen() {
		import std.stdio;
		write("\033[2J\033[;H");
	}

	private void moveTo(uint x, uint y) {
		import std.stdio;
		import std.conv;
		write("\033["~(y + 1).to!string~";"~x.to!string~"H");
	}

	private void renderTile(uint number, uint position) {
		import std.conv;
		import std.stdio;

		enum _tl = '┏';
		enum _tr = '┓';
		enum _bl = '┗';
		enum _br = '┛';
		enum ti = '┳';
		enum bi = '┻';
		enum li = '┣';
		enum ri = '┫';
		enum ci = '╋';
		enum h = '━';
		enum v = '┃';

		wchar tl = '╋';
		wchar tr = '╋';
		wchar bl = '╋';
		wchar br = '╋';

		//FIXME: `position` is zero-based, comparing needs something else

		if (position == 0) {//top left tile
			tl = _tl;
			tr = ti;
			bl = li;
		} else if (position == dim - 1) {//top right
			tl = ti;
			tr = _tr;
			br = ri;
		} else if (position == (dim^^2) - dim + 1) {//bottom left
			tl = li;
			bl = _bl;
			br = bi;
		} else if (position == (dim^^2) - 1) {//bottom right
			tr = ri;
			bl = bi;
			br = _br;
		} else if (position <= dim) {//top row
			tl = ti;
			tr = ti;
		} else if (position > (dim^^2) - dim) {//bottom row
			bl = bi;
			br = bi;
		} else if ((position - 1) % dim == 0) {//left col
			tl = li;
			bl = li;
		} else if (position % dim == 0) {//right col
			tr = ri;
			br = ri;
		}

		wstring num = number.to!wstring;

		if (num.length == 1) {
			num ~= "  ";
		} else if (num.length == 2) {
			num ~= " ";
		}

		wstring[] rows = [
			tl~"━━━"w~tr,
			"┃"w~num~"┃"w,
			bl~"━━━"w~br,
		];

		foreach (i; 0 .. rows.length) {
			import std.stdio;

			uint x = (position % dim) * 5;//*5: the width (# of characters) of the rendered tile
			uint y = (((position - (position % dim)) / dim)) * 3;//*3: the height (# of characters) of the rendered tile
			moveTo(x, y + i.to!uint);
			write(rows[i]);
		}
	}
}
